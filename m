Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Jul 2013 10:32:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
cc: Oliver Neukum <oneukum@suse.de>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: autosuspend issues with the Intel Bluetooth device [8087:07dc]
In-Reply-To: <87mwq2lrsp.fsf@nemi.mork.no>
Message-ID: <Pine.LNX.4.44L0.1307041024140.21341-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 4 Jul 2013, Bjørn Mork wrote:

> > It may be that the device simply takes longer to resume than it should.  
> > Or longer than btusb expects it to, which may not be the same thing.
> 
> Yes, that is what it looks like.  But the URBs are submitted as part of
> the resume callback.  Shouldn't the device be alive and kicking when
> this is called?  At least from the USB point of view, which is all the
> driver can possibly know anything about? Is the problem that the
> firmware finishes the USB resume before actually being ready to respond
> to the HCI command?

I don't know.  The USB spec gives devices 10 ms to recover during a 
resume; after that they are supposed to be ready to operate normally.  
This delay is already built into usbcore and it is visible in your 
usbmon trace.

There is one notable difference between your failure and success 
traces.  Failure:

> ffff88021ace62c0 3675041611 S Co:002:00 s 20 00 0000 0000 0003 3 = 011000
> ffff88022228d140 3675041721 S Co:002:00 s 01 0b 0000 0001 0000 0
> ffff88021ace62c0 3675042361 C Co:002:00 0 3 >
> ffff88022228d140 3675042409 C Co:002:00 0 0
> ffff88020c40f380 3675043359 C Ii:002:01 0 6 = 0f040101 010b
> ffff88020c40f380 3675043429 S Ii:002:01 -115 64 <

Success:

> ffff88020c40f200 88163963 S Co:002:00 s 20 00 0000 0000 0003 3 = 011000
> ffff88020c752980 88165215 C Ii:002:01 0 14 = 0e0c0101 10000600 05060200 0005
> ffff88020c752980 88165281 S Ii:002:01 -115 64 <
> ffff88020c40f200 88165327 C Co:002:00 0 3 >

In the failure case, a Set-Interface request gets sent before the 
interrupt URB completes.  Maybe that accounts for the unexpected 
behavior.

Alan Stern

