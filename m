Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EE6032.7070708@fastwebnet.it>
From: WiseLYNX <wiselynx.naima@fastwebnet.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de> <41EE4ACD.9070105@fastwebnet.it> <41EE66A2.1040106@dark-reality.de>
In-Reply-To: <41EE66A2.1040106@dark-reality.de>
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
Date: Wed, 19 Jan 2005 14:27:14 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| Sounds like it might be the fault of the dongle, or the bluez stack has
| an issue with it. Did you try with M$windows?

no, nor I can try. my pc is M$ stuff free :)

| no, it's not patched with mh1. Best thing would be to use the vanilla
| kernel (i.e. get it directly from kernel.org) and patch it with -mh1
| patchset from bluez. I'm using gentoo, too, btw, so it should work this
| way.

I'd rather keeping the gentoo-dev kernel. isn't it possible to patch it?

| it should. You can use this as the simplest and fool-proof testing
| method, as it does not involve any alsa library stuff beyond the
| snd-bt-sco-kernel module itself, so there are not many other error
| sources than the dongle and the headself itself.

I'll have another try so..

| Maybe there's a problem with the hci_usb implementation for your dongle=
...

I'll try with another dongle when I'll be able to (it belongs to a
friend of mine, I should see him soon)

- --

=B0=B0=B0 Wise
~ O  LYNX

GPG key: http://wiselynx.interfree.it/wiselynx.naima.asc
MD5 checksum: http://wiselynx.interfree.it/wiselynx.naima.asc.md5

- -----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GE>$/IT/S d+ s: !a>? C++(+++)>$ U P>+ L++>++++ E--- W++ N ?o ?K w-- ?O ?M
?V>+ PS+ !PE Y+ PGP+ t- ?5 X- R+(*) tv- b+(++)>+++ DI(++) !D G e++ h!*@
r%>++ y-->+
- ------END GEEK CODE BLOCK------

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB7mAxkYE9G6fXLlgRAun5AJ9mdIGObx0aPoUBuLj06NF+IDfmWQCfc7Ov
clpfM3jtfJh64bi2Ja4jMRE=3D
=3D7DWM
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
