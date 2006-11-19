Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45603A25.9080806@surrel.org>
Date: Sun, 19 Nov 2006 12:04:05 +0100
From: Valentin SURREL <dev@surrel.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] PATCH for dund : correct --dialup behavior (Tomtom
	GPS)
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

Hello,

I've found a little problem when trying to connect my Tomtom One GPS to 
the Intenet via my computer.

Tomtom GPS expect to find a GSM Phone with DUN. I changed the class in 
/etc/bluetooth/hcid.conf to 0x520204.
Then I started dund with the correct options (--dialup particularly).

It did'nt work, Tomtom claiming that my 'phone' have not DUN.

I made this very little modification to dund/sdp.c :

./bluez-utils-3.7/dund$ diff sdp_original.c sdp.c
173a174,176
 >       case DIALUP:
 >               sdp_uuid16_create(&svclass, DIALUP_NET_SVCLASS_ID);
 >               break;

After that, it works perfectly. Maybe this patch should be integrated 
into the official Bluez utils...

Valentin SURREL


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
