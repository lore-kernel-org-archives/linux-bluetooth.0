Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 12 Jan 2010 17:57:11 +0800
Message-ID: <6aeb672b1001120157x18b2fee0n2e47078214e0f239@mail.gmail.com>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Marcel and other people who's interested on this topic,

We resumed the work of troubleshooting some problematic carkits
recently. While we agree with that eSCO/SCO is handled by the stuff
below HCI and bluez is absoultely right handling this, we still need
to face the fact that there're bunch of carkits and headsets with
hidden issues which only get exposed in certain combination like the
HF850 and our phones. Bluez can still be even better.

In our case, the HF850 claims eSCO but when you're trying to connect
with it, it will timeout. So to have the stack works with those
on-market products, it's better if the developers sitting above the
HCI layer have some tweaking method on bluez behavior in ununsal
cases.

Regarding the particular eSCO timeout failure, we add the following
delta into the net/bluetooth/hci_event.c

        hci_proto_connect_cfm(conn, ev->status);
+
+    if (conn->out && (ev->status == 0x1a || ev->status == 0x1c ||
+            ev->status == 0x1f || ev->status == 0x10) &&
+            conn->attempt < 2) {
+        conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
+                    (hdev->esco_type & EDR_ESCO_MASK);
+        hci_setup_sync(conn, conn->link->handle);
+        goto unlock;
+    }
+
      if (ev->status)
              hci_conn_del(conn);

With this code change, we can successfully retry a SCO link after eSCO
attempt timeout. Still, a setsockopt interface will be better for
tweaking. Or is there any better idea on how to allow bluez work with
those on-market problematic devices?

The hcidump log is copied again here for your convenience:
> 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection (0x01|0x0
> 028) plen 17
>    handle 1 voice setting 0x0060
> 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
>    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (0x2c) plen
>  17
>    status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
>    Error: Connection Accept Timeout Exceeded

Regards,
Liang Bao

Quoted text:
===================

Hi Marcel,

2009/9/14 Lan Zhu <zhu.lan.cn@...>:
> Hi Marcel,
>
> 2009/9/14 Marcel Holtmann <marcel@...>:
>> Hi,
>>
>>> When we connect a SCO socket, BlueZ decides whether to connect SCO or
>>> eSCO type according to the remote feature. If the remote device
>>> declares supporting eSCO in the remote feature, BlueZ will select eSCO
>>> type to connect with it.
>>>
>>> But in fact  there are some old carkits or headsets which are only
>>> support SCO but wrongly declare to support eSCO, such as Motorola
>>> HF850 and HS820 which use a very old CSR chip, so we have problem to
>>> create sco connection with them.
>>>
>>> We thought a method to resolve this issue, which is force to create
>>> SCO type connection if we find the HFP version of one remote device is
>>> less than 1.2. So we need a method to control the SCO type from user
>>> space. We want to use setsockopt() functon to do that. The code change
>>> in net/bluetooth/sco.c is like below,
>>>
>>>
>>> @@ -653,12 +653,25 @@ static int sco_sock_setsockopt(struct socket *sock, int le
>>>  {
>>>        struct sock *sk = sock->sk;
>>>        int err = 0;
>>> +       u32 opt;
>>>
>>>        BT_DBG("sk %p", sk);
>>>
>>>        lock_sock(sk);
>>>
>>> +       if (level != SOL_SCO) {
>>> +               err = -ENOPROTOOPT;
>>> +               return err;
>>> +       }
>>> +
>>>        switch (optname) {
>>> +       case BT_DISABLE_ESCO:
>>> +               if (get_user(opt, (u32 __user *) optval)) {
>>> +                       err = -EFAULT;
>>> +                       break;
>>> +               }
>>> +               disable_esco = opt;
>>> +               break;
>>>        default:
>>>                err = -ENOPROTOOPT;
>>>                break;
>>>
>>>
>>> Then, in the user space, we can call setsockopt(fd, SOL_SCO,
>>> BT_DISABLE_ESCO, &disabled, sizeof(disabled)) to force to connect SCO.
>>>
>>> Do you agree with this change?
>>
>> I don't. You first have to prove to me that this change is needed at
>> all. Show me the hcidump -X -V connections attempts for these carkits.
>>
>> Also your analysis is wrong. BlueZ doesn't care if the remote headset
>> supports eSCO or not. We just care about if our local controller has the
>> synchronous setup commands. It is the job of the link manager inside the
>> controller firmware to either establish SCO or eSCO. And we do retry
>> with SCO if eSCO fails. This sounds more like the case that you have an
>> outdated kernel.
>>
>> Regards
>>
>> Marcel
>>
>>
>>
>
> Please excuse me for my inaccurate description. Actually it is LMP
> layer to check the remote feature then decide which SCO type shall be
> setup. So, if one remote device wrongly declare to support eSCO, it
> will cause problem. I do know you have a retry mechanism to retry SCO
> if eSCO failed, it is in below code in net/bluetooth/hci_event.c,
> right?
>
>        case 0x1c:      /* SCO interval rejected */
>        case 0x1f:      /* Unspecified error */
>                if (conn->out && conn->attempt < 2) {
>                        conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
>                                        (hdev->esco_type & EDR_ESCO_MASK);
>                        hci_setup_sync(conn, conn->link->handle);
>                        goto unlock;
>                }
>                /* fall through */
>
> But the problem is, not all the returned error code can bring retry
> SCO. So, we still got problem when connecting some devices because it
> returns some error code else.
>
> This is the hcidump log when we test SCO with HF850 carkit.
>
> 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection (0x01|0x0
> 028) plen 17
>    handle 1 voice setting 0x0060
> 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
>    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (0x2c) plen
>  17
>    status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
>    Error: Connection Accept Timeout Exceeded
> 2009-09-03 17:26:34.191196 < HCI Command: Setup Synchronous Connection (0x01|0x0
> 028) plen 17
>    handle 1 voice setting 0x0060
>
> From the log you can see, the eSCO connection failed in 5 seconds with
> the error "0x10 Timeout Exceeded", and it do not retry SCO again.
>
> In order to resolve such issue, we have thought about two methods to
> resolve this.
>
> The first one is, add a new case for "0x10" error code and then retry
> SCO. We do have tested this, SCO can be setup, but the 5 seconds delay
> can not be eliminated.
>
> The second one is, we hope to force to use the sco type of SCO for
> some special devices which have compatible issue with eSCO. We can
> force to connect SCO by calling hci_add_sco() or hci_setup_sync() with
> limited pkt_type for those kind of devices. This is why we want to add
> a DISABLE_ESCO option into setsockopt() function.
>
>
> Thank you,
> Zhu Lan
>

We did some investigation on Mecel Bluetooth stack and Qualcomm's,
they both provide the upper layer with the option to specify SCO type
or eSCO type when creating synchronous connection. There are plenty of
different Bluetooth devices in the world, compatiblility with them is
usually a big issue for one Bluetooth product. So the rubestness will
be a very important target for a product. Sometimes the Bluetooth
developer need enough flexibility to handle many specific cases,
because that can not be totally dealt with
in stack layer. Actually Bluez already has an excellent architecture,
but still a little weak in the rubestness. Then, why not give the
developer more flexibility to deal with some problems?

Thanks,
Zhu Lan
