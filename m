Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 5 Apr 2007 11:43:24 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070405094324.GA9948@suse.de>
MIME-Version: 1.0
Subject: [Bluez-devel] Microsoft Bluetooth Keyboard, "missinig" keys
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

Hi,

i got one of those:

http://www.microsoft.com/hardware/mouseandkeyboard/productdetails.aspx?pid=033

and it works pretty well with 2.6.21rc5, even most of the previously
unhandled "silver" keys around the main keyboard and the wheel work fine.
However, some of the silver keys do not work. They show up neither with
showkey nor with evtest.

I can see they do transmit something with hcidump -X -V.

So the question is: what information do i need to supply (and to whom :-)
to make all the keys work?

-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
