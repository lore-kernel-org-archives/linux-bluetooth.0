Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6669365c0706220449u1b7848a6j984c0ef00f0ebbf2@mail.gmail.com>
Date: Fri, 22 Jun 2007 11:49:56 +0000
From: "Daniel Ribeiro" <drwyrm@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6669365c0706210944m23ffe64kde10851d85edf3f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_159909_6093058.1182512996917"
References: <6669365c0706210944m23ffe64kde10851d85edf3f0@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH] BCM2035 on UART at higher speeds +
	Support for setting bdaddr.
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

------=_Part_159909_6093058.1182512996917
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/6/21, Daniel Ribeiro <drwyrm@gmail.com>:
> Sending again as Marcel requested.
Corrections as requested on IRC..

-- 
EOF

Daniel Ribeiro

------=_Part_159909_6093058.1182512996917
Content-Type: text/x-diff; name=bluez-bcm2035.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f38f6oqb
Content-Disposition: attachment; filename="bluez-bcm2035.patch"

Q29ycmVjdCBiYXVkcmF0ZSBwYXJhbWV0ZXJzIGZvciBiY20yMDM1IG9uIHVhcnQgYW5kIHNldCBi
ZGFkZHIuCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgUmliZWlybyA8ZHJ3eXJtQGdtYWlsLmNvbT4K
SW5kZXg6IGJsdWV6LXV0aWxzLTMuMTAvdG9vbHMvaGNpYXR0YWNoLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
Ymx1ZXotdXRpbHMtMy4xMC5vcmlnL3Rvb2xzL2hjaWF0dGFjaC5jCTIwMDctMDUtMTIgMTM6MTY6
MzguMDAwMDAwMDAwIC0wMzAwCisrKyBibHVlei11dGlscy0zLjEwL3Rvb2xzL2hjaWF0dGFjaC5j
CTIwMDctMDYtMjEgMTg6NDI6MDcuMDAwMDAwMDAwIC0wMzAwCkBAIC05NTEsNiArOTUxLDMxIEBA
CiAJCXJldHVybiAtMTsKIAl9CiAKKwlpZiAodS0+YmRhZGRyICE9IE5VTEwpIHsKKwkJLyogc2V0
IGJkYWRkciAqLworCQltZW1zZXQoY21kLCAwLCBzaXplb2YoY21kKSk7CisJCW1lbXNldChyZXNw
LCAwLCBzaXplb2YocmVzcCkpOworCQljbWRbMF0gPSBIQ0lfQ09NTUFORF9QS1Q7CisJCWNtZFsx
XSA9IDB4MDE7CisJCWNtZFsyXSA9IDB4ZmM7CisJCWNtZFszXSA9IDB4MDY7CisKKwkJc3RyMmJh
KHUtPmJkYWRkciwgKGJkYWRkcl90ICopIChjbWQgKyA0KSk7CisKKwkJLyogU2VuZCBjb21tYW5k
ICovCisJCWlmICh3cml0ZShmZCwgY21kLCAxMCkgIT0gMTApIHsKKwkJCWZwcmludGYoc3RkZXJy
LCAiRmFpbGVkIHRvIHdyaXRlIFwic2V0IGJkYWRkclwiICIKKwkJCSJjb21tYW5kXG4iKTsKKwkJ
CXJldHVybiAtMTsKKwkJfQorCisJCS8qIFJlYWQgcmVwbHkgKi8KKwkJaWYgKChuID0gcmVhZF9o
Y2lfZXZlbnQoZmQsIHJlc3AsIDEwKSkgPCAwKSB7CisJCQlmcHJpbnRmKHN0ZGVyciwgIkZhaWxl
ZCB0byBzZXQgYmRhZGRyXG4iKTsKKwkJCXJldHVybiAtMTsKKwkJfQorCX0KKwogCS8qIFJlYWQg
dGhlIGxvY2FsIHZlcnNpb24gaW5mbyAqLwogCW1lbXNldChjbWQsIDAsIHNpemVvZihjbWQpKTsK
IAltZW1zZXQocmVzcCwgMCwgc2l6ZW9mKHJlc3ApKTsKQEAgLTEwMTAsMTEgKzEwMzUsMTEgQEAK
IAkJY21kWzVdID0gMHhmYTsKIAkJYnJlYWs7CiAJY2FzZSA0NjA4MDA6Ci0JCWNtZFs0XSA9IDB4
MTE7CisJCWNtZFs0XSA9IDB4MjI7CiAJCWNtZFs1XSA9IDB4ZmQ7CiAJCWJyZWFrOwogCWNhc2Ug
OTIxNjAwOgotCQljbWRbNF0gPSAweDY1OworCQljbWRbNF0gPSAweDU1OwogCQljbWRbNV0gPSAw
eGZmOwogCQlicmVhazsKIAlkZWZhdWx0OgpAQCAtMTEwMyw3ICsxMTI4LDcgQEAKIAl7ICJiaWxs
aW9udG9uIiwgMHgwMjc5LCAweDk1MGIsIEhDSV9VQVJUX0JDU1AsIDExNTIwMCwgMTE1MjAwLCAw
LCAgICAgICAgTlVMTCwgYmNzcCAgICAgfSwKIAogCS8qIEJyb2FkY29tIEJDTTIwMzUgKi8KLQl7
ICJiY20yMDM1IiwgICAgMHgwQTVDLCAweDIwMzUsIEhDSV9VQVJUX0g0LCAgIDExNTIwMCwgMTE1
MjAwLCAwLCAgICAgICAgTlVMTCwgYmNtMjAzNSAgfSwKKwl7ICJiY20yMDM1IiwgICAgMHgwQTVD
LCAweDIwMzUsIEhDSV9VQVJUX0g0LCAgIDExNTIwMCwgNDYwODAwLCBGTE9XX0NUTCwgTlVMTCwg
YmNtMjAzNSAgfSwKIAogCXsgTlVMTCwgMCB9CiB9Owo=
------=_Part_159909_6093058.1182512996917
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------=_Part_159909_6093058.1182512996917
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_159909_6093058.1182512996917--
