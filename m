Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E481A1.5020402@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple Headsets
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de>	 <1105362147.8652.10.camel@pegasus> <41E2A9FC.2010405@dark-reality.de>	 <41E39BC8.2020105@xmission.com> <1105438532.8056.12.camel@pegasus> <41E3AAD8.9090303@dark-reality.de> <41E3FE69.5030903@xmission.com> <41E404E9.60405@dark-reality.de>
In-Reply-To: <41E404E9.60405@dark-reality.de>
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
Date: Wed, 12 Jan 2005 02:47:13 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| Expect the table in an upcoming mail :)

OK, this is what I took from the documentation:

alternate setting 0:
- - no active channels (for USB compliance)

alternate setting 1 (9 byte suggested max. packet size):
- - one voice channel 8 bit (currently unsupported by btsco)

alternate setting 2 (17 byte):
- - two voice channels 8 bit (currently unsupported by btsco)
- - one voice channel 16 bit (supported by btsco)

alternate setting 3 (25 byte):
- - three voice channels 8 bit (currently unsupported by btsco)

alternate setting 4 (33 byte):
- - two voice channel 16 bit (supported by btsco)

alternate setting 5 (49 byte):
- - three voice channels 16 bit (supported by btsco)

I'm unsure whether it's possible or not to use alternate modes 3,4,5 for
multiple 8bit transfer, too, the documentation does not mention it.

As btsco right now only supports 16 bit audio, I marked only the 16 bit
options as usable.

So, the "math" is simple (for 16 bit):

headset count   |    alternate setting
~   1            |       2
~   2            |       4
~   3            |       5

Maybe I'll try to add a kernel parameter to the snd-bt-sco module too,
that switches between the different codec types available, so that we
can support 8bit modes, too.

best regards,
~  Lars

- -------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



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

iD8DBQFB5IGhQWC6DTWkDAoRAlGrAKCUDQf8aiyiQSBi5kMc4EORpcdKugCfQ93V
hblLoa92rGSBTs5uh/mMGrs=
=Xqlj
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
