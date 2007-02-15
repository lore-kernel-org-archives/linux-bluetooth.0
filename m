Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D4ED2D.7060706@mojo-working.com>
Date: Thu, 15 Feb 2007 15:30:53 -0800
From: Art Rothstein <art@mojo-working.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45D3F804.5030601@mojo-working.com>
	<1171527486.28302.14.camel@violet>
In-Reply-To: <1171527486.28302.14.camel@violet>
Subject: Re: [Bluez-devel] Role switch: Detecting, predicting, preventing
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I have incorporated your hci_conn_info test into a minimal test case derived 
from my application.  You can find source, executable, and hcidump traces at 
http://65.104.11.121/TwoAdapters .  Both cases were run on the same desktop PC, 
with the same two USB dongles.  The client adapter was a Motorola PC850, and the 
server an IOGear GBU211.  Both run LM 1.2 on a member of the Broadcom 2035 
family.  The -386 traces were run with Ubuntu 2.6.17-11-386 installed on a hard 
disk.  The -generic traces were run with Ubuntu 2.6.17-10-generic, booted from 
the Ubuntu 6.10 live CD.  As before, hciconfig always reports SLAVE ACCEPT, and 
the role change flows in the -386 case.

Thanks very much for your help.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
