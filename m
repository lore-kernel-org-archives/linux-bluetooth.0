Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C61B4E.1E75FB24"
Subject: RE: [Bluez-devel] Problems with smart phones when using a"silent"kernel
Message-ID: <C70061B183DE09419568AB2060C52A95017BED92@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Tue, 17 Jan 2006 11:07:30 +0100

This is a multi-part message in MIME format.

------_=_NextPart_001_01C61B4E.1E75FB24
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

Marcel,

Now using daemon(3) .

Regards,
     Victor.

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Dimitry
Andric
Sent: Monday, January 16, 2006 17:18 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems with smart phones when using
a"silent"kernel

Victor Shcherbatyuk wrote:
> This fixes the problem with console redirected to /dev/null.
---snip---
> +=09=09dup2(fd, STDIN_FILENO);
> +=09=09dup2(fd, STDOUT_FILENO);
> +=09=09dup2(fd, STDERR_FILENO);

Heheh, yet another reason to always use daemon(3) instead of rolling
your own!




This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.

------_=_NextPart_001_01C61B4E.1E75FB24
Content-Type: application/octet-stream;
	name="sdpd_daemonize.patch"
Content-Transfer-Encoding: base64
Content-Description: sdpd_daemonize.patch
Content-Disposition: attachment;
	filename="sdpd_daemonize.patch"

SW5kZXg6IHNkcGQvbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2JsdWV6L3V0
aWxzL3NkcGQvbWFpbi5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjE0CmRpZmYgLXUgLXIxLjE0
IG1haW4uYwotLS0gc2RwZC9tYWluLmMJMTYgSmFuIDIwMDYgMTY6MTk6MjggLTAwMDAJMS4xNAor
Kysgc2RwZC9tYWluLmMJMTcgSmFuIDIwMDYgMTA6MDE6NDggLTAwMDAKQEAgLTMwLDcgKzMwLDYg
QEAKIAogI2luY2x1ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8ZXJybm8uaD4KLSNpbmNsdWRlIDxm
Y250bC5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPHN0ZGxpYi5oPgogI2luY2x1
ZGUgPHNpZ25hbC5oPgpAQCAtMjkwLDMzICsyODksNiBAQAogCWV4aXQoMCk7CiB9CiAKLXN0YXRp
YyBpbnQgYmVjb21lX2RhZW1vbih2b2lkKQotewotCWludCBmZDsKLQotCWlmIChnZXRwcGlkKCkg
IT0gMSkgewotCQlzaWduYWwoU0lHVFRPVSwgU0lHX0lHTik7Ci0JCXNpZ25hbChTSUdUVElOLCBT
SUdfSUdOKTsKLQkJc2lnbmFsKFNJR1RTVFAsIFNJR19JR04pOwotCQlpZiAoZm9yaygpKQotCQkJ
cmV0dXJuIDA7Ci0JCXNldHNpZCgpOwotCX0KLQotCWZkID0gb3BlbigiL2Rldi9udWxsIiwgT19S
RFdSKTsKLQlpZiAoZmQgIT0gLTEpIHsKLQkJZHVwMihmZCwgU1RESU5fRklMRU5PKTsKLQkJZHVw
MihmZCwgU1RET1VUX0ZJTEVOTyk7Ci0JCWR1cDIoZmQsIFNUREVSUl9GSUxFTk8pOwotCi0JCWlm
IChmZCA+IFNUREVSUl9GSUxFTk8pCi0JCQljbG9zZShmZCk7Ci0JfQotCi0JY2hkaXIoIi8iKTsK
LQlyZXR1cm4gMTsKLX0KLQogc3RhdGljIGlubGluZSB2b2lkIGhhbmRsZV9yZXF1ZXN0KGludCBz
aywgdWludDhfdCAqZGF0YSwgaW50IGxlbikKIHsKIAlzdHJ1Y3Qgc29ja2FkZHJfbDIgc2E7CkBA
IC00MTEsNyArMzgzLDcgQEAKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewot
CWludCBkYWVtb24gPSAxOworCWludCBkYWVtb25pemUgPSAxOwogCWludCBtYXN0ZXIgPSAwOwog
CWludCBwdWJsaWMgPSAwOwogCWludCBvcHQ7CkBAIC00MTksNyArMzkxLDcgQEAKIAl3aGlsZSAo
KG9wdCA9IGdldG9wdF9sb25nKGFyZ2MsIGFyZ3YsICJubXAiLCBtYWluX29wdGlvbnMsIE5VTEwp
KSAhPSAtMSkKIAkJc3dpdGNoIChvcHQpIHsKIAkJY2FzZSAnbic6Ci0JCQlkYWVtb24gPSAwOwor
CQkJZGFlbW9uaXplID0gMDsKIAkJCWJyZWFrOwogCQljYXNlICdtJzoKIAkJCW1hc3RlciA9IDE7
CkBAIC00MzIsOSArNDA0LDEwIEBACiAJCQlleGl0KDApOwogCQl9CiAJb3BlbmxvZygic2RwZCIs
IExPR19QSUQgfCBMT0dfTkRFTEFZLCBMT0dfREFFTU9OKTsKLQkKLQlpZiAoZGFlbW9uICYmICFi
ZWNvbWVfZGFlbW9uKCkpCi0JCXJldHVybiAwOworCWlmIChkYWVtb25pemUgJiYgZGFlbW9uKDAs
IDApKSB7CisJCVNEUEVSUigiU2VydmVyIHN0YXJ0dXAgZmFpbGVkOiVzIiwgc3RyZXJyb3IoZXJy
bm8pKTsKKwkJcmV0dXJuIC0xOworCX0KIAogCWFyZ2MgLT0gb3B0aW5kOwogCWFyZ3YgKz0gb3B0
aW5kOwo=

------_=_NextPart_001_01C61B4E.1E75FB24--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
