Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 10/22] unit: Fix 128-bit UUID format
Date: Mon, 24 Mar 2014 16:25:31 -0300
Message-Id: <1395689143-11091-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No matter the system, 128-bit UUID must use big endian byte order format
(similar to human-readable format).
---
 unit/test-uuid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 225a7b5..6c7e9d0 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -97,7 +97,6 @@ static void test_uuid(gconstpointer data)
 {
 	const struct uuid_test_data *test_data = data;
 	bt_uuid_t uuid;
-	uint128_t n128, u128;
 
 	g_assert(bt_string_to_uuid(&uuid, test_data->str) == 0);
 	g_assert(uuid.type == test_data->type);
@@ -110,9 +109,11 @@ static void test_uuid(gconstpointer data)
 		g_assert(uuid.value.u32 == test_data->val32);
 		break;
 	case BT_UUID128:
-		memcpy(&n128, test_data->binary, 16);
-		ntoh128(&n128, &u128);
-		g_assert(memcmp(&uuid.value.u128, &u128, 16) == 0);
+		/*
+		 * No matter the system type: 128-bit UUID should use
+		 * big-endian (human readable format).
+		 */
+		g_assert(memcmp(&uuid.value.u128, test_data->binary, 16) == 0);
 		break;
 	default:
 		return;
-- 
1.8.3.1

