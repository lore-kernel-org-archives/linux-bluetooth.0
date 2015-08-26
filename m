Return-Path: <cyrus@holtmann.org>
From: "Ge, Ethan" <ethan.ge@intel.com>
To: Mark Haun <haunma@keteu.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Date: Wed, 26 Aug 2015 05:56:55 +0000
Message-ID: <86D221DC0B85F94D9B05B97827669A34064C6CFE@PGSMSX106.gar.corp.intel.com>
References: <20150819222049.15ca98f0@angwin.home>
 <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
 <20150825165238.GA28893@hau.nz>
In-Reply-To: <20150825165238.GA28893@hau.nz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

After you replace the ibt-xxx.bseq file, you need to shut down your machine and reboot it (power off device). Then the controller will re-load the FW patch.

And you will find Bluetooth: hci0: read Intel version: 3707100180012d0da1
Bluetooth: hci0: Intel device is already patched. patch num: a1

Ethan
-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Mark Haun
Sent: Wednesday, August 26, 2015 12:53 AM
To: Ge, Ethan
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s

Hi Ethan,

Ge, Ethan [ethan.ge@intel.com] wrote:
> Your Intel FW version hci0: read Intel version: 3707100180012d0d06, 
> it's too old.  Please try latest Intel WP2 FW 
> Ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq in linux-firmware/intel.

So I tried this before going away for the weekend, rebooted, and then checked dmesg when I got back.  The issue is still there, spontaneous disconnect/reconnect every 23h18m07s like clockwork.

I am starting to second-guess myself a little, though, because I am confused about the firmware naming.  The firmware or microcode files I am familiar with (iwlwifi for instance) have the firmware version as part of the file name.  The ibt-hw-* firmwares, on the other hand, appear to keep the *same* filename when new versions come out; only the increased file size indicates that the contents have changed.  So I am guessing that the filename refers to the hardware revision it is intended for, rather than the firmware/microcode revision?  Either that, or debian is not distributing the same firmware files as the ones in git!

In any case, the dmesg output with the [presumed correct] firmware is precisely the same as before:

Bluetooth: hci0: read Intel version: 3707100180012d0d06
Bluetooth: hci0: Intel device is already patched. patch num: 06

The size of the file "ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq" is now 17310 bytes.  That is larger than the one it overwrote, but I didn't write down the old size.

Kernel version is 4.2.0-rc4.

Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
