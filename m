Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 5 Mar 2016 21:52:47 +0300
Message-ID: <CAAo+LNPy_HCx_sv9ftj-CcCRr2EDcu9KsESaV7R-JLvMOT90Uw@mail.gmail.com>
Subject: BTLE pairing sequence problem
From: Andrew - <hidefromkgb@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=047d7b5d8d39d7cd9e052d51bc20
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b5d8d39d7cd9e052d51bc20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello. I`m using BlueZ 5.37 on Arch Linux 4.4.3 and I`ve got problems
pairing a Bluetooth 4.0 LE device, Microsoft Designer Keyboard.

As it turns out, the kernel side of BlueZ can not initiate BTLE
pairing sequence on my machine (probably due to
https://bugzilla.kernel.org/show_bug.cgi?id=3D104011 bug: at least, the
message 'Bluetooth: SMP security requested but not available' does
appear in dmesg), so I decided to try and implement it myself in user
mode.
I did not yet apply the =C2=ABuntested=C2=BB patch proposed, since first I =
want
to understand what exactly I`m doing wrong.

I`ve written an utility that sends BTLE pairing messages and analyzes repli=
es.
It does pass the test from Vol.3, p.602 (p.1962 of the official
all-in-one PDF) of the standard which states that
c1(0x00, 0x5783D52156AD6F0E6388274EC6702EE0, 0x07071000000101,
0x05000800000302, 0x01, 0x00, 0xA1A2A3A4A5A6, 0xB1B2B3B4B5B6) =3D
0x1E1E3FEF878988EAD2A74DC5BEF13B86

However, my implementation of c1() does not return the value that the
real MS Designer Keyboard wants, despite having been written by the
standard and returning exact same results as CrackLE`s c1(), for
example.
This indicates that the problem is due to me passing wrong input.

Fortunately, I`ve got an Android smartphone that computes the
confirmation value correctly, and the capture log shows that
c1(0x0655D4, 0x1BE7F4845600E49C43761FC5D9487ADB, 0x07071005000101,
0x03061005000202, 0x01, 0x01, 0x305A3A1930C4, 0xC1C35B2D97B9) =3D
0xFC6021261D1F35FC1D978BAF631CDCEF

My question is: how`s that possible?
I`ve tried all 2^7 different combinations of byte orderings for every
PIN value (yielding 128 000 000 combinations in total), but I`m
positively unable to make c1() produce the result needed.
Can you please show how to feed the data to c1() properly?

The HCI packet log that confirms my words is attached; the PIN shall be 415=
188.

--047d7b5d8d39d7cd9e052d51bc20
Content-Type: application/vnd.tcpdump.pcap; name="btle.cap"
Content-Disposition: attachment; filename="btle.cap"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

YnRzbm9vcAAAAAABAAAD6gAAAB0AAAAdAAAAAgAAAAAA4gnBPE/j6wENIBlgADAAAAG5ly1bw8EB
GAAoAAAA0AcAAAAAAAAABwAAAAcAAAADAAAAAADiCcE8T+YSBA8EAAENIAAAABYAAAAWAAAAAwAA
AAAA4gnBPFBlmQQ+EwEAQAAAAbmXLVvDwScAAADQBwUAAAAGAAAABgAAAAIAAAAAAOIJwTxQaFoB
FiACQAAAAAAHAAAABwAAAAMAAAAAAOIJwTxQauoEDwQAARYgAAAADwAAAA8AAAADAAAAAADiCcE8
VB8wBD4MBABAAAEAAAAAAAAAAAAAEAAAABAAAAAAAAAAAADiCcE8VCxeAkAACwAHAAYAAQEABRAH
BwAAABAAAAAQAAAAAQAAAAAA4gnBPFWaygJAIAsABwAGAAICAAUQBgMAAAAEAAAABAAAAAIAAAAA
AOIJwTxVppoBGCAAAAAADwAAAA8AAAADAAAAAADiCcE8Va33BA4MARggANRVtnYASQhFAAAABAAA
AAQAAAACAAAAAADiCcE8Vbt6ARggAAAAAA8AAAAPAAAAAwAAAAAA4gnBPFXK0gQODAEYIADbekjZ
xR92QwAAAAQAAAAEAAAAAgAAAAAA4gnBPFXUHAEYIAAAAAAPAAAADwAAAAMAAAAAAOIJwTxV2q4E
DgwBGCAAnOQAVoT05xsAAAAaAAAAGgAAAAAAAAAAAOIJwTxV5bACQAAVABEABgAD79wcY6+Llx38
NR8dJiFg/AAAAAgAAAAIAAAAAwAAAAAA4gnBPFZZQAQTBQFAAAIAAAAABQAAAAUAAAACAAAAAADi
CcE8WDOLARoMAQIAAAAHAAAABwAAAAMAAAAAAOIJwTxYOoIEDgQBGgwAAAAAEwAAABMAAAACAAAA
AADiCcE8WELeAQYgDzAAMAAAAQAAAAAAAAAHAAAAAAcAAAAHAAAAAwAAAAAA4gnBPFhJIgQOBAEG
IAAAAAAFAAAABQAAAAIAAAAAAOIJwTxYT8oBGgwBAgAAAAcAAAAHAAAAAwAAAAAA4gnBPFhWoQQO
BAEaDAAAAAAVAAAAFQAAAAEAAAAAAOIJwTydxksCQCAQAAwABQASAggAFAAkAAQALAEAAAAPAAAA
DwAAAAAAAAAAAOIJwTyd0PwCQAAKAAYABQATAgIAAAAAAAAIAAAACAAAAAMAAAAAAOIJwTyhdRoE
EwUBQAABAAAAABoAAAAaAAAAAQAAAAAA4gnBPNTgcQJAIBUAEQAGAAPzrCh/zt/q8fKRlwtH0Q7l
AAAAGgAAABoAAAAAAAAAAADiCcE81OtTAkAAFQARAAYABNt6SNnFH3ZDnOQAVoT05xsAAAAaAAAA
GgAAAAEAAAAAAOIJwTzWYzICQCAVABEABgAEVYhx5z4pX8XnCVWH21ySBwAAACAAAAAgAAAAAgAA
AAAA4gnBPNZzBwEZIBxAAAAAAAAAAAAAAACoMBLA4rbPBHfnicPyaw8pAAAABwAAAAcAAAADAAAA
AADiCcE81noLBA8EAAEZIA==
--047d7b5d8d39d7cd9e052d51bc20--
