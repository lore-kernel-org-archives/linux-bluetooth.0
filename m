Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E3AAD8.9090303@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple Headsets
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de>	 <1105362147.8652.10.camel@pegasus> <41E2A9FC.2010405@dark-reality.de>	 <41E39BC8.2020105@xmission.com> <1105438532.8056.12.camel@pegasus>
In-Reply-To: <1105438532.8056.12.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 Jan 2005 11:30:48 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

@Brad:

well yes it's not really the "final" solution but at least one can
change the setting without hacking around in the kernel (that was the
old solution, also used by btsco before hci_usb was totally removed and
we started using only voice mode 0x0060).

What has to be documented is:

how to calculate the bitrate for the proper "alternate setting" of usb_hci?

We could put the table from the BT docs online and add some examples how
to find the correct mode, that should be sufficient.

Next target would be finding a way to change this "online" *sigh*

best regards,
~  Lars

Marcel Holtmann wrote:
| Hi Brad,
|
|
|>I would be happy to document it, but I'm not sure exactly what Marcel
|>did. If the number of headsets is fixed at module insertion time then it
|>sounds like it's just good for testing.
|
|
| with a 2.6 kernel you can change a kernel module parameter on the fly
| from /sys/module/ and then you only have to re-plug your dongle to
| activate the new settings.
|
| Regards
|
| Marcel


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB46rYQWC6DTWkDAoRAhgIAJ9TXlzExSHC+IMe7zSdwSK3WMN+PACdHsOb
BXgt+pfyMKT79k+xfgY7JyA=
=w8dD
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
