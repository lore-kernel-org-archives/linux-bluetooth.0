Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <412DD322.1080703@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
CC: philip@lawatsch.at, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Limit communication to serveral devices
References: <412D99CA.5050209@nue.et-inf.uni-siegen.de>
In-Reply-To: <412D99CA.5050209@nue.et-inf.uni-siegen.de>
Content-Type: text/plain; charset="us-ascii"
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
Date: Thu, 26 Aug 2004 13:10:10 +0100

Michael Schmidt wrote:
> Philip Lawatsch wrote:
>> Call me paranoid but I would like to know if there is any way to limit
>> all types of communication to just several devices by checking with the
>> hardware addresses.
[...]
> When assessing your level of security (and evaluating address
> filtering), keep in mind that it's not too difficult to masquerade BT
> device addresses. You only neeed to look up the Axis OpenBT stack source
> code to figure out how to adjust the device address of certain Ericsson
> and CSR-based modules.
>
> Clearly, your main line of defense should be a strong BT PIN.

Actually, I'd disagree.

A strong BT PIN [1] should not be your main line of defence, it should
be merely your first line of defence.

If you're looking to restrict access to just a few devices then you
should trust just those few devices, not every device that can guess
the PIN. Restriction of access to services to just a few trusted
devices is your main line of defence.

Although, as Michael correctly points out, it's easy to change the
address of a BT device, authentication is designed to prevent this
attack.

The Bluetooth spec talks about various grades of devices: unknown,
known, paired and trusted. The two key points about trust are: firstly,
that it's a manual step whereas all the others may be automatic [2];
and secondly; that it's per service rather than per device.

You need not give all paired devices access to all services.

Note also that trust is granted at the service level, not at the HCI
level. The HCI level can merely authenticate a device - "the device
claiming to have address X is the same device that claimed to have
address X when you paired". Trust is granted above HCI because it's
granted by the user (who sits above HCI) not by the device below HCI.

Also, you should avoid re-pairing devices to avoid spoofing. Ideally,
you'd want a device to become untrusted if it ever re-paired.

Pairing is not a procedure to be performed every time a device wants
to connect. It should be performed once to allow the user to teach the
Bluetooth stack about a device.

If pairing were to be performed without any eavesdroppers (say in a
shielded room) then it wouldn't matter if the PIN were weak. The PIN is
used only during the initial pairing procedure and then discarded [3].

It may be worth cycling link keys occasionally by using the HCI command
Change_Connection_Link_Key. That way if an attacker did know the link
key, if they're not snooping at the time you change the link key,
they'll be locked out.

You probably also want to add application level security. There's a
phrase "defence in depth" - never rely on a single security barrier,
always use many.

I'm not sure how well BlueZ's security model matches the model in the
spec (maybe Marcel can comment). From what other people have said in
this thread, it sounds like BlueZ is missing an application to allow
users easily to grant and deny access to services.

	- Steven

[1] The GAP spec mandates that at the user interface level, the
    phrase "Bluetooth Passkey" should be used - not Bluetooth PIN.
    However, PIN is much easier to type :-)

[2] If you're having to type in a PIN then the pairing step is manual,
    but if you're handling it through a script which doesn't prompt
    the user then it's automatic.

    An individual service may be prepared to allow access from
    untrusted devices. For example, vCard exchange could be allowed
    with all devices.

    In theory you could tell your host to trust all paired devices,
    but that'd be silly - why not just reduced the access level of
    that service to 'any paired device' instead of 'trusted devices'.

[3] For reference, the PIN is used secure an initial transation during
    which two 128 bit random numbers are exchanged. The information
    from the PIN is then discarded and the link key is generated from
    the random numbers. Weak PINs mean that it's possible to snoop
    this initial transaction. However, if the transaction is not
    snooped then it doesn't matter how weak the PINs were - the random
    numbers are just as random as with a strong PIN.

    Each time you pair you're exposing your system.
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
