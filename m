Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Frederic Detienne <fd@cisco.com>
Reply-To: fd@cisco.com
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1078912919.32148.356.camel@metal.cisco.com>
Mime-Version: 1.0
Subject: [Bluez-users] Logitech MX900 oddities and solutions
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
Date: Wed, 10 Mar 2004 11:02:00 +0100

Hello,

I have a Logitech MX900 (purchased in Belgium) whose hub I want to use
in Bluetooth mode. It has a CSR chip that boots in USB-HID mode and must
be switched to HCI mode through a Bluez tool called hid2hci. I want to
report my experience as this was not as easy as it seemed and also would
like to report some issues.

Before I start, thanks a lot to the Bluez developers for bringing this
great thing to Linux!! I will stop the kudos straight here but just to
let you know there is no offense in what I will say below; just
feedback.

Credits: I have found a lot of info on this mailing list and under the
two following links:

http://www.bueche.ch/comp/mx900/mx900.html
http://www.bueche.ch/comp/mx900/feedback/ghisoli_alexandre_mx900_with_hub.txt

Obviously my mileage varied and here is the delta.

Diclaimer: I am a total Bluetooth idiot; forgive and correct errors I
made please.

For starters, I patched a stock 2.6.3 Linux kernel with the -mh4 patch,
then I downloaded and installed bluez-libs2 and bluez-utils2 from CVS in
order to obtain hid2hci. First problem is that the "compat" tools
Makefile (including hcitool) needed to be compiled separately. This is
sad since hcitool is very useful to ensure your hub is really alive.

Second problem is that hid2hci needs to pass multibyte commands to the
USB-BT hub and the -mh4 patch does not support that. I had to manually
overpatch the kernel with instructions found here:

http://sourceforge.net/mailarchive/forum.php?thread_id=3803086&forum_id=1883

I would have expected this patch to be part of -mh4 (that is what I
remember having read) but it was not there. It should! :-) I can't wait
to have the patches synced to the 2.6 kernel tree.

Third problem is that hid2hci did not recognize my Logitech hub. Looking
through the code showed that the vendor/product id's are hardcoded
(that's fair) but my device was not in the list. Here is an excerpt of
lsusb:

Bus 001 Device 009: ID 046d:c705 Logitech, Inc.
                               ^
                               |
     culprit ------------------+

So I patched hid2hci to recognize 046d:c705 as a Logitech thingy. Beware
that I bought the mouse in Belgium and there may be more unknown ID's in
the world wild wireless mess (wireMess?).

Running the fixed hid2hci effectively switched the base station into a
recognized Bluetooth "hub".

Here we go! This is where the technical part ends and the esoteric part
begins.

I then used bthid to have the mouse recognized. It worked but not quite
fine: the mouse was jaggy or jumpy. I do not know how to explain... it
seemed like the events were queued and delayed somewhere, causing the
mouse to move slower than it should have (lagging behind), then all
those messages would be released in a burst and the mouse would jump
forward, suddenly reaching the position it would have had if it had not
lagged behind. This made the mouse hardly usable (very imprecise).

I tried the other bthid from here:

http://www.visi.com/~pmk/msbtkb-linux.html

with no more success; I had to patch it to work with the compat Bluez
library, and that new bthid worked but the problem was the same. The
various options of that bthid are rather interesting, though.

Well... I stopped and restarted bthid (both versions) a gazillion times
with various options, disconnected all my wireless stuff at home to rule
out interferences, re-paired the mouse,... without success; the mouse
was still jumpy. Until this morning when I compiled hcid (from util2
compat), launched it and restarted bthid. The mouse movement was super
fine! I am dumb wrt/ Bluetooth but I did not understand. So I stopped
hcid and bthid and restarted bthid alone (the Bluez one) and the mouse
still worked perfectly.

Sounds like spraying chicken blood on the keyboard or doing the magic
dance. I am looking for an explanation... what has hcid got to do with
that ?

At the moment, my MX900 works like a charm in BT mode and the Logitech
hub sees my Nokia phone too. I will play more with that when I have
time.

thanks and regards,

	fred




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
