Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20040708165219.16a1d6db@coredump>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__8_Jul_2004_16_52_19_+0200_BJ6/ID7fTNBYncwt"
Subject: [Bluez-devel] patch for: RFComm dynamic channel allocation
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
Date: Thu, 8 Jul 2004 16:52:19 +0200


--Multipart=_Thu__8_Jul_2004_16_52_19_+0200_BJ6/ID7fTNBYncwt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

just found and fixed the problem with dynamic rfcomm channel allocation.
My code binds to a specific local bdaddr, the rfcomm tool binds to ANY.
This case was not handled correctly. The fix is simple, see attachment.


... Collin

-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Just don't create a file called -rf.  :-)  --Larry Wall

--Multipart=_Thu__8_Jul_2004_16_52_19_+0200_BJ6/ID7fTNBYncwt
Content-Type: application/octet-stream;
 name="rfcomm_dynamic_channel_alloc_fix.patch"
Content-Disposition: attachment;
 filename="rfcomm_dynamic_channel_alloc_fix.patch"
Content-Transfer-Encoding: base64

LS0tIHNvY2suY19vcmlnCTIwMDQtMDctMDggMTY6Mzk6MjkuMDAwMDAwMDAwICswMjAwCisrKyBz
b2NrLmMJMjAwNC0wNy0wOCAxNjo0NzoyOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTQwNyw3ICs0MDcs
NyBAQAogCQl3cml0ZV9sb2NrX2JoKCZyZmNvbW1fc2tfbGlzdC5sb2NrKTsKIAogCQlmb3IgKGNo
YW5uZWwgPSAxOyBjaGFubmVsIDwgMzE7IGNoYW5uZWwrKykKLQkJCWlmICghX19yZmNvbW1fZ2V0
X3NvY2tfYnlfYWRkcihjaGFubmVsLCBzcmMpKSB7CisJCQlpZiAoIV9fcmZjb21tX2dldF9zb2Nr
X2J5X2NoYW5uZWwoMCwgY2hhbm5lbCwgc3JjKSkgewogCQkJCXJmY29tbV9waShzayktPmNoYW5u
ZWwgPSBjaGFubmVsOwogCQkJCWVyciA9IDA7CiAJCQkJYnJlYWs7Cg==

--Multipart=_Thu__8_Jul_2004_16_52_19_+0200_BJ6/ID7fTNBYncwt--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
