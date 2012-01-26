Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F217DE3.4020104@babioch.de>
References: <4F204BDC.1010007@babioch.de>
	<CABBYNZJk+n2Rh4K2J_fc8A_WXjyBwck4qhYcfe6wCmK7vK7t-Q@mail.gmail.com>
	<4F2145AF.4050401@babioch.de>
	<4F2159DC.4090408@babioch.de>
	<CABBYNZJ09fo8X69Hqs+d_NiHmq9f2a1JHcSZnot4RXy0fk-u+g@mail.gmail.com>
	<4F217DE3.4020104@babioch.de>
Date: Thu, 26 Jan 2012 19:13:26 +0200
Message-ID: <CABBYNZK2507h+s=SowzpSj4MU=RKk2xsj13VfVbS-7gwLm2FFQ@mail.gmail.com>
Subject: Re: Changed default configuration in bluez 4.97 and higher?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Karol Babioch <karol@babioch.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=485b397dd1258ff14104b7717f40
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--485b397dd1258ff14104b7717f40
Content-Type: text/plain; charset=ISO-8859-1

Hi Karol,

On Thu, Jan 26, 2012 at 6:22 PM, Karol Babioch <karol@babioch.de> wrote:
> Hi,
>
> Am 26.01.2012 16:17, schrieb Luiz Augusto von Dentz:
>> can you check if you get
>> anything on bluetoothd logs like this:
>
> I'm attaching my logs (with -d enabled) here. Hopefully they are not too
> long. As you can see, the discovery works just fine, but I can't see any
> registration of an endpoint, like you proposed.

Thanks for the log, Ive figure out the problem, here is a patch that
might fix it (also attached):

diff --git a/audio/a2dp.c b/audio/a2dp.c
index c4cdc62..2eebe6b 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1441,9 +1441,9 @@ static struct a2dp_server *find_server(GSList
*list, const bdaddr_t *src)

 int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 {
-       int sbc_srcs = 1, sbc_sinks = 1;
+       int sbc_srcs = 0, sbc_sinks = 0;
        int mpeg12_srcs = 0, mpeg12_sinks = 0;
-       gboolean source = TRUE, sink = FALSE, socket = TRUE;
+       gboolean source = TRUE, sink = FALSE, socket = FALSE;
        gboolean delay_reporting = FALSE;
        char *str;
        GError *err = NULL;
@@ -1463,6 +1463,8 @@ int a2dp_register(DBusConnection *conn, const
bdaddr_t *src, GKeyFile *config)
                        source = TRUE;
                if (strstr(str, "Source"))
                        sink = TRUE;
+               if (strstr(str, "Socket"))
+                       socket = TRUE;
                g_free(str);
        }

@@ -1482,18 +1484,14 @@ int a2dp_register(DBusConnection *conn, const
bdaddr_t *src, GKeyFile *config)
        }

        /* Don't register any local sep if Socket is disabled */
