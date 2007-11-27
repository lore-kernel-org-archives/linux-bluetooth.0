Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0711270003r2e32f78ev18205a8381d750d3@mail.gmail.com>
Date: Tue, 27 Nov 2007 09:03:05 +0100
From: "Andrea Galbusera" <gizero@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1196055392.4217.41.camel@aeonflux>
MIME-Version: 1.0
References: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
	<1192630825.6184.17.camel@violet>
	<f8e53fb0711250754n60de59f7md759b9d21f39ec53@mail.gmail.com>
	<1196055392.4217.41.camel@aeonflux>
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

Hi Marcel,

On Nov 26, 2007 6:36 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> a small comment up-front. Top-posting is not a good way of getting my
> attention. Check http://www.bluez.org/lists.html

You are obviously right! I apologize to you and other users of the
list for the inconvenience. That was accidental and was not intended
as a way to catch more attention. I understand that some of my
questions may sound silly to you and other bluez developers, but I
don't have a wireless communication background and I'm trying to
approach bluetooth from the application level.

> It takes 20 seconds, because that is the page timeout of your local
> hardware. You can change it with "hciconfig hci0 pageto". You can also
> play with the link supervision timeout to faster detect a link loss.
> Please remember that a shorter value also has disadvantages.

I will search more on these timeouts and the pro/cons of changing
them. Maybe tuning them will suffice.

> It serializes connection attempts to different remote devices. If you
> try to connect to the same remote device (by opening the same TTY twice)
> then you are out of luck. The kernel is not doing anything here.

My question was not clear enough... In my test I try to connect to a
different remote address while in progress with the first one (both
powered off). I do it like this:

Terminal 1:
$> rfcomm connect 00:01:95:07:30:EA

Terminal 2 (while the first attempt is in progress):
$> rfcomm connect 00:01:95:07:30:40
Can't connect RFCOMM socket: Device or resource busy

Does it mean my kernel and/or my bluez-utils are too old to queue
connection attempts?

> You need to read the specification since clearly you are guessing here
> behavior. The various timeouts can be configured. Or maybe get a book
> that explains the basics behind the Bluetooth radio.

I'm going to follow your suggestions, even if I believe the
specification is too intricated for me. Maybe a book is a better
choice. Thanks for patience.

Regards,
Andrea

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
