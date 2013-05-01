Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 3/6] gobex: Get rid of gchar
Date: Wed,  1 May 2013 01:51:58 -0300
Message-Id: <1367383921-19129-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain char instead of gchar.
---
 gobex/gobex.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index ce4f284..6badfeb 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -260,9 +260,9 @@ static gboolean write_stream(GObex *obex, GError **err)
 {
 	GIOStatus status;
 	gsize bytes_written;
-	gchar *buf;
+	char *buf;
 
-	buf = (gchar *) &obex->tx_buf[obex->tx_sent];
+	buf = (char *) &obex->tx_buf[obex->tx_sent];
 	status = g_io_channel_write_chars(obex->io, buf, obex->tx_data,
 							&bytes_written, err);
 	if (status != G_IO_STATUS_NORMAL)
@@ -280,9 +280,9 @@ static gboolean write_packet(GObex *obex, GError **err)
 {
 	GIOStatus status;
 	gsize bytes_written;
-	gchar *buf;
+	char *buf;
 
-	buf = (gchar *) &obex->tx_buf[obex->tx_sent];
+	buf = (char *) &obex->tx_buf[obex->tx_sent];
 	status = g_io_channel_write_chars(obex->io, buf, obex->tx_data,
 							&bytes_written, err);
 	if (status != G_IO_STATUS_NORMAL)
@@ -1036,14 +1036,14 @@ static gboolean read_stream(GObex *obex, GError **err)
 	GIOStatus status;
 	gsize rbytes, toread;
 	guint16 u16;
-	gchar *buf;
+	char *buf;
 
 	if (obex->rx_data >= 3)
 		goto read_body;
 
 	rbytes = 0;
 	toread = 3 - obex->rx_data;
-	buf = (gchar *) &obex->rx_buf[obex->rx_data];
+	buf = (char *) &obex->rx_buf[obex->rx_data];
 
 	status = g_io_channel_read_chars(io, buf, toread, &rbytes, NULL);
 	if (status != G_IO_STATUS_NORMAL)
@@ -1069,7 +1069,7 @@ read_body:
 
 	do {
 		toread = obex->rx_pkt_len - obex->rx_data;
-		buf = (gchar *) &obex->rx_buf[obex->rx_data];
+		buf = (char *) &obex->rx_buf[obex->rx_data];
 
 		status = g_io_channel_read_chars(io, buf, toread, &rbytes, NULL);
 		if (status != G_IO_STATUS_NORMAL)
@@ -1098,7 +1098,7 @@ static gboolean read_packet(GObex *obex, GError **err)
 		goto fail;
 	}
 
-	status = g_io_channel_read_chars(io, (gchar *) obex->rx_buf,
+	status = g_io_channel_read_chars(io, (char *) obex->rx_buf,
 					obex->rx_mtu, &rbytes, &read_err);
 	if (status != G_IO_STATUS_NORMAL) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
-- 
1.8.2.2

