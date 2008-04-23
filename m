Return-Path: <cyrus@holtmann.org>
Message-ID: <50282bd30804231336p41e5de3ajd3920aa6eb157f5e@mail.gmail.com>
Date: Wed, 23 Apr 2008 17:36:32 -0300
From: "Cidorvan Leite" <cidorvan@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_20387_17106963.1208982992853"
Subject: [Bluez-devel] Memory leak in sdptool
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

------=_Part_20387_17106963.1208982992853
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

There are a lot of memory leaks in sdptool when adding local services.
The patch attached fixes wiimote local service.
This is not a critical problem because sdptool closes after the
service added and all memory is released.
However, with this fix, sdptool can be used like examples for other
sdp applications without memory leak.

So, is that a good idea to fix all local service?

------=_Part_20387_17106963.1208982992853
Content-Type: text/x-patch; name=leak.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffe8mhtn0
Content-Disposition: attachment; filename=leak.diff

SW5kZXg6IHNkcHRvb2wuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9ibHVlei91dGls
cy90b29scy9zZHB0b29sLmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNzIKZGlmZiAtdSAtcCAt
cjEuNzIgc2RwdG9vbC5jCi0tLSBzZHB0b29sLmMJMiBGZWIgMjAwOCAwMzozNzo1NCAtMDAwMAkx
LjcyCisrKyBzZHB0b29sLmMJMjMgQXByIDIwMDggMTQ6Mjg6MzggLTAwMDAKQEAgLTIzMDQsMTUg
KzIzMDQsMTggQEAgc3RhdGljIGludCBhZGRfaGlkX3dpaW1vdGUoc2RwX3Nlc3Npb25fdAogCXNk
cF91dWlkMTZfY3JlYXRlKCZyb290X3V1aWQsIFBVQkxJQ19CUk9XU0VfR1JPVVApOwogCXJvb3Qg
PSBzZHBfbGlzdF9hcHBlbmQoTlVMTCwgJnJvb3RfdXVpZCk7CiAJc2RwX3NldF9icm93c2VfZ3Jv
dXBzKCZyZWNvcmQsIHJvb3QpOworCXNkcF9saXN0X2ZyZWUocm9vdCwgTlVMTCk7CiAKIAlzZHBf
dXVpZDE2X2NyZWF0ZSgmaGlkX3V1aWQsIEhJRF9TVkNMQVNTX0lEKTsKIAlzdmNsYXNzX2lkID0g
c2RwX2xpc3RfYXBwZW5kKE5VTEwsICZoaWRfdXVpZCk7CiAJc2RwX3NldF9zZXJ2aWNlX2NsYXNz
ZXMoJnJlY29yZCwgc3ZjbGFzc19pZCk7CisJc2RwX2xpc3RfZnJlZShzdmNsYXNzX2lkLCBOVUxM
KTsKIAogCXNkcF91dWlkMTZfY3JlYXRlKCZwcm9maWxlWzBdLnV1aWQsIEhJRF9QUk9GSUxFX0lE
KTsKIAlwcm9maWxlWzBdLnZlcnNpb24gPSAweDAxMDA7CiAJcGZzZXEgPSBzZHBfbGlzdF9hcHBl
bmQoTlVMTCwgcHJvZmlsZSk7CiAJc2RwX3NldF9wcm9maWxlX2Rlc2NzKCZyZWNvcmQsIHBmc2Vx
KTsKKwlzZHBfbGlzdF9mcmVlKHBmc2VxLCBOVUxMKTsKIAogCXNkcF91dWlkMTZfY3JlYXRlKCZs
MmNhcF91dWlkLCBMMkNBUF9VVUlEKTsKIAlwcm90b1sxXSA9IHNkcF9saXN0X2FwcGVuZCgwLCAm
bDJjYXBfdXVpZCk7CkBAIC0yMzI2LDYgKzIzMjksMTEgQEAgc3RhdGljIGludCBhZGRfaGlkX3dp
aW1vdGUoc2RwX3Nlc3Npb25fdAogCiAJYXByb3RvID0gc2RwX2xpc3RfYXBwZW5kKDAsIGFwc2Vx
KTsKIAlzZHBfc2V0X2FjY2Vzc19wcm90b3MoJnJlY29yZCwgYXByb3RvKTsKKwlzZHBfZGF0YV9m
cmVlKHBzbSk7CisJc2RwX2xpc3RfZnJlZShwcm90b1syXSwgTlVMTCk7CisJc2RwX2xpc3RfZnJl
ZShwcm90b1sxXSwgTlVMTCk7CisJc2RwX2xpc3RfZnJlZShhcHNlcSwgTlVMTCk7CisJc2RwX2xp
c3RfZnJlZShhcHJvdG8sIE5VTEwpOwogCiAJcHJvdG9bMV0gPSBzZHBfbGlzdF9hcHBlbmQoMCwg
JmwyY2FwX3V1aWQpOwogCXBzbSA9IHNkcF9kYXRhX2FsbG9jKFNEUF9VSU5UMTYsICZpbnRyKTsK
QEAgLTIzMzgsNiArMjM0NiwxMSBAQCBzdGF0aWMgaW50IGFkZF9oaWRfd2lpbW90ZShzZHBfc2Vz
c2lvbl90CiAKIAlhcHJvdG8gPSBzZHBfbGlzdF9hcHBlbmQoMCwgYXBzZXEpOwogCXNkcF9zZXRf
YWRkX2FjY2Vzc19wcm90b3MoJnJlY29yZCwgYXByb3RvKTsKKwlzZHBfZGF0YV9mcmVlKHBzbSk7
CisJc2RwX2xpc3RfZnJlZShwcm90b1syXSwgTlVMTCk7CisJc2RwX2xpc3RfZnJlZShwcm90b1sx
XSwgTlVMTCk7CisJc2RwX2xpc3RfZnJlZShhcHNlcSwgTlVMTCk7CisJc2RwX2xpc3RfZnJlZShh
cHJvdG8sIE5VTEwpOwogCiAJYWRkX2xhbmdfYXR0cigmcmVjb3JkKTsKIApAQCAtMjQwNyw2ICsy
NDIwLDkgQEAgc3RhdGljIGludCBhZGRfaGlkX3dpaW1vdGUoc2RwX3Nlc3Npb25fdAogCQlyZXR1
cm4gLTE7CiAJfQogCisJc2RwX2xpc3RfZnJlZShyZWNvcmQucGF0dGVybiwgZnJlZSk7CisJc2Rw
X2xpc3RfZnJlZShyZWNvcmQuYXR0cmxpc3QsIChzZHBfZnJlZV9mdW5jX3Qpc2RwX2RhdGFfZnJl
ZSk7CisKIAlwcmludGYoIldpaS1Nb3RlIHNlcnZpY2UgcmVnaXN0ZXJlZFxuIik7CiAKIAlyZXR1
cm4gMDsK
------=_Part_20387_17106963.1208982992853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------=_Part_20387_17106963.1208982992853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_20387_17106963.1208982992853--
