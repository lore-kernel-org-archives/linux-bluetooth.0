Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8143AECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIUVrD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIUVrC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 17:47:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E9A6AFF
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:47:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r23so7237913pgr.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=6W9MrSFw3Dj8LODmWhYflLLrYCpPux4iXSGDv9dO1HI=;
        b=OFFHg43n4qQXqU+nTjmRZSeWCxlW8N3qECUsa9mGZSNdmqN/0NjxHsmvdKKIiHA9wX
         VEi5af7NHiwDcpJE0xOWEqteaCQ+IQgPSaJVLS+o3IQ+esrwYabGdXhQ9bI0GLhXr1pu
         rsdyC/2ZeqK20XSOzcPg1YCTiDznbSpjuKYDjIJTh7dnGsqQ34GAB7JsMEJIbBzZWepi
         YxG7YvAKCNdEWyd0EMiyQOX5bteBwQqpVU38GxmUtFQiB+NMc6jh+hlyjLpjZ7QbFC0V
         M2f70Q5l873nrdX31ust9ne0QKTMPLrT8GnSGdq7OTJBHUC001xNcKFupJM/2fQfB733
         FH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6W9MrSFw3Dj8LODmWhYflLLrYCpPux4iXSGDv9dO1HI=;
        b=SIp8yfrIXST2kV6ZHOXGv1spJ7daZ4LfpaP59aFRRUmlbfDzxpMZMVP2TEbI6K8WiF
         sOW76wjivC52ZJ9ckcIZFMqxNCo1vmeHD4GK2IScX9nKtNzhD6prYRU2zwSxJDriV+7S
         grqdP3Z0LEhyjY7F8ImCQZuIhBvD4KoHcxoQ+SjvAP1mOFW+bQzCpcAwSElw3T8J4eFa
         RnnJyuaaJnpTzNTR28veX7aLlsIB9TEJCu/qwwHoEh5sXTdAuUkpUdpITQaCCFebIkfh
         yVejVaEmv7/3nso2AVChoEvo8ZvYyEkZaWZJHCvG5lIjrWJFELtqt3qjoyfrbpGyw2xJ
         QGuA==
X-Gm-Message-State: ACrzQf1JixK0RjWihd/o9Bh6bkMoaVRvbFnELS+RERnY3UjlA7l1m5I6
        aPO6MQtbqE2tfDP9el8baB+FFmoMBiU=
X-Google-Smtp-Source: AMsMyM6/6EDPmgVes5IXggWr1C2n0ib6bpo66tCh2pnvPLvWD0F/91AHRVHF4biui3tsGO1wNeTx0A==
X-Received: by 2002:a63:243:0:b0:43c:75c:d92a with SMTP id 64-20020a630243000000b0043c075cd92amr195269pgc.497.1663796820823;
        Wed, 21 Sep 2022 14:47:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b001782a6fbcacsm2506526plg.101.2022.09.21.14.46.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:47:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/gatt: Fix notification enabled/disabled output
Date:   Wed, 21 Sep 2022 14:46:56 -0700
Message-Id: <20220921214656.2241730-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921214656.2241730-1-luiz.dentz@gmail.com>
References: <20220921214656.2241730-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When notifications are enabled/disable the output was not print a new
line.
---
 client/gatt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 4c1efaf75ac8..efd736b2359a 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -2518,7 +2518,7 @@ static DBusMessage *chrc_start_notify(DBusConnection *conn, DBusMessage *msg,
 
 	chrc->notifying = true;
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s (%s) notifications "
-			"enabled", chrc->path, bt_uuidstr_to_str(chrc->uuid));
+			"enabled\n", chrc->path, bt_uuidstr_to_str(chrc->uuid));
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
 							"Notifying");
 
@@ -2538,7 +2538,8 @@ static DBusMessage *chrc_stop_notify(DBusConnection *conn, DBusMessage *msg,
 
 	chrc->notifying = false;
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s (%s) notifications "
-			"disabled", chrc->path, bt_uuidstr_to_str(chrc->uuid));
+			"disabled\n", chrc->path,
+			bt_uuidstr_to_str(chrc->uuid));
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
 							"Notifying");
 
-- 
2.37.3

