Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 07 Mar 2007 12:17:32 +0100
From: =?iso-8859-1?Q?=22Hans-J=FCrgen_Lange=22?= <Hans-Juergen.Lange@gmx.de>
Message-ID: <20070307111732.15900@gmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Wrong installation path of configuration files
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

i did install the bluez-utils-3.9 from source. 
configure --help tells me that all files are installed below /usr/local which is nice to keep the system clean.
But after running make install i find the hcid.conf and the dbus configuration files in /etc and not where expected in /usr/local/etc
Is it possible to move the configuration files from /etc to /usr/local/etc ?

Anyway I think its wrong in the installation or the description of the default behavior of make install.

BR
Hans-Juergen
-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
