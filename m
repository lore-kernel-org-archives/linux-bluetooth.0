Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <beb7688e0609220628p6239199ai9c5479725e09b894@mail.gmail.com>
References: <451334F6.2010707@gmail.com> <eevdff$gco$1@sea.gmane.org>
	<20060922091022.3a8f4ee8@nim.leo>
	<beb7688e0609220628p6239199ai9c5479725e09b894@mail.gmail.com>
Date: Mon, 25 Sep 2006 23:47:06 +0200
Message-Id: <1159220826.20997.21.camel@localhost>
Mime-Version: 1.0
Cc: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
Subject: Re: [Bluez-users] Keyboard Device Pairing (gmane: message 13 of 20)
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

Hi Chris,

> > > [root@localhost]# hidd --connect 00:0D:3C:40:68:7C
> > > <window popped up asking for a passkey>
> > > Can't get device information: Too many levels of symbolic links
> > > [root@localhost]# hidd --connect 00:0D:3C:40:68:7C
> > > Can't get device information: Function not implemented
> >
> > Random guess, but that to me looks like "errno" is getting undefined
> > values and is printing whatever random number of error it happens to find.
> 
> I continued to play around with it, and tried using kbluetoothd to
> connect. When I was again prompted for a passkey, I keyed it in on
> both my PC and on the keyboard, and it suddenly started working. I'm
> not confident I could get this working again if I had to. Is there a
> tutorial somewhere on pairing bluetooth devices? I didn't find
> anything on bluez.org.

there is no really tutorial. And in case or pairing problems it helps to
run "hcidump -X -V" to see what is going on. However with the D-Bus API
you have a CreateBonding command that will take care of everything and
at some point we will have a connection wizard. If I have enough free
time to write all this GUI stuff. I am not really a GUI programmer.

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
