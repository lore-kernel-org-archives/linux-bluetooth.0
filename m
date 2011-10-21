Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/7 v3] gobex: dump data when G_OBEX_DEBUG_DATA is set
Date: Fri, 21 Oct 2011 13:34:05 +0300
Message-Id: <1319193245-23058-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1319193245-23058-1-git-send-email-luiz.dentz@gmail.com>
References: <1319193245-23058-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 3930cd7..61edbd5 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -202,6 +202,8 @@ static gboolean write_stream(GObex *obex, GError **err)
 	if (status != G_IO_STATUS_NORMAL)
 		return FALSE;
 
+	g_obex_dump("<", buf, bytes_written);
+
 	obex->tx_sent += bytes_written;
 	obex->tx_data -= bytes_written;
 
@@ -223,6 +225,8 @@ static gboolean write_packet(GObex *obex, GError **err)
 	if (bytes_written != obex->tx_data)
 		return FALSE;
 
+	g_obex_dump("<", buf, bytes_written);
+
 	obex->tx_sent += bytes_written;
 	obex->tx_data -= bytes_written;
 
@@ -720,7 +724,7 @@ static gboolean read_stream(GObex *obex, GError **err)
 
 	obex->rx_data += rbytes;
 	if (obex->rx_data < 3)
-		return TRUE;
+		goto done;
 
 	memcpy(&u16, &buf[1], sizeof(u16));
 	obex->rx_pkt_len = g_ntohs(u16);
@@ -734,7 +738,7 @@ static gboolean read_stream(GObex *obex, GError **err)
 
 read_body:
 	if (obex->rx_data >= obex->rx_pkt_len)
-		return TRUE;
+		goto done;
 
 	do {
 		toread = obex->rx_pkt_len - obex->rx_data;
@@ -742,11 +746,14 @@ read_body:
 
 		status = g_io_channel_read_chars(io, buf, toread, &rbytes, NULL);
 		if (status != G_IO_STATUS_NORMAL)
-			return TRUE;
+			goto done;
 
 		obex->rx_data += rbytes;
 	} while (rbytes > 0 && obex->rx_data < obex->rx_pkt_len);
 
+done:
+	g_obex_dump(">", obex->rx_buf, obex->rx_data);
+
 	return TRUE;
 }
 
@@ -791,6 +798,8 @@ static gboolean read_packet(GObex *obex, GError **err)
 		return FALSE;
 	}
 
+	g_obex_dump(">", obex->rx_buf, obex->rx_data);
+
 	return TRUE;
 fail:
 	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
-- 
1.7.6.4

