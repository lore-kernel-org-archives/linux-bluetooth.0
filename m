Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0702280423h737f8190n1fa76f35ea4413@mail.gmail.com>
References: <57c68ddc0702280423h737f8190n1fa76f35ea4413@mail.gmail.com>
Date: Sat, 03 Mar 2007 12:33:57 +0100
Message-Id: <1172921637.24446.15.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] error while making call to ioctl for releasing
	a	device
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

Hi Siddhant,

>    I am trying to obex push a file through rfcomm channel. Everything
> goes fine (including sending of file) until i try to release the
> device via call to ioctl
> 
> exact call is 
> 
> ioctl(sock,RFCOMMRELEASEDEV,&req) 
> 
> with error  " Bad File Descriptor".
> 
> Can anyone give me a hint abt why can this happen..
> Waiting for some reply

without looking at the code, I can't tell you anything. However you
should use the RFCOMM socket directly and not the virtual TTY. It is not
needed to put another kernel layer in between.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
