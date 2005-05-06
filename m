Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
Message-Id: <20050506060525.32b209ca.henryk@ploetzli.ch>
In-Reply-To: <20050505124512.53335.qmail@web8306.mail.in.yahoo.com>
References: <20050505124512.53335.qmail@web8306.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__6_May_2005_06_05_25_+0200_npEMx2xpfp9UnzR+"
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
Date: Fri, 6 May 2005 06:05:25 +0200

--Signature=_Fri__6_May_2005_06_05_25_+0200_npEMx2xpfp9UnzR+
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__6_May_2005_06_05_25_+0200_9blF6XW50yKi4m58"


--Multipart=_Fri__6_May_2005_06_05_25_+0200_9blF6XW50yKi4m58
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Thu, 5 May 2005 13:45:12 +0100 (BST) schrieb Mayank Batra:

> Did you try what I suggested you in my mail titled 'A
> small Query' ?

Ah no, but luckily Brad did. However, that wasn't the problem. The
problem was that a2recv didn't correctly fill out the transaction
label. When responding to a request one must use the same transaction
label that the other side used.

I don't fully understand the logic behind what init_request() in
a2recv.c does to the transaction_label, but it's most likely wrong.

I therefore introduced a function init_response() that takes the header
of the command that was received and creates a positive response header.
init_request() is then used nowhere anymore, so I #if 0'd it. I also
went through a hcidump of the (now working) stream setup phase and
compared it to the AVDTP spec. Most of it looks correct now, except for
Open Stream Response and Start Stream Response, which are too long (I'm
not sure what to do about that as the additional byte(s) are reserved in
the struct open_stream_rsp and struct start_stream_rsp for the case of
an error).

So now I made it to "Sent start stream confirm" but not further as the
audio dongle doesn't seem to start streaming. The last three packets I
see in an hcidump are

1115349894.700415 > ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 5
        ACP SEID 1
1115349894.700472 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 25]
      AVDTP(m): ver 1 ext cc 2 pt 7 seqn 0 time 1090519040 ssrc 40962
1115349894.709416 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...

(The second packet is actually an almost proper Start Stream Response=20
that's only decoded wrong by hcidump. hcidump -R shows
1115349894.700472 < 0000: 02 29 20 08 00 04 00 41  00 52 07 00 00
which is correct, except for the two trailing zeros.)

After that things sit still for about 6 seconds and then I get

