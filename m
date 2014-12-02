Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/13] gobex: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:32 +0100
Message-Id: <1417541318-24259-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 gobex/gobex-header.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index ed7fd08..c594999 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -241,6 +241,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 			header->extdata = TRUE;
 			header->v.extdata = ptr;
 			break;
+		case G_OBEX_DATA_INHERIT:
 		default:
 			g_set_error(err, G_OBEX_ERROR,
 					G_OBEX_ERROR_INVALID_ARGS,
-- 
1.9.1

