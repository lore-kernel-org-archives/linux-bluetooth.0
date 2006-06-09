Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606090629i6b431352pedf0e125d8d399d4@mail.gmail.com>
Date: Fri, 9 Jun 2006 10:29:45 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2795_9035622.1149859785856"
Subject: [Bluez-devel] bug in hci_devba
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_2795_9035622.1149859785856
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

running the program:
----------------------------------------------
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int main() {
        bdaddr_t bdaddr;
        hci_devba(0, &bdaddr);
        return 0;
}
-----------------------------------------------

in valgrind produces this warning:
-------------------------------------------------------------------------------------
==7618== Conditional jump or move depends on uninitialised value(s)
==7618==    at 0x4B25757: hci_devba (in /usr/lib/libbluetooth.so.1.0.25)
==7618==    by 0x40058D: main (in /home/rafael/temp/temp)
-------------------------------------------------------------------------------------

The attached patch fixes this.

Best Regards,
Rafael

------=_Part_2795_9035622.1149859785856
Content-Type: application/octet-stream; name=hci.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo8kt3vs
Content-Disposition: attachment; filename="hci.patch"

LS0tIHNyYy9oY2kuYwkyMDA2LTAxLTA3IDIzOjAzOjA1LjAwMDAwMDAwMCAtMDMwMAorKysgL2hv
bWUvcmFmYWVsL2hjaS5jCTIwMDYtMDYtMDkgMTA6MjY6MDIuMDAwMDAwMDAwIC0wMzAwCkBAIC03
NjEsNiArNzYxLDcgQEAKIGludCBoY2lfZGV2YmEoaW50IGRldl9pZCwgYmRhZGRyX3QgKmJkYWRk
cikKIHsKIAlzdHJ1Y3QgaGNpX2Rldl9pbmZvIGRpOworCW1lbXNldCgmZGksIDAsIHNpemVvZihk
aSkpOwogCiAJaWYgKGhjaV9kZXZpbmZvKGRldl9pZCwgJmRpKSkKIAkJcmV0dXJuIC0xOwo=
------=_Part_2795_9035622.1149859785856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_2795_9035622.1149859785856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_2795_9035622.1149859785856--
