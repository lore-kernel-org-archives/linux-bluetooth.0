Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: Rfcomm qualification
Date: Tue, 29 Jul 2003 13:58:20 -0700
Message-ID: <000201c35614$251dcaf0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0003_01C355D9.78BEF2F0"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C355D9.78BEF2F0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Marcel,

We ran into another 1.0B problem with rfcomm testing. We didn't notice this
last time because the tests were done slightly differently (without an
automated tester).

The tester acts as a 1.0B device and establishes a connection with the IUT.
The IUT sent credits (pf bit = 1) after the MSC echange. It shouldn't.
Attached is an hcidump of it.

We'll have to get this resolved before we can check the fcon/fcoff mods.

Could you take a look?

Thanks,

-Daryl.

------=_NextPart_000_0003_01C355D9.78BEF2F0
Content-Type: application/octet-stream; name="rfc_bv_10_devB.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rfc_bv_10_devB.dat"

DQABAEPspQBUkgwABAQKvMMAWwIAAAAAAQsAAABD7KUA25MMAAEJBAe8wwBbAgABBwABAEPspQBB
oQwABA8EAAgJBA4AAQBD7KUAbdoMAAQDCwABALzDAFsCAAEACAAAAEPspQDc2gwAAQ0IBAEADgAJ
AAEAQ+ylAGsWDQAEDgYIDQgAAQAIAAAAQ+ylAMIhDQABDwQEAQAYzAcAAQBD7KUAcDUNAAQPBAAH
DwQIAAEAQ+ylAHWWDQAEHQUAAQAYzAcAAQBD7KUAzpYNAAQPBAAIAAAGAAEAQ+ylAC6XDQAEGwMB
AAURAAEAQ+ylAOkpDwACASAMAAgAAQACAQQAAwBAABUAAABD7KUAMysPAAIBIBAADAABAAMBCABA
AEAAAAAAAAgAAQBE7KUAKloAAAQTBQEBAAEAMQABAETspQA3owEAAgEgLAAoAAEABAIkAEAAAAAB
Av8BAgL//wMWAAH/////AAAAAAAAAAD//////////xMAAABE7KUABqQBAAIBIA4ACgABAAUCBgBA
AAAAAAAVAAAAROylAEakAQACASAQAAwAAQAEAQgAQAAAAAECAAQIAAEAROylAJgWAgAEEwUBAQAB
AAgAAQBE7KUARiUCAAQTBQEBAAEAGAABAETspQASTwYABA0VAAEAAAGoAgAAAAAAAKhhAAD/////
LwABAETspQCLSwgAAgEgKgAmAAEABQEiAEAAAAAAAAECAAQDFgABAAAAAAAAAAAAAAAA////////
//8NAAEAROylAJaYCAACASAIAAQAQAADPwEcDQAAAETspQASmQgAAgEgCAAEAEAAA3MB1wgAAQBE
7KUAiA4JAAQTBQEBAAEADQABAETspQAMHwoAAgEgCAAEAEAACz8BWQ0AAABE7KUAzh8KAAIBIAgA
BABAAAtzAZIRAAAAROylAC8gCgACASAMAAgAQAAB7wnjBQuNqggAAQBE7KUABpYKAAQTBQEBAAEA
CAABAETspQCOowoABBMFAQEAAQARAAEARuylANyBAwACASAMAAgAQAAD7wnhBQuNcBEAAQBG7KUA
FNADAAIBIAwACABAAAPvCeMFC41wEQAAAEbspQCQ0AMAAgEgDAAIAEAAAe8J4QULjaoOAAAARuyl
AOrQAwACASAJAAUAQAAJ/wEhXAgAAQBG7KUA20kEAAQTBQEBAAEACAABAEbspQDdVAQABBMFAQEA
AQARAAEARuylAF6KBgACASAMAAgAAQAGAwQAQABAABEAAABG7KUAIZAGAAIBIAwACAABAAcDBABA
AEAACAABAEbspQD1BAcABBMFAQEAAQAHAAEARuylABDrCAAEBQQAAQATGhoaGhoaGhoaGhoaGg==

------=_NextPart_000_0003_01C355D9.78BEF2F0--
