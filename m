Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436F608D.4020407@web.de>
From: Dirk Stockmann <dirk.stockmann@web.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Periodic noise on microphone with bt_sco (BTA-6030
 Dongle, Motorola H500 Headset)
References: <436F1C3B.5020002@web.de> <436F4D85.4030404@csr.com> <436F5602.1040105@web.de> <436F5B5C.7070506@csr.com>
In-Reply-To: <436F5B5C.7070506@csr.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 07 Nov 2005 15:11:25 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Steven Singer wrote:
> I agree with this diagnostic. If the headset doesn't generate noise
> when attached to another device then the noise is probably not being
> inserted at the headset end.

No noise with two different mobile phones, but with two different dongles.

> One way to confirm whether it's electrical is to record digital signal
> received from the dongle into a file, shut down the SCO link and then
> play the file to the PC's loudspeakers.

When I record "silence" from the microphone (as silent as possible) then
there is clearly the noise with about -40db power.
Is there a way to record the digital from the headset directly, before
it is processed in alsa? Similar to the way hcidump works, maybe?

> Are you sending a signal to the headset and, if so, are you hearing a
> buzz in the headset's speaker? I'm wondering if a buzz in that
> direction (coming from the sensitive microphone input on the PC) is
> being looped through the air (or through the plastic) from the
> headset's speaker to its microphone.

Sound sent to the headset from the PC (e.g. an audiobook) is without the
buzz. It is quite low quality (like on a phone) but clear.

Regards,
Dirk

- --
Key can be found on:
http://sks.keyserver.penguin.de
hkp://sks.keyserver.penguin.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDb2CMLi2VR2b1/voRAsm4AJwJh4tySPRkrzk0V88aGjDqGyzZIgCfd2g8
Q9zUy5UtvCTbifPGH9nSyzg=
=ry8L
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
