Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FCF647.7050806@prolly.org>
From: Douglas Ward <douglas.ward@prolly.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-devel] Logitech BT mini-receiver
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Feb 2006 18:39:51 -0500

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

after being completely ignored on the bluez users list i decided to post
this here.

I can't seem to get an hci device with this device. it came with my
Logitech Cordless desktop mx 5000. It does the whole hid proxy thing so
i tried to run hid2hci and got:

Switching device 046d:0b02 to HCI mode was successful

but when i run hciconfig i get nothing. dmesg shows nothing.

any ideas?
- --
Douglas K Ward
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iQIVAwUBQ/z2RlKDmmHy9Q32AQJtoRAAtgBx34JGrEpsQ51/D2WacNuJTZ8fGxoM
vZ6HtCrn9zfgITBMXQb4pX/PChnxHoaGjnQ4zMi35ZF4S9v2hryyCauDRYGWjFkc
CDrjLrgsqTM/EGgd3ImaeoLrQqZDpKjzn15DleU911YQn5+/gEiz3U7MwvhaI/Rl
fgpgdwU0KY4NnnVFJjolgKsr+EX0By8qDIbDoeGIZVJRy7rDeCClRR6viZ/5blXg
6+lMk9u7ZQEUH6GXZNKXppaQ5OQbYwG5/zEu98VW9xDWxz8gww6eoM0WAEnYykW5
2O1PZ7jYlgHTzQDH2W65R0evNwvTMoahlcflA5AaaoL7dJIcF68lIWV1A1fLt7ym
JSkNQTYmorUL7hSvLDUsRP8JG5DkIf9u4QRVYkE2/fl52k1XkzeXxykhl8SzmrPj
FSUPa2ITHJVyeFzTUGkHvZNrzgQ5Bhkzi3GUU1YBTXOUT1lp6sdXaz2qFa40mPhE
1AP17ZKxsj80SQnHIAoSO/ODp/TP0ZNXmFtfH1a6W00vNdG0nlH4O4eOIed//f50
Ca+5KvVzzPMTSOyojVHTkn5amPlMW6zhgt6Ik968Nu7IW5RJ1b0lL5dZof/1f4sm
wXzMmXt3lMlDX4ZKbZkXA9t7+c/ef4yOt7qtz+DZJD7MhqJr1BlPx1TkUl1+HJyd
xay3Q4sIe80=
=62n/
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
