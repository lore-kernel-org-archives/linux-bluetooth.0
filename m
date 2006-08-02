Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: neci <robo.neci@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 2 Aug 2006 23:50:07 +0200
References: <200608021725.01649.robo.neci@gmail.com>
	<200608022226.21020.robo.neci@gmail.com>
	<20060802214634.GD25403@suse.de>
In-Reply-To: <20060802214634.GD25403@suse.de>
MIME-Version: 1.0
Message-Id: <200608022350.09592.robo.neci@gmail.com>
Cc: Stefan Seyfried <seife@suse.de>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

linux:/dev # rfcomm
rfcomm0: 00:01:E3:58:23:EA channel 1 closed

Stefan Seyfried write:
> On Wed, Aug 02, 2006 at 10:26:19PM +0200, neci wrote:
> > doing something wrong? i can upload files with OBEX object push client.
> >
> > linux:/dev # cd /dev && mknod rfcomm0 c 216 0 && mknod rfcomm1 c 216 1
> > linux:/dev # chmod 666 /dev/rfcomm*
> > linux:/dev # ls | grep rfcomm
> > rfcomm0
> > rfcomm1
> > linux:/dev # hcitool scan
> > Scanning ...
> >         00:01:E3:58:23:EA       Neci
> > linux:/dev # rfcomm bind 0 00:01:E3:58:23:EA 1
> > Can't create device: Address already in use
>
> output of just plain "rfcomm"?
>
> Oh - and stripping a bit of the useless quotes surely would not
> hurt :-)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
