Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD163C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jan 2022 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354610AbiALPfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiALPfb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jan 2022 10:35:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04BC06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 07:35:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o3so5675196pjs.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Dk/y377iRORsKiJ49yJXoJTYjyMu47/+41vc8VQxzY=;
        b=qtu7OvzPbjMNDhmtSerzkWoF6dHKnW+dVVEX3n00weDWnwJQsP4SniLgO+6xDOzDpw
         fiFoONCTne4/G+jf2iL31mmfb4E8V0qGtu7HFinpoe6v7iuCS4BQ+eKma+oxVcgOw9XM
         Nz2JMEywBLR8uT/P81l4z+7kJCX9eSpsTBevB1p0zujp3ls8Qu+FGWYY5o6bIYe1ie6m
         3SrqTenWJxnsLJws1G/TvyyylyJ+PtHCenAzER0KEz5tOinGFF54sLE4zLRB0e7/j0cw
         Mk5PvW6jD/clFPgqdIzwU4wPe90lzlXEt5Bgg65ilQiWRJXPnbQaPvS5BUUTRwsgS5Xf
         L9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Dk/y377iRORsKiJ49yJXoJTYjyMu47/+41vc8VQxzY=;
        b=n9GHCdwva0SlLoHN82hpRoIbw9bGb0tdbBG5GRD/F23aUovr9L/Q9Mg3z3dqTugk0B
         tNkcZ1wniLyV1RBpsmpSH+jCf/05kJ/bLdW+fAp6dgh0Q+EXO8Im35KwSXqy9dWbeioy
         S3Q9Cmyv9dzwnCwtUYCbAH6cj+iS1kX7xyulu6D1GuLUjIc/Ez/97pzeEoVl2+bbeQIX
         6EYM2so/0+d2p12bR0S5QPVPHi2qAiTvvBfGxWzNKGtALJruIvetLuZrlZJLrEq73VxN
         7QpCigIHBp90d3mN856cmfQuNt+SPjjwVXmg1dG/rNElAxbTuPved/a5yE7UOctY/32Y
         kURQ==
X-Gm-Message-State: AOAM530l+/v0Zp59J1tjNBvd6dRQDTg1rDwgjrWo4Ej1XN/o+doI/xfd
        GJ75e/VG9PerRnpz9sWzT6BgARq4i5w=
X-Google-Smtp-Source: ABdhPJy1Up4S8XCW4tMzIa1dxX9af+JyLCLFYywQNWmBEe6H6cU8STaFOFS9gEBYNySzADqZHzrRMg==
X-Received: by 2002:a17:903:11c5:b0:149:a8cf:37da with SMTP id q5-20020a17090311c500b00149a8cf37damr10055282plh.132.1642001730495;
        Wed, 12 Jan 2022 07:35:30 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b12sm30017pfv.148.2022.01.12.07.35.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 07:35:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix crash when endpoint replies with an error to SetConfiguration
Date:   Wed, 12 Jan 2022 07:35:29 -0800
Message-Id: <20220112153529.338208-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If endpoint responds to SetConfiguration the transport is being
destroyed without removing it from the list leading a crash.

Fixes: https://github.com/bluez/bluez/issues/269
---
 profiles/audio/media.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index edefedc90..8162417ce 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -241,6 +241,16 @@ static struct media_adapter *find_adapter(struct btd_device *device)
 	return NULL;
 }
 
+static void endpoint_remove_transport(struct media_endpoint *endpoint,
+					struct media_transport *transport)
+{
+	if (!endpoint || !transport)
+		return;
+
+	endpoint->transports = g_slist_remove(endpoint->transports, transport);
+	media_transport_destroy(transport);
+}
+
 static void clear_configuration(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
@@ -260,8 +270,7 @@ static void clear_configuration(struct media_endpoint *endpoint,
 							DBUS_TYPE_INVALID);
 	g_dbus_send_message(btd_get_dbus_connection(), msg);
 done:
-	endpoint->transports = g_slist_remove(endpoint->transports, transport);
-	media_transport_destroy(transport);
+	endpoint_remove_transport(endpoint, transport);
 }
 
 static void clear_endpoint(struct media_endpoint *endpoint)
@@ -301,12 +310,8 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 
 		if (dbus_message_is_method_call(request->msg,
 					MEDIA_ENDPOINT_INTERFACE,
-					"SetConfiguration")) {
-			if (request->transport == NULL)
-				error("Expected to destroy transport");
-			else
-				media_transport_destroy(request->transport);
-		}
+					"SetConfiguration"))
+			endpoint_remove_transport(endpoint, request->transport);
 
 		dbus_error_free(&err);
 		goto done;
-- 
2.33.1

