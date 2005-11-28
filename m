Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
In-Reply-To: <200511281620.55644.Loial@home.nl>
Message-ID: <Pine.LNX.4.33.0511281626380.24498-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 28 Nov 2005 16:29:01 +0100 (CET)


Hi,

get the HID SPec from www.usb.org and the hid profile documentation from
www.bluetooth.org. HID devices usualy export structures which describes
their capabilities and how to use them.

Ciao,

Peter


On Mon, 28 Nov 2005, Rutger Hendriks wrote:

> On Saturday 26 November 2005 20:32, Marcel Holtmann wrote:
> > Hi Rutger,
> >
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
> >
> > Regards
> >
> > Marcel
>
> Hi Marcel,
>
> sdptool finds the LCD device supports the HID service (which I already
> knew :P ) What I do not know is how I can send data to the device (using
> HID). Any pointers to docs/example code ?
>
> Thanks!
> Rutger
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
