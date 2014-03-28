Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 28 Mar 2014 11:44:50 +0100
Message-ID: <CALkxMhEJxUXaKZgSQ4BSa-UvuEx1uFwVbr4yikH+qB81cUkvDw@mail.gmail.com>
Subject: Missing Linux Bluetooth Headers
From: Michal Labedzki <michal.labedzki@tieto.com>
To: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Could you explain why Linux kernel do not provide any header files for
its sockets?

For example: "socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)"
I do not need a userspace (BlueZ [and do not want it]) to communicate
with kernel, but no Linux headers is a problem. Add dependency to
BlueZ is ugly, because  I do not depend on BlueZ, but Linux kernel.
Also BlueZ is not used in project like "libpcap".

I see that BlueZ have those headers in "lib" directory (sources).
Linux have them in "include/net/bluetooth" but they are not installed
(by "make headers_install").

I think Linux should provide Bluetooth headers files. I see that CAN
(#include <linux/can.h>) do that.

I see that you also try to synchronize with kernel side... (why you do
not use it?)

commit d22d083d6dd681f8d25eb806d4ec91853475ee06
Author:     Gustavo Padovan <gustavo@padovan.org>
AuthorDate: Thu Apr 5 16:22:55 2012 -0300
Commit:     Johan Hedberg <johan.hedberg@intel.com>
CommitDate: Thu Apr 5 22:30:31 2012 +0300

    mgmt: update mgmt control channel id

    kernel side has updated its control channel id from 1 to 3.
---
 lib/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.h b/lib/hci.h
index 887a860..f7be92d 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2288,8 +2288,8 @@ struct sockaddr_hci {
 #define HCI_DEV_NONE   0xffff

 #define HCI_CHANNEL_RAW                0
-#define HCI_CHANNEL_CONTROL    1
 #define HCI_CHANNEL_MONITOR    2
+#define HCI_CHANNEL_CONTROL    3

 struct hci_filter {
        uint32_t type_mask;


-- 

Pozdrawiam / Best regards
-------------------------------------------------------------------------------------------------------------
Michał Łabędzki, Software Engineer
Tieto Corporation

Product Development Services

http://www.tieto.com / http://www.tieto.pl
---
ASCII: Michal Labedzki
location: Swobodna 1 Street, 50-088 Wrocław, Poland
room: 5.01 (desk next to 5.08)
---
Please note: The information contained in this message may be legally
privileged and confidential and protected from disclosure. If the
reader of this message is not the intended recipient, you are hereby
notified that any unauthorised use, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please notify us immediately by replying to
the message and deleting it from your computer. Thank You.
---
Please consider the environment before printing this e-mail.
---
Tieto Poland spółka z ograniczoną odpowiedzialnością z siedzibą w
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w Sądzie Rejonowym
Szczecin-Centrum w Szczecinie, XIII Wydział Gospodarczy Krajowego
Rejestru Sądowego pod numerem 0000124858. NIP: 8542085557. REGON:
812023656. Kapitał zakładowy: 4 271500 PLN
