Return-Path: <cyrus@holtmann.org>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80909180347g59ac5444ta70e17c7eb3cb86e@mail.gmail.com>
References: <113d36d80909140452jb808a2bub393aae7307c7450@mail.gmail.com>
	 <1252935154.3421.17.camel@localhost.localdomain>
	 <113d36d80909140829g74828077tfd1a56348abcc916@mail.gmail.com>
	 <113d36d80909180347g59ac5444ta70e17c7eb3cb86e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Sep 2009 08:31:23 -0700
Message-Id: <1253287883.28416.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> >>> When we connect a SCO socket, BlueZ decides whether to connect SCO or
> >>> eSCO type according to the remote feature. If the remote device
> >>> declares supporting eSCO in the remote feature, BlueZ will select eSCO
> >>> type to connect with it.
> >>>
> >>> But in fact  there are some old carkits or headsets which are only
> >>> support SCO but wrongly declare to support eSCO, such as Motorola
> >>> HF850 and HS820 which use a very old CSR chip, so we have problem to
> >>> create sco connection with them.
> >>>
> >>> We thought a method to resolve this issue, which is force to create
> >>> SCO type connection if we find the HFP version of one remote device is
> >>> less than 1.2. So we need a method to control the SCO type from user
> >>> space. We want to use setsockopt() functon to do that. The code change
> >>> in net/bluetooth/sco.c is like below,
> >>>
> >>>
> >>> @@ -653,12 +653,25 @@ static int sco_sock_setsockopt(struct socket *sock, int le
> >>>  {
> >>>        struct sock *sk = sock->sk;
> >>>        int err = 0;
> >>> +       u32 opt;
> >>>
> >>>        BT_DBG("sk %p", sk);
> >>>
> >>>        lock_sock(sk);
> >>>
> >>> +       if (level != SOL_SCO) {
> >>> +               err = -ENOPROTOOPT;
> >>> +               return err;
> >>> +       }
> >>> +
> >>>        switch (optname) {
> >>> +       case BT_DISABLE_ESCO:
> >>> +               if (get_user(opt, (u32 __user *) optval)) {
> >>> +                       err = -EFAULT;
> >>> +                       break;
> >>> +               }
> >>> +               disable_esco = opt;
> >>> +               break;
> >>>        default:
> >>>                err = -ENOPROTOOPT;
> >>>                break;
> >>>
> >>>
> >>> Then, in the user space, we can call setsockopt(fd, SOL_SCO,
> >>> BT_DISABLE_ESCO, &disabled, sizeof(disabled)) to force to connect SCO.
> >>>
> >>> Do you agree with this change?
> >>
> >> I don't. You first have to prove to me that this change is needed at
> >> all. Show me the hcidump -X -V connections attempts for these carkits.
> >>
> >> Also your analysis is wrong. BlueZ doesn't care if the remote headset
> >> supports eSCO or not. We just care about if our local controller has the
> >> synchronous setup commands. It is the job of the link manager inside the
> >> controller firmware to either establish SCO or eSCO. And we do retry
> >> with SCO if eSCO fails. This sounds more like the case that you have an
> >> outdated kernel.
> >>
> >> Regards
> >>
> >> Marcel
> >>
> >>
> >>
> >
> > Please excuse me for my inaccurate description. Actually it is LMP
> > layer to check the remote feature then decide which SCO type shall be
> > setup. So, if one remote device wrongly declare to support eSCO, it
> > will cause problem. I do know you have a retry mechanism to retry SCO
> > if eSCO failed, it is in below code in net/bluetooth/hci_event.c,
> > right?
> >
> >        case 0x1c:      /* SCO interval rejected */
> >        case 0x1f:      /* Unspecified error */
> >                if (conn->out && conn->attempt < 2) {
> >                        conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
> >                                        (hdev->esco_type & EDR_ESCO_MASK);
> >                        hci_setup_sync(conn, conn->link->handle);
> >                        goto unlock;
> >                }
> >                /* fall through */
> >
> > But the problem is, not all the returned error code can bring retry
> > SCO. So, we still got problem when connecting some devices because it
> > returns some error code else.
> >
> > This is the hcidump log when we test SCO with HF850 carkit.
> >
> > 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection (0x01|0x0
> > 028) plen 17
> >    handle 1 voice setting 0x0060
> > 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
> >    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> > 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (0x2c) plen
> >  17
> >    status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
> >    Error: Connection Accept Timeout Exceeded
> > 2009-09-03 17:26:34.191196 < HCI Command: Setup Synchronous Connection (0x01|0x0
> > 028) plen 17
> >    handle 1 voice setting 0x0060
> >
> > From the log you can see, the eSCO connection failed in 5 seconds with
> > the error "0x10 Timeout Exceeded", and it do not retry SCO again.
> >
> > In order to resolve such issue, we have thought about two methods to
> > resolve this.
> >
> > The first one is, add a new case for "0x10" error code and then retry
> > SCO. We do have tested this, SCO can be setup, but the 5 seconds delay
> > can not be eliminated.
> >
> > The second one is, we hope to force to use the sco type of SCO for
> > some special devices which have compatible issue with eSCO. We can
> > force to connect SCO by calling hci_add_sco() or hci_setup_sync() with
> > limited pkt_type for those kind of devices. This is why we want to add
> > a DISABLE_ESCO option into setsockopt() function.
>
> We did some investigation on Mecel Bluetooth stack and Qualcomm's,
> they both provide the upper layer with the option to specify SCO type
> or eSCO type when creating synchronous connection. There are plenty of
> different Bluetooth devices in the world, compatiblility with them is
> usually a big issue for one Bluetooth product. So the rubestness will
> be a very important target for a product. Sometimes the Bluetooth
> developer need enough flexibility to handle many specific cases,
> because that can not be totally dealt with
> in stack layer. Actually Bluez already has an excellent architecture,
> but still a little weak in the rubestness. Then, why not give the
> developer more flexibility to deal with some problems?

BlueZ is not weak in robustness. Do me a favor and get your English
right here and do not spread FUD. You are saying that it is important to
work around some total broken eSCO capable chip to be robust. I do
question that statement. It is nice to have good interoperability with
broken devices, but there is a limit of broken devices we can support.

And the userspace option to select between SCO and eSCO is just stupid
since you just start hacking some blacklist non-sense into the code that
becomes a big magic blob that nobody can track or understand.

The way forward here is to analyze the headset and see what information
it gives us to determine that eSCO might not be working good enough. So
I want output from hcitool info and detailed hcidump.

Regards

Marcel


