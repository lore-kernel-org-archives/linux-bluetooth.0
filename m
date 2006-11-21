Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <456363FF.7070801@vasmac.com>
Date: Tue, 21 Nov 2006 15:39:27 -0500
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455392B6.5060209@free.fr> <45634AFC.909@vasmac.com>
	<45635BFD.7070404@free.fr>
In-Reply-To: <45635BFD.7070404@free.fr>
Subject: Re: [Bluez-devel] New bluetooth-headset release 20061109 : nickname
 'dogfood' ; -)
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

Hi Fabien,

Please take a look at file /proc/net/unix.
It lists all opened sockets. If headsetd is running,
it's easy to tell because that is the only one that
has a string of nul characters following the name.
My patch fixes that.

Jose


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
