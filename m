Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <458169FA.2040803@adamis.de>
Date: Thu, 14 Dec 2006 16:12:58 +0100
From: Mathias Adam <a1@adamis.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4434.195.146.105.162.1166011822.squirrel@mserv.smecno.net>
In-Reply-To: <4434.195.146.105.162.1166011822.squirrel@mserv.smecno.net>
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
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

Hi,

Jan SVETLIK wrote:
> Hello all. A have too problem with PCMCIA Billiongton PCBTC1.
> 
> root@r51:# cardctl insert
> 
> Dec 10 09:34:45 localhost kernel: pccard: PCMCIA card inserted into slot 0
> Dec 10 09:34:45 localhost kernel: pcmcia: registering new device pcmcia0.0
> Dec 10 09:34:45 localhost cardmgr[4761]: socket 0: Serial or Modem
> Dec 10 09:34:45 localhost kernel: ttyS2: detected caps 00000700 should be
> 00000100
> Dec 10 09:34:45 localhost kernel: 0.0: ttyS2 at I/O 0x3100 (irq = 3) is a
> 16C950/954
> Dec 10 09:34:46 localhost cardmgr[4761]: executing: './serial start ttyS2 2>&1'
> Dec 10 09:34:46 localhost cardmgr[4761]: + udev active, devices will be
> created in /dev/.static/dev/
[...]
> root@r51:# hciattach ttyS2 billionton 115200  (i tried 115200 and 6550 too)
> BCSP initialization timed out
[...]
> root@r51:# hciattach ttyS2 bcsp 115200  (i tried 115200 and 6550 too)
> BCSP initialization timed out

as your card uses a 16C950/954 too you could try this kernel patch:
http://www.adamis.de/linux/bt-socket.html

Or simply try a kernel 2.4.

Regards
Mathias

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
