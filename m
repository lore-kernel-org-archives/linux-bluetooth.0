Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EF869D.8020705@fastwebnet.it>
From: WiseLYNX <wiselynx.naima@fastwebnet.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de> <41EE4ACD.9070105@fastwebnet.it> <41EE66A2.1040106@dark-reality.de> <41EE69F3.1030401@fastwebnet.it> <41EE989A.7030206@dark-reality.de> <41EED6AE.1080205@fastwebnet.it> <41EF0C15.3040705@dark-reality.de>
In-Reply-To: <41EF0C15.3040705@dark-reality.de>
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
Date: Thu, 20 Jan 2005 11:23:25 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| well it *should* work with this setup, as it works on my system with
| stock 2.6.10 plus mh1 patches. Anything else special, like, are you
| using an SMP kernel?

no, ? just checked and SMP is disabled. it may be some issue with other
settings, maybe in the bluetooth section?

| Maybe it's a problem with your dongle, do you have access to another on=
e
| to test this? (local setup: epox bt-dg03 + sony/eri. hbh-35 headset)

it could be of course. I'll have a try with the one (other productor,
but same chipset I fear) of a friend of mine, but it won't be before
next week. anyway, isn't it strange that the dongle works fine with
other applications (I'm able to connect via gprs with my phone)?

I'll do some more experiments on my own, and I'll let you know if I
understand something.

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

iD8DBQFB74abkYE9G6fXLlgRAs9TAJ47Tx0yZ6YAwFeqpqLTfrG/boodBACfWeO8
N75/q3lcD973LmTFA3wzec8=3D
=3DdV8P
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
