Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <416D23A6.3010904@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] question about hci_usb endpoint selection...
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 13 Oct 2004 14:46:30 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I already asked this before, but I want to "nail down" this problem now,
so I'm asking again and hope that someone can give some suggestions that
even my stupid brain can understand. If this is the wrong list to ask,
just point me to the correct one, and I'll post again there.

The problem is this:
when using sco and using different voice modes (0x0060 for 16bit/8kHz,
0x0040 for 8bit/8kHz), different "alternate settings" have to be used on
hci_usb.

The former answer was:
"Don't use this patch [changing the "alternate settings" selection
hardcodedly] and accept the default voice setting of 0x0060."

We really don't want to. There are MANY people out there who want to use
16 bit audio, and MANY who want to use 8bit MU_LAW. What has to be done
to make it possible to change this "alternate setting" when we actually
*need* not alternate setting "2" (16bit), but use alternate setting "1"
when needed?

Marcel pointed out that:
"You can make use of the notify() callback and adjust the alternate
setting as needed. Maybe you have to unlink and re-submit the ISOC
URB's, but the best way is to start the ISOC URB's only when a SCO
connection is created."

Uhm, sorry. What? Yes, I'm not firm in kernel hacking, yes, I did not
RTFM, please just push me into the right direction here. Either API
documentation href and/or "use this and that function", or just dump
some lines of pseudo code with "what function comes from what API" so
that I can get a basic understanding what's going on in hci_usb. What
notify callback? How to register? Where can I find an example of someone
else doing this? Where can I find out what an ISOC URB really is?

I really don't want someone else to do my work, I just don't know where
to begin :'(

thanks very much in advance,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBbSOlQWC6DTWkDAoRAvCeAJ0dVdrxZQLICG+YWblj66AV13L2CQCfUy0t
Ik0eK8//nhu6vUssynVgT74=
=+L+B
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
