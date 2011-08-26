Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/6] gobex: fix not handling unkown transport type
Date: Fri, 26 Aug 2011 12:49:31 +0300
Message-Id: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index ff35830..7c2fbcc 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -884,6 +884,9 @@ GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 		obex->read = read_packet;
 		obex->write = write_packet;
 		break;
+	default:
+		g_obex_unref(obex);
+		return NULL;
 	}
 
 	g_io_channel_set_encoding(io, NULL, NULL);
-- 
1.7.6

