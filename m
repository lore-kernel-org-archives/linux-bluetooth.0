Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b621074b0704020451o3bde514ay12d20cece9c71846@mail.gmail.com>
References: <b621074b0704020400r2e1500d5u4972031e010a05e5@mail.gmail.com>
	<1175511796.5815.329.camel@violet>
	<b621074b0704020451o3bde514ay12d20cece9c71846@mail.gmail.com>
Date: Mon, 02 Apr 2007 14:04:14 +0200
Message-Id: <1175515454.5815.340.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Usage of fcntl for non blocking mode...
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

Hi Tushar,

> Actually this code is part of bluetooth implementation of jsr82 in
> phonme project.
> Does making non-blocking HCI socket helps in any way for function
> calls such as  hci_send_cmd ?. Or is there any other advantage ?

no. It makes no difference. The HCI socket has specific semantics
anyway.

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
