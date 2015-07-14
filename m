Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2015 15:59:29 -0400
From: Chris Mason <clm@fb.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] I have no idea what I'm doing
Message-ID: <20150714195929.GB27622@ret.masoncoding.com>
References: <20150714191612.GA27622@ret.masoncoding.com>
 <47D2BE08-D7D0-4B1A-8B5B-17C99E0A3CF7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <47D2BE08-D7D0-4B1A-8B5B-17C99E0A3CF7@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 14, 2015 at 09:49:28PM +0200, Marcel Holtmann wrote:
> Hi Chris,
> 
> > I upgraded my macbook from 4.0.2 to 4.1.2, and now I get
> > messages similar to this bugzilla:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=100651
> > 
> > and this one:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=101171
> > 
> > [21552.711888] Bluetooth: hci0: BCM: Read verbose config info failed (-16)
> > [21728.019676] Bluetooth: hci0: BCM: Read verbose config info failed (-16)
> > 
> > A little poking around shows you recently added this check, and from
> > what I can tell with grep and friends the btbcm_read_verbose_config()
> > function is completely new?  I don't see similar reads being done by
> > older kernels.
> > 
> > So, I pushed some code around.  It does compile, but printk proves that
> > only the second hunk is happening on my box, so testing is somewhat
> > light.
> > 
> > With this applied, I'm able to use bluetooth again.
> > 
> > Signed-off-by: Chris Mason <clm@fb.com>
> > 
> > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > index 4bba866..90e7099 100644
> > --- a/drivers/bluetooth/btbcm.c
> > +++ b/drivers/bluetooth/btbcm.c
> > @@ -294,11 +294,10 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> > 
> > 	/* Read Verbose Config Version Info */
> > 	skb = btbcm_read_verbose_config(hdev);
> > -	if (IS_ERR(skb))
> > -		return PTR_ERR(skb);
> > -
> > -	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
> > -	kfree_skb(skb);
> > +	if (!IS_ERR(skb)) {
> > +		BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
> > +		kfree_skb(skb);
> > +	}
> 
> leave this one out of it. Since all Broadcom chips do actually support
> this as far as I can tell. We really want to fail this one since
> something went wrong in that case.

ack.  Both of those bugzillas look like macs, so they shouldn't need
this hunk either.

> 
> > 
> > 	switch ((rev & 0xf000) >> 12) {
> > 	case 0:
> > @@ -378,12 +377,11 @@ int btbcm_setup_apple(struct hci_dev *hdev)
> > 
> > 	/* Read Verbose Config Version Info */
> > 	skb = btbcm_read_verbose_config(hdev);
> > -	if (IS_ERR(skb))
> > -		return PTR_ERR(skb);
> > -
> > -	BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
> > -		get_unaligned_le16(skb->data + 5));
> > -	kfree_skb(skb);
> > +	if (!IS_ERR(skb)) {
> > +		BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
> > +			get_unaligned_le16(skb->data + 5));
> > +		kfree_skb(skb);
> > +	}
> > 
> > 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 
> This hunk is fine. I would accept a patch for this. I tested 8 Apple
> Bluetooth modules and they were all fine with this command. It seems
> there is this one chip in this one MacBook that is not.
> 
>
> Actually can you run something like "hciconfig hci0 version" and see
> if it really is a Broadcom chip in there or if Apple switched vendors
> and we are accidentally assuming it is Broadcom while in reality it is
> not. If it is not then the quirk might actually not apply either
> anymore.

mason@ret ~> hciconfig hci0 version
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 60:03:08:8D:0D:A9  ACL MTU: 1021:8  SCO MTU: 64:1
	HCI Version: 4.0 (0x6)  Revision: 0x21ae
	LMP Version: 4.0 (0x6)  Subversion: 0x414e
	Manufacturer: Broadcom Corporation (15)

One of the threads I saw when I was googling claimed it worked if you
rebooted from 4.0 into 4.1 but not 4.1 into 4.1.

-chris
