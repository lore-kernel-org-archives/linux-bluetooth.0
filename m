Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E404E9.60405@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple Headsets
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de>	 <1105362147.8652.10.camel@pegasus> <41E2A9FC.2010405@dark-reality.de>	 <41E39BC8.2020105@xmission.com> <1105438532.8056.12.camel@pegasus> <41E3AAD8.9090303@dark-reality.de> <41E3FE69.5030903@xmission.com>
In-Reply-To: <41E3FE69.5030903@xmission.com>
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
Date: Tue, 11 Jan 2005 17:55:05 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brad Midgley wrote:

| Where do I look to find this table? (The phrase "alternate setting" does
| not seem to be the way to find it)

I'll copy it from the docs, I should be able to recover it fastly.

| What if it's set too high? Will it fail to work or will it waste space
| in the transmission?

It should simply fail, as Marcel already stated. This is not like
choosing an upper limit, because the transfers should be synchronous and
this have to fit in exact transmission windows. Of course it should do
no harm if the windows are to big, but the specs are quite clear that
cumulated data size and window size must fit exactly (well, plus one
byte if I remember correctly).

Expect the table in an upcoming mail :)

- - Lars

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

iD4DBQFB5ATpQWC6DTWkDAoRAl7QAJ9Xig8w+YC7j9CMhc5BNp6jp17E3ACYrN7s
xNGMnAUMV4UC/UdrBSVrig==
=9XR2
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
