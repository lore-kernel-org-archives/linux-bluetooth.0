Return-Path: <cyrus@holtmann.org>
Message-ID: <f9d4bd30805011546r4511609dned47cc9021dbe88d@mail.gmail.com>
Date: Thu, 1 May 2008 19:46:11 -0300
From: "Claudio Takahasi" <claudio.takahasi@openbossa.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9444_7189898.1209681971977"
Subject: [Bluez-devel] [PATCH]Trusted verification for service authorization
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

------=_Part_9444_7189898.1209681971977
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

here is the patch to check global and service trust before request for
authorization.

The code was basically copied from RequestAuthorization method. Any
idea why BDADDR_ANY is being used?

"read_trust(BDADDR_ANY, ..."
Using this adapter address, service based "trust" will be applied to
all adapters. Do you want this behavior?

ps: tested using network service only, I don't have headsets or input
devices at home.

Regards,
Claudio.

-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999

------=_Part_9444_7189898.1209681971977
Content-Type: text/x-diff; name=trust01.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffpx7hq10
Content-Disposition: attachment; filename=trust01.patch

SW5kZXg6IGhjaWQvZGJ1cy1zZXJ2aWNlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3Qv
Ymx1ZXovdXRpbHMvaGNpZC9kYnVzLXNlcnZpY2UuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4x
NDgKZGlmZiAtdSAtcjEuMTQ4IGRidXMtc2VydmljZS5jCi0tLSBoY2lkL2RidXMtc2VydmljZS5j
CTEgTWF5IDIwMDggMTM6NTI6MjcgLTAwMDAJMS4xNDgKKysrIGhjaWQvZGJ1cy1zZXJ2aWNlLmMJ
MSBNYXkgMjAwOCAyMjozMTo1NyAtMDAwMApAQCAtMTIzNiw2ICsxMjM2LDcgQEAKIAogCWdfZnJl
ZShhdXRoKTsKIH0KKwogaW50IHNlcnZpY2VfcmVxX2F1dGgoYmRhZGRyX3QgKnNyYywgYmRhZGRy
X3QgKmRzdCwKIAkJY29uc3QgY2hhciAqdXVpZCwgc2VydmljZV9hdXRoX2NiIGNiLCB2b2lkICp1
c2VyX2RhdGEpCiB7CkBAIC0xMjQzLDcgKzEyNDQsOSBAQAogCXN0cnVjdCBhZGFwdGVyICphZGFw
dGVyOwogCXN0cnVjdCBkZXZpY2UgKmRldmljZTsKIAlzdHJ1Y3QgYWdlbnQgKmFnZW50OworCXN0
cnVjdCBzZXJ2aWNlICpzZXJ2aWNlOwogCWNoYXIgYWRkcmVzc1sxOF07CisJZ2Jvb2xlYW4gdHJ1
c3RlZDsKIAogCWFkYXB0ZXIgPSBiYTJhZGFwdGVyKHNyYyk7CiAJaWYgKCFhZGFwdGVyKQpAQCAt
MTI1OSwxMCArMTI2MiwxOCBAQAogCWlmICghZGV2aWNlKQogCQlyZXR1cm4gLUVQRVJNOwogCi0J
aWYgKCFzZWFyY2hfc2VydmljZV9ieV91dWlkKHV1aWQpKQorCXNlcnZpY2UgPSBzZWFyY2hfc2Vy
dmljZV9ieV91dWlkKHV1aWQpOworCWlmICghc2VydmljZSkKIAkJcmV0dXJuIC1FUEVSTTsKIAot
CS8qIEZJWE1FOiBNaXNzaW5nIGNoZWNrIHRydXN0ZWQgZmlsZSBlbnRyaWVzICovCisJdHJ1c3Rl
ZCA9IHJlYWRfdHJ1c3Qoc3JjLCBhZGRyZXNzLCBHTE9CQUxfVFJVU1QpOworCWlmICghdHJ1c3Rl
ZCkKKwkJdHJ1c3RlZCA9IHJlYWRfdHJ1c3QoQkRBRERSX0FOWSwgYWRkcmVzcywgc2VydmljZS0+
aWRlbnQpOworCisJaWYgKHRydXN0ZWQpIHsKKwkJY2IoTlVMTCwgdXNlcl9kYXRhKTsKKwkJcmV0
dXJuIDA7CisJfQogCiAJYWdlbnQgPSAoZGV2aWNlLT5hZ2VudCA/IDogYWRhcHRlci0+YWdlbnQp
OwogCWlmICghYWdlbnQpCkluZGV4OiBuZXR3b3JrL3NlcnZlci5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZp
bGU6IC9jdnNyb290L2JsdWV6L3V0aWxzL25ldHdvcmsvc2VydmVyLmMsdgpyZXRyaWV2aW5nIHJl
dmlzaW9uIDEuOTMKZGlmZiAtdSAtcjEuOTMgc2VydmVyLmMKLS0tIG5ldHdvcmsvc2VydmVyLmMJ
MSBNYXkgMjAwOCAxMzo1MjoyOCAtMDAwMAkxLjkzCisrKyBuZXR3b3JrL3NlcnZlci5jCTEgTWF5
IDIwMDggMjI6MzE6NTggLTAwMDAKQEAgLTU5MiwxNCArNTkyLDE2IEBACiAJCWdvdG8gcmVwbHk7
CiAJfQogCisJc2V0dXAgPSBzZXR1cF9zZXNzaW9uX25ldyhhZGRyZXNzLCBkc3Rfcm9sZSwgc3Jj
X3JvbGUsIHNrLCB0by0+d2F0Y2gpOworCiAJLyogV2FpdCBhdXRob3JpemF0aW9uIGJlZm9yZSBy
ZXBseSBzdWNjZXNzICovCiAJaWYgKGF1dGhvcml6ZV9jb25uZWN0aW9uKG5zLCBhZGRyZXNzKSA8
IDApIHsKKwkJc2V0dXBfc2Vzc2lvbl9mcmVlKHNldHVwKTsKKwkJc2V0dXAgPSBOVUxMOwogCQly
c3AgPSBCTkVQX0NPTk5fTk9UX0FMTE9XRUQ7CiAJCWdvdG8gcmVwbHk7CiAJfQogCi0Jc2V0dXAg
PSBzZXR1cF9zZXNzaW9uX25ldyhhZGRyZXNzLCBkc3Rfcm9sZSwgc3JjX3JvbGUsIHNrLCB0by0+
d2F0Y2gpOwotCiAJZ19zb3VyY2VfcmVtb3ZlKHRvLT5pZCk7CiAJdG8tPmlkID0gMDsKIAo=
------=_Part_9444_7189898.1209681971977
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------=_Part_9444_7189898.1209681971977
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_9444_7189898.1209681971977--
