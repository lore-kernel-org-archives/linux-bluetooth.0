Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200511291038.22058.Loial@home.nl>
References: <200511262023.23140.Loial@home.nl>
	 <200511281620.55644.Loial@home.nl> <1133208749.31513.45.camel@blade>
	 <200511291038.22058.Loial@home.nl>
Content-Type: text/plain
Message-Id: <1133259183.12447.4.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Nov 2005 11:13:03 +0100

Hi Rutger,

> > > sdptool finds the LCD device supports the HID service (which I already
> > > knew :P ) What I do not know is how I can send data to the device (using
> > > HID). Any pointers to docs/example code ?
> >
> > don't tell me that it is one of the Logitech diNovo devices. If it is
> > is, please see my comments about it on the mailing list. Otherwise send
> > in details about that device.
> 
> Actually, it is one of the Logitech diNovo devices (the mediapad). I know you 
> did some work on it (in december 2003) and that all information about it is 
> lost, but I'm willing to try to redo your work. It will be a nice pastime, I 
> hope :)

why don't you tell us from the start what kind of device it is.

> I have searched the archives in the past and could not find anything, but now 
> I looked again and I've finally found the messages in which you describe some 
> of your findings!
> 
> I will read through all I can find and see if there is anything in there I can 
> use, which will probably be the case :) I already saw you were using report ID 
> 16 and 17, so I will try that too.

You need to send and receive reports with ID 16 and 17. Both have fixed
length and 16 was for the short messages and 17 for the long messages if
I remember that correctly. They are the same we used for switching the
dongle from HID into HCI mode.

The problem is to get these reports to the device. The HIDP kernel
module with the report protocol (see -mh patch) lacks hiddev support.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
