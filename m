Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Noring <noring@nocrew.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1074941532.6007.22.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] PAN data corruption
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
Date: Sat, 24 Jan 2004 11:52:25 +0100

Hi

I've been testing a Bluez PAN configuration for about a week and it
works pretty good except for a data corruption problem:

   - Using scp, copying more than a few megabytes often gives 
     "Corrupted MAC on input".

   - Using netcat, copying a 53244356 byte source file results
     in a 53243904 byte destination file. It stops 452 bytes short
     of a complete file.

I've tested this with both MSI6967 and BCM2003 devices. One box runs
Fedora Core 1 and the other is patched with patch-2.4.18-mh10.

I've disabled SCO, BNEP multicast filter, USB zero packet, BNEP 
protocol filter and most other unneeded Bluez modules. Enabling
some combination of those trigs random "ACL tx timeout" crashes 
and more problems.

Any ideas about the data corrpution?

Thanks,
Fredrik




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
