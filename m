Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcitool scan problems....
From: Diego Liziero <liziero.diego@unimore.it>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1C090C0C-3E51-11D9-950D-00039390D626@pepper.com>
References: <1C090C0C-3E51-11D9-950D-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1101371373.11603.24.camel@igno>
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
Date: Thu, 25 Nov 2004 09:29:32 +0100

On Wed, 2004-11-24 at 14:43 -0500, Michael Frey wrote:
> I am currently seeing strange behavior while doing "scans".
> 
> It takes me several scans to see the devices I have in range.  Also,  
> sometimes when I issue "hcitool scan" it does not even scan.  It just 
> stops immediately after printing "Scanning ...".
> 
> Can anyone explain this?
Maybe,
the default option is to search other bluetooth devices
for 8 windows (about 10 seconds).

Try to wait 10 seconds or decrease the scanning length
with option --length=how_many_win_to_use_for_searching

When you see the devices printed immediately,
it could be because they are discovered during the first
window, or because they are already in the cache,
due to a previous scan.

Regards,
-- 
Diego Liziero <diego.liziero@unimore.it>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