-       if (socket == FALSE) {
-               sbc_srcs = 0;
-               sbc_sinks = 0;
-               mpeg12_srcs = 0;
-               mpeg12_sinks = 0;
:

Basically the problem is that the code is assuming that Socket is
enabled by default which is not true anymore.

-- 
Luiz Augusto von Dentz

--485b397dd1258ff14104b7717f40
Content-Type: text/x-patch; charset=US-ASCII; name="diff.patch"
Content-Disposition: attachment; filename="diff.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxw1gpsd1

ZGlmZiAtLWdpdCBhL2F1ZGlvL2EyZHAuYyBiL2F1ZGlvL2EyZHAuYwppbmRleCBjNGNkYzYyLi4y
ZWViZTZiIDEwMDY0NAotLS0gYS9hdWRpby9hMmRwLmMKKysrIGIvYXVkaW8vYTJkcC5jCkBAIC0x
NDQxLDkgKzE0NDEsOSBAQCBzdGF0aWMgc3RydWN0IGEyZHBfc2VydmVyICpmaW5kX3NlcnZlcihH
U0xpc3QgKmxpc3QsIGNvbnN0IGJkYWRkcl90ICpzcmMpCiAKIGludCBhMmRwX3JlZ2lzdGVyKERC
dXNDb25uZWN0aW9uICpjb25uLCBjb25zdCBiZGFkZHJfdCAqc3JjLCBHS2V5RmlsZSAqY29uZmln
KQogewotCWludCBzYmNfc3JjcyA9IDEsIHNiY19zaW5rcyA9IDE7CisJaW50IHNiY19zcmNzID0g
MCwgc2JjX3NpbmtzID0gMDsKIAlpbnQgbXBlZzEyX3NyY3MgPSAwLCBtcGVnMTJfc2lua3MgPSAw
OwotCWdib29sZWFuIHNvdXJjZSA9IFRSVUUsIHNpbmsgPSBGQUxTRSwgc29ja2V0ID0gVFJVRTsK
KwlnYm9vbGVhbiBzb3VyY2UgPSBUUlVFLCBzaW5rID0gRkFMU0UsIHNvY2tldCA9IEZBTFNFOwog
CWdib29sZWFuIGRlbGF5X3JlcG9ydGluZyA9IEZBTFNFOwogCWNoYXIgKnN0cjsKIAlHRXJyb3Ig
KmVyciA9IE5VTEw7CkBAIC0xNDYzLDYgKzE0NjMsOCBAQCBpbnQgYTJkcF9yZWdpc3RlcihEQnVz
Q29ubmVjdGlvbiAqY29ubiwgY29uc3QgYmRhZGRyX3QgKnNyYywgR0tleUZpbGUgKmNvbmZpZykK
IAkJCXNvdXJjZSA9IFRSVUU7CiAJCWlmIChzdHJzdHIoc3RyLCAiU291cmNlIikpCiAJCQlzaW5r
ID0gVFJVRTsKKwkJaWYgKHN0cnN0cihzdHIsICJTb2NrZXQiKSkKKwkJCXNvY2tldCA9IFRSVUU7
CiAJCWdfZnJlZShzdHIpOwogCX0KIApAQCAtMTQ4MiwxOCArMTQ4NCwxNCBAQCBpbnQgYTJkcF9y
ZWdpc3RlcihEQnVzQ29ubmVjdGlvbiAqY29ubiwgY29uc3QgYmRhZGRyX3QgKnNyYywgR0tleUZp
bGUgKmNvbmZpZykKIAl9CiAKIAkvKiBEb24ndCByZWdpc3RlciBhbnkgbG9jYWwgc2VwIGlmIFNv
Y2tldCBpcyBkaXNhYmxlZCAqLwotCWlmIChzb2NrZXQgPT0gRkFMU0UpIHsKLQkJc2JjX3NyY3Mg
PSAwOwotCQlzYmNfc2lua3MgPSAwOwotCQltcGVnMTJfc3JjcyA9IDA7Ci0JCW1wZWcxMl9zaW5r
cyA9IDA7CisJaWYgKHNvY2tldCA9PSBGQUxTRSkKIAkJZ290byBwcm9jZWVkOwotCX0KIAogCXN0
ciA9IGdfa2V5X2ZpbGVfZ2V0X3N0cmluZyhjb25maWcsICJBMkRQIiwgIlNCQ1NvdXJjZXMiLCAm
ZXJyKTsKIAlpZiAoZXJyKSB7CiAJCURCRygiYXVkaW8uY29uZjogJXMiLCBlcnItPm1lc3NhZ2Up
OwogCQlnX2NsZWFyX2Vycm9yKCZlcnIpOworCQlzYmNfc3JjcyA9IDE7CiAJfSBlbHNlIHsKIAkJ
c2JjX3NyY3MgPSBhdG9pKHN0cik7CiAJCWdfZnJlZShzdHIpOwpAQCAtMTUxMiw2ICsxNTEwLDcg
QEAgaW50IGEyZHBfcmVnaXN0ZXIoREJ1c0Nvbm5lY3Rpb24gKmNvbm4sIGNvbnN0IGJkYWRkcl90
ICpzcmMsIEdLZXlGaWxlICpjb25maWcpCiAJaWYgKGVycikgewogCQlEQkcoImF1ZGlvLmNvbmY6
ICVzIiwgZXJyLT5tZXNzYWdlKTsKIAkJZ19jbGVhcl9lcnJvcigmZXJyKTsKKwkJc2JjX3Npbmtz
ID0gMTsKIAl9IGVsc2UgewogCQlzYmNfc2lua3MgPSBhdG9pKHN0cik7CiAJCWdfZnJlZShzdHIp
Owo=
--485b397dd1258ff14104b7717f40--
