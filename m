Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 01/19] health: Fix memory leak
Date: Thu, 12 Apr 2012 20:32:52 +0530
Message-id: <1334243001-17016-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 4c726b6..b76d88a 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -901,6 +901,7 @@ static gboolean parse_set_opts(struct mcap_mdl_cb *mdl_cb, GError **err,
 		default:
 			g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
 						"Unknown option %d", cb);
+			g_free(c);
 			return FALSE;
 		}
 		cb = va_arg(args, int);
-- 
1.7.4.1

