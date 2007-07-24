Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "leiyu" <leiyu@kcoe.cn>
To: "Bluez-Users" <bluez-users@lists.sourceforge.net>
Date: Tue, 24 Jul 2007 11:43:28 +0800
Message-ID: <EJENLMBEOLKAMCJFBFMDAEDGCAAA.leiyu@kcoe.cn>
MIME-Version: 1.0
In-Reply-To: <EJENLMBEOLKAMCJFBFMDOEDDCAAA.leiyu@kcoe.cn>
Subject: [Bluez-users] Fail in cross-compile bluez-utils-3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0276405020=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0276405020==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

DQoNCkRlYXIgQUxMLA0KDQpJIGhhcyBwYXNzZWQgdG8gY29uZmlndXJlIGJsdWV6LXV0aWxzIGJ5
IFN1bWVldCdzIGhlbHAuDQpCdXQgd2hlbiBJIGVudGVyIGludG8gYmx1ZXotdXRpbHMgZGlyZWN0
b3J5IHRoZW4gbWFrZSBpdCwNCml0IGhhcHBlbnMgbWFueSBlcnJvcnMgYXMgYmVsb3csIEhvdyBj
YW4gSSBmaXggdGhlc2UgcHJvYmxlbXM/DQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAu
IA0KDQouLi4uLi4NCnNkcC14bWwuYzogSW4gZnVuY3Rpb24gYHNkcF94bWxfcGFyc2VfZGF0YXR5
cGUnOg0Kc2RwLXhtbC5jOjc2NDogZXJyb3I6IGRlcmVmZXJlbmNpbmcgcG9pbnRlciB0byBpbmNv
bXBsZXRlIHR5cGUNCnNkcC14bWwuYzo3Njc6IGVycm9yOiBgU0RQX0JPT0wnIHVuZGVjbGFyZWQg
KGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0Kc2RwLXhtbC5jOjc2OTogZXJyb3I6IGBTRFBf
VUlOVDgnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0Kc2RwLXhtbC5j
Ojc3MTogZXJyb3I6IGBTRFBfVUlOVDE2JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikNCnNkcC14bWwuYzo3NzM6IGVycm9yOiBgU0RQX1VJTlQzMicgdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQpzZHAteG1sLmM6Nzc1OiBlcnJvcjogYFNEUF9V
SU5UNjQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0Kc2RwLXhtbC5j
Ojc3NzogZXJyb3I6IGBTRFBfVUlOVDEyOCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMg
ZnVuY3Rpb24pDQpzZHAteG1sLmM6Nzc5OiBlcnJvcjogYFNEUF9JTlQ4JyB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCnNkcC14bWwuYzo3ODE6IGVycm9yOiBgU0RQX0lO
VDE2JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCnNkcC14bWwuYzo3
ODM6IGVycm9yOiBgU0RQX0lOVDMyJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5j
dGlvbikNCnNkcC14bWwuYzo3ODU6IGVycm9yOiBgU0RQX0lOVDY0JyB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCnNkcC14bWwuYzo3ODc6IGVycm9yOiBgU0RQX0lOVDEy
OCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQpzZHAteG1sLmM6Nzkz
OiBlcnJvcjogZGVyZWZlcmVuY2luZyBwb2ludGVyIHRvIGluY29tcGxldGUgdHlwZQ0Kc2RwLXht
bC5jOiBBdCB0b3AgbGV2ZWw6DQpzZHAteG1sLmM6NjU6IGVycm9yOiBzdG9yYWdlIHNpemUgb2Yg
YGluZGVudCcgaXNuJ3Qga25vd24NCnNkcC14bWwuYzo2NzogZXJyb3I6IHN0b3JhZ2Ugc2l6ZSBv
ZiBgbmV4dF9pbmRlbnQnIGlzbid0IGtub3duDQpzZHAteG1sLmM6Mzc0OiB3YXJuaW5nOiBgY29u
dmVydF9yYXdfYXR0cl90b194bWxfZnVuYycgZGVmaW5lZCBidXQgbm90IHVzZWQNCm1ha2VbMl06
ICoqKiBbc2RwLXhtbC5vXSBlcnJvcq+vIDENCm1ha2VbMl06IExlYXZpbmcgZGlyZWN0b3J5IGAv
Ymx1ZXovYmx1ZXotMy0zLTIvYmx1ZXotdXRpbHMtMy45L2NvbW1vbicNCm1ha2VbMV06ICoqKiBb
YWxsLXJlY3Vyc2l2ZV0gZXJyb3KvryAxDQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL2Js
dWV6L2JsdWV6LTMtMy0yL2JsdWV6LXV0aWxzLTMuOScNCm1ha2U6ICoqKiBbYWxsXSBlcnJvcq+v
IDINCg0KQmVzdCByZWdhcmRzLA0KTGVpeXU=



--===============0276405020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0276405020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0276405020==--
