Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Make btmgmt tools installable
Date: Fri, 31 Mar 2017 16:58:23 +0300
Message-Id: <20170331135823.21883-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.tools | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 55d392e..73b2eef 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -348,7 +348,9 @@ EXTRA_DIST += tools/hid2hci.1
 endif
 
 if READLINE
-noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
+bin_PROGRAMS += tools/btmgmt
+
+noinst_PROGRAMS += tools/obex-client-tool tools/obex-server-tool \
 			tools/bluetooth-player tools/obexctl
 
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
-- 
2.9.3

