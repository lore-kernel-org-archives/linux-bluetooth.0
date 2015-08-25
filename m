Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150825191523.GA3220@hau.nz>
Date: Tue, 25 Aug 2015 14:36:08 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E3B23B91-CC1C-43E7-96BE-3A23692E41DE@holtmann.org>
References: <20150819222049.15ca98f0@angwin.home> <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com> <20150825165238.GA28893@hau.nz> <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org> <20150825171647.GB28893@hau.nz> <DE828595-3ADE-4F8F-8B24-4426C19A8DFF@holtmann.org> <20150825191523.GA3220@hau.nz>
To: Mark Haun <haunma@keteu.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

>> please run bluemoon -T to enable the LMP tracing feature and then see if
>> you happen to catch the messages before the controller jumps off the bus. 
>> I wonder which side initiates the key refresh.  Also what is the remote
>> device.  You can try hcitool info <bdaddr> to get its features.
> 
> Took me a while to figure out you have to bring down the hci0 interface and
> stop bluetoothd before running bluemoon.  Otherwise I get "Failed to open
> HCI user channel."  So now when I run bluemoon -T it just sits there forever
> after the welcome message.  Is this expected behavior?  Should I then
> restart bluetoothd in another console and leave the whole thing for a couple
> of days to catch the USB disconnect?

you can run bluemoon with -r switch additionally to any other command. It will use raw HCI access and it will also work when the device is up and bluetoothd already running.

Regards

Marcel

