Return-Path: <cyrus@holtmann.org>
Message-ID: <48BEE75C.9050008@free.fr>
Date: Wed, 03 Sep 2008 21:37:00 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Sniff mode issues regarding Sony Ericsson headsets: kernel patch
 proposal.
Content-Type: multipart/mixed;
 boundary="------------070406070805090803030301"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070406070805090803030301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Marcel,

Due to job requirement, I recently fined tuned a kernel to work well 
with some Sony Erisson A2DP Headsets (namely Motorola HBH-DS970 and 
HBH-DS980): this means making sure to force the other side to exit sniff 
mode early on before the AVDTP signalling comes into play.

If i remember well we had a talk a while ago about the way the sniff 
mode was handled by the kernel due to various issues with some bluetooth 
keyboards. The conclusion we had at that time, the best way to handle 
this issue was to add a socket option on an L2CAP channel to force the 
other side to exit sniff mode even if it was the one who initially 
entered the sniff mode.

I used this approach and wrote & tested a patch against 2.6.26-mh3. 
Patch is attached and seems to solve the issue.

*but*

During validation testing we found yet another issue that seems to be 
related to the way we handle the sniff mode.
The syndrom is that if the user screws up at enterring the pin code 
during pairing bluez fails to close the acl connection properly,
which means subsequent attempts result in a "connection already exist" 
error. From the user point of view it is impossible to try to pair again 
to the same headset...which is quite annoying.
Below is an hci trace of the issue:
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 1 status 1
      Connection pending - Authentication pending
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:1C:A4:2C:FA:4A
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:1C:A4:2C:FA:4A len 4 pin '1111'
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 2
    status 0x00 bdaddr 00:1C:A4:2C:FA:4A
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 3 status 0
      Connection refused - security block
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x02 interval 2048
    Mode: Sniff
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x0c handle 1 reason 0x1f
    Error: Command Disallowed
 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 2

I hacked the kernel to try to see if forcing the headset to exit sniff 
mode before sending disconnect would solve the issue.... well it did :-)
Trace below shows this working:
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0x2e 0x2d 0xfa 0x98 0x39 0x00 0x80
 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 2
    status 0x00 handle 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 1 status 1
      Connection pending - Authentication pending
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:1C:A4:2C:FA:4A
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:1C:A4:2C:FA:4A len 4 pin '1111'
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 2
    status 0x00 bdaddr 00:1C:A4:2C:FA:4A
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 3 status 0
      Connection refused - security block
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x02 interval 2048
    Mode: Sniff
< HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 1
 > HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 0
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x00 interval 0
    Mode: Active
 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 2

Conclusion: to have those bloody Sony Erisson headsets working we have 
to change two things in the kernel:
  1) Provide a way for a L2CAP socket user to alter sniff mode exit 
behaviour
  2) Make sure we exit sniff mode before to disconnect

Question 1: Are you interested in reviewing then merging my patches if i 
try to fix thoses issues ?
Question 2: I have the gut feeling that we should change default 
behaviour to the behaviour required by those headsets, and provide a 
socket option for the bluetooth HID, rather than the other way round. 
What do you think ?

If we can come on an agreement on the proper way to fix this issue then 
i should come with a patch in a 3-4 days timeframe.

Regards,

Fabien




--------------070406070805090803030301
Content-Type: text/plain;
 name="a2dp-sniff-mode-issue.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="a2dp-sniff-mode-issue.diff"

