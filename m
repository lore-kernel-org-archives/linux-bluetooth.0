Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6669365c0706210944m23ffe64kde10851d85edf3f0@mail.gmail.com>
Date: Thu, 21 Jun 2007 16:44:38 +0000
From: "Daniel Ribeiro" <drwyrm@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_146916_30137553.1182444278599"
Subject: [Bluez-devel] [PATCH] BCM2035 on UART at higher speeds + Support
	for setting bdaddr.
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

------=_Part_146916_30137553.1182444278599
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sending again as Marcel requested.

-- 
EOF

Daniel Ribeiro

------=_Part_146916_30137553.1182444278599
Content-Type: text/x-diff; name=bluez-bcm2035.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f37a7ulb
Content-Disposition: attachment; filename="bluez-bcm2035.patch"

VGhpcyBjb3JyZWN0cyBiYXVyYXRlIHBhcmFtZXRlcnMgZm9yIGJjbTIwMzUgY29ubmVjdGVkIHZp
YSB1YXJ0IGFuZCBhZGRzCnN1cHBvcnQgZm9yIHNldHRpbmcgdGhlIGJkYWRkci4KClNpZ25lZC1v
ZmYtYnk6IERhbmllbCBSaWJlaXJvIDxkcnd5cm1AZ21haWwuY29tPgpJbmRleDogYmx1ZXotdXRp
bHMtMy4xMC90b29scy9oY2lhdHRhY2guYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBibHVlei11dGlscy0zLjEw
Lm9yaWcvdG9vbHMvaGNpYXR0YWNoLmMJMjAwNy0wNS0xMiAxMzoxNjozOC4wMDAwMDAwMDAgLTAz
MDAKKysrIGJsdWV6LXV0aWxzLTMuMTAvdG9vbHMvaGNpYXR0YWNoLmMJMjAwNy0wNS0xMiAxNTo0
NDoxNC4wMDAwMDAwMDAgLTAzMDAKQEAgLTkyNSwxMSArOTI1LDEzIEBACiAvKgogICogQnJvYWRj
b20gc3BlY2lmaWMgaW5pdGlhbGl6YXRpb24KICAqIEV4dHJhY3RlZCBmcm9tIEp1bmdvIG9wZW5y
ZworICogU2V0IGJkYWRkciBhbmQgY29ycmVjdCBiYXVkIHJhdGUgYXJndW1lbnRzIHRha2VuIGZy
b20gT3BlbkVaWAogICovCiBzdGF0aWMgaW50IGJjbTIwMzUoaW50IGZkLCBzdHJ1Y3QgdWFydF90
ICp1LCBzdHJ1Y3QgdGVybWlvcyAqdGkpCiB7CiAJaW50IG47CiAJdW5zaWduZWQgY2hhciBjbWRb
MzBdLCByZXNwWzMwXTsKKwliZGFkZHJfdCBiZGFkZHI7CiAKIAkvKiBSZXNldCB0aGUgQlQgQ2hp
cCAqLwogCW1lbXNldChjbWQsIDAsIHNpemVvZihjbWQpKTsKQEAgLTk1MSw2ICs5NTMsMzIgQEAK
IAkJcmV0dXJuIC0xOwogCX0KIAorCWlmICh1LT5iZGFkZHIgIT0gTlVMTCkgeworCQkvKiBzZXQg
YmRhZGRyICovCisJCW1lbXNldChjbWQsIDAsIHNpemVvZihjbWQpKTsKKwkJbWVtc2V0KHJlc3As
IDAsIHNpemVvZihyZXNwKSk7CisJCWNtZFswXSA9IEhDSV9DT01NQU5EX1BLVDsKKwkJY21kWzFd
ID0gMHgwMTsKKwkJY21kWzJdID0gMHhmYzsKKwkJY21kWzNdID0gMHgwNjsKKworCQlzdHIyYmEo
dS0+YmRhZGRyLCAmYmRhZGRyKTsKKwkJYmFjcHkoKGJkYWRkcl90ICopIChjbWQgKyA0KSwgJmJk
YWRkcik7CisKKwkJLyogU2VuZCBjb21tYW5kICovCisJCWlmICh3cml0ZShmZCwgY21kLCAxMCkg
IT0gMTApIHsKKwkJCWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHdyaXRlIFwic2V0IGJkYWRk
clwiICIKKwkJCSJjb21tYW5kXG4iKTsKKwkJCXJldHVybiAtMTsKKwkJfQorCisJCS8qIFJlYWQg
cmVwbHkgKi8KKwkJaWYgKChuID0gcmVhZF9oY2lfZXZlbnQoZmQsIHJlc3AsIDEwKSkgPCAwKSB7
CisJCQlmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0byBzZXQgYmRhZGRyXG4iKTsKKwkJCXJldHVy
biAtMTsKKwkJfQorCX0KKwogCS8qIFJlYWQgdGhlIGxvY2FsIHZlcnNpb24gaW5mbyAqLwogCW1l
bXNldChjbWQsIDAsIHNpemVvZihjbWQpKTsKIAltZW1zZXQocmVzcCwgMCwgc2l6ZW9mKHJlc3Ap
KTsKQEAgLTEwMTAsMTEgKzEwMzgsMTEgQEAKIAkJY21kWzVdID0gMHhmYTsKIAkJYnJlYWs7CiAJ
Y2FzZSA0NjA4MDA6Ci0JCWNtZFs0XSA9IDB4MTE7CisJCWNtZFs0XSA9IDB4MjI7CiAJCWNtZFs1
XSA9IDB4ZmQ7CiAJCWJyZWFrOwogCWNhc2UgOTIxNjAwOgotCQljbWRbNF0gPSAweDY1OworCQlj
bWRbNF0gPSAweDU1OwogCQljbWRbNV0gPSAweGZmOwogCQlicmVhazsKIAlkZWZhdWx0OgpAQCAt
MTEwMyw3ICsxMTMxLDcgQEAKIAl7ICJiaWxsaW9udG9uIiwgMHgwMjc5LCAweDk1MGIsIEhDSV9V
QVJUX0JDU1AsIDExNTIwMCwgMTE1MjAwLCAwLCAgICAgICAgTlVMTCwgYmNzcCAgICAgfSwKIAog
CS8qIEJyb2FkY29tIEJDTTIwMzUgKi8KLQl7ICJiY20yMDM1IiwgICAgMHgwQTVDLCAweDIwMzUs
IEhDSV9VQVJUX0g0LCAgIDExNTIwMCwgMTE1MjAwLCAwLCAgICAgICAgTlVMTCwgYmNtMjAzNSAg
fSwKKwl7ICJiY20yMDM1IiwgICAgMHgwQTVDLCAweDIwMzUsIEhDSV9VQVJUX0g0LCAgIDExNTIw
MCwgNDYwODAwLCBGTE9XX0NUTCwgTlVMTCwgYmNtMjAzNSAgfSwKIAogCXsgTlVMTCwgMCB9CiB9
Owo=
------=_Part_146916_30137553.1182444278599
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------=_Part_146916_30137553.1182444278599
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_146916_30137553.1182444278599--
