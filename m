Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] eSCO fallback to SCO on Error: Connection Failed to
 Complete
From: Marcel Holtmann <marcel@holtmann.org>
To: smcoe1 <smcoe1@gmail.com>
Cc: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <9c9ad6a31002160721j38fc388u99e35234f28270ed@mail.gmail.com>
References: <9c9ad6a31002111256v1c3394d1rade3c3640ee7efb5@mail.gmail.com>
	 <35c90d961002111320n3e5626d6oca767c7facccc356@mail.gmail.com>
	 <9c9ad6a31002120806m381e6548xacf28c5ba9b079de@mail.gmail.com>
	 <1265997402.21559.0.camel@localhost.localdomain>
	 <9c9ad6a31002160721j38fc388u99e35234f28270ed@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Feb 2010 07:40:52 -0800
Message-ID: <1266334852.8849.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stephen,

> The Bluetooth SIG PTS test case: TC_AG_ACS_BV_10_I, rejects eSCO with
> "Unsupported Feature or Parameter Value" (0x11).  This patch adds case
> for SCO fall back.
> 
> 2007-09-20 12:20:37.787747 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>     handle 38 packets 1
> 2007-09-20 12:20:37.842154 < HCI Command: Setup Synchronous Connection
> (0x01|0x0028) plen 17
>     handle 38 voice setting 0x0060
> 2007-09-20 12:20:37.847037 > HCI Event: Command Status (0x0f) plen 4
>     Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> 2007-09-20 12:20:37.855233 > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 38 slots 1
> 2007-09-20 12:20:39.913354 > HCI Event: Synchronous Connect Complete
> (0x2c) plen 17
>     status 0x11 handle 38 bdaddr 00:16:93:01:01:7A type eSCO
>     Error: Unsupported Feature or Parameter Value
> 2007-09-20 12:20:39.922629 > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 38 slots 5
> 2007-09-20 12:20:58.126886 < ACL data: handle 38 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 0]
>       0000: 0b 53 01 b8                                       .S..
> 2007-09-20 12:20:58.130138 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>     handle 38 packets 1
> 
> 
> 
> Signed-off-by: Stephen Coe <smcoe1@gmail.com>
>
> ---
>  net/bluetooth/hci_event.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 592da5c..6c57fc7 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1698,6 +1698,7 @@ static inline void
> hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu
>         hci_conn_add_sysfs(conn);
>         break;
> 

your mailer seem to have corrupted the patch. Make sure it doesn't
introduce any line break. Or better just use git send-email.

Regards

Marcel


