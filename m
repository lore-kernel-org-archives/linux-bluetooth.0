Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496622D794
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747658; cv=none; b=WveL1h9R4Pkb3GKi4SI9hjkXLDef6kd/kOyF9hR/xBlggHqhiyLxNE4cVwDje2U6caKeRFrjlaYqRJI8Th+Td0cjXAnHdHgm1B+QZbJ9B1JYYQ0GNFFHYcLdlPBI4mmFF3c/37k5d1ytuuixMQv3q1B3xFpxxR5dBp/uE+GFhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747658; c=relaxed/simple;
	bh=9gmKhuZ8BmjU8wEpq26PBWx+Zm0yTHLuPJqRTTpwAXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naPd77MvLjDvcYi9VCBWxLeo8mw4aqZQORAc7t4VsyLiK0t9eh1hjeYrz5JzYo/tSwKiATS36EEf63FAaFaD5RSuWUqycID/YE97KFomAvoQ0cQ2RJoq4JB1IzeN3PpJ+xmiF79zDqNAs/U9A0sNTvMVgo7XP6qqe/OpGkfO2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1528843A21;
	Tue, 20 May 2025 13:27:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v3 1/4] client: Add client-side error decoding
Date: Tue, 20 May 2025 15:26:33 +0200
Message-ID: <20250520132733.1746996-1-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffteektdejuddvhfdtfedtvdetgeeileethfetgfdtheekvefgueeifffhvefhfeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdrrddpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght
X-GND-Sasl: hadess@hadess.net

The D-Bus errors returned in a number of cases aren't in human-readable
form, but instead exist as "codes" (listed in src/error.h).

This new function will allow us to split a specifically formatted string
into a human-readable message and an error code.
---
 Makefile.tools       |  2 +
 client/error-parse.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 client/error-parse.h | 12 ++++++
 3 files changed, 103 insertions(+)
 create mode 100644 client/error-parse.c
 create mode 100644 client/error-parse.h

diff --git a/Makefile.tools b/Makefile.tools
index e60c31b1d907..27346f1368a2 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -10,6 +10,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/advertising.c \
 					client/adv_monitor.h \
 					client/adv_monitor.c \
+					client/error-parse.h \
+					client/error-parse.c \
 					client/gatt.h client/gatt.c \
 					client/admin.h client/admin.c \
 					client/player.h client/player.c \
diff --git a/client/error-parse.c b/client/error-parse.c
new file mode 100644
index 000000000000..782d63f625f9
--- /dev/null
+++ b/client/error-parse.c
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025 Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ */
+
+#include <stddef.h>
+#include <glib.h>
+#include "src/error.h"
+#include "error-parse.h"
+
+const char *error_codes[] = {
+	ERR_BREDR_CONN_ALREADY_CONNECTED,
+	ERR_BREDR_CONN_PAGE_TIMEOUT,
+	ERR_BREDR_CONN_PROFILE_UNAVAILABLE,
+	ERR_BREDR_CONN_SDP_SEARCH,
+	ERR_BREDR_CONN_CREATE_SOCKET,
+	ERR_BREDR_CONN_INVALID_ARGUMENTS,
+	ERR_BREDR_CONN_ADAPTER_NOT_POWERED,
+	ERR_BREDR_CONN_NOT_SUPPORTED,
+	ERR_BREDR_CONN_BAD_SOCKET,
+	ERR_BREDR_CONN_MEMORY_ALLOC,
+	ERR_BREDR_CONN_BUSY,
+	ERR_BREDR_CONN_CNCR_CONNECT_LIMIT,
+	ERR_BREDR_CONN_TIMEOUT,
+	ERR_BREDR_CONN_REFUSED,
+	ERR_BREDR_CONN_ABORT_BY_REMOTE,
+	ERR_BREDR_CONN_ABORT_BY_LOCAL,
+	ERR_BREDR_CONN_LMP_PROTO_ERROR,
+	ERR_BREDR_CONN_CANCELED,
+	ERR_BREDR_CONN_KEY_MISSING,
+	ERR_BREDR_CONN_UNKNOWN,
+	ERR_LE_CONN_INVALID_ARGUMENTS,
+	ERR_LE_CONN_ADAPTER_NOT_POWERED,
+	ERR_LE_CONN_NOT_SUPPORTED,
+	ERR_LE_CONN_ALREADY_CONNECTED,
+	ERR_LE_CONN_BAD_SOCKET,
+	ERR_LE_CONN_MEMORY_ALLOC,
+	ERR_LE_CONN_BUSY,
+	ERR_LE_CONN_REFUSED,
+	ERR_LE_CONN_CREATE_SOCKET,
+	ERR_LE_CONN_TIMEOUT,
+	ERR_LE_CONN_SYNC_CONNECT_LIMIT,
+	ERR_LE_CONN_ABORT_BY_REMOTE,
+	ERR_LE_CONN_ABORT_BY_LOCAL,
+	ERR_LE_CONN_LL_PROTO_ERROR,
+	ERR_LE_CONN_GATT_BROWSE,
+	ERR_LE_CONN_KEY_MISSING,
+	ERR_LE_CONN_UNKNOWN
+};
+
+#define MIN_ERROR_MSG_LEN 4
+
+/* Parse formatted combined error code + user-readable error
+ * string into its components.
+ * Format is ":code:message" */
+const char *detailed_error_parse(const char  *error_msg,
+				 const char **error_code)
+{
+	const char *second_colon;
+	unsigned int i;
+
+	if (error_msg == NULL)
+		goto out;
+
+	if (*error_msg != ':')
+		goto out;
+	if (strlen(error_msg) < MIN_ERROR_MSG_LEN)
+		goto out;
+
+	second_colon = strchr(error_msg + 1, ':');
+	if (second_colon == NULL)
+		goto out;
+
+	for (i = 0; i < G_N_ELEMENTS(error_codes); i++) {
+		if (strncmp(error_codes[i], error_msg + 1, (size_t)(second_colon - 1 - error_msg)) == 0) {
+			if (error_code != NULL)
+				*error_code = error_codes[i];
+			return second_colon + 1;
+		}
+	}
+
+out:
+	return error_msg;
+}
diff --git a/client/error-parse.h b/client/error-parse.h
new file mode 100644
index 000000000000..c983982232f1
--- /dev/null
+++ b/client/error-parse.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025 Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ */
+
+const char *detailed_error_parse(const char  *error_msg,
+				 const char **error_code);
-- 
2.49.0

