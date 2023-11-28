Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ4T90Tr"
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E410CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:28:39 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ec9a79bdso3730851b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701185317; x=1701790117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Zv7hq1AH16bnPc19IonLtbuxJzvavyDhkPsM0yiosw=;
        b=DJ4T90TrVtQvZiHAN3A1VMCeGhhnxTE8k844T0JRskywFbuROf+Oz3xVutWCIhXdzt
         TzDOaVRdCNLAeeBddySRXfoxpeEZoost8NbsRFxB8vaEvWpXbQ5fqI5MVJjEbN/wHc5u
         6y6DhtxsbuAbW33bVA4mbQjMqUYPAOL460QxJjLyGVMWb1w4pNdsP8aYQ29Mpv8HjzOA
         /FAhSaly3pSPiI5w9YmJGGHGviu7a3lHSKa4mhGKOKWCqpqXb5sQzA8yNtTl8xGdBh4G
         6QDI0XO8LnQHi2Yw/Sh0htBy+rDvO1wPUiBRhYZCm7MWAsVN64bdEjJTUVRzSHrHz+cg
         IbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701185317; x=1701790117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Zv7hq1AH16bnPc19IonLtbuxJzvavyDhkPsM0yiosw=;
        b=sVB82TLOKLJ+zxT6Aa7/pVjuzq59R54p22uS/Ln64eB+1fchuHAUckLlL7pGC4x58/
         XolkYOf3XWEqYhgLQzEJ6UUWiYNY2O/n6RpoyEd3aoKJoid+OVYjtxVmrnbwL1h8aDjK
         wwB3DQcnXbjYZLVFb8+EygAqBRiqFgyTV/mxBxrRCFoRpGNSNAmb9e2AG3+GJ93LgHov
         Ar7DDzHH40E7ZjuK6Tg1ewJPe/XrEcIRvaJZW+WF79EO5Nou9R2e1jyLFb75OE7WotXo
         g5itl1a9I3rg4N/T7+flq2tQ4FWi8W36Qs05b0OZV+StUCKUXgPw3gABhERfZwy5EDxR
         8akg==
X-Gm-Message-State: AOJu0Yx5myIyrXHKxjeUinxEWTBwixkjxdeUUDLuAr8bG0qvZHIGrW1m
	2VEnsNp4YXZZtRQJ1QxL9e5NcdlvDV6vfg==
X-Google-Smtp-Source: AGHT+IE2nldLYBZyuU4ph72iJ7oxktkjIq+H7i9Tx0MbHZMlB646GbTGMEqUsDUofotvBc6XeyQQvQ==
X-Received: by 2002:a05:6358:291e:b0:16d:bc0b:836 with SMTP id y30-20020a056358291e00b0016dbc0b0836mr15681130rwb.19.1701185317153;
        Tue, 28 Nov 2023 07:28:37 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bf9-20020a056130054900b0079a1018d185sm1660644uab.31.2023.11.28.07.28.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:28:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] util: Make debugger arg of util_debug_ltv const
Date: Tue, 28 Nov 2023 10:28:31 -0500
Message-ID: <20231128152832.1730901-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128152832.1730901-1-luiz.dentz@gmail.com>
References: <20231128152832.1730901-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the debugger argument of util_debug_ltv const as they are not
suppose to change during its call.
---
 src/shared/bap-debug.c |  6 +++---
 src/shared/util.c      | 10 +++++-----
 src/shared/util.h      |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap-debug.c b/src/shared/bap-debug.c
index 62bcde969377..495a22c44126 100644
--- a/src/shared/bap-debug.c
+++ b/src/shared/bap-debug.c
@@ -184,7 +184,7 @@ done:
 					user_data);
 }
 
-struct util_ltv_debugger pac_cap_table[] = {
+static const struct util_ltv_debugger pac_cap_table[] = {
 	UTIL_LTV_DEBUG(0x01, pac_debug_freq),
 	UTIL_LTV_DEBUG(0x02, pac_debug_duration),
 	UTIL_LTV_DEBUG(0x03, pac_debug_channels),
@@ -413,7 +413,7 @@ done:
 				user_data);
 }
 
-struct util_ltv_debugger ase_cc_table[] = {
+static const struct util_ltv_debugger ase_cc_table[] = {
 	UTIL_LTV_DEBUG(0x01, ase_debug_freq),
 	UTIL_LTV_DEBUG(0x02, ase_debug_duration),
 	UTIL_LTV_DEBUG(0x03, ase_debug_location),
@@ -527,7 +527,7 @@ done:
 				user_data);
 }
 
-struct util_ltv_debugger ase_metadata_table[] = {
+static const struct util_ltv_debugger ase_metadata_table[] = {
 	UTIL_LTV_DEBUG(0x01, ase_debug_preferred_context),
 	UTIL_LTV_DEBUG(0x02, ase_debug_context),
 	UTIL_LTV_DEBUG(0x03, ase_debug_program_info),
diff --git a/src/shared/util.c b/src/shared/util.c
index cebb02cc3ee4..34491f4e5a56 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -157,8 +157,8 @@ uint64_t util_debug_bit(const char *label, uint64_t val,
 	return mask;
 }
 
-static struct util_ltv_debugger*
-ltv_debugger(struct util_ltv_debugger *debugger, size_t num, uint8_t type)
+static const struct util_ltv_debugger*
+ltv_debugger(const struct util_ltv_debugger *debugger, size_t num, uint8_t type)
 {
 	size_t i;
 
@@ -166,7 +166,7 @@ ltv_debugger(struct util_ltv_debugger *debugger, size_t num, uint8_t type)
 		return NULL;
 
 	for (i = 0; i < num; i++) {
-		struct util_ltv_debugger *debug = &debugger[i];
+		const struct util_ltv_debugger *debug = &debugger[i];
 
 		if (debug->type == type)
 			return debug;
@@ -177,7 +177,7 @@ ltv_debugger(struct util_ltv_debugger *debugger, size_t num, uint8_t type)
 
 /* Helper to print debug information of LTV entries */
 bool util_debug_ltv(const uint8_t *data, uint8_t len,
-			struct util_ltv_debugger *debugger, size_t num,
+			const struct util_ltv_debugger *debugger, size_t num,
 			util_debug_func_t function, void *user_data)
 {
 	struct iovec iov;
@@ -188,7 +188,7 @@ bool util_debug_ltv(const uint8_t *data, uint8_t len,
 
 	for (i = 0; iov.iov_len; i++) {
 		uint8_t l, t, *v;
-		struct util_ltv_debugger *debug;
+		const struct util_ltv_debugger *debug;
 
 		if (!util_iov_pull_u8(&iov, &l)) {
 			util_debug(function, user_data,
diff --git a/src/shared/util.h b/src/shared/util.h
index 44205d7d35d5..6698d00415de 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -135,7 +135,7 @@ struct util_ltv_debugger {
 };
 
 bool util_debug_ltv(const uint8_t *data, uint8_t len,
-			struct util_ltv_debugger *debugger, size_t num,
+			const struct util_ltv_debugger *debugger, size_t num,
 			util_debug_func_t function, void *user_data);
 
 unsigned char util_get_dt(const char *parent, const char *name);
-- 
2.43.0

