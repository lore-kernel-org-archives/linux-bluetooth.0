Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v613)
Message-Id: <8F95FDA9-93BB-11D8-88A9-00039390D626@pepper.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: [Bluez-devel] BTHID setup...
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
Date: Wed, 21 Apr 2004 13:44:38 -0400

I now have my kernel running bluez and now want to set up the new bthid 
from CVS.

I built libs2 and utils2 and am trying to run the bthidd and get the 
following errors.

root@(none):/opt/bluetooth/bluez/sbin# ./bthidd
Can't open HIDP control socket: Invalid argument

Did I not compile something into the kernel that I need to support this?

Thanks in advance,
Michael



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
