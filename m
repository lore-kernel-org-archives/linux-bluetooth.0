Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1410161012530.1316-100000@iolanthe.rowland.org>
References: <CAG0bkvJD_j_SUuSm4_+DiMqc-RH63BDU=cAtbkmNZdJ-ps=q6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1410161012530.1316-100000@iolanthe.rowland.org>
Date: Thu, 16 Oct 2014 21:02:04 +0530
Message-ID: <CAG0bkvKNrQqDhJK5SCqU+Pc99sR5x_Jnga1cR37ZXLZ0a5uVVQ@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 16, 2014 at 7:46 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 16 Oct 2014, Naveen Kumar Parna wrote:
>
>> > It's entirely possible that the stall packets are created by the hub.
>> > When a full-speed device is connected to a USB-2 hub, and the device
>> > fails to respond to a packet sent by the host, the hub reports this
>> > failure as a stall.
>>
>> Here I don’t think device fails to respond to a packet sent by the
>> host. I verified this by connecting Ellisys USB analyser in between
>> host and devices.
>>
>> For example Look at the attached(Sample_HciEvt.png) HCI event captured
>> by Ellisys USB analyser. It is a valid HCI event from device to Host.
>> IN transaction 96 1 ACK FS 16 bytes (FF 2F C2 01 00 17 00 DF 00 01 10
>> 00 00 A9 EE 0F)
>> IN transaction 96 1 ACK FS 16 bytes (00 00 00 5A 06 9D 39 00 00 66 00
>> 00 00 00 00 00)
>> IN transaction 96 1 ACK FS 16 bytes (00 00 00 00 00 00 00 00 00 00 00
>> 8E 05 28 00 01)
>> IN transaction 96 1 ACK FS 1 byte (00)
>
> This doesn't prove anything.  All it means is that the device responded
> properly on these four occasions.  What if the device failed to respond
> on some other occasion?  You have to compare the output of the analyzer
> with the output from usbmon.  If usbmon shows a STALL and the analyzer
> shows a valid reply for the very same packet, then you'll know the
> device isn't at fault.
>


I forgot to post usbmon log, but usbmon shows a STALL and the analyser
shows a valid reply for the very same packet.

I tried this many number of times and always got same result.

But did not get STALL on OHCI-USB host controller on PCI card with
internal USB 1.1 hub. In both the scenario’s I used same devices.




> You should also run a similar test when you connect the device through
> a USB-2 hub.  In fact, you should run two tests.  In one test, connect
> the analyzer to the cable segment between the computer and the hub; in
> the other test, connect the analyzer to the cable segment between the
> hub and the device.
>


Ok, I will try and update you on this.




Thanks,
Naveen
