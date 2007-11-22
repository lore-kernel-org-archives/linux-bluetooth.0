Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82D16.8500AC90"
Date: Thu, 22 Nov 2007 16:46:51 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803AF0549@esebe104.NOE.Nokia.com>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-utils/audio:
	kv-multiple-periods-support
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82D16.8500AC90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20 Nov 2007,  Vehmanen Kai (Nokia-TP-MSW/Helsinki) wrote:
>here's a patch that allows pcm_bluetooth.c to support multiple=20
>period sizes (and thus gives application some control over the=20
>wakeup/latency requirements it has to meet).

updated to latest CVS, recreated, renamed and attached.

--=20
first.surname@nokia.com (Kai Vehmanen)

------_=_NextPart_001_01C82D16.8500AC90
Content-Type: application/octet-stream;
	name="patch-20071122-kv-multiple-periods-support.diff"
Content-Transfer-Encoding: base64
Content-Description: patch-20071122-kv-multiple-periods-support.diff
Content-Disposition: attachment;
	filename="patch-20071122-kv-multiple-periods-support.diff"

LS0tIGF1ZGlvL3BjbV9ibHVldG9vdGguYwkyMSBOb3YgMjAwNyAyMDoyNDoxMSAtMDAwMAkxLjg0
CisrKyBhdWRpby9wY21fYmx1ZXRvb3RoLmMJMjIgTm92IDIwMDcgMTI6NTc6MTggLTAwMDAKQEAg
LTk5Nyw3ICs5OTcsOSBAQAogCXVuc2lnbmVkIGludCByYXRlX2NvdW50OwogCWludCBlcnIsIG1p
bl9jaGFubmVscywgbWF4X2NoYW5uZWxzOwogCXVuc2lnbmVkIGludCBwZXJpb2RfbGlzdFtdID0g
ewotCQk0MDk2LCAvKiAyMy80Nm1zIChzdGVyZW8vbW9ubyAxNmJpdCBhdCA0NC4xa0h6KSAqLwor
CQkyMDQ4LAorCQk0MDk2LCAvKiBlLmcuIDIzLjJtc2VjL3BlcmlvZCAoc3RlcmVvIDE2Yml0IGF0
IDQ0LjFrSHopICovCisJCTgxOTIKIAl9OwogCiAJLyogYWNjZXNzIHR5cGUgKi8KQEAgLTEwMjgs
MTUgKzEwMzAsMTYgQEAKIAlpZiAoZXJyIDwgMCkKIAkJcmV0dXJuIGVycjsKIAotCS8qIHN1cHBv
cnRlZCBibG9jayBzaXplczogKi8KLQllcnIgPSBzbmRfcGNtX2lvcGx1Z19zZXRfcGFyYW1fbGlz
dChpbywgU05EX1BDTV9JT1BMVUdfSFdfUEVSSU9EX0JZVEVTLAotCQkJQVJSQVlfTkVMRU1TKHBl
cmlvZF9saXN0KSwgcGVyaW9kX2xpc3QpOworCS8qIHN1cHBvcnRlZCBidWZmZXIgc2l6ZXMgCisJ
ICogKGNhbiBiZSB1c2VkIGFzIDMqODE5MiwgNio0MDk2LCAxMioyMDQ4LCAuLi4pICovCisJZXJy
ID0gc25kX3BjbV9pb3BsdWdfc2V0X3BhcmFtX21pbm1heChpbywgU05EX1BDTV9JT1BMVUdfSFdf
QlVGRkVSX0JZVEVTLAorCQkJCQkgICAgICA4MTkyKjMsIDgxOTIqMyk7CiAJaWYgKGVyciA8IDAp
CiAJCXJldHVybiBlcnI7CiAKLQkvKiBwZXJpb2QgY291bnQgZml4ZWQgdG8gMyBhcyB3ZSBkb24n
dCBzdXBwb3J0IHByZWZpbGxpbmcgKi8KLQllcnIgPSBzbmRfcGNtX2lvcGx1Z19zZXRfcGFyYW1f
bWlubWF4KGlvLCBTTkRfUENNX0lPUExVR19IV19QRVJJT0RTLAotCQkJCQkgICAgICAzLCAzKTsK
KwkvKiBzdXBwb3J0ZWQgYmxvY2sgc2l6ZXM6ICovCisJZXJyID0gc25kX3BjbV9pb3BsdWdfc2V0
X3BhcmFtX2xpc3QoaW8sIFNORF9QQ01fSU9QTFVHX0hXX1BFUklPRF9CWVRFUywKKwkJCUFSUkFZ
X05FTEVNUyhwZXJpb2RfbGlzdCksIHBlcmlvZF9saXN0KTsKIAlpZiAoZXJyIDwgMCkKIAkJcmV0
dXJuIGVycjsKIAo=

------_=_NextPart_001_01C82D16.8500AC90
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------_=_NextPart_001_01C82D16.8500AC90
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C82D16.8500AC90--
