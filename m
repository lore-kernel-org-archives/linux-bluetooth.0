Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/13] lib: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:28 +0100
Message-Id: <1417541318-24259-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 lib/uuid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 5c3f986..186a7e6 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -84,6 +84,7 @@ void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 	case BT_UUID16:
 		bt_uuid16_to_uuid128(src, dst);
 		break;
+	case BT_UUID_UNSPEC:
 	default:
 		break;
 	}
@@ -171,6 +172,7 @@ int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n)
 				ntohl(data4), ntohs(data5));
 		}
 		break;
+	case BT_UUID_UNSPEC:
 	default:
 		snprintf(str, n, "Type of UUID (%x) unknown.", uuid->type);
 		return -EINVAL;	/* Enum type of UUID not set */
-- 
1.9.1

