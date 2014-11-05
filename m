Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Nov 2014 16:09:59 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkvKB9qnYxhk2RPGDUV4rv=GgVeTiQ4aAJp+EDNpQXdAoGA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411051552510.1531-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 5 Nov 2014, Naveen Kumar Parna wrote:

> > Can you do it again, but this time keep the SOF packets?
> >
> > You don't have to post the entire analyzer log.  Just extract 3 or 4 ms
> > from the middle, where it shows the SSPLITS but no CSPLITS for the
> > interrupt endpoints, and post only that portion.
> >
> 
> I tried again, I keep getting STALL's but this time I see CSPLITS  for
> the interrupt end points.

Any idea why you see the CSPLITs now but didn't see them before?

> usbmon log:
> ffff8800b2cce6c0 1558099725 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 1558099740 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 1558435684 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 1558435700 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 1558447773 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 1558447790 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 1562003759 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 1562003777 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 1835091798 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 1835091818 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2360295770 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2360295785 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2360307814 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2360307827 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2746327776 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2746327796 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2750455832 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2750455844 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2751751777 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2751751788 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2752707689 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2752707707 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2762271761 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2762271776 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 2977131824 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 2977131835 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 3602679779 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 3602679798 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 456023739 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 456023758 S Ii:1:055:1 -115:1 16 <
> ffff8800b2cce6c0 456231695 C Ii:1:055:1 -32:1 0
> ffff8800b2cce6c0 456231712 S Ii:1:055:1 -115:1 16 <

Notice that the problem seems to occur very rarely.  There are often
many seconds between the -32 status values, whereas the interrupt
endpoint gets polled 1000 times per second.

Inconsistent behavior like that tends to indicate a hardware problem.  
Software would behave the same way every time, unless there was some 
sort of race.

> Dev 55 usb log:
> 
> SSPLIT IN transaction 55 1 HS No data 0.000 238 117
> Start of Frame (2) HS 228.0 -> 228.1 0.000 340 583
> CSPLIT IN transaction 55 1 NAK HS No data 0.000 489 817
> Start of Frame (6) HS 228.2 -> 228.7 0.000 590 617
> SSPLIT IN transaction 55 1 HS No data 0.001 238 117
> Start of Frame (2) HS 229.0 -> 229.1 0.001 340 733
> CSPLIT IN transaction 55 1 NAK HS No data 0.001 489 850
> Start of Frame (6) HS 229.2 -> 229.7 0.001 590 767
> SSPLIT IN transaction 55 1 HS No data 0.002 238 933
> Start of Frame (2) HS 230.0 -> 230.1 0.002 340 867
> CSPLIT IN transaction 55 1 NAK HS No data 0.002 489 933
> Start of Frame (6) HS 230.2 -> 230.7 0.002 590 900
> SSPLIT IN transaction 55 1 HS No data 0.003 238 967
> Start of Frame (2) HS 231.0 -> 231.1 0.003 341 017
> CSPLIT IN transaction 55 1 NAK HS No data 0.003 489 900
> Start of Frame (6) HS 231.2 -> 231.7 0.003 591 050
> SSPLIT IN transaction 55 1 HS No data 0.004 238 950
> Start of Frame (2) HS 232.0 -> 232.1 0.004 341 150
> CSPLIT IN transaction 55 1 NAK HS No data 0.004 489 950
> Start of Frame (6) HS 232.2 -> 232.7 0.004 591 183
> SSPLIT IN transaction 55 1 HS No data 0.005 239 000
> Start of Frame (2) HS 233.0 -> 233.1 0.005 341 283
> CSPLIT IN transaction 55 1 NAK HS No data 0.005 490 000

This looks right.  The SSPLIT packets get sent in microframe 7 of each
frame and the CSPLIT packets get sent in microframe 1.  (The full-speed
bus transaction occurs during microframe 0, in between.)

Also, a NAK response to a CSPLIT is correct when the device has no data 
to send.  It wouldn't cause you to get a STALL indication.

I need to see the portion of the analyzer log that corresponds to one 
of those -32 events in the usbmon log.  It ought to show something 
different, something that would cause the -32 status.

> External USB-2 hub (Dev 51) log:
> Start of Frame (570) HS 258.7 -> 330.0 0.000 090 550
> IN transaction 51 1 NAK HS No data 0.071 226 050
> Start of Frame (2,048) HS 299.0 -> 554.7 0.071 350 517
> IN transaction 51 1 NAK HS No data 0.327 261 817
> Start of Frame (2,048) HS 555.0 -> 810.7 0.327 386 250
> IN transaction 51 1 NAK HS No data 0.583 297 550
> Start of Frame (2,048) HS 811.0 -> 1,066.7 0.583 422 000
> IN transaction 51 1 NAK HS No data 0.839 333 283
> Start of Frame (2,048) HS 1,067.0 -> 1,322.7 0.839 457 733
> IN transaction 51 1 NAK HS No data 1.095 369 050
> Start of Frame (2,048) HS 1,323.0 -> 1,578.7 1.095 493 483
> IN transaction 51 1 NAK HS No data 1.351 404 767
> Start of Frame (2,048) HS 1,579.0 -> 1,834.7 1.351 529 233
> IN transaction 51 1 NAK HS No data 1.607 440 517

This also looks right.  The hub won't have any data to send until you 
plug in or unplug a device from one of its ports.

> Internal USB-2 hub (Dev 2) log:
> Start of Frame (266) HS 258.7 -> 292.0 0.000 090 550
> Incomplete IN transaction 2 1 INCOMPLETE HS No data 0.033 220 750
> Start of Frame (2,048) HS 261.0 -> 516.7 0.033 345 200
> Incomplete IN transaction 2 1 INCOMPLETE HS No data 0.289 256 517
> Start of Frame (2,048) HS 517.0 -> 772.7 0.289 380 950
> Incomplete IN transaction 2 1 INCOMPLETE HS No data 0.545 292 233
> Start of Frame (2,048) HS 773.0 -> 1,028.7 0.545 416 683
> Incomplete IN transaction 2 1 INCOMPLETE HS No data 0.801 328 000

And this looks right too.  The analyzer was unable to record the
responses to the IN transactions because the response packets were sent
directly back to the host controller -- they don't get sent to the
external port where the analyzer is attached.

Alan Stern

