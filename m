Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C61AAF.C419DC4F"
Subject: RE: [Bluez-devel] Problems with smart phones when using a"silent"kernel
Message-ID: <C70061B183DE09419568AB2060C52A950177D435@arion.intra.local>
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
Date: Mon, 16 Jan 2006 16:13:57 +0100

This is a multi-part message in MIME format.

------_=_NextPart_001_01C61AAF.C419DC4F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

Marcel,

This fixes the problem with console redirected to /dev/null.

Regards,
    Victor.

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Victor
Shcherbatyuk
Sent: Friday, January 13, 2006 14:02 PM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] Problems with smart phones when using
a"silent"kernel

I've checked, it is running, so the only option it has some issues with
console redirected to /dev/null... Will check the logs...

Regards,
    Victor.=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, January 13, 2006 13:13 PM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] Problems with smart phones when using
a"silent"kernel

Hi Victor,

> Small update. I've tried to connect with rfcomm tool - the same=20
> behaviour. With the silent kernel it does not connect to Windows=20
> Mobile phones. The logs show attempts to connect to the phone with
"normal"
> kernel (connection successful) and "silent" one (fails). PSM Not=20
> Supported is something that probably goes wrong...

these stupid Microsoft devices. Everytime they get a connection, they
connect back to the SDP server of that device and this fails. So it
seems to me that the SDP daemon is not running or have problems with the
console redirected to /dev/null. Check in the log files for errors from
sdpd. Or you might need to use strace to track it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files for problems?  Stop!  Download the new AJAX search engine that
makes searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may
be privileged. It is intended for use by the addressee only. If you are
not the intended addressee, we request that you notify the sender
immediately and delete or destroy this e-mail message and any
attachment(s), without copying, saving, forwarding, disclosing or using
its contents in any other way. TomTom N.V., TomTom International BV or
any other company belonging to the TomTom group of companies will not be
liable for damage relating to the communication by e-mail of data,
documents or any other information.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files for problems?  Stop!  Download the new AJAX search engine that
makes searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=3Dick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.

------_=_NextPart_001_01C61AAF.C419DC4F
Content-Type: application/octet-stream;
	name="sdpd_noconsole.patch"
Content-Transfer-Encoding: base64
Content-Description: sdpd_noconsole.patch
Content-Disposition: attachment;
	filename="sdpd_noconsole.patch"

PyBzZHBkX25vY29uc29sZS5wYXRjaApJbmRleDogc2RwZC9tYWluLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2c3Jvb3QvYmx1ZXovdXRpbHMvc2RwZC9tYWluLmMsdgpyZXRyaWV2aW5nIHJldmlz
aW9uIDEuMTMKZGlmZiAtdSAtcjEuMTMgbWFpbi5jCi0tLSBzZHBkL21haW4uYwkzIEphbiAyMDA2
IDEzOjI5OjAxIC0wMDAwCTEuMTMKKysrIHNkcGQvbWFpbi5jCTE2IEphbiAyMDA2IDE1OjA0OjQ0
IC0wMDAwCkBAIC0zNSw5ICszNSwxMSBAQAogI2luY2x1ZGUgPHNpZ25hbC5oPgogI2luY2x1ZGUg
PHN5c2xvZy5oPgogI2luY2x1ZGUgPGdldG9wdC5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CiAjaW5j
bHVkZSA8c3lzL3N0YXQuaD4KICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KICNpbmNsdWRlIDxzeXMv
c29ja2V0Lmg+CisjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAKICNpbmNsdWRlIDxibHVldG9vdGgv
Ymx1ZXRvb3RoLmg+CiAjaW5jbHVkZSA8Ymx1ZXRvb3RoL2wyY2FwLmg+CkBAIC0zMDEsOCArMzAz
LDEzIEBACiAJCQlyZXR1cm4gMDsKIAkJc2V0c2lkKCk7CiAJfQotCWZvciAoZmQgPSAwOyBmZCA8
IDM7IGZkKyspCi0JCWNsb3NlKGZkKTsKKwlpZiAoKGZkID0gb3BlbigiL2Rldi9udWxsIiwgT19S
RFdSLCAwKSkgIT0gLTEpIHsKKwkJZHVwMihmZCwgU1RESU5fRklMRU5PKTsKKwkJZHVwMihmZCwg
U1RET1VUX0ZJTEVOTyk7CisJCWR1cDIoZmQsIFNUREVSUl9GSUxFTk8pOworCQlpZiAoZmQgPiBT
VERFUlJfRklMRU5PKQorCQkJY2xvc2UoZmQpOworCX0KIAogCWNoZGlyKCIvIik7CiAJcmV0dXJu
IDE7Cg==

------_=_NextPart_001_01C61AAF.C419DC4F--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
