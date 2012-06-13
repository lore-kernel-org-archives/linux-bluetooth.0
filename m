Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 4/7] gobex: Fix dead assignments in gobex-header.c
Date: Wed, 13 Jun 2012 22:49:20 +0200
Message-Id: <1339620563-25161-4-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Values stored are never read.
---
 gobex/gobex-header.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 035725b..77dcc6e 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -109,23 +109,23 @@ gssize g_obex_header_encode(GObexHeader *header, void *buf, gsize buf_len)
 		g_assert_cmpuint(utf16_len + 3, ==, header->hlen);
 		u16 = g_htons(utf16_len + 3);
 		ptr = put_bytes(ptr, &u16, sizeof(u16));
-		ptr = put_bytes(ptr, utf16, utf16_len);
+		put_bytes(ptr, utf16, utf16_len);
 		g_free(utf16);
 		break;
 	case G_OBEX_HDR_ENC_BYTES:
 		u16 = g_htons(header->hlen);
 		ptr = put_bytes(ptr, &u16, sizeof(u16));
 		if (header->extdata)
-			ptr = put_bytes(ptr, header->v.extdata, header->vlen);
+			put_bytes(ptr, header->v.extdata, header->vlen);
 		else
-			ptr = put_bytes(ptr, header->v.data, header->vlen);
+			put_bytes(ptr, header->v.data, header->vlen);
 		break;
 	case G_OBEX_HDR_ENC_UINT8:
 		*ptr = header->v.u8;
 		break;
 	case G_OBEX_HDR_ENC_UINT32:
 		u32 = g_htonl(header->v.u32);
-		ptr = put_bytes(ptr, &u32, sizeof(u32));
+		put_bytes(ptr, &u32, sizeof(u32));
 		break;
 	default:
 		g_assert_not_reached();
@@ -263,7 +263,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 		}
 		header->vlen = 4;
 		header->hlen = 5;
-		ptr = get_bytes(&header->v.u32, ptr, sizeof(header->v.u32));
+		get_bytes(&header->v.u32, ptr, sizeof(header->v.u32));
 		header->v.u32 = g_ntohl(header->v.u32);
 		*parsed = 5;
 		break;
-- 
1.7.10.4


