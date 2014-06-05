Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/client: Fix handling hex test arguments
Date: Thu,  5 Jun 2014 13:08:41 +0200
Message-Id: <1401966521-32270-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1401966521-32270-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1401966521-32270-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to pass as argument hex and int values as test command
argument. Hex values must be prefixed by '0x' or '0X'.
---
 android/client/if-gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 652c0f8..178770d 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -68,6 +68,7 @@ const btgatt_interface_t *if_gatt = NULL;
 #define VERIFY_TRANS_ID(n, v) VERIFY_INT_ARG(n, v, "No trans_id specified\n")
 #define VERIFY_STATUS(n, v) VERIFY_INT_ARG(n, v, "No status specified\n")
 #define VERIFY_OFFSET(n, v) VERIFY_INT_ARG(n, v, "No offset specified\n")
+#define VERIFY_TEST_ARG(n, v) VERIFY_INT_ARG(n, v, "No test arg specified\n")
 #define VERIFY_HANDLE(n, v) VERIFY_HEX_ARG(n, v, "No "#v" specified\n")
 #define VERIFY_SERVICE_HANDLE(n, v) VERIFY_HANDLE(n, v)
 
@@ -1406,7 +1407,7 @@ static void test_command_p(int argc, const char **argv)
 	VERIFY_UUID(4, &uuid);
 
 	for (i = 5; i < argc; i++)
-		*u++ = atoi(argv[i]);
+		VERIFY_TEST_ARG(i, *u++);
 
 	EXEC(if_gatt->client->test_command, command, &params);
 }
-- 
1.9.2

