Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2015 13:49:11 -0700
From: Mark Haun <haunma@keteu.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Loic Poulain <loic.poulain@intel.com>
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Message-ID: <20150825204911.GA3479@hau.nz>
References: <20150819222049.15ca98f0@angwin.home>
 <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
 <20150825165238.GA28893@hau.nz>
 <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org>
 <20150825171647.GB28893@hau.nz>
 <DE828595-3ADE-4F8F-8B24-4426C19A8DFF@holtmann.org>
 <20150825191523.GA3220@hau.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150825191523.GA3220@hau.nz>
List-ID: <linux-bluetooth.vger.kernel.org>

Mark Haun [haunma@keteu.org] wrote:
> Took me a while to figure out you have to bring down the hci0 interface and
> stop bluetoothd before running bluemoon.  Otherwise I get "Failed to open
> HCI user channel."  So now when I run bluemoon -T it just sits there forever
> after the welcome message.  Is this expected behavior?  Should I then
> restart bluetoothd in another console and leave the whole thing for a couple
> of days to catch the USB disconnect?

Ok, I think I am seeing a bug very similar to this one reported by Loic
Poulain:

http://marc.info/?l=linux-bluetooth&m=143220351521634&w=2
("bluetooth-next HCI user channel issue")

I have the same symptom of bluemoon hanging, and I figured out that I can
recover the system without rebooting by forcing hci0 down again.  "hciconfig
hci0 down" takes about ten seconds to return, and then I have a 0xfc3f
timeout in dmesg:

[ 5563.562554] Bluetooth: hci0 command 0xfc3f tx timeout
[ 5571.557618] Bluetooth: hci0: turning off Intel device LED failed (-110)

This is the same error Loic was getting, I assume because the commit in
question has now made it into my kernel (4.2.0-rc4).

Mark
