Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How is pairing completed in rfcomm?
From: Marcel Holtmann <marcel@holtmann.org>
To: David Feldman <wb0gaz@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040621135136.7C703C50.wb0gaz@hotmail.com>
References: <20040621135136.7C703C50.wb0gaz@hotmail.com>
Content-Type: text/plain
Message-Id: <1087852135.4328.30.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 21 Jun 2004 23:08:55 +0200

Hi David,

> I'm working on getting my RH9 laptop to communicate with T68 (not i), 
> and I made
> another step forward, but I can't complete the "pairing" process (
> which is where the
> phone picks up the identity of a PC and makes that PC "OK" for future 
> data operation.)
> 
> My steps:
> 
> insert card, do cardctl insert.
> hciconfig hci0 up
> rfcomm /dev/rfcomm0 MAC-ADDRESS 1    (1 is for DUN on this phone)

it is "rfcomm bind 0 <bdaddr> [channel]".

> Now at this step I gave the phone the instruction to add to paired 
> devices, with
> the option "phone accepts".
> 
> Then, I did this:
> 
> cat </dev/rfcomm0
> 
> at which point the phone displays the PC's name, then asks for a PIN.
> 
> I entered the PIN (a 4-digit code) that I had previously configured
> 
> Now the phone says "pairing..." and waits forever.
> 
> If I interrupt the cat </dev/rfcomm0 with Control-C,
> 
> then the following is seen:
> 
> 1. Any output (echo, cat, etc.) to /dev/rfcomm0 produces the error 
> message:
> "bash: /dev/rfcomm0: Operation already in progress"
> 
> 2. The rfcomm command produces the message:
> rfcomm0: MAC-ADDRESS channel 1 disconnecting

Until you upgraded to a newer kernel I can't guarantee that this will
work. Your RFCOMM code seems to be buggy for Bluetooth 1.0b phones.

> Marcel had advised me to update to the latest kernel - I am not in a 
> position to
> do this immediately, and it I hope the pairing process would be able 
> to proceed
> in any event, if I am using the correct procedure. I am using Kernel 2.
> 4.20-31.9,
> which was current as of 04/2004; as the phone is nearly 2 years old, 
> I'm hoping
> I can validate it's operation at least through the pairing process.

The phone will work. I don't see any problem here because the Bluetooth
stack of the T68 and the T39m are identical and the T39m is working for
me.

> So my core question - how do I complete the pairing process, when 
> initiated
> by the PC and accepted by the phone?

The phone uses security level 2 and this means the security routines
kick in when you request access to the RFCOMM channel. If you want them
earlier then the use of security mode 3 is needed. Use "hciconfig hci0
auth" to activate it on your device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
