Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v4 0/10] Bluetooth: Add RTL8723BS support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180802145721.31390-1-hdegoede@redhat.com>
Date: Fri, 3 Aug 2018 14:11:10 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Message-Id: <E299C667-DF12-4F96-9E57-BCF72864BC5C@holtmann.org>
References: <20180802145721.31390-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Here is v4 of my series of patches adding support for RTL8723BS'
> bluetooth component through serdev enumeration.
> 
> This builds on the great work done on this by Martin Blumenstingl
> which makes the btrtl.c code also support firmware+config loading
> for the RTL8723BS, as well as Jeremy's Cline work to add ACPI
> enumeration support on top of this.
> 
> New in v4:
> -Add new rtl_dev_err, rtl_dev_info, etc. helper macros and use those
> instead of bt_dev_err, etc
> -Add a new patch replacing all existing BT_ERR, bt_dev_err, etc. calls
> in btrtl.c with the new helpers
> 
> New in v3:
> -Fix build error when CONFIG_RTL_BT is not set, reported by Paul Cercueil
> 
> New in v2:
> -Dropped devicetree specific patches
> (these can be reposted later by someone who can actually test them)
> -Add the option to pass a postfix for the config firmware filename,
> to btrtl_initialize() (new patch). For ACPI serdev enumerated
> devies this will be set to the ACPI HID, so the filename becomes e.g.
> rtl_bt/rtl8732bs_config-OBDA8723.bin
> This is done because the config is board specific and we may need a
> different file for e.g. ARM boards
> 
> I've tested this series on several Intel boards with a RTL8723BS chip.

so I applied all 10 patches to bluetooth-next tree.

However I am bit disappointed that we couldn’t get bt3wire.c fixed to be used for this hardware. Having to hack this into hci_h5.c is a step back in my book. And I know what happens now. Nobody is going to work on it and we keep adding hacks and hacks on top of hci_ldisc.c that was never really designed for this. Maybe the next time around I have to be hardline and just reject unclean driver support.

In addition I am not happy with the -postfix firmware naming support. I think that is dangerous and might get us into a bad spot. Assuming anything about vendor firmware names and policies is bad. And from what I have seen with Realtek drivers, they are not consistent and are really hacking things together to make it just work for a single design. I really hope this is not coming back to haunt us.

Regards

Marcel

