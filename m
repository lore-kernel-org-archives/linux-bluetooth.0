Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY107-F1712202F8AB9BFB5AC45CBD8650@phx.gbl>
From: "Adolfo Bulfoni" <iaquintovski@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 05 Apr 2007 10:05:41 +0200
Mime-Version: 1.0
Subject: [Bluez-devel] intercept new authentication events
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

Hi guys, I'm developing a java apps that exploits the BlueZ stack via JNI 
and some C functions.
Now, I'd like that my app intercept the event that happens when a new remote 
device wants to authenticate itself with my bt dongle (i.e. wants to trigger 
the pair procedure).
I've searched in the hcitool.c file and found and found the function:
static int conn_list(int s, int dev_id, long arg)
that prints all the active connections from and to my bt dongle. But this 
function is not what I'm looking for, since it is not a callback function 
and most important it prints out all the connections (including data ones).
Does exist a way to know if a new remote device want to pair with my bt 
dongle? And if so, what are the functions I need to look at?

Adolfo

_________________________________________________________________
Scopri gli ospiti di MSN VideoVip! E intervieni in diretta! 
http://videovip.it.msn.com/


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
