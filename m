Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857A2367C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525340; cv=none; b=Ha+hrOzxFx66MMu+SMNPypeJzkW4MPGUwZk66qFwUFcLgCjyK8JEYX1dWRpK3QmoU9Y3cVkKFeya/N5iEtabAHQAFjBaBIVzotTBOwerKmAeEfCc3Ke3miRbMaMwkWSZHihrRP7eMl0qbB4WDycfBGqz0M7+c+9VHn2b3R9PCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525340; c=relaxed/simple;
	bh=SxJZHzZg7hm1aACpU3oO17u/Hu8g4VUoMUKUdadpyBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spp3ebflTMfloqBS7mtoCMJU4a+/LnNzqy/3rJbTQdZX7WeHKWQ4CtNJ+JMNUhHx+cszdA15WZgBGZDj3XXwHLrClbuktSoMxNtl36H300j04K4A1wr+nQc12oRMONM6l9AyqN0w4r+wpeRR9Q3GhZLibVwke38ZGZSMt1yy5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avR+qmGo; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avR+qmGo"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86fea8329cdso2697589241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752525336; x=1753130136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDmQlZxao2kvU7S3sNffYC8jFdndBkxzbJvSWiVx+qU=;
        b=avR+qmGoCKGxtMqCFBQqhmFnHkXtV2dWI3ajPmqK5zTnHBFc4q8L4DYniQUqm+s9H8
         gBNCSCwW/c2xHZpfE1c8A0BBXVRfH76lJrXw65XsSfskYXo8g38hVxG/lyKMDwgJRs8P
         aRRikHvgJgUBr3Qmd5Ta/+pjoZR9IbzT114WbdGGCWXo1OZ7d+1oJ4LEXAHZyw3lGP6P
         CJrBUj/UHPU0ZquvAka5z16bwxFqBGoWuHAxRzDDkgUZBm+7dtYGCWKd06oTBzPBHok2
         kDgCeqd4b88Wa7lHdafcyvoiyT9rRlI29j9fDx8c14oKYWTCFEnWTzJqQGpLczt3ccz3
         12Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525336; x=1753130136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDmQlZxao2kvU7S3sNffYC8jFdndBkxzbJvSWiVx+qU=;
        b=MVam1Ol4NqfcBfN3muI3t1llNIh5FI1Db22XgU5hSJ2UHFJmkb+VDZJeqCRz08fc/w
         moq+a8//SIiL3/78mAiL7x/5H3YorwQCwGEs+gtZ4fV7i8UxZkHYNmNMcTtsiQx/6P4q
         KnFfcrtMcygV1HEX4830Om9YitVuSdqjPL9fIh5iTdvOa2sOyqonoAzF7sLsmgcUSOby
         jHRdogHTrOSS3IYGuLxEiEEtwic+S3A0pxq1wYA4UtIt5PMQWmiDGWatTg+I7IQLVZ/X
         DlIsOiFVBEgJ6Sqr1rEwvqo3J0hQXVDFHvpo45lfXo9n1wUIGKnBxSwkjvZE8tp7k4fX
         lt0g==
X-Gm-Message-State: AOJu0Ywe+mPr+uRQ68ZQH9IQOJTj/h28Ylq0XWQh9BVI0MJ5AYRc2u2v
	YASMiNA/2lWTGg7aMIWCj4Vltgaf8zWC56KqBl542EhicYppttMUFMZvHYDwRG3j
X-Gm-Gg: ASbGncvwjaoyxlZa8d6OPVD+oDreRzHPC5T+vIzMY4Wl6DcsNQpRQslkqiTLIOrV6Zb
	C91zG8f1mg82+5jgCh44a3mjHPSCZywQj/qTD9Pd5YkTElvkfMnZIfX9ONMUGg16OYj/XQVBr8W
	Frh5BnAUfbnppLjF+LxuKVexKnJ1+A7ZjHb+37HIOieSzPi2GRUkutckyOoE1VwlRbCMXXIK1y8
	YnVfNlPnsgRJNoxnWxnbmcGJ2PLMPuKgO1lBxvakNkwSaCEYVOj1U5bNKXsroodSTzaHOXTKZIi
	EbAzXhjfNe8U7VEthRFFPWHUz6IX2mTJwCcfs5BLiNwCGrGyVUGXA8nD9hcrtDvLZl+22EGBnK2
	Q4HhqarUmHbCLcpwn2ViZm4x37LoyxtTpss76zx+IMHcF3ycABlYQTwruWCxl7Y1n
X-Google-Smtp-Source: AGHT+IGlZQOo64pptBUtMDCWFdweMsBzrXjFriwN5bYquijxx7IP/PBChlmYmp04l9+vXI58/Wt//g==
X-Received: by 2002:a05:6102:5801:b0:4e4:f503:6675 with SMTP id ada2fe7eead31-4f7f110fb1cmr28882137.18.1752525336248;
        Mon, 14 Jul 2025 13:35:36 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec44a6f6sm1887177241.24.2025.07.14.13.35.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:35:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] client: Rework handling of Disconnected signal
Date: Mon, 14 Jul 2025 16:35:19 -0400
Message-ID: <20250714203519.345226-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714203519.345226-1-luiz.dentz@gmail.com>
References: <20250714203519.345226-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print with color the signal to indicate there is a change, also rework
the order of the parameters and use bearer specific suffix if the signal
comes from org.bluez.Bearer.*.
---
 client/main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/client/main.c b/client/main.c
index 09df7b37c46f..0a928efaa9bb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -806,7 +806,11 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 static void message_handler(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	if (!strcmp(dbus_message_get_member(message), "Disconnected")) {
+	const char *iface = dbus_message_get_interface(message);
+	const char *member = dbus_message_get_member(message);
+
+	if (!strcmp(member, "Disconnected")) {
+		const char *label;
 		const char *name;
 		const char *msg;
 
@@ -816,16 +820,22 @@ static void message_handler(DBusConnection *connection,
 					DBUS_TYPE_INVALID))
 			goto failed;
 
-		bt_shell_printf("[SIGNAL] %s.%s %s %s\n",
-					dbus_message_get_interface(message),
-					dbus_message_get_member(message),
-					name, msg);
+		if (!strcmp(iface, "org.bluez.Bearer.BREDR1"))
+			label = "BREDR.Disconnected";
+		else if (!strcmp(iface, "org.bluez.Bearer.LE1"))
+			label = "LE.Disconnected";
+		else
+			label = "Disconnected";
+
+		bt_shell_printf("[" COLOR_YELLOW "SIGNAL" COLOR_OFF"] "
+					"%s - %s, %s\n",
+					label, name, msg);
 		return;
 	}
 
 failed:
-	bt_shell_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
-					dbus_message_get_member(message));
+	bt_shell_printf("[" COLOR_YELLOW "SIGNAL" COLOR_OFF"] %s.%s\n",
+					iface, member);
 }
 
 static struct adapter *find_ctrl_by_address(GList *source, const char *address)
-- 
2.50.0

