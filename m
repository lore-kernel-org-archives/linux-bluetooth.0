Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b621074b0704020400r2e1500d5u4972031e010a05e5@mail.gmail.com>
References: <b621074b0704020400r2e1500d5u4972031e010a05e5@mail.gmail.com>
Date: Mon, 02 Apr 2007 13:03:16 +0200
Message-Id: <1175511796.5815.329.camel@violet>
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

> I'm getting some problem while using Bluez hci function calls. The
> pseudo code is as under:
> 
> ...
> devId = hci_devid(addr);
> sock = hci_open_dev(devId);
> ...
> fcntl(sock, F_SETFL, O_NONBLOCK); /** whats the problem ??? */
> ...
> hci_read_local_name(sock, size, name, 0)
> ....
> 
> 
> If I comment call to fcntl()  , I get correct name of device by using
> hci_read_local_name() function. 
> But if the call is made to fcntl(),  subsequent  calls of hci_*
> function does not work properly. In fact hci_read_local_name()
> returns  null name.  
> Any idea what is the problem with usage of  fcntl() this way ?

I never tried to have a non-blocking HCI socket. And I have no idea why
you actually need it. It is better to use the D-Bus API anyway.

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
