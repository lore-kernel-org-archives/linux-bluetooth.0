Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <c5cec3110607192037w3d5a3086ib00ff4d6c8b5c93@mail.gmail.com>
References: <c5cec3110607192037w3d5a3086ib00ff4d6c8b5c93@mail.gmail.com>
Date: Wed, 26 Jul 2006 09:27:06 +0200
Message-Id: <1153898826.746.16.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] usb device problem
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

Hi Bees,

>     I ported the bluez-libs-2.25 and bluez-utils-2.25 to an embedded
> system last week, but when I plug my usb bluetooth dongle into the
> board, it says"usb device not accepting new address", so I can't use
> my bluetooth dongle in this embedded system.
>     I'sure my usb bluetooth is well, it worked normally on PC
> (FedoraCore4). 
>     And the usb interface on board is well too, because when I pluged
> my U-disk into it ,the U-disk worked normally.
>     Then why my usb dongle didn't work on the embedded system board?

what kernel version are you using? The recent 2.6 kernels are a little
bit more robust when it comes to cheap USB hardware.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
