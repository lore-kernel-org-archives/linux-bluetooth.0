Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AB5463.80503@palmsource.com>
Date: Mon, 15 Jan 2007 11:16:03 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150305.07478.bluez-devel@huitl.de>
In-Reply-To: <200701150305.07478.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] a2dpd: cmdplay fails: "No such application:
 'amarok player play'"
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
The command line is restricted to one program (dcop) and one parameter =

(amarok player play). You can overcome this issue by doing a shell =

script taking one parameter which will it turn execute your program =

using whatever parameters you want.

Fr=E9d=E9ric

Robert Huitl a =E9crit :
> Hi again,
>
> the cmd* functions do not work for me:
> cmdplay=3Ddcop amarok player play
>
> When I press the play button, the following line is print (from somewhere =

> inside the execlp() call):
> No such application: 'amarok player play'
>
> I hacked around this problem by using system() instead of execlp():
>
> Index: a2dpd_ipc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/a2dpd/a2dpd_ipc.c,v
> retrieving revision 1.3
> diff -u -r1.3 a2dpd_ipc.c
> --- a2dpd_ipc.c 12 Jan 2007 16:34:01 -0000      1.3
> +++ a2dpd_ipc.c 15 Jan 2007 02:02:15 -0000
> @@ -384,8 +384,10 @@
>                                  close_server_socket_on_fork();
>
>                                  // Replace children with new process
> -                                i =3D execlp(command, command, argv[0], =
NULL);
> -                                DBG("execlp failed %s=3D%d (errno=3D%d:%=
s)", cmd, =

> i, errno, strerror(errno));
> +                                system(cmd);
> +                                exit(0);
>                                  break;
>                          case -1:
>                                  // failed
>
>
> Regards,
>   Robert
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-- =

Frederic

Without the wind, the grass does not move.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
