Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Soenke von Stamm <bluez0406@elmo.dyn.lindenarea.net>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406281843.14536.bluez0406@elmo.dyn.lindenarea.net>
Subject: [Bluez-users] yet another Barton Keyboard problem
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
Date: Mon, 28 Jun 2004 18:43:14 +0200

Hi!

I'm new to the list but I've read about another guy's problem with this k=
b in=20
the archive. My problem might be a little different as I assume my shiny=20
lilly Barton is jast broken.

I have purchased it just a few days back, plugged it into the next comput=
er=20
(the originally supplied dongle that is) and wondered a bit why I couldn'=
t=20
access the BIOS. I had jus read in c't that this should work... (and it w=
orks=20
with my Logitech Cordless Desktop via USB)

Further on under Linux (debian sid, 2.6.[67]-mh1/custom) after some troub=
le I=20
was able to attach the mouse which then also ran in hidproxy mode, but th=
e kb=20
still refuses every connection attempt. On one machine I was able to see =
it=20
via=20

~$ hcitool inq
Inquiring ...
        00:04:61:81:75:B2       clock offset: 0x0597    class: 0x002580
        00:04:61:81:74:2B       clock offset: 0x5658    class: 0x002540
(kb is the second one)

but my home machine doesn't even give me that:

~$ hcitool inq
Inquiring ...
~$

Funny anough, the kde environment (kbluetoothd and bluetooth:/) returns=20
adresses and names. The mouse works fine now.

Connection attempts mostly look like this:

bibo:~# hcitool cc --role=3Dm 00:04:61:81:74:2B
Can't create connection: Connection timed out
bibo:~# hcitool cc --role=3Ds 00:04:61:81:74:2B
Can't create connection: Connection timed out

but sometimes I also get that error 53...

As I've read the other thread I've tried each and every option described =
there=20
but nothing helps.

Now I'm wondering if I should just return the whole package because of th=
e=20
non-operational hidproxy mode. Or I could bite the bullet and try with a=20
win98se install only for testing my hardware :-(


any advice?

tia,

	S=F6nke




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
