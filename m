Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82D15.EDA1C227"
Date: Thu, 22 Nov 2007 16:42:37 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803AF0538@esebe104.NOE.Nokia.com>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-utils/audio/pcm_bluetooth.c:
	drop-pcm_bluetooth-gettimeofday
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

------_=_NextPart_001_01C82D15.EDA1C227
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20 Nov 2007 Vehmanen Kai wrote:
>here's a patch that gets rid of all uses of gettimeofday() and=20
>also does away with using struct timevals for calculating the=20
>hw_ptr. Should have no impact to plugin functionality.

updated to latest CVS, recreated, renamed and attached. Note
that I've used priv_timespecsub() macro name to avoid nameclash
with BSD macro timespecsub() (which has different signature).

--=20
first.surname@nokia.com (Kai Vehmanen)

------_=_NextPart_001_01C82D15.EDA1C227
Content-Type: application/octet-stream;
	name="patch-20071122-kv-drop-pcm_bluetooth-gettimeofday.diff"
Content-Transfer-Encoding: base64
Content-Description: patch-20071122-kv-drop-pcm_bluetooth-gettimeofday.diff
Content-Disposition: attachment;
	filename="patch-20071122-kv-drop-pcm_bluetooth-gettimeofday.diff"

LS0tIGF1ZGlvL3BjbV9ibHVldG9vdGguYwkyMSBOb3YgMjAwNyAyMDoyNDoxMSAtMDAwMAkxLjg0
CisrKyBhdWRpby9wY21fYmx1ZXRvb3RoLmMJMjIgTm92IDIwMDcgMTI6NTk6MzEgLTAwMDAKQEAg
LTY4LDEyICs2OCwxNiBAQAogI2RlZmluZSBTQ09fUlhCVUZTIDB4MDQKICNlbmRpZgogCi0jaWZu
ZGVmIFRJTUVTUEVDX1RPX1RJTUVWQUwKLSMgZGVmaW5lIFRJTUVTUEVDX1RPX1RJTUVWQUwodHYs
IHRzKSB7CQkJXAotCQkodHYpLT50dl9zZWMgPSAodHMpLT50dl9zZWM7CQlcCi0JCSh0diktPnR2
X3VzZWMgPSAodHMpLT50dl9uc2VjIC8gMTAwMDsJXAotfQotI2VuZGlmCisvKiBhZGFwdGVkIGZy
b20gZ2xpYmMgc3lzL3RpbWUuaCB0aW1lcnN1YigpIG1hY3JvICovCisjIGRlZmluZSBwcml2X3Rp
bWVzcGVjc3ViKGEsIGIsIHJlc3VsdCkJCSAgIAkJICAgICAgICAgICAgICBcCisgIGRvIHsJCQkJ
CQkJCQkgICAgICBcCisgICAgKHJlc3VsdCktPnR2X3NlYyA9IChhKS0+dHZfc2VjIC0gKGIpLT50
dl9zZWM7CQkJICAgICAgXAorICAgIChyZXN1bHQpLT50dl9uc2VjID0gKGEpLT50dl9uc2VjIC0g
KGIpLT50dl9uc2VjOwkJCSAgICAgIFwKKyAgICBpZiAoKHJlc3VsdCktPnR2X25zZWMgPCAwKSB7
CQkJCQkgICAgICBcCisgICAgICAtLShyZXN1bHQpLT50dl9zZWM7CQkJCQkJICAgICAgXAorICAg
ICAgKHJlc3VsdCktPnR2X25zZWMgKz0gMTAwMDAwMDAwMDsJCQkJCSAgICAgIFwKKyAgICB9CQkJ
CQkJCQkJICAgICAgXAorICB9IHdoaWxlICgwKQogCiBzdHJ1Y3QgYmx1ZXRvb3RoX2EyZHAgewog
CXNiY19jYXBhYmlsaXRpZXNfdCBzYmNfY2FwYWJpbGl0aWVzOwpAQCAtMTQ5LDggKzE1Myw3IEBA
CiAJc3RydWN0IGJsdWV0b290aF9kYXRhICpkYXRhID0gcGFyYW07CiAJdW5zaWduZWQgaW50IHBy
ZXZfcGVyaW9kczsKIAlkb3VibGUgcGVyaW9kX3RpbWU7Ci0Jc3RydWN0IHRpbWV2YWwgc3RhcnQ7
Ci0Jc3RydWN0IHRpbWVzcGVjIHN0YXJ0X21vbm90b25pYzsKKwlzdHJ1Y3QgdGltZXNwZWMgc3Rh
cnQ7CiAJc3RydWN0IHBvbGxmZCBmZHNbMl07CiAJaW50IHBvbGxfdGltZW91dDsKIApAQCAtMTY3
LDEzICsxNzAsMTEgQEAKIAllbHNlCiAJCXBvbGxfdGltZW91dCA9IE1JTl9QRVJJT0RfVElNRTsK
IAotCWNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmc3RhcnRfbW9ub3RvbmljKTsKLQlU
SU1FU1BFQ19UT19USU1FVkFMKCZzdGFydCwgJnN0YXJ0X21vbm90b25pYyk7CisJY2xvY2tfZ2V0
dGltZShDTE9DS19NT05PVE9OSUMsICZzdGFydCk7CiAKIAl3aGlsZSAoMSkgewogCQl1bnNpZ25l
ZCBpbnQgZHRpbWUsIHBlcmlvZHM7Ci0JCXN0cnVjdCB0aW1ldmFsIGN1ciwgZGVsdGE7Ci0JCXN0
cnVjdCB0aW1lc3BlYyBjdXJfbW9ub3RvbmljOworCQlzdHJ1Y3QgdGltZXNwZWMgY3VyLCBkZWx0
YTsKIAkJaW50IHJldDsKIAogCQlpZiAoZGF0YS0+c3RvcHBlZCkKQEAgLTE4MiwxNyArMTgzLDE1
IEBACiAJCWlmIChkYXRhLT5yZXNldCkgewogCQkJREJHKCJIYW5kbGUgWFJVTiBpbiBody10aHJl
YWQuIik7CiAJCQlkYXRhLT5yZXNldCA9IDA7Ci0JCQljbG9ja19nZXR0aW1lKENMT0NLX01PTk9U
T05JQywgJnN0YXJ0X21vbm90b25pYyk7Ci0JCQlUSU1FU1BFQ19UT19USU1FVkFMKCZzdGFydCwg
JnN0YXJ0X21vbm90b25pYyk7CisJCQljbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnN0
YXJ0KTsKIAkJCXByZXZfcGVyaW9kcyA9IDA7CiAJCX0KIAotCQljbG9ja19nZXR0aW1lKENMT0NL
X01PTk9UT05JQywgJmN1cl9tb25vdG9uaWMpOwotCQlUSU1FU1BFQ19UT19USU1FVkFMKCZjdXIs
ICZjdXJfbW9ub3RvbmljKTsKKwkJY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZjdXIp
OwogCi0JCXRpbWVyc3ViKCZjdXIsICZzdGFydCwgJmRlbHRhKTsKKwkJcHJpdl90aW1lc3BlY3N1
YigmY3VyLCAmc3RhcnQsICZkZWx0YSk7CiAKLQkJZHRpbWUgPSBkZWx0YS50dl9zZWMgKiAxMDAw
MDAwICsgZGVsdGEudHZfdXNlYzsKKwkJZHRpbWUgPSBkZWx0YS50dl9zZWMgKiAxMDAwMDAwICsg
ZGVsdGEudHZfbnNlYyAvIDEwMDA7CiAJCXBlcmlvZHMgPSAxLjAgKiBkdGltZSAvIHBlcmlvZF90
aW1lOwogCiAJCWlmIChwZXJpb2RzID4gcHJldl9wZXJpb2RzKSB7CkBAIC0yMTUsNyArMjE0LDcg
QEAKIAkJCQlwcmV2X3BlcmlvZHMgPSBwZXJpb2RzOwogCQkJZWxzZSB7CiAJCQkJcHJldl9wZXJp
b2RzID0gMDsKLQkJCQlnZXR0aW1lb2ZkYXkoJnN0YXJ0LCAwKTsKKwkJCQljbG9ja19nZXR0aW1l
KENMT0NLX01PTk9UT05JQywgJnN0YXJ0KTsKIAkJCX0KIAkJfQogCg==

------_=_NextPart_001_01C82D15.EDA1C227
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------_=_NextPart_001_01C82D15.EDA1C227
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C82D15.EDA1C227--
