Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051128092101.GM15156@polar.elf12.net>
References: <20051127230444.GG15156@polar.elf12.net> <1133133083.13629.43.camel@blade> <20051127234927.GI15156@polar.elf12.net> <1133136167.13629.58.camel@blade> <20051128015303.GJ15156@polar.elf12.net> <1133143721.13629.67.camel@blade> <20051128022901.GK15156@polar.elf12.net> <1133146623.13629.74.camel@blade> <20051128084428.GL15156@polar.elf12.net> <1133168403.31513.2.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133168403.31513.2.camel@blade>
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
Date: Mon, 28 Nov 2005 10:21:01 +0100

> > > If hcidump is showing nothing, then the device is not sending any report
> > > at all. This means the device is at fault if it is jumpy.
> > 
> > Of course. That's clear. - But still believe that it's possible to
> > influence it in this behaviour.
> 
> maybe, but then this is Wacom specific.

Okay, I will pester the wacom guys more... (-:

> > > > > What does the pairing button do? It makes the device discoverable and
> > > > > pairable, right?
> > > > 
> > > > I think so. It is already a "long time" ago, because some things did
> > > > work with the pairing auth/enc switched on, but it did not end up
> > > > working (to the level it does without)...
> > > 
> > > Don't even think about switching into security mode 3. Use the -E switch
> > > of hidd instead.

Why? What is the difference?

> > Man page and hidd --help output don't say it: what does the -E switch?
> 
> This is a lack in the documentation. The -E switch works the same as in
> pand and dund. It establishes encryption (and authentication) for every
> keyboard device.

Okay, hidd is running with "--server -E". No visible change. Where could
I actually look at to verify the encryption? Anyway
/etc/bluetooth/link_key is zero bytes long. - Where would the key be?



Robert


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
