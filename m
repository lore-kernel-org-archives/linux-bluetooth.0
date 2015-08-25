Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150825165238.GA28893@hau.nz>
Date: Tue, 25 Aug 2015 10:06:27 -0700
Cc: "Ge, Ethan" <ethan.ge@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org>
References: <20150819222049.15ca98f0@angwin.home> <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com> <20150825165238.GA28893@hau.nz>
To: Mark Haun <haunma@keteu.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

>> Your Intel FW version hci0: read Intel version: 3707100180012d0d06, it's
>> too old.  Please try latest Intel WP2 FW
>> Ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq in linux-firmware/intel.
> 
> So I tried this before going away for the weekend, rebooted, and then
> checked dmesg when I got back.  The issue is still there, spontaneous
> disconnect/reconnect every 23h18m07s like clockwork.

this sounds suspiciously like the validity of the encryption key. I assume your connection is encrypted.

Please provide the btmon output for the section where you see the disconnect + reconnect. I need to check what the firmware is telling us. And please include the initial connection setup as well. I need to see the features of the remote device.

However in theory the firmware should be using using encryption pause and resume to renew the encryption key prior to it expiring. We might need the LMP details in that case. You can use bluemoon -T to enable them (and that tool will also decode firmware version for you). Decoding the LMP vendor events will not be possible since we have not added support for it to btmon yet.

Regards

Marcel