1115351711.667759 > HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 28 00 08                                       .(..

I have attached a dump of the whole process (and the beginning of=20
the reconnections that the dongle tries after the failure).

Anyways: I have committed the changed transaction_label handling to=20
CVS, so please check that it doesn't break your already working=20
devices.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Multipart=_Fri__6_May_2005_06_05_25_+0200_9blF6XW50yKi4m58
Content-Type: application/octet-stream;
 name="iphono_to_a2rcv"
Content-Disposition: attachment;
 filename="iphono_to_a2rcv"
Content-Transfer-Encoding: base64

DQABAD7rekIHlwgABAQKPAU19AgAKAQgAQsAAAA+63pCJ5cIAAEJBAc8BTX0CAABBwABAD7rekIW
vggABA8EAAEJBAkAAQA+63pCoE4JAAQXBjwFNfQIABoAAAA+63pCsE8JAAELBBY8BTX0CADviYUR
upOJZbH2hSxkYWuHDQABAD7rekIbuAkABA4KAQsEADwFNfQIAA4AAQA+63pCnO4JAAQDCwAoADwF
NfQIAAEACAAAAD7rekLO7gkAAQ0IBCgADwAKAAEAPut6QrHyCQAEIAc8BTX0CAABBgABAD7rekLW
FQoABBsDKAAFEQABAD7rekKyHQoAAiggDAAIAAEAAgEEAAEAQAAJAAEAPut6Qr4dCgAEDgYBDQgA
KAAIAAAAPut6QuQdCgABDwQEKAAYzBUAAAA+63pC6x0KAAIoIBAADAABAAMBCABAAEAAAAAAAAcA
AQA+63pCuEQKAAQPBAABDwQIAAEAPut6QodMCgAEHQUAKAAYzAgAAQA+63pCEGAKAAQTBQEoAAEA
FQABAD7rekJwewoAAiggEAAMAAEABAIIAEAAAAABAqACEwAAAD7rekKLewoAAiggDgAKAAEABQIG
AEAAAAAAABEAAAA+63pCknsKAAIoIAwACAABAAQBBABAAAAACAABAD7rekLbmAoABBMFASgAAQAI
AAEAPut6QrmgCgAEEwUBKAABABMAAQA+63pCXqoKAAIoIA4ACgABAAUBBgBAAAAAAAAWAAEAPut6
QgG2CgACKCARAA0AQAAC//4ACDUDGRELAAIAFwAAAD7rekKgtgoAAiggEgAOAEAAA//+AAkAAQAB
AAEAAAAIAAEAPut6QhLdCgAEEwUBKAABABEAAQA+63pC4uQKAAIoIAwACAABAAYDBABAAEAAEQAA
AD7rekL95AoAAiggDAAIAAEABwMEAEAAQAARAAEAPut6QpjwCgACKCAMAAgAAQACBAQAGQBBABUA
AAA+63pCr/AKAAIoIBAADAABAAMECABAAEEAAAAAAAgAAQA+63pCHwQLAAQTBQEoAAEACAABAD7r
ekLxCwsABBMFASgAAQAVAAEAPut6QqkXCwACKCAQAAwAAQAEBQgAQAAAAAECoAITAAAAPut6QroX
CwACKCAOAAoAAQAFBQYAQQAAAAAAEQAAAD7rekK/FwsAAiggDAAIAAEABAIEAEEAAAAIAAEAPut6
QgQzCwAEEwUBKAABAAgAAQA+63pCtz4LAAQTBQEoAAEAEwABAD7rekKMRgsAAiggDgAKAAEABQIG
AEAAAAAAAAsAAQA+63pCWk4LAAIoIAYAAgBAABABDQAAAD7rekKjTgsAAiggCAAEAEEAEgEECggA
AQA+63pCsW0LAAQTBQEoAAEADAABAD7rekJWeQsAAiggBwADAEAAIAIEFQAAAD7rekL3hQsAAigg
EAAMAEEAIgIBAAcGAAD//wL6CAABAD7rekI7qAsABBMFASgAAQAXAAEAPut6Qu6zCwACKCASAA4A
QAAwAwQEAQAHBgAAIkYC+g0AAAA+63pCaMALAAIoIAgABABBADIDAAAMAAEAPut6QonuCwACKCAH
AAMAQABABgQIAAEAPut6Qm/yCwAEEwUBKAABAAwAAAA+63pC4woMAAIoIAcAAwBBAEIGABEAAQA+
63pCREoMAAIoIAwACAABAAIGBAAZAEIACAABAD7rekJSSgwABBMFASgAAQAVAAAAPut6QnJKDAAC
KCAQAAwAAQADBggAQQBCAAAAAAAVAAEAPut6QmBzDAACKCAQAAwAAQAEBwgAQQAAAAECoAITAAAA
Put6Qn5zDAACKCAOAAoAAQAFBwYAQgAAAAAAEQAAAD7rekKFcwwAAiggDAAIAAEABAMEAEIAAAAI
AAEAPut6QkR3DAAEEwUBKAABAAgAAQA+63pCTZ4MAAQTBQEoAAEACAABAD7rekIBqgwABBMFASgA
AQATAAEAPut6QrC5DAACKCAOAAoAAQAFAwYAQQAAAAAADAABAD7rekJQyQwAAiggBwADAEAAUAcE
DQAAAD7rekKVyQwAAiggCAAEAEEAUgcAAAgAAQA+63pCKfgMAAQTBQEoAAEABwABAEXrekIWMgoA
BAUEACgACA0AAQBK63pCX94MAAQECjwFNfQIACgEIAELAAAASut6Qn/eDAABCQQHPAU19AgAAQcA
AQBK63pCZgUNAAQPBAABCQQJAAEASut6QtaZDQAEFwY8BTX0CAAaAAAASut6QmCmDQABCwQWPAU1
9AgA74mFEbqTiWWx9oUsZGFrhw0AAQBK63pCIAsOAAQOCgELBAA8BTX0CAAOAAEASut6QtY9DgAE
AwsAKQA8BTX0CAABAAgAAABK63pC7z0OAAENCAQpAA8ACgABAErrekLbQQ4ABCAHPAU19AgAAREA
AQBK63pC8mgOAAIpIAwACAABAAIBBAABAEAABgABAErrekL/aA4ABBsDKQAFFQAAAErrekIuaQ4A
AikgEAAMAAEAAwEIAEAAQAAAAAAACQABAErrekK9cQ4ABA4GAQ0IACkACAAAAErrekLYcQ4AAQ8E
BCkAGMwHAAEASut6QtuTDgAEDwQAAQ8EFQABAErrekLElw4AAikgEAAMAAEABAIIAEAAAAABAqAC
EwAAAErrekLblw4AAikgDgAKAAEABQIGAEAAAAAAABEAAABK63pC75cOAAIpIAwACAABAAQBBABA
AAAACAABAErrekKwmw4ABB0FACkAGMwIAAEASut6QnijDgAEEwUBKQABAAgAAQBK63pCGLMOAAQT
BQEpAAEACAABAErrekLCwg4ABBMFASkAAQATAAEASut6QqzGDgACKSAOAAoAAQAFAQYAQAAAAAAA
FgABAErrekJY0g4AAikgEQANAEAAAv/+AAg1AxkRCwACABcAAABK63pCH9UOAAIpIBIADgBAAAP/
/gAJAAEAAQABAAAACAABAErrekI8AQ8ABBMFASkAAQARAAEASut6QgkJDwACKSAMAAgAAQAGAwQA
QABAABEAAABK63pCHAkPAAIpIAwACAABAAcDBABAAEAAEQABAErrekLYEA8AAikgDAAIAAEAAgQE
ABkAQQAVAAAASut6QucQDwACKSAQAAwAAQADBAgAAABBAAIAAAAIAAEASut6QnggDwAEEwUBKQAB
AAgAAQBK63pCMCwPAAQTBQEpAAEABwABAEvrekIN6AcABAUEACkACA==

--Multipart=_Fri__6_May_2005_06_05_25_+0200_9blF6XW50yKi4m58--

--Signature=_Fri__6_May_2005_06_05_25_+0200_npEMx2xpfp9UnzR+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFCeu0OIjWgKE0OA2gRAhuYAJY3IpvUuDerdVcC/ZMbExvP3D8hAJ46ywhw
pgtbGZLbeFLJ69aL9yu9yg==
=mT9U
-----END PGP SIGNATURE-----

--Signature=_Fri__6_May_2005_06_05_25_+0200_npEMx2xpfp9UnzR+--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
