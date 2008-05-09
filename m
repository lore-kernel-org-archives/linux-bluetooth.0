Return-Path: <cyrus@holtmann.org>
Message-ID: <f9d4bd30805091252j4fdb59ddrfed908cf6af4ef46@mail.gmail.com>
Date: Fri, 9 May 2008 16:52:45 -0300
From: "Claudio Takahasi" <claudio.takahasi@openbossa.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6429_30333392.1210362765174"
Subject: [Bluez-devel] [PATCH]Service Search Request bug
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

------=_Part_6429_30333392.1210362765174
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Please review the attached patch.

I found this error when I was using OBEX Data Server. There is a
"short" description here:
http://pastebin.com/m7b65cb6e

The same bug was reported in the ubuntu launchpad:
https://bugs.launchpad.net/ubuntu/+source/obex-data-server/+bug/211252

Regards,
Claudio.
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999

------=_Part_6429_30333392.1210362765174
Content-Type: text/x-diff; name=sdpd01.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg16hjdo0
Content-Disposition: attachment; filename=sdpd01.patch

SW5kZXg6IHNkcGQvcmVxdWVzdC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2JsdWV6
L3V0aWxzL3NkcGQvcmVxdWVzdC5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIyCmRpZmYgLXUg
LXIxLjIyIHJlcXVlc3QuYwotLS0gc2RwZC9yZXF1ZXN0LmMJNSBNYXIgMjAwOCAxODoxMDozOSAt
MDAwMAkxLjIyCisrKyBzZHBkL3JlcXVlc3QuYwk5IE1heSAyMDA4IDE5OjM2OjU4IC0wMDAwCkBA
IC0yMzgsMTMgKzIzOCwxMiBAQAogewogCWludCBzdGF0dXMgPSAwLCBpLCBwbGVuLCBtbGVuLCBt
dHUsIHNjYW5uZWQ7CiAJc2RwX2xpc3RfdCAqcGF0dGVybiA9IE5VTEw7Ci0JdWludDE2X3QgZXhw
ZWN0ZWQsIGFjdHVhbDsKKwl1aW50MTZfdCBleHBlY3RlZCwgYWN0dWFsLCByc3BfY291bnQgPSAw
OwogCXVpbnQ4X3QgZHRkOwogCXNkcF9jb250X3N0YXRlX3QgKmNzdGF0ZSA9IE5VTEw7CiAJdWlu
dDhfdCAqcENhY2hlQnVmZmVyID0gTlVMTDsKIAlpbnQgaGFuZGxlU2l6ZSA9IDA7CiAJdWludDMy
X3QgY1N0YXRlSWQgPSAwOwotCXNob3J0IHJzcF9jb3VudCA9IDA7CiAJc2hvcnQgKnBUb3RhbFJl
Y29yZENvdW50LCAqcEN1cnJlbnRSZWNvcmRDb3VudDsKIAl1aW50OF90ICpwZGF0YSA9IHJlcS0+
YnVmICsgc2l6ZW9mKHNkcF9wZHVfaGRyX3QpOwogCg==
------=_Part_6429_30333392.1210362765174
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------=_Part_6429_30333392.1210362765174
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_6429_30333392.1210362765174--
