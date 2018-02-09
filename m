Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/4] obexd: Emit Size property of transfer after
 open()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
Message-ID: <dab940d5-fac4-f0ab-f89b-d97af82b1765@jp.fujitsu.com>
Date: Fri, 9 Feb 2018 18:11:41 +0900
MIME-Version: 1.0
In-Reply-To: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emits the Size property of transfer after calling ->open() because it
may update the size information.
---
 obexd/src/obex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index a4bae857f..ed219d3e7 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
 		return err;
 	}
 
+	if (os->size != OBJECT_SIZE_DELETE && os->size != OBJECT_SIZE_UNKNOWN)
+		manager_emit_transfer_property(os->service_data, "Size");
+
 	os->path = g_strdup(filename);
 
 	return 0;
-- 
2.14.1

