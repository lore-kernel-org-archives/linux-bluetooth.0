Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <f8e53fb0711250754n60de59f7md759b9d21f39ec53@mail.gmail.com>
References: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
	<1192630825.6184.17.camel@violet>
	<f8e53fb0711250754n60de59f7md759b9d21f39ec53@mail.gmail.com>
Date: Mon, 26 Nov 2007 06:36:32 +0100
Message-Id: <1196055392.4217.41.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] concurrent calls to RFCOMM connect()
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andrea,

a small comment up-front. Top-posting is not a good way of getting my
attention. Check http://www.bluez.org/lists.html

> I have been reading and thinking on this issue but need some more
> clarification. After reading RFCOMM documentation on BlueZ's site I
> wasn't able to get it clear, so I set up this simple experiment: usign
> bluez rfcomm utility I try to connect to an unavailable (powered off)
> device.
> 
> $> rfcomm connect 00:01:95:07:30:EA
> 
> It takes about 20 seconds to timeout with a reasonable "Host is down"
> error. This means to me an internal bluez rfcomm socket timeout,
> correct?. In the meanwhile, if I make another call to rfcomm connect,
> I get "Device or resource busy". I understand this as: "there is no
> way other than serializing connection attempts". Is this an intrinsic
> behaviour of the rfcomm implementation or might it depend on the
> specific hardware I use? I did this test on my Ubuntu 2.6.20 kernel
> with rfcomm ver 3.9.

It takes 20 seconds, because that is the page timeout of your local
hardware. You can change it with "hciconfig hci0 pageto". You can also
play with the link supervision timeout to faster detect a link loss.
Please remember that a shorter value also has disadvantages.

> In your reply to my original post (attached) you said that newer
> kernel are supposed to do some queuing on the request... Does it mean
> that my test should have behaved differently?

It serializes connection attempts to different remote devices. If you
try to connect to the same remote device (by opening the same TTY twice)
then you are out of luck. The kernel is not doing anything here. And why
should it? If it just failed a few milliseconds ago, why should the
attempt succeed now. It might be, but it is unlikely and blocking the
baseband with another page attempt makes no sense here.

> My concern is that I have to be able to keep four devices connected
> and implement some sort of reconnection scheme when I loose the rfcomm
> link. It is important to understand if I have to estimate a worst case
> latency on devices reconnection of about 20 seconds (the connect
> timout) multiplied by the number of unavailable devices (if I just
> implement some sort of round-robin reconnection attempt loop and I
> happen to start from the very-wrong device in the list).

You need to read the specification since clearly you are guessing here
behavior. The various timeouts can be configured. Or maybe get a book
that explains the basics behind the Bluetooth radio.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
