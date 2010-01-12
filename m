Return-Path: <cyrus@holtmann.org>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: Liang Bao <tim.bao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6aeb672b1001120157x18b2fee0n2e47078214e0f239@mail.gmail.com>
References: <6aeb672b1001120157x18b2fee0n2e47078214e0f239@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 03:22:17 -0800
Message-ID: <1263295337.12466.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Liang,

> We resumed the work of troubleshooting some problematic carkits
> recently. While we agree with that eSCO/SCO is handled by the stuff
> below HCI and bluez is absoultely right handling this, we still need
> to face the fact that there're bunch of carkits and headsets with
> hidden issues which only get exposed in certain combination like the
> HF850 and our phones. Bluez can still be even better.
> 
> In our case, the HF850 claims eSCO but when you're trying to connect
> with it, it will timeout. So to have the stack works with those
> on-market products, it's better if the developers sitting above the
> HCI layer have some tweaking method on bluez behavior in ununsal
> cases.
> 
> Regarding the particular eSCO timeout failure, we add the following
> delta into the net/bluetooth/hci_event.c
> 
>         hci_proto_connect_cfm(conn, ev->status);
> +
> +    if (conn->out && (ev->status == 0x1a || ev->status == 0x1c ||
> +            ev->status == 0x1f || ev->status == 0x10) &&
> +            conn->attempt < 2) {
> +        conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
> +                    (hdev->esco_type & EDR_ESCO_MASK);
> +        hci_setup_sync(conn, conn->link->handle);
> +        goto unlock;
> +    }
> +
>       if (ev->status)
>               hci_conn_del(conn);
> 
> With this code change, we can successfully retry a SCO link after eSCO
> attempt timeout. Still, a setsockopt interface will be better for
> tweaking. Or is there any better idea on how to allow bluez work with
> those on-market problematic devices?

no you can NOT. It is race condition hazard. You can not call
hci_proto_connect_cfm() and then just hci_setup_sync(). That confuses
upper layers and just works by pure luck.

The upstream code actually handles already the 0x1c and 0x1f error codes
and retries the setup without eSCO packets types. So you snippet is
against an old kernel (older than 2.6.30 at least).

> The hcidump log is copied again here for your convenience:
> > 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connection (0x01|0x0
> > 028) plen 17
> >    handle 1 voice setting 0x0060
> > 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen 4
> >    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> > 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complete (0x2c) plen
> >  17
> >    status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
> >    Error: Connection Accept Timeout Exceeded

The accept timeout has a pretty clear definition and while we could
retry, I am having some concerns here. This also does not explain why
0x1a is in your code snippet.

Regards

Marcel


