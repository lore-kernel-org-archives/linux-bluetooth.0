Return-Path: <tony@atomide.com>
Date: Tue, 20 Mar 2018 14:11:51 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-bluetooth@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, robh@kernel.org
Subject: Re: [RFC] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
Message-ID: <20180320211151.GW5796@atomide.com>
References: <20180320083704.11705-1-marcel@holtmann.org>
 <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
 <20180320172827.ohla5v4a23v3u3qq@earth.universe>
 <20180320201449.GV5796@atomide.com>
 <E7257152-583E-4BCC-B366-2627E62F1FE1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E7257152-583E-4BCC-B366-2627E62F1FE1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Marcel Holtmann <marcel@holtmann.org> [180320 21:01]:
> Hi Tony,
> 
> >>>> The HCILL or eHCILL protocol from TI is actually an H:4 protocol with a
> >>>> few extra events and thus can also use the h4_recv_buf helper. Instead
> >>>> of open coding the same funtionality add the extra events to the packet
> >>>> description table and use h4_recv_buf.
> >>>> 
> >>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>> ---
> >>>> drivers/bluetooth/Kconfig  |   1 +
> >>>> drivers/bluetooth/hci_ll.c | 214 +++++++++++++++------------------------------
> >>>> 2 files changed, 70 insertions(+), 145 deletions(-)
> >>> 
> >>> is anybody able to test this change for me and verify that it doesn’t break things.
> >> 
> >> The diffstat looks nice :) I can give it a test on Motorola Droid 4
> >> later this week. If you want feedback a bit earlier, maybe Tony
> >> can give it a try (added to cc).
> > 
> > I tried applying it from the mailing list archive against
> > current Linux next and -rc6 but it failed:
> > 
> > patching file drivers/bluetooth/Kconfig
> > Hunk #1 succeeded at 147 with fuzz 2 (offset -13 lines).
> > patching file drivers/bluetooth/hci_ll.c
> > Hunk #2 succeeded at 88 (offset 4 lines).
> > Hunk #3 FAILED at 364.
> > 
> > Any ideas which patch(es) I might be missing?
> 
> that might be a git am issue and it being rather strict.

Or the patch not being correct copied from the archive.
Do you have a patchwork url for it or care to bounce the
patch to me?

Regards,

Tony
