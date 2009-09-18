Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <113d36d80909140829g74828077tfd1a56348abcc916@mail.gmail.com>
References: <113d36d80909140452jb808a2bub393aae7307c7450@mail.gmail.com>
	 <1252935154.3421.17.camel@localhost.localdomain>
	 <113d36d80909140829g74828077tfd1a56348abcc916@mail.gmail.com>
Date: Fri, 18 Sep 2009 18:47:10 +0800
Message-ID: <113d36d80909180347g59ac5444ta70e17c7eb3cb86e@mail.gmail.com>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2009/9/14 Lan Zhu <zhu.lan.cn@gmail.com>:
> Hi Marcel,
>
> 2009/9/14 Marcel Holtmann <marcel@holtmann.org>:
>> Hi,
>>
>>> When we connect a SCO socket, BlueZ decides whether to connect SCO or
>>> eSCO type according to the remote feature. If the remote device
>>> declares supporting eSCO in the remote feature, BlueZ will select eSCO
>>> type to connect with it.
>>>
>>> But in fact =A0there are some old carkits or headsets which are only
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
>>> @@ -653,12 +653,25 @@ static int sco_sock_setsockopt(struct socket *soc=
k, int le
>>> =A0{
>>> =A0 =A0 =A0 =A0struct sock *sk =3D sock->sk;
>>> =A0 =A0 =A0 =A0int err =3D 0;
>>> + =A0 =A0 =A0 u32 opt;
>>>
>>> =A0 =A0 =A0 =A0BT_DBG("sk %p", sk);
>>>
>>> =A0 =A0 =A0 =A0lock_sock(sk);
>>>
>>> + =A0 =A0 =A0 if (level !=3D SOL_SCO) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOPROTOOPT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>> + =A0 =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 =A0switch (optname) {
>>> + =A0 =A0 =A0 case BT_DISABLE_ESCO:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (get_user(opt, (u32 __user *) optval))=
 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EFAULT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_esco =3D opt;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0default:
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENOPROTOOPT;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
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
> =A0 =A0 =A0 =A0case 0x1c: =A0 =A0 =A0/* SCO interval rejected */
> =A0 =A0 =A0 =A0case 0x1f: =A0 =A0 =A0/* Unspecified error */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (conn->out && conn->attempt < 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->pkt_type =3D (hdev->=
esco_type & SCO_ESCO_MASK) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(hdev->esco_type & EDR_ESCO_MASK);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_setup_sync(conn, conn-=
>link->handle);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> But the problem is, not all the returned error code can bring retry
> SCO. So, we still got problem when connecting some devices because it
> returns some error code else.
>
> This is the hcidump log when we test SCO with HF850 carkit.
>
> 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection (0=
x01|0x0
> 028) plen 17
> =A0 =A0handle 1 voice setting 0x0060
> 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
> =A0 =A0Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (0x2=
c) plen
> =A017
> =A0 =A0status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
> =A0 =A0Error: Connection Accept Timeout Exceeded
> 2009-09-03 17:26:34.191196 < HCI Command: Setup Synchronous Connection (0=
x01|0x0
> 028) plen 17
> =A0 =A0handle 1 voice setting 0x0060
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
