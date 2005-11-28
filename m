Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200511281620.55644.Loial@home.nl>
References: <200511262023.23140.Loial@home.nl>
	 <1133033547.15981.2.camel@blade>  <200511281620.55644.Loial@home.nl>
Content-Type: text/plain
Message-Id: <1133208749.31513.45.camel@blade>
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
Date: Mon, 28 Nov 2005 21:12:29 +0100

Hi Rutger,

> > > I have a bluetooth device here that has an LCD display. I want to be able
> > > to send arbitrary data to the device. This way I can (hopefully) make
> > > text appear on the LCD display. The problem is, that I can not find
> > > enough documentation to send the arbitrary data. So I'm hoping to find
> > > some help here...
> > >
> > > But, now I'm stuck. What function can I call to send arbitrary hex data?
> >
> > totally wrong direction. Use sdptool and its various option to discover
> > the services offered by this LCD device.
> 
> sdptool finds the LCD device supports the HID service (which I already 
> knew :P ) What I do not know is how I can send data to the device (using 
> HID). Any pointers to docs/example code ?

don't tell me that it is one of the Logitech diNovo devices. If it is
is, please see my comments about it on the mailing list. Otherwise send
in details about that device.

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
