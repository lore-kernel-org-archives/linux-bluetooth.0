Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 4 Mar 2007 21:58:38 +0000 (GMT)
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <1173045518.989564.4714.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Subject: [Bluez-devel] Link Mode
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
   I am trying to write a compatible equivalent to the Link Mode socket
options API for NetBSD, and I wonder if somebody can clarify some things
for me since I can't find any documentation about this.

I assume that RFCOMM_LM and L2CAP_LM are essentially the same, the
following bits are defined:

_LM_MASTER
	means we prefer to be master of the baseband link

_LM_AUTH
	means we want the baseband link to be authenticated

_LM_ENCRYPT
	means we want the baseband link to be encrypted

_LM_TRUSTED
	this seems unused, is there an intention?

_LM_RELIABLE
	signal error on unreliable link (means disconnect?)

_LM_SECURE
	is this somehow different than (_LM_AUTH | _LM_ENCRYPT)?

thanks,
iain

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
