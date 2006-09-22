Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <beb7688e0609220628p6239199ai9c5479725e09b894@mail.gmail.com>
Date: Fri, 22 Sep 2006 09:28:49 -0400
From: "Chris S" <chrisspen@gmail.com>
To: "Paul LeoNerd Evans" <leonerd@leonerd.org.uk>
In-Reply-To: <20060922091022.3a8f4ee8@nim.leo>
MIME-Version: 1.0
References: <451334F6.2010707@gmail.com> <eevdff$gco$1@sea.gmane.org>
	<20060922091022.3a8f4ee8@nim.leo>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
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

On 9/22/06, Paul LeoNerd Evans <leonerd@leonerd.org.uk> wrote:
> On Thu, 21 Sep 2006 21:15:26 -0400
> Chris Spencer <gmane.20.evilspam@spamgourmet.com> wrote:
>
> > [root@localhost]# hidd --connect 00:0D:3C:40:68:7C
> > <window popped up asking for a passkey>
> > Can't get device information: Too many levels of symbolic links
> > [root@localhost]# hidd --connect 00:0D:3C:40:68:7C
> > Can't get device information: Function not implemented
>
> Random guess, but that to me looks like "errno" is getting undefined
> values and is printing whatever random number of error it happens to find.

I continued to play around with it, and tried using kbluetoothd to
connect. When I was again prompted for a passkey, I keyed it in on
both my PC and on the keyboard, and it suddenly started working. I'm
not confident I could get this working again if I had to. Is there a
tutorial somewhere on pairing bluetooth devices? I didn't find
anything on bluez.org.

Regards,
Chris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