ZGlmZiAtcnUgLXggJyouc28nIC14ICcqLmxkcycgLXggJyouYScgLXggJyouZWxmJyAteCAn
LionIC14ICcqLm9yZGVyJyAteCAnKi5rbycgLXggJyoubW9kLmMnIC14ICcqLm8nIC14ICcq
LmNtZCcgbGludXgtMi42LjI2L2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oIGxp
bnV4LTIuNi4yNittaDMrZmNoL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oCi0t
LSBsaW51eC0yLjYuMjYvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgJMjAwOC0w
OS0wMSAxNzowNjoyMi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yNittaDMrZmNo
L2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oCTIwMDgtMDktMDEgMTI6MjI6MzYu
MDAwMDAwMDAwICswMjAwCkBAIC0xNzAsNiArMTcwLDcgQEAKIAlfX3UzMgkJIGxpbmtfbW9k
ZTsKIAlfX3U4ICAgICAgICAgICAgIGF1dGhfdHlwZTsKIAlfX3U4ICAgICAgICAgICAgIHBv
d2VyX3NhdmU7CisJX191OCAgICAgICAgICAgICBmb3JjZV9hY3RpdmVfbW9kZTsKIAl1bnNp
Z25lZCBsb25nCSBwZW5kOwogCiAJdW5zaWduZWQgaW50CSBzZW50OwpkaWZmIC1ydSAteCAn
Ki5zbycgLXggJyoubGRzJyAteCAnKi5hJyAteCAnKi5lbGYnIC14ICcuKicgLXggJyoub3Jk
ZXInIC14ICcqLmtvJyAteCAnKi5tb2QuYycgLXggJyoubycgLXggJyouY21kJyBsaW51eC0y
LjYuMjYvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmggbGludXgtMi42LjI2K21oMytm
Y2gvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmgKLS0tIGxpbnV4LTIuNi4yNi9pbmNs
dWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaAkyMDA4LTA3LTEzIDIzOjUxOjI5LjAwMDAwMDAw
MCArMDIwMAorKysgbGludXgtMi42LjI2K21oMytmY2gvaW5jbHVkZS9uZXQvYmx1ZXRvb3Ro
L2wyY2FwLmgJMjAwOC0wOS0wMSAxNjoyMDoxNy4wMDAwMDAwMDAgKzAyMDAKQEAgLTYyLDYg
KzYyLDggQEAKICNkZWZpbmUgTDJDQVBfTE1fUkVMSUFCTEUJMHgwMDEwCiAjZGVmaW5lIEwy
Q0FQX0xNX1NFQ1VSRQkJMHgwMDIwCiAKKyNkZWZpbmUgTDJDQVBfRk9SQ0VfQUNUSVZFX01P
REUJMHgwNAorCiAvKiBMMkNBUCBjb21tYW5kIGNvZGVzICovCiAjZGVmaW5lIEwyQ0FQX0NP
TU1BTkRfUkVKIDB4MDEKICNkZWZpbmUgTDJDQVBfQ09OTl9SRVEgICAgMHgwMgpTZXVsZW1l
bnQgZGFucyBsaW51eC0yLjYuMjYrbWgzK2ZjaC9rZXJuZWw6IGJvdW5kcy5zClNldWxlbWVu
dCBkYW5zIGxpbnV4LTIuNi4yNittaDMrZmNoL2tlcm5lbDogdGltZWNvbnN0LmgKU2V1bGVt
ZW50IGRhbnMgbGludXgtMi42LjI2K21oMytmY2gvbGliOiBjcmMzMnRhYmxlLmgKU2V1bGVt
ZW50IGRhbnMgbGludXgtMi42LjI2K21oMytmY2gvbGliOiBnZW5fY3JjMzJ0YWJsZQpTZXVs
ZW1lbnQgZGFucyBsaW51eC0yLjYuMjYrbWgzK2ZjaC86IE1vZHVsZS5zeW12ZXJzCmRpZmYg
LXJ1IC14ICcqLnNvJyAteCAnKi5sZHMnIC14ICcqLmEnIC14ICcqLmVsZicgLXggJy4qJyAt
eCAnKi5vcmRlcicgLXggJyoua28nIC14ICcqLm1vZC5jJyAteCAnKi5vJyAteCAnKi5jbWQn
IGxpbnV4LTIuNi4yNi9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMgbGludXgtMi42LjI2K21o
MytmY2gvbmV0L2JsdWV0b290aC9oY2lfY29ubi5jCi0tLSBsaW51eC0yLjYuMjYvbmV0L2Js
dWV0b290aC9oY2lfY29ubi5jCTIwMDgtMDktMDEgMTc6MDY6MjIuMDAwMDAwMDAwICswMjAw
CisrKyBsaW51eC0yLjYuMjYrbWgzK2ZjaC9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMJMjAw
OC0wOS0wMSAxNjoxNjozMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTIxNCw2ICsyMTQsNyBAQAog
CWNvbm4tPnN0YXRlID0gQlRfT1BFTjsKIAogCWNvbm4tPnBvd2VyX3NhdmUgPSAxOworCWNv
bm4tPmZvcmNlX2FjdGl2ZV9tb2RlID0gMDsKIAogCXN3aXRjaCAodHlwZSkgewogCWNhc2Ug
QUNMX0xJTks6CkBAIC00NjQsNyArNDY1LDEwIEBACiAJaWYgKHRlc3RfYml0KEhDSV9SQVcs
ICZoZGV2LT5mbGFncykpCiAJCXJldHVybjsKIAotCWlmIChjb25uLT5tb2RlICE9IEhDSV9D
TV9TTklGRiB8fCAhY29ubi0+cG93ZXJfc2F2ZSkKKwlpZiAoY29ubi0+bW9kZSAhPSBIQ0lf
Q01fU05JRkYpCisJCWdvdG8gdGltZXI7CisKKwlpZiAoIWNvbm4tPnBvd2VyX3NhdmUgJiYg
IWNvbm4tPmZvcmNlX2FjdGl2ZV9tb2RlKQogCQlnb3RvIHRpbWVyOwogCiAJaWYgKCF0ZXN0
X2FuZF9zZXRfYml0KEhDSV9DT05OX01PREVfQ0hBTkdFX1BFTkQsICZjb25uLT5wZW5kKSkg
ewpkaWZmIC1ydSAteCAnKi5zbycgLXggJyoubGRzJyAteCAnKi5hJyAteCAnKi5lbGYnIC14
ICcuKicgLXggJyoub3JkZXInIC14ICcqLmtvJyAteCAnKi5tb2QuYycgLXggJyoubycgLXgg
JyouY21kJyBsaW51eC0yLjYuMjYvbmV0L2JsdWV0b290aC9sMmNhcC5jIGxpbnV4LTIuNi4y
NittaDMrZmNoL25ldC9ibHVldG9vdGgvbDJjYXAuYwotLS0gbGludXgtMi42LjI2L25ldC9i
bHVldG9vdGgvbDJjYXAuYwkyMDA4LTA5LTAxIDE3OjA2OjIyLjAwMDAwMDAwMCArMDIwMAor
KysgbGludXgtMi42LjI2K21oMytmY2gvbmV0L2JsdWV0b290aC9sMmNhcC5jCTIwMDgtMDkt
MDEgMTc6MTg6MjMuMDAwMDAwMDAwICswMjAwCkBAIC0xMTMzLDYgKzExMzMsMjAgQEAKIAkJ
bDJjYXBfcGkoc2spLT5saW5rX21vZGUgPSBvcHQ7CiAJCWJyZWFrOwogCisJY2FzZSBMMkNB
UF9GT1JDRV9BQ1RJVkVfTU9ERToKKwkJaWYgKHNrLT5za19zdGF0ZSAhPSBCVF9DT05ORUNU
RUQpIHsKKwkJCWVyciA9IC1FTk9UQ09OTjsKKwkJCWJyZWFrOworCQl9CisKKwkJaWYgKGdl
dF91c2VyKG9wdCwgKHUzMiBfX3VzZXIgKikgb3B0dmFsKSkgeworCQkJZXJyID0gLUVGQVVM
VDsKKwkJCWJyZWFrOworCQl9CisKKwkJbDJjYXBfcGkoc2spLT5jb25uLT5oY29uLT5mb3Jj
ZV9hY3RpdmVfbW9kZSA9IG9wdDsKKwkJYnJlYWs7CisKIAlkZWZhdWx0OgogCQllcnIgPSAt
RU5PUFJPVE9PUFQ7CiAJCWJyZWFrOwpAQCAtMTE4OSw2ICsxMjAzLDE3IEBACiAKIAkJYnJl
YWs7CiAKKwljYXNlIEwyQ0FQX0ZPUkNFX0FDVElWRV9NT0RFOgorCQlpZiAoc2stPnNrX3N0
YXRlICE9IEJUX0NPTk5FQ1RFRCkgeworCQkJZXJyID0gLUVOT1RDT05OOworCQkJYnJlYWs7
CisJCX0KKworCQlpZiAocHV0X3VzZXIobDJjYXBfcGkoc2spLT5jb25uLT5oY29uLT5mb3Jj
ZV9hY3RpdmVfbW9kZSwKKwkJCQkgKHUzMiBfX3VzZXIgKikgb3B0dmFsKSkKKwkJCWVyciA9
IC1FRkFVTFQ7CisJCWJyZWFrOworCiAJZGVmYXVsdDoKIAkJZXJyID0gLUVOT1BST1RPT1BU
OwogCQlicmVhazsK
--------------070406070805090803030301--
