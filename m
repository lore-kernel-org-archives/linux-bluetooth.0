Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F262EFDA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471350; cv=none; b=Ez2dHe4HrI1NkUGoUdyfnwY50bCzzMLHFhWb6xFk9oxRWHzsc1KewSdQopfQJo49SsVn40+uXSHv4fnHbe2t4idbXudbOqKuaHHVUdHHdE3ghOQYf9GV9Xjn/LqFF7CgUdypfFeOAmVvHna0zSwSOOUtRl0ypgeEePwX6ED9fBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471350; c=relaxed/simple;
	bh=OCi+9BdbMVfw+r3BjpSKNzTbsTKwzgaZRfsDj2Qrq9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u6W6BgIwRNKEpcy58hsXDi0y3dhT8EsTHHdC3jOIyN8L0IB8cppzOWTbPmTfnlnofd8ool6vJ96ALQjTSmkxk7676bau8VcoAXGBySUNrK7gkJzne62nhR1i07g3s7TFMHP/ngMIVtiO+VGbYxtfz8vDSH+djSuML/ZuQBxfVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAAjF0zE; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAAjF0zE"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2043744e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760471347; x=1761076147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwNmgwNOsf1TUnXGz5Q/BxH13xe/NAAQpPcN96/Vadc=;
        b=NAAjF0zEFHl/BMWN05ShAAua7lxOaVuk1zpJFmQHaCIfmyqPrMFP2ROS1Xb6XCaC7v
         dPhZa2hkd+s/N+UA+Zo0iO0TElL3HzCmuk7qYnFsbuO4fHeeFjGGQkbGDJD8yClKcSU+
         7erjeTqkrLpsfVADBQxlSObS5wjYY5IxVmyp+28Wr7g3gVEZBxoX6rUCYqcFyhOrRGu7
         0OXCptptICXcpbKyed9nWaYkBzrAqRnyw1zh57Xnf439z7w7cONEnJddwlgPqCiRUt8I
         81s4LMKNAEm+KLMCvx4IzJMrTZoQfQD8SXT7RtIK+sAYZW1a9mKirNyg72DdBLCcecd3
         /T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471347; x=1761076147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwNmgwNOsf1TUnXGz5Q/BxH13xe/NAAQpPcN96/Vadc=;
        b=poQZXKj4pal2RU8rnncC3xAR939t/kCtQxyrerwFCSrD9VDhUhsfdT508V4WkVJyxm
         UMcbgcnF2/Qi2iF7E1w7bX3vRIxPMDdSTVZuUWapDbIWur13y7Bzf8UBsqzKYGfNulBw
         TsLlUhne335hsXe8M35UqSvmHZ4K+NYioBhTIulTpZsUWbZZleagFFrYj9v63tciYy3V
         fZtuC67um19IXO2GNqak3cpUBPYi9tsmJHuKIzjxHQW9FGOPNUrroIvnlL38qgCPCokE
         sS8q/bR5iu2SojCDsNeZrXhdBk8vZ5BwBcmrBH1skd7jPcj1O9qpCHB7HqHvMNyJlLMV
         uflw==
X-Gm-Message-State: AOJu0Ywl2zooVgiLeWtRah6vI3QjhLGFFM3ocEnMzhXg77FbDsKlsDVa
	/7fIc24+q6Egp/uNaA2Z4sglAoYIzezcPKx1NLn4u5Ipfh6gxjSYWs/OqjNaGliV
X-Gm-Gg: ASbGncuv+GXOFyiHY8Fj3rShPBFNBtivA7GZRke9RFfTviOkJ33i5O2t3ypRIDw9l3o
	P/XqL3PMcbQv9uF9S52aJOCR7G3b8JI6nld98fFyvi7CERJIsS/alAUMABglv9FFFvPFRQ7BxC9
	dpmwbkTAIxnGxKQm0A8bincVIYbdDuZOgaMeTaat1Ura7dN+ntetYid84InHO7MbXJJPbDp9QJ6
	EqpuoCjGGFhp5w9K2PwZ+uolRcJDODq5vSuTtSi+w+Z/ObAYXiXm98iK+NsOg2LuzVbIjgrRqpw
	643Swytol53q8q9k0Xfx/MmFg0PFKZIX3izY/SDw837avbw0cB0Pz1vA0NcQapDrzNnNFo1yLMA
	973LIf/Q5GYIS3hKFvE98e+oCgQ4K+cXAZJKYPRW6gSLpBpkfCMdXQig=
X-Google-Smtp-Source: AGHT+IGkvwtywegrS2T22BC7wV1KOJgZC5WRquMuqjthtOKuS84TsSXkX9XgsQ2GjyZ5W7ptTLlZzQ==
X-Received: by 2002:a05:6102:390b:b0:5d6:fce:4443 with SMTP id ada2fe7eead31-5d60fce44d4mr3613866137.43.1760471346965;
        Tue, 14 Oct 2025 12:49:06 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm4570763e0c.18.2025.10.14.12.49.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:49:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] client/player: Add 'auto' option to transport.acquire
Date: Tue, 14 Oct 2025 15:48:54 -0400
Message-ID: <20251014194855.384197-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables transport.acquire auto which enables to overwrite the
default behavior of prompting when endpoint is registering without
setting auto accept.
---
 client/player.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/client/player.c b/client/player.c
index a8d05cf175c9..4f8293ce7842 100644
--- a/client/player.c
+++ b/client/player.c
@@ -134,6 +134,7 @@ static GList *local_endpoints = NULL;
 static GList *transports = NULL;
 static struct queue *ios = NULL;
 static uint8_t bcast_code[] = BCAST_CODE;
+static bool auto_acquire = false;
 
 struct transport {
 	GDBusProxy *proxy;
@@ -5072,10 +5073,8 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 
 	dbus_message_iter_get_basic(iter, &str);
 
-	if (strcmp(str, "pending"))
-		return;
-
-	transport_acquire(proxy, true);
+	if (!strcmp(str, "pending") || !strcmp(str, "broadcasting"))
+		transport_acquire(proxy, !auto_acquire);
 }
 
 static void property_changed(GDBusProxy *proxy, const char *name,
@@ -5224,6 +5223,11 @@ static void cmd_acquire_transport(int argc, char *argv[])
 	GDBusProxy *proxy;
 	int i;
 
+	if (argc == 2 && !strcmp(argv[1], "auto")) {
+		auto_acquire = true;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
 	for (i = 1; i < argc; i++) {
 		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-- 
2.51.0

