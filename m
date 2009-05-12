Return-Path: <cyrus@holtmann.org>
Message-ID: <671907.21026.qm@web95401.mail.in2.yahoo.com>
Date: Tue, 12 May 2009 17:44:30 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Help me to test top of tree bluetooth subsystem
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1160769928-1242130470=:21026"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--0-1160769928-1242130470=:21026
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi All ,=0A=0AI have upgraded the ubuntu 8.04 kernel to 2.6.30-rc5 and blue=
z 4.39. I did pairing with Jabra headset using below pyhton script. I got b=
elow error message. This issue is related with ubuntu application dbus. so =
please advise me which distribution , setup procedure  would be suitable to=
 test top tree of bluetooth subsystem.=0A=0AThanks,=0ABalaji.P=0A=0A=0ATrac=
eback (most recent call last):=0A  File "./bthstereoheadset.py", line 25, i=
n <module>=0A    path =3D audio.CreateDevice(headsetAddress)=0A  File "/var=
/lib/python-support/python2.5/dbus/proxies.py", line 68, in __call__=0A    =
return self._proxy_method(*args, **keywords)=0A  File "/var/lib/python-supp=
ort/python2.5/dbus/proxies.py", line 140, in __call__=0A    **keywords)=0A =
 File "/var/lib/python-support/python2.5/dbus/connection.py", line 607, in =
call_blocking=0A    message, timeout)=0Adbus.exceptions.DBusException: org.=
bluez.Error.ConnectionAttemptFailed: Host is down=0A=0A=0A      Now surf fa=
ster and smarter ! Check out the new Firefox 3 - Yahoo! Edition http://down=
loads.yahoo.com/in/firefox/?fr=3Dom_email_firefox
--0-1160769928-1242130470=:21026
Content-Type: text/x-python; name="bthstereoheadset.py"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bthstereoheadset.py"

IyEvdXNyL2Jpbi9weXRob24KaW1wb3J0IGRidXMKaW1wb3J0IG9zCmltcG9y
dCBzeXMKCmRlZiBwcmludHVzYWdlKCk6CglwcmludCAnYnRoc3RlcmVvaGVh
ZHNldC5weSA8b3B0aW9ucz4nCglwcmludCAnICAgIGNyZWF0ZSAtIGNyZWF0
ZSBhIHN0ZXJlbyBoZWFkc2V0JwoJcHJpbnQgJyAgICBzdGFydCAgLSBjb25u
ZWN0IHNpbmsnCglwcmludCAnICAgIHN0b3AgICAtIGRpc2Nvbm5lY3Qgc2lu
aycKCXJldHVybgoJCmhlYWRzZXRBZGRyZXNzID0gb3MuZ2V0ZW52KCJCVFNU
RVJFT19IRUFEU0VUIikKCnByaW50ICdCVCBTdGVyZW8gSGVhZHNldCBJcyA6
ICA9PiAlcycgJSBoZWFkc2V0QWRkcmVzcwoKYnVzID0gZGJ1cy5TeXN0ZW1C
dXMoKQptYW5hZ2VyID0gZGJ1cy5JbnRlcmZhY2UoYnVzLmdldF9vYmplY3Qo
J29yZy5ibHVleicsICcvb3JnL2JsdWV6JyksICdvcmcuYmx1ZXouTWFuYWdl
cicpCmJ1c19pZCA9IG1hbmFnZXIuQWN0aXZhdGVTZXJ2aWNlKCdhdWRpbycp
CmF1ZGlvID0gZGJ1cy5JbnRlcmZhY2UoYnVzLmdldF9vYmplY3QoYnVzX2lk
LCAnL29yZy9ibHVlei9hdWRpbycpLCAnb3JnLmJsdWV6LmF1ZGlvLk1hbmFn
ZXInKQogICAKaWYgbGVuKHN5cy5hcmd2KSA9PSAxIDoKCXByaW50dXNhZ2Uo
KQplbGlmIGxlbihzeXMuYXJndikgPiAxIGFuZCBzeXMuYXJndlsxXSA9PSAn
Y3JlYXRlJyAgOgoJcGF0aCA9IGF1ZGlvLkNyZWF0ZURldmljZShoZWFkc2V0
QWRkcmVzcykKCWF1ZGlvLkNoYW5nZURlZmF1bHREZXZpY2UocGF0aCkgCglz
aW5rID0gZGJ1cy5JbnRlcmZhY2UgKGJ1cy5nZXRfb2JqZWN0KGJ1c19pZCwg
cGF0aCksICdvcmcuYmx1ZXouYXVkaW8uU2luaycpCglzaW5rLkNvbm5lY3Qo
KQoJcHJpbnQgJ1N0ZXJlbyBIZWFkc2V0IENvbm5lY3QgRG9uZScKZWxpZiBs
ZW4oc3lzLmFyZ3YpID4gMSBhbmQgc3lzLmFyZ3ZbMV0gPT0gJ3N0YXJ0JyAg
OgoJcGF0aCA9IGF1ZGlvLkRlZmF1bHREZXZpY2UoKQoJc2luayA9IGRidXMu
SW50ZXJmYWNlIChidXMuZ2V0X29iamVjdChidXNfaWQsIHBhdGgpLCAnb3Jn
LmJsdWV6LmF1ZGlvLlNpbmsnKSAKCWlmIG5vdCBzaW5rLklzQ29ubmVjdGVk
KCkgOgoJCXNpbmsuQ29ubmVjdCgpCQkJCQoJcHJpbnQgJ0F1ZGlvIGNvbm5l
Y3RlZCcKZWxpZiBsZW4oc3lzLmFyZ3YpID4gMSBhbmQgc3lzLmFyZ3ZbMV0g
PT0gJ3N0b3AnICA6CglwYXRoID0gYXVkaW8uRGVmYXVsdERldmljZSgpCglz
aW5rID0gZGJ1cy5JbnRlcmZhY2UgKGJ1cy5nZXRfb2JqZWN0KGJ1c19pZCwg
cGF0aCksICdvcmcuYmx1ZXouYXVkaW8uU2luaycpIAoJdHJ5IDogCgkJc2lu
ay5EaXNjb25uZWN0KCkKCWV4Y2VwdCBkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4
Y2VwdGlvbjoKCQlwcmludCAnRGlzY29ubmVjdCBGYWlsZWQnCQkKCXByaW50
ICdTdGVyZW8gaGVhZHNldCBkaXNjb25uZWN0IGNvbXBsZXRlJwoK

--0-1160769928-1242130470=:21026--

