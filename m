Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42093340.4@fastwebnet.it>
From: WiseLYNX <wiselynx.naima@fastwebnet.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: bluetooth headset - connects but no audio
References: <99803f32050207174495135a8@mail.gmail.com>
In-Reply-To: <99803f32050207174495135a8@mail.gmail.com>
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
Date: Tue, 08 Feb 2005 22:46:40 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| I had the same permission errors with my logitech f-0179a, but in the
| end it was the /etc/bluetooth/link_key file. Delete this file and try
| to run btsco again. It worked for me.

thanks, this worked for me also (at least to resolve the permissions issu=
e)

now, I lost a bit the discussion thread, because it was some time ago I
last wrote, and I'm also having a lot of work for university. let me
summary things up now:

- - hardware is Ericsscon HBH-35 and a SiW based usb dongle
- - software is gentoo-dev 2.6.10-r5, with mh4 patch (also tried a
vanilla, with same results)
- - the problem is, btsco connects and I can set the volume and hear
hissing sound, but I can't hear anything using aplay or others (they
just hang there), nor set the loopback option
- - I tried my friend's dongle, with other chipset, and everything just
works fine; anyway I'd of course rather to be able to use _my_ dongle :)

Lars pointed out some times ago that there was an issue with handles.
here I report what he told:

| I asked Marcel on this list, but I did not understand his answer...:

|> the Silicon Wave chips are not the best ones. They have problems and i=
t
|> seems that they are not going to fix them. Mostly because they sell RO=
M
|> chips are these ones can't be updated by a newer firmware. However if
|> this is the problem with SCO packets and handle 0 then the hci_usb
|> driver should simply drop these frames, because they are not valid SCO
|> payload.

after applying the mh4 patch, and doing some more try (with no better
results), I noticed a lot of kernel debugging stuff in the logs, thing
that I didn't notice in th past. here is a sample of it:

Feb  8 22:29:27 [hcid] link_key_request (sba=3D00:0B:0D:40:6F:B9,
dba=3D00:0E:07:4E:4B:3E)
Feb  8 22:29:41 [hcid] link_key_request (sba=3D00:0B:0D:40:6F:B9,
dba=3D00:0E:07:4E:4B:3E)
Feb  8 22:29:54 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 1280
Feb  8 22:29:54 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 14
Feb  8 22:29:54 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 65535
Feb  8 22:29:54 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 65535
Feb  8 22:29:56 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 3072
Feb  8 22:29:56 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 64512
Feb  8 22:29:56 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 18
Feb  8 22:29:56 [kernel] hci_scodata_packet: hci0 SCO packet for unknown
connection handle 0

is this useful in some way? is there anything that can be done in the
drivers to make SiW and other broken chipset usable?

I'd like to help finding a solution, but I'm not experienced at all in
kernel/driver programming, and I have too few spare time left right now :=
(

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

iD8DBQFCCTM+kYE9G6fXLlgRAoekAJ925cgIgHOjo6h8xuK5ts3AXAP+agCfWOce
+zKpM7z9FE2F1sa8EwDdmms=3D
=3Djnzx
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
