Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <Sch@ttgen.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Inquiry scans.
References: <403A1ECE.6030005@superbug.demon.co.uk>
In-Reply-To: <403A1ECE.6030005@superbug.demon.co.uk>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402231838.53701.Sch@ttgen.net>
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
Date: Mon, 23 Feb 2004 18:38:53 +0100

On Monday 23 February 2004 16:39, James Courtier-Dutton wrote:
> I have a Nokia 6310i mobile phone.
> It has a bluetooth menu item that says: -
> "Search for audio accessories"
>
> If I activate this on the Nokia, it finds the Bluetooth headset.
>
> In Bluez, in hcidump, I would expect to see these requests/responds
> between those two devices, but I see nothing.
>
> If bluez never sees the Inquiry scan from the Nokia, how will bluez ever
> be able to respond?

You can't see inquiry scans with hcidump. Afaik there is no way to find out if 
your bluetooth adapter responded to an inquiry from another device.
The nokia probably looks a the device class - which is returned as part of an 
inquiry result - of the bluetooth device to find out if it is a 
headset/handsfree or not, so it can single out the headsets
without having to use SDP (which is visible in hcidump).
If you set the device class of your computer to 0x700408 for instance, the 
phone should recognize your computer as a handsfree. Problem is that most 
devices will place a headset icon next to your computers name in the device 
list now ;)

greetings
Fred

-- 
Fred Schaettgen
Sch@ttgen.net


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
