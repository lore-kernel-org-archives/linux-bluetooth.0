Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] README: Add HACKING section
Date: Tue,  1 Jul 2014 15:50:40 +0300
Message-Id: <1404219043-4216-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
References: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 README | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/README b/README
index c991ab0..fd32464 100644
--- a/README
+++ b/README
@@ -125,3 +125,15 @@ Mailing lists:
 
 For additional information about the project visit BlueZ web site:
 	http://www.bluez.org
+
+Hacking
+=======
+
+It is recommended to use bootstrap-configure over configure when hacking, in
+addition to that it is also recommended to use Sparse if possible e.g:
+	./boostrap-configure CC=cgcc
+
+Valgrind shall always be used when testing changes:
+	G_SLICE=always-malloc G_DEBUG=gc-friendly,resident-module valgrind
+	--trace-children=yes --track-origins=yes --show-possibly-lost=no
+	--leak-check=full ./bluetoothd
-- 
1.9.3

