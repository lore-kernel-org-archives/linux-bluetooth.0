Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Inquiry scans.
From: Stephen Crane <steve.crane@rococosoft.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403A1ECE.6030005@superbug.demon.co.uk>
References: <403A1ECE.6030005@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077555891.1955.90.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: Mon, 23 Feb 2004 17:04:52 +0000

The Nokia is probably making its decision on the basis of the
class-of-device field returned by a device inquiry. 

I'm not sure if this is visible above the HCI level.

On Mon, 2004-02-23 at 15:39, James Courtier-Dutton wrote:
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
> 
> Cheers
> James
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
