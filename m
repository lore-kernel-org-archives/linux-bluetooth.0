Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Vitaliy Pronkin <vit@mifki.ru>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085360239.5329.19.camel@n-vit>
References: <loom.20040523T164826-243@post.gmane.org>
	 <1085324502.8309.19.camel@pegasus>
	 <loom.20040523T170840-699@post.gmane.org>
	 <1085326200.8309.22.camel@pegasus>  <1085327326.29252.169.camel@n-vit>
	 <1085328263.8309.25.camel@pegasus>  <1085328722.23050.175.camel@n-vit>
	 <1085351626.8309.91.camel@pegasus>  <1085360239.5329.19.camel@n-vit>
Content-Type: text/plain
Message-Id: <1085377686.9779.2.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: help me
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 24 May 2004 07:48:07 +0200

Hi,

> It seems that I found the problem. 
> Don't know why, but select() in main loop of sdpd never returns, even if
> there's some data in socket.
> I implemented some temporary solution to test - I created two threads,
> one for l2cap sockets and one for local. Each of them runs accept() in a
> loop. And in main loop I left only check_active(). So now I don't use
> select() function and it works - at least PDA can get list of services
> from laptop.

I read something about non working select() on LKML, but I thought this
was 2.6. However you should update your kernel to the latest -pre from
Marcelo and or use the latest stable with my -mh patch.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
