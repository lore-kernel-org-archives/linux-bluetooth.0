Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43724A9D.8060807@hkr.at>
From: Harald Krammer <Harald.Krammer@hkr.at>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------010707000606020707020503"
Subject: [Bluez-users] problem to bring up my BT-Device up and running
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 09 Nov 2005 20:14:37 +0100

This is a multi-part message in MIME format.
--------------010707000606020707020503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi *,
I have a problem to bring up my BT-Device up and running. I used my
BT-USB-Stick already success full  under plain Linux, but now I get a
request to make the same under VMWare 5.0 on a Windows host. Btw, it was
not my idea. I installed all needed software, but it doesn't seem to work.

If I try
>hciconfig hci0 up
I get only this message:
Can't init device hci0: Connection timed out (110)

The reason is unclear for me. Is it a problem with the latest software
release or is it problematic to use BT-USB over VMWare ?

I attached my kernel-log output with enabled hci_usb debug message. If
you want to skip the boot-up message look for  @MARK.


Here a summary of my config:
----------------------------
BT-USB stick:
ACER BT600 or Toshiba Version 2.0 edr
(both tested)

Host type:
Debian 3.1 on VMWare 5.0 on Win2k

Version information:

Linux Kernel 2.6.14.1-mh2
bluez-utils 2.22
bluez-libs 2.22
bluez-firmware 1.1

Any hints are welcome!

nice greetings,
harald

-- 

Harald Krammer
Brucknerstrasse 33
A - 4020  Linz
AUSTRIA

Mobil +43.(0) 664. 130 59 58
Mail: Harald.Krammer (at) hkr.at

--------------010707000606020707020503
Content-Type: application/x-tar;
 name="messages.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="messages.gz"

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
oIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKBiUmh8KZXtE3qCojxM
ZfuEUEEFFVRQQQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQ
QQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQQeXvptL8Uirb
J/QERXmYyvYJoYIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqo
oIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooILK/UXZ/1Iq
2yf0BEV5mMr2CaGCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoq
qKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooILK
302l9aVUtk/oCYryMJXtE0IFFVRQQQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQQQUV
VFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEFFVRQQQUVVFBBBRVUUEEF
FVRQQQWVv5tK+0upbJ/QExTlYSrbJ4QKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIK
KqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCC
CiqooILKY6o0nC+k8ggJPUFRHqTyCAmhggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqig
ggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqo
oIIKKqigggoqqKCCCip/WRX3S6lsn9ATFOVhKtsnhAoqqKCCCiqooIIKKqigggoqqKCCCiqo
oIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoq
qKCCCiqooIIKKqigggoqqKCCCiomBe9LqWyf0BMU5WEq2yeECiqooIIKKqigggoqqKCCCiqo
oIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoqqKCCCiqooIIKKqigggoq
qKCCCiqooIIKKqigggoqqKCCCir3F8X/UirbJ/QERXmYyvYJ/V87ZZTCMAgE0avsBQrWaslt
ArWmDRULldy/Ja4YLMVKNpCP/V3YHWaeI1NhKkyFqTAVpsJUyKkMbgr3eLthy7hnsM1bk3ej
f/QfC2H9Lgwva0d/gx4jkeeLETGSI+TZVa1SiZOso5XtVNKRkGdNOj+44qF0HHEeZPGCdtm6
GiCa4OqAZmdCJGdLt6Q6cwcLHezlVj/J10Og5LNVbmVNKVL7o6ZGm5NCHQV5pilqGg+l4xQ1
rbaHxM/ys38DKqEXPVheAwA=
--------------010707000606020707020503--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
