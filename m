Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Message-Id: <20040610203555.273c77bd.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__10_Jun_2004_20:35:55_+0200_0841a078"
Subject: [Bluez-devel] [PATCH] Deleted acl-handles on failed hci_create_connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 10 Jun 2004 20:35:55 +0200

This is a multi-part message in MIME format.

--Multipart_Thu__10_Jun_2004_20:35:55_+0200_0841a078
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Heres a patch for hci_event.c to fix the problem that acl-handles are removed 
from the kernels connection hash when a hci_create_connection returnes a
command status thats not 0x00.

One of the problems that was caused by this bug was that cc could be issued 
even if the peer was already connected. This case leads to the error message 
"Too many links" with sdptool and rfcomm for example. This connection could 
only be removed if the acl handle was known otherwise or by removing power 
from the usb-dongle (unplugg).

Have Fun!

Greetings

Andreas Gaufer
 


--Multipart_Thu__10_Jun_2004_20:35:55_+0200_0841a078
Content-Type: application/octet-stream;
 name="patch-2.4.26-ag1.gz"
Content-Disposition: attachment;
 filename="patch-2.4.26-ag1.gz"
Content-Transfer-Encoding: base64

H4sICMOlyEACA3BhdGNoLTIuNC4yNi1hZzEAlU9NT8JAED23v2IgwbTpLqUtQS2RVEANSvQgicem
H1PapGxJu4skhv/utkXBg4ledmfevDfzXpwlCVAqWJZkGMuqxEiUVbZDoAswy6Lg60AkppwwfKdJ
liPkGRN7aveHfXtkMuRmmAvkkpmaaZT5uEPG+9EPGg3W1u9UlVL6x63Km3R5jyFYV2ANXWfkOjbY
g8FQNQzjHyeVVSrgUTCwBlLuWo7rOO0ezwPqWNfEcsCo/0vwPBWU6cqfTx+0bq+CigdcVDDY9/YQ
xkEclyDRqGAMetsugTTGHZ2wYIMEpFJRWgGBMOBFxUvtIoropFXqpBHqYxVUqmQJaC1Zhw/ZN0Az
b1ulrumkpiDcgPQ0W7683s3HzbCOty0LXvg1DSPuR8mmkZOjZ/1ErGE/xlw7npf4QT4HwLxCec1o
bndObqB10/myA0c70sf3PplIq9MTuJ0t/eXi+YnAedhxozoP9QmLF5OUgAIAAA==

--Multipart_Thu__10_Jun_2004_20:35:55_+0200_0841a078--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
