Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 2 Aug 2006 23:46:34 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060802214634.GD25403@suse.de>
References: <200608021725.01649.robo.neci@gmail.com>
	<200608022158.27059.robo.neci@gmail.com>
	<44D10743.6080800@ibdcon.org.br>
	<200608022226.21020.robo.neci@gmail.com>
Mime-Version: 1.0
In-Reply-To: <200608022226.21020.robo.neci@gmail.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Connection refused
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Aug 02, 2006 at 10:26:19PM +0200, neci wrote:
> doing something wrong? i can upload files with OBEX object push client.
> =

> linux:/dev # cd /dev && mknod rfcomm0 c 216 0 && mknod rfcomm1 c 216 1
> linux:/dev # chmod 666 /dev/rfcomm*
> linux:/dev # ls | grep rfcomm
> rfcomm0
> rfcomm1
> linux:/dev # hcitool scan
> Scanning ...
>         00:01:E3:58:23:EA       Neci
> linux:/dev # rfcomm bind 0 00:01:E3:58:23:EA 1
> Can't create device: Address already in use

output of just plain "rfcomm"?

Oh - and stripping a bit of the useless quotes surely would not
hurt :-)

-- =

Stefan Seyfried                     | "Please, just tell people
QA / R&D Team Mobile Devices        |               to use KDE."
SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
