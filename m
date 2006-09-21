Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d23110170609211259j164c0167ib751ab3ee2f75079@mail.gmail.com>
References: <450603BA.3090302@vasmac.com>
	<Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>
	<1158050613.14015.1.camel@localhost>
	<Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
	<45081402.8020909@vasmac.com>
	<Pine.LNX.4.63.0609141052130.22339@redbean.intranet.gw-instruments.de>
	<1158313791.5233.9.camel@localhost>
	<d23110170609200748u4d16a947q9cfa716825ea44b7@mail.gmail.com>
	<1158764715.10356.0.camel@localhost>
	<d23110170609211259j164c0167ib751ab3ee2f75079@mail.gmail.com>
Date: Thu, 21 Sep 2006 22:05:53 +0200
Message-Id: <1158869153.11194.60.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] socket connect returns EAGAIN
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

Hi Ulisses,

> > what about the server socket. In this case EAGAIN is fine.
> 
> Yes, in this case EAGAIN is fine. However, I don't think we are even
> calling bt_sock_wait_state() for a server socket (please, correct me
> if I'm wrong) so changing EAGAIN to EINPROGRESS inside
> bt_sock_wait_state() should just work, right? (we just  need to fix
> rfcomm_session_create() too and that's it).

looks like it is okay, care to send a patch.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
