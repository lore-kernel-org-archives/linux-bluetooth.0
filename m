Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2015 09:52:38 -0700
From: Mark Haun <haunma@keteu.org>
To: "Ge, Ethan" <ethan.ge@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Message-ID: <20150825165238.GA28893@hau.nz>
References: <20150819222049.15ca98f0@angwin.home>
 <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

Ge, Ethan [ethan.ge@intel.com] wrote:
> Your Intel FW version hci0: read Intel version: 3707100180012d0d06, it's
> too old.  Please try latest Intel WP2 FW
> Ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq in linux-firmware/intel.

So I tried this before going away for the weekend, rebooted, and then
checked dmesg when I got back.  The issue is still there, spontaneous
disconnect/reconnect every 23h18m07s like clockwork.

I am starting to second-guess myself a little, though, because I am confused
about the firmware naming.  The firmware or microcode files I am familiar
with (iwlwifi for instance) have the firmware version as part of the file
name.  The ibt-hw-* firmwares, on the other hand, appear to keep the *same*
filename when new versions come out; only the increased file size indicates
that the contents have changed.  So I am guessing that the filename refers
to the hardware revision it is intended for, rather than the
firmware/microcode revision?  Either that, or debian is not distributing the
same firmware files as the ones in git!

In any case, the dmesg output with the [presumed correct] firmware is
precisely the same as before:

Bluetooth: hci0: read Intel version: 3707100180012d0d06
Bluetooth: hci0: Intel device is already patched. patch num: 06

The size of the file "ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq" is now 17310
bytes.  That is larger than the one it overwrote, but I didn't write down
the old size.

Kernel version is 4.2.0-rc4.

Mark
