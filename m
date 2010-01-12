Return-Path: <cyrus@holtmann.org>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: Liang Bao <tim.bao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6aeb672b1001120539u1285b7ccr2558d804e965782b@mail.gmail.com>
References: <6aeb672b1001120157x18b2fee0n2e47078214e0f239@mail.gmail.com>
	 <1263295337.12466.22.camel@localhost.localdomain>
	 <6aeb672b1001120539u1285b7ccr2558d804e965782b@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 10:45:44 -0800
Message-ID: <1263321945.12466.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Liang,

> >> We resumed the work of troubleshooting some problematic carkits
> >> recently. While we agree with that eSCO/SCO is handled by the stuff
> >> below HCI and bluez is absoultely right handling this, we still need
> >> to face the fact that there're bunch of carkits and headsets with
> >> hidden issues which only get exposed in certain combination like the
> >> HF850 and our phones. Bluez can still be even better.
> >>
> >> In our case, the HF850 claims eSCO but when you're trying to connect
> >> with it, it will timeout. So to have the stack works with those
> >> on-market products, it's better if the developers sitting above the
> >> HCI layer have some tweaking method on bluez behavior in ununsal
> >> cases.
> >>
> >> Regarding the particular eSCO timeout failure, we add the following
> >> delta into the net/bluetooth/hci_event.c
> >>
> >>         hci_proto_connect_cfm(conn, ev->status);
> >> +
> >> +    if (conn->out && (ev->status == 0x1a || ev->status == 0x1c ||
> >> +            ev->status == 0x1f || ev->status == 0x10) &&
> >> +            conn->attempt < 2) {
> >> +        conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
> >> +                    (hdev->esco_type & EDR_ESCO_MASK);
> >> +        hci_setup_sync(conn, conn->link->handle);
> >> +        goto unlock;
> >> +    }
> >> +
> >>       if (ev->status)
> >>               hci_conn_del(conn);
> >>
> >> With this code change, we can successfully retry a SCO link after eSCO
> >> attempt timeout. Still, a setsockopt interface will be better for
> >> tweaking. Or is there any better idea on how to allow bluez work with
> >> those on-market problematic devices?
> >
> > no you can NOT. It is race condition hazard. You can not call
> > hci_proto_connect_cfm() and then just hci_setup_sync(). That confuses
> > upper layers and just works by pure luck.
> >
> > The upstream code actually handles already the 0x1c and 0x1f error codes
> > and retries the setup without eSCO packets types. So you snippet is
> > against an old kernel (older than 2.6.30 at least).
> >
> Yeah, you're right, we're using version 2.6.29. I put the retry code between
> 
>     hci_proto_connect_cfm(conn, ev->status)
> 
> and
> 
>     if (ev->status)
>          hci_conn_del(conn);
> 
> because the kernel log is showing a warning complaining duplicate
> device files is being added( log put at the end to make reading easy).
> It seems the device file is created twice. I noticed a call to
> hci_conn_hold_device(conn) is added to kernel 2.6.30 and onwards. I'll
> try the new way tomorrow.

that should be fixed. Please re-test with bluetooth-testing tree based
on 2.6.33-rc3.

> >> The hcidump log is copied again here for your convenience:
> >> > 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection (0x01|0x0
> >> > 028) plen 17
> >> >    handle 1 voice setting 0x0060
> >> > 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
> >> >    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> >> > 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (0x2c) plen
> >> >  17
> >> >    status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
> >> >    Error: Connection Accept Timeout Exceeded
> >
> > The accept timeout has a pretty clear definition and while we could
> > retry, I am having some concerns here. This also does not explain why
> > 0x1a is in your code snippet.
> We conduct a retry for the code 0x1a because there's also some devices
> claim eSCO capability but respond with "Unsupported Remote Feature /
> Unsupported LMP Feature (0X1A)".

So adding 0x1a to the exception list and falling back to SCO is fine
with me. Send a proper patch against the bluetooth-testing tree with a
detailed commit message and the extract of hcidump -X -V for this one.
You will find an example on how such a commit message should look like
when looking through the history.

> We can understand your concern for 0x10 as it's a timeout by
> definition, therefore, if a retry will be done, probably the same set
> of parameters shall be used. However, the reality is that devices came
> to market around eSCO was introduced could be troubles - eSCO was
> added but not fully tested or failed to pass test and finally device
> manufacturer had to turn off them but inconsistency was kept - like
> what the Motorola HF850 does. Anyway, it's your call to determine the
> behavior for the 0x10(Connection Accept Timeout Exceeded) and
> personally I'll respect that.

If we really wanna work around this problem, then it might be better to
extend the SCO socket parameters to allow specifying a eSCO/SCO packet
mask. So it is up to the userspace to select any quirks.

Regards

Marcel


