Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: Bluetooth regression in 3.10
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130904155318.21cb6f37@milhouse>
Date: Wed, 4 Sep 2013 08:40:00 -0700
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Message-Id: <F0FC77C9-DCEF-48B8-8ABF-12446908AAC4@holtmann.org>
References: <20130904155318.21cb6f37@milhouse>
To: =?iso-8859-1?Q?Michael_B=FCsch?= <m@bues.ch>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> I noticed the thread "3.10-rc: bluetooth disappeared on thinkpad x60 (regression)"
> on lkml, but unfortunately the resulting patch does not fix the regression
> for me.
> I'm running 3.10.10, so the fix from the thread is applied to my kernel.
> 
> I see similar issues when trying to bring up my Bluetooth dongle:
> 
> $ lsusb | grep Blue
> Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> 
> This is a Broadcom chip based device.

that device is CSR based and not Broadcom based. Check with hciconfig hci0 version to see what it really is.
> 
> $ hciconfig hci0 up                                            
> Can't init device hci0: Operation not supported (95)
> 
> hcidump hci0 -X shows:
> 
> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>    bdaddr 00:00:00:00:00:00 all 1
>> HCI Event: Command Complete (0x0e) plen 4
>    Delete Stored Link Key (0x03|0x0012) ncmd 1
>    status 0x11 deleted 0
>    Error: Unsupported Feature or Parameter Value
> device: disconnected

And hciconfig hci0 commands tells you that this command is actually supported.

> The following workaround fixes the problem for me:
> 
> Index: linux/net/bluetooth/hci_core.c
> ===================================================================
> --- linux.orig/net/bluetooth/hci_core.c	2013-07-21 17:34:22.749435335 +0200
> +++ linux/net/bluetooth/hci_core.c	2013-09-04 15:39:07.580170034 +0200
> @@ -598,7 +598,7 @@
> 	u8 p;
> 
> 	/* Only send HCI_Delete_Stored_Link_Key if it is supported */
> -	if (hdev->commands[6] & 0x80) {
> +	if (0) {
> 		struct hci_cp_delete_stored_link_key cp;
> 
> 		bacpy(&cp.bdaddr, BDADDR_ANY);

Can you toy with hcitool cmd to send the HCI_Delete_Stored_Link_Key commands and see what parameters it would accept to delete all keys.

Regards

Marcel

