Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B17C2BA15
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD9920B1F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mFUaAWLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390424AbgDCHjr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:39:47 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38259 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390432AbgDCHjq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 03:39:46 -0400
Received: by mail-wr1-f50.google.com with SMTP id c7so7277924wrx.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FHzkoUD/xowPDU11bOzdhNb9PO6qVCWxnykQFFJpI6Y=;
        b=mFUaAWLeOX3NmGvmLJ9Fuc0nQa60riAzZUEAJc/QQWVsmQ9KLr+ehrXmo+Br/2VPoi
         5/V+NNDUsIbek4Ln1hr77dp8E959fmDbPLN3UOS5/hGS8cAokVFMubF9iDA4iop2rsxM
         rDMUPgALjJ6stzFturvxz7elRoEOw6rFfeuPLEzaeEodk8P+7PSBrAfOlZP+vqXtEznP
         LSKubqJW5m6EerbcKTTkYbPhxXzC3W+cyqvkMTRjymMLoLQgvRzcbl0UqAQ+OfdcO12k
         kPdCf25PMUvO7O9gdUmRxWsCA0euBrcz6BsDnQbSt1/K0DSQArhCfMoQ6Jg4i8tXBFQD
         NgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FHzkoUD/xowPDU11bOzdhNb9PO6qVCWxnykQFFJpI6Y=;
        b=einJhEp8lXfLwYEiTYqzLsxi07/aBBHBxX1/G3cx6g+cYj5m7jvZCFyy/Lr4TWoXut
         kbeLhnkl2OZ92t60ZmlCaMurfafrJjC/z2GlL6Ek6cRMa8/FJspZkDb+3i9uu2GMViiS
         G/w00mId7ww29gSb0Ys3sxytB2TboKkVPTpeA5078IqsbmVF7h+irgpuy9l9xYAkJu7Y
         ND9QrHKxo2CqeXNFamr7IXnjxPihPLto9/n6vOh7YqtrnrJbXbWKwh+ga3cSVbsxjI+o
         FtpXyCNSHzEK9r5TBQ7QzkF6STthfek9mJXL2M2AqBptRdngNjnIouTJNZANh/a1nGMd
         II4A==
X-Gm-Message-State: AGi0PuaKZud9vTyq3+HulE6kHOGLibKsSwKAu21rI8t7qjet2ZwEqGuG
        4IpFnirVd1nrPoQTc+W41HatApjN
X-Google-Smtp-Source: APiQypLsZQrImQe0TuTrx66cnqyXKIX7OsnqEUOKyNjxQDkCLQS9hb+i1pTHKX3HB3AExSFEqT+HWg==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr7412727wrm.393.1585899584862;
        Fri, 03 Apr 2020 00:39:44 -0700 (PDT)
Received: from RBGWVBL000659.fritz.box (p5B26793F.dip0.t-ipconnect.de. [91.38.121.63])
        by smtp.gmail.com with ESMTPSA id h5sm10943051wro.83.2020.04.03.00.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:39:44 -0700 (PDT)
From:   "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
X-Google-Original-From: "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Ryll, Jan (BSH)" <jan.ryll@bshg.com>
Subject: [PATCH BlueZ] fix dbus error code in case of invalid offset (org.bluez.Error.InvalidOffset)
Date:   Fri,  3 Apr 2020 09:39:28 +0200
Message-Id: <1585899568-14564-2-git-send-email-thorsten.klein@bshg.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com>
References: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Ryll, Jan (BSH)" <jan.ryll@bshg.com>

---
 client/gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 416eda9..cf2cb17 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -2276,6 +2276,10 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 	if (prep_authorize)
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
+    if (offset >= (chrc->max_val_len))
+        return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidOffset", NULL);
+
 	if (write_value(&chrc->value_len, &chrc->value, value, value_len,
 						offset, chrc->max_val_len))
 		return g_dbus_create_error(msg,
-- 
2.7.4

