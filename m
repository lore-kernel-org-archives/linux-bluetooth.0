Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mitsu Hadeishi <mitsu@syntheticzero.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Suspend/resume issues with bluez
References: <200403022202.19259.mitsu@syntheticzero.com> <200403032224.08229.bluez-devel@cpinkney.org.uk>
In-Reply-To: <200403032224.08229.bluez-devel@cpinkney.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403091754.52270.mitsu@syntheticzero.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 9 Mar 2004 17:54:52 -0500

Hi,

Just a note to the list regarding suspend/resume.  I have a Thinkpad T40p 
which was having problems with bluez and suspend/resume.  I just tried 
installing the Affix drivers on my Thinkpad T40p; but I had the same problem 
(well, it was slightly different, but the upshot was, Bluetooth didn't work 
when I came back from suspend).

So I tried a suggestion written by someone else on this list, which was not 
only to unload all of the Bluetooth modules, but also unload and reload the 
USB modules.  This DID work, at least with the Affix drivers.  Perhaps the 
same trick would work with the bluez drivers.

Basically I have a script which rmmod's all the affix modules, then rmmod's 
all the usb modules I could find (usb-uhci, hid, ehci-hcd) --- though I don't 
know if I really need to unload them all.

Doing a modprobe of those modules again caused the Affix drivers to come back 
(though sometimes I have to do it twice, i.e., run the rmmod's then the 
modprobes, then rmmod's again, then modprobes again).

Mitsu

On 03/03/2004 05:24 pm, Colin Pinkney wrote:
> Since the Zaurus does not have builtin Bluetooth, every Zaurus must use
> Bluetooth CF cards so we're able to eject the card and reinsert it. Nothing
> else brings it back (apart from a reboot of course), not even things like
> 'cardctl reset'. But at least the ejecting and reinserting can be automated
> which I put into a script that is run on every resume. I guess you don't
> have this option though if the Bluetooth device is built into your laptop.
>
> BTW the Affix Bluetooth drivers have no problem with suspending and
> resuming. Is your Bluetooth device supported by Affix?
>
> - --
> Colin Pinkney
> http://www.cpinkney.org.uk
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>
> iD8DBQFARlsIioDqRlN9/eURAqT7AKDPD9uUEcDw4TezKbAf3h+EgSMwlgCfTOXK
> ttu8XI/LaXZKvCFlANA0Wmc=
> =nKSA
> -----END PGP SIGNATURE-----
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=Click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
http://www.syntheticzero.com/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
