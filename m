Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "leiyu" <leiyu@kcoe.cn>
To: "Bluez-Users" <bluez-users@lists.sourceforge.net>
Date: Tue, 24 Jul 2007 13:37:43 +0800
Message-ID: <EJENLMBEOLKAMCJFBFMDIEDGCAAA.leiyu@kcoe.cn>
MIME-Version: 1.0
In-Reply-To: <EJENLMBEOLKAMCJFBFMDAEDGCAAA.leiyu@kcoe.cn>
Subject: [Bluez-users] cross-compile bluez-utils-3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1232042231=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1232042231==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

RGVhciBBTEwsDQoNCkkgaGFzIHBhc3NlZCB0byBjb25maWd1cmUgYmx1ZXotdXRpbHMgYnkgU3Vt
ZWV0J3MgaGVscC4NCkJ1dCB3aGVuIEkgZW50ZXIgaW50byBibHVlei11dGlscyBkaXJlY3Rvcnkg
dGhlbiBtYWtlIGl0LA0KaXQgaGFwcGVucyBtYW55IGVycm9ycyBhcyBiZWxvdywgSG93IGNhbiBJ
IGZpeCB0aGVzZSBwcm9ibGVtcz8NClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgaGVscC4gDQoN
Ci4uLi4uLg0Kc2RwLXhtbC5jOiBJbiBmdW5jdGlvbiBgc2RwX3htbF9wYXJzZV9kYXRhdHlwZSc6
DQpzZHAteG1sLmM6NzY0OiBlcnJvcjogZGVyZWZlcmVuY2luZyBwb2ludGVyIHRvIGluY29tcGxl
dGUgdHlwZQ0Kc2RwLXhtbC5jOjc2NzogZXJyb3I6IGBTRFBfQk9PTCcgdW5kZWNsYXJlZCAoZmly
c3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQpzZHAteG1sLmM6NzY5OiBlcnJvcjogYFNEUF9VSU5U
OCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQpzZHAteG1sLmM6Nzcx
OiBlcnJvcjogYFNEUF9VSU5UMTYnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKQ0Kc2RwLXhtbC5jOjc3MzogZXJyb3I6IGBTRFBfVUlOVDMyJyB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCnNkcC14bWwuYzo3NzU6IGVycm9yOiBgU0RQX1VJTlQ2
NCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQpzZHAteG1sLmM6Nzc3
OiBlcnJvcjogYFNEUF9VSU5UMTI4JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5j
dGlvbikNCnNkcC14bWwuYzo3Nzk6IGVycm9yOiBgU0RQX0lOVDgnIHVuZGVjbGFyZWQgKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0Kc2RwLXhtbC5jOjc4MTogZXJyb3I6IGBTRFBfSU5UMTYn
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0Kc2RwLXhtbC5jOjc4Mzog
ZXJyb3I6IGBTRFBfSU5UMzInIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQ0Kc2RwLXhtbC5jOjc4NTogZXJyb3I6IGBTRFBfSU5UNjQnIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKQ0Kc2RwLXhtbC5jOjc4NzogZXJyb3I6IGBTRFBfSU5UMTI4JyB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCnNkcC14bWwuYzo3OTM6IGVy
cm9yOiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBlDQpzZHAteG1sLmM6
IEF0IHRvcCBsZXZlbDoNCnNkcC14bWwuYzo2NTogZXJyb3I6IHN0b3JhZ2Ugc2l6ZSBvZiBgaW5k
ZW50JyBpc24ndCBrbm93bg0Kc2RwLXhtbC5jOjY3OiBlcnJvcjogc3RvcmFnZSBzaXplIG9mIGBu
ZXh0X2luZGVudCcgaXNuJ3Qga25vd24NCnNkcC14bWwuYzozNzQ6IHdhcm5pbmc6IGBjb252ZXJ0
X3Jhd19hdHRyX3RvX3htbF9mdW5jJyBkZWZpbmVkIGJ1dCBub3QgdXNlZA0KbWFrZVsyXTogKioq
IFtzZHAteG1sLm9dIGVycm9yr68gMQ0KbWFrZVsyXTogTGVhdmluZyBkaXJlY3RvcnkgYC9ibHVl
ei9ibHVlei0zLTMtMi9ibHVlei11dGlscy0zLjkvY29tbW9uJw0KbWFrZVsxXTogKioqIFthbGwt
cmVjdXJzaXZlXSBlcnJvcq+vIDENCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvYmx1ZXov
Ymx1ZXotMy0zLTIvYmx1ZXotdXRpbHMtMy45Jw0KbWFrZTogKioqIFthbGxdIGVycm9yr68gMg0K
DQpCZXN0IHJlZ2FyZHMsDQpMZWl5dQ==



--===============1232042231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1232042231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1232042231==--
