Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F7972D.7080709@yahoo.com.au>
Date: Wed, 14 Mar 2007 07:33:17 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <57c68ddc0703130100v68ef402dx647e81460d5ff189@mail.gmail.com>
In-Reply-To: <57c68ddc0703130100v68ef402dx647e81460d5ff189@mail.gmail.com>
Subject: Re: [Bluez-users] suitable BT USB dongle
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

siddhant tewari - siddhant.tewari@gmail.com wrote:
> hi Marcel,
>              Can you suggest which BT USB dongle i should use , which can
> support all the latest bluetooth 2.0 specification features namely:-
> 
>              i) EDR.
>              ii) Multiple Connections.
> 
> With bluez.

Since no-one else has piped up, and I've recently been through this
myself, here's my experience...

First, you want a dongle with the CSR (Cambridge Silicon Radio)
"Bluecore" chipset.  There are various versions of Bluecore, the latest
seems to be Bluecore 4.  CSR chips seems to be more stable and just
generally work better.  Also, since the bluez developers all prefer CSR
chips, the equipment they buy for themselves tends to be CSR, which
means bluez tends to be better supported with CSR.

Of course that now raises the question, how can you know which dongles
are CSR?  And it's not easy.  There's some information here from the
last time I asked:

http://sourceforge.net/mailarchive/forum.php?thread_id=31657125&forum_id=1883

If you get a Bluetooth 2.0 dongle, then you definitely have EDR (unless
I've spectacularly misunderstood something).  EDR is basically the whole
point of Bluetooth 2.0.

Similarly, every bluetooth dongle, no matter what version, should
support multiple connections.  Mainly this is up to the software to
support elegantly.

Having said that though, I recently bought a dongle and tried to use it
with a bluetooth headset (high quality audio, A2DP) and a mouse
simultaneously.  If I was using the mouse, the audio kept cutting out.
I don't know if this is the fault of the hardware or the software.  But
in any case, multiple connections were working, it's just that they
weren't working fast enough for A2DP.  Maybe if it was a Bluetooth 2.0
dongle this would have worked better.

And the last question is, what range do you need?  My experience has
been that if the devices are in the same room, a class 2 device is
enough, but if you want to communicate between rooms, get a class 1
device.  Most bluetooth dongles are class 2, so if you need class 1 it
might be harder to find something.

Hope this helps, and I hope other people reading the list will jump in
to correct anything I've got wrong.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
