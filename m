Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C8C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CAD2065F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgPkwNgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGOUqk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGOUqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 16:46:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC57C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 13:46:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gc15so2292095pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qI7srOxReILXOvnMcKlZjOffQlZJcwTzr1eNxTALca4=;
        b=vgPkwNgHScNjq/+eA2pH424fLIHnwYDcFVmwqcMFlf4bFCB7LwjEvCIdjYSMwU4MYZ
         Wdg+Vn7ZVKMZQew9BIvtslzQuSxBe0GzfXouM13/p85cMYIabzRd8MELSSYTAj1J2tRS
         mLsvJxD6Ds9wT+GQmffhDreVmawxf9wQJ8EbFnSjCpk8JCRtS7znc7Eq1i1PpJPpglPQ
         YZRce/MpwHdD8D3Umno9ELFaJ2sCBUsMJq4bxNg4bzhjBK1u9E7GU82n0xP3p3kSu7E4
         U4mfBbQ/c2bQD1t6XCZJuLl0os3A7DaYCJUsz3ObDVS3pFNqu1lsIvF2pyO4lKNoT9E3
         WOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qI7srOxReILXOvnMcKlZjOffQlZJcwTzr1eNxTALca4=;
        b=AEJtT8pVmbO+QFwUqnCgPYXzS/jH83kSNGMOpG2b3fdYB8jE4dAS7Nd/JTc3uwDGB9
         T1eIvZ6oSguDwUHJVwlxPd3qj/wFBJ4/4k0TlbL6X+qpRC+qn7Q9b1XxVHnBqFWU7eEl
         +ZYjSAOc4/Y0jL3r0CUp8wqM7OurutYFV1qnknL4TWTtWb+7rHXdU525BJ1drSmOwT+F
         EzruKoY67wnZ/Tpzp31hBRCFAUdTzMKoHoqLdA9o7WrD+rXupAGSH7UV4oWJPm21WtmU
         M6m9iebb/P12PwvlK7U/Jn7UOe3r/ZyHGSgtzQElcGhImTverUw0NOz7S55wfYIW4PVO
         0kgQ==
X-Gm-Message-State: AOAM533EOCmGo5yJuoJ22iOB7s1w3vvX+cvDZgkCpWV9k4M9WNhQGDli
        7ap3f8uYNrqTGEFAFtIhmctsZDyyvA0=
X-Google-Smtp-Source: ABdhPJygIoHJJ+F+SXz8r7bL9DI3gLJtzwO3nxyjz6vR4y6meZRJztQHZT354i/hEFomuhFz/nMlWA==
X-Received: by 2002:a17:90a:354d:: with SMTP id q71mr1559702pjb.216.1594845997632;
        Wed, 15 Jul 2020 13:46:37 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i125sm2901142pgd.21.2020.07.15.13.46.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:46:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] adapter: Remove timer for removing temporary devices
Date:   Wed, 15 Jul 2020 13:46:35 -0700
Message-Id: <20200715204635.755599-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200715204635.755599-1-luiz.dentz@gmail.com>
References: <20200715204635.755599-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that each temporary device object can cleanup after it has detected
that it has disappeared it is no longer necessary to keep this logic as
well in the adapter.
---
 src/adapter.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7a80554c5..c757447e2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -258,7 +258,6 @@ struct btd_adapter {
 	GSList *discovery_found;	/* list of found devices */
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
-	guint temp_devices_timeout;	/* timeout for temporary devices */
 
 	guint pairable_timeout_id;	/* pairable timeout id */
 	guint auth_idle_id;		/* Pending authorization dequeue */
@@ -1484,27 +1483,6 @@ static void invalidate_rssi_and_tx_power(gpointer a)
 	device_set_tx_power(dev, 127);
 }
 
-static gboolean remove_temp_devices(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	GSList *l, *next;
-
-	DBG("%s", adapter->path);
-
-	adapter->temp_devices_timeout = 0;
-
-	for (l = adapter->devices; l != NULL; l = next) {
-		struct btd_device *dev = l->data;
-
-		next = g_slist_next(l);
-
-		if (device_is_temporary(dev) && !btd_device_is_connected(dev))
-			btd_adapter_remove_device(adapter, dev);
-	}
-
-	return FALSE;
-}
-
 static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 {
 	GSList *l, *next;
@@ -1516,11 +1494,6 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 		adapter->discovery_idle_timeout = 0;
 	}
 
-	if (adapter->temp_devices_timeout > 0) {
-		g_source_remove(adapter->temp_devices_timeout);
-		adapter->temp_devices_timeout = 0;
-	}
-
 	g_slist_free_full(adapter->discovery_found,
 						invalidate_rssi_and_tx_power);
 	adapter->discovery_found = NULL;
@@ -1536,9 +1509,6 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 		if (device_is_temporary(dev) && !device_is_connectable(dev))
 			btd_adapter_remove_device(adapter, dev);
 	}
-
-	adapter->temp_devices_timeout = g_timeout_add_seconds(timeout,
-						remove_temp_devices, adapter);
 }
 
 static void discovery_free(void *user_data)
-- 
2.25.3

