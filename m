Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Feldman <wb0gaz@hotmail.com>
To: bluez-users@lists.sourceforge.net
Cc: wb0gaz@hotmail.com
Message-Id: <20040621135136.7C703C50.wb0gaz@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Bluez-users] How is pairing completed in rfcomm?
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
Date: Mon, 21 Jun 2004 13:51:36 -0600

I'm working on getting my RH9 laptop to communicate with T68 (not i), 
and I made
another step forward, but I can't complete the "pairing" process (
which is where the
phone picks up the identity of a PC and makes that PC "OK" for future 
data operation.)

My steps:

insert card, do cardctl insert.
hciconfig hci0 up
rfcomm /dev/rfcomm0 MAC-ADDRESS 1    (1 is for DUN on this phone)

Now at this step I gave the phone the instruction to add to paired 
devices, with
the option "phone accepts".

Then, I did this:

cat </dev/rfcomm0

at which point the phone displays the PC's name, then asks for a PIN.

I entered the PIN (a 4-digit code) that I had previously configured

Now the phone says "pairing..." and waits forever.

If I interrupt the cat </dev/rfcomm0 with Control-C,

then the following is seen:

1. Any output (echo, cat, etc.) to /dev/rfcomm0 produces the error 
message:
"bash: /dev/rfcomm0: Operation already in progress"

2. The rfcomm command produces the message:
rfcomm0: MAC-ADDRESS channel 1 disconnecting

Marcel had advised me to update to the latest kernel - I am not in a 
position to
do this immediately, and it I hope the pairing process would be able 
to proceed
in any event, if I am using the correct procedure. I am using Kernel 2.
4.20-31.9,
which was current as of 04/2004; as the phone is nearly 2 years old, 
I'm hoping
I can validate it's operation at least through the pairing process.

So my core question - how do I complete the pairing process, when 
initiated
by the PC and accepted by the phone?

Dave
wb0gaz@hotmail.com



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
