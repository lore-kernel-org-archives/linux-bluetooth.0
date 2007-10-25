Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 25 Oct 2007 12:06:53 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Message-ID: <20071025120653.5a89aebe@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart_Thu__25_Oct_2007_12_06_53_+0200_Sq/WzR7ya3m3NTN_"
Subject: [Bluez-devel] [PATCH] Fix broken EVT_REMOTE_NAME_REQ_COMPLETE
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

--Multipart_Thu__25_Oct_2007_12_06_53_+0200_Sq/WzR7ya3m3NTN_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

I'm sending this bluez-libs patch for the third time now and i wonder why
you do not include it. If there is anything wrong with it please let me know
so I can learn.

Please look at 

http://article.gmane.org/gmane.linux.bluez.devel/13859
http://thread.gmane.org/gmane.linux.bluez.devel/12491

We did extensive testing and rolled that patch into production
environment already and there is another independent user (Matthias
Becker) who confirmed its usefulness.

Hoping to hear from You

Andreas Gaufer

I fully agree with RFC 1855


--Multipart_Thu__25_Oct_2007_12_06_53_+0200_Sq/WzR7ya3m3NTN_
Content-Type: application/octet-stream;
	name=bluez-libs-3.21-EVT_REMOTE_NAME_REQ_COMPLETE.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=bluez-libs-3.21-EVT_REMOTE_NAME_REQ_COMPLETE.patch

ZGlmZiAtdXIgYmx1ZXotbGlicy0zLjIxLW9yaWcvc3JjL2hjaS5jIGJsdWV6LWxpYnMtMy4yMS9z
cmMvaGNpLmMKLS0tIGJsdWV6LWxpYnMtMy4yMS1vcmlnL3NyYy9oY2kuYwkyMDA3LTEwLTA1IDA5
OjE1OjUyLjAwMDAwMDAwMCArMDIwMAorKysgYmx1ZXotbGlicy0zLjIxL3NyYy9oY2kuYwkyMDA3
LTEwLTI1IDExOjU3OjQ3LjcyOTY1NTU4NCArMDIwMApAQCAtMTAxMCw2ICsxMDEwLDggQEAKIAl3
aGlsZSAodHJ5LS0pIHsKIAkJZXZ0X2NtZF9jb21wbGV0ZSAqY2M7CiAJCWV2dF9jbWRfc3RhdHVz
ICAgKmNzOworCQlldnRfcmVtb3RlX25hbWVfcmVxX2NvbXBsZXRlICpybjsKKwkJcmVtb3RlX25h
bWVfcmVxX2NwICpjcDsKIAogCQlpZiAodG8pIHsKIAkJCXN0cnVjdCBwb2xsZmQgcDsKQEAgLTEw
NzQsNiArMTA3NiwyMSBAQAogCQkJbWVtY3B5KHItPnJwYXJhbSwgcHRyLCByLT5ybGVuKTsKIAkJ
CWdvdG8gZG9uZTsKIAorCQljYXNlIEVWVF9SRU1PVEVfTkFNRV9SRVFfQ09NUExFVEU6CisKKwkJ
CWlmIChoZHItPmV2dCAhPSByLT5ldmVudCkKKwkJCQlicmVhazsKKworCQkJci0+cmxlbiA9IE1J
TihsZW4sIHItPnJsZW4pOworCQkJbWVtY3B5KHItPnJwYXJhbSwgcHRyLCByLT5ybGVuKTsKKwor
CQkJcm4gPSByLT5ycGFyYW07CisJCQljcCA9IHItPmNwYXJhbTsKKworCQkJaWYgKGJhY21wKCZy
bi0+YmRhZGRyLCZjcC0+YmRhZGRyKSA9PSAwKQorCQkJCWdvdG8gZG9uZTsKKwkJCWNvbnRpbnVl
OworCiAJCWRlZmF1bHQ6CiAJCQlpZiAoaGRyLT5ldnQgIT0gci0+ZXZlbnQpCiAJCQkJYnJlYWs7
Cg==

--Multipart_Thu__25_Oct_2007_12_06_53_+0200_Sq/WzR7ya3m3NTN_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--Multipart_Thu__25_Oct_2007_12_06_53_+0200_Sq/WzR7ya3m3NTN_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Multipart_Thu__25_Oct_2007_12_06_53_+0200_Sq/WzR7ya3m3NTN_--
