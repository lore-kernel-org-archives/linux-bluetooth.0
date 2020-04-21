Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B3C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 07:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FDF20CC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWpeN2Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDUH72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDUH72 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 03:59:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A57C061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 00:59:26 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l9so2400612pjq.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HXFyDUscfdGi0ICO5wJP7agrZP67yVZV05e4YMvw9Tk=;
        b=SWpeN2QuWXTBr4GpLZq2XkDkvNlGEAvRV6L6NEh2rPNKeNE/puRDoe+BMlz5OC4vyZ
         0ykYZK4VAynmXu+LJrFmZo99Mx/azKTxjma2995Js2qa/4yIkY+z96XovtBo/CjFnGzS
         TqZyer/pjJYQiGIa51dxY9THc3AnJmgtxqTUH74GWRqysn7wl6PZIKzzYFnjeUJMPOPg
         z/1edS46Nfhj1JEHFg9MQZ6SUelGSlvoAAu+6et4lOBSHylCRqQ5hvv+0ucd57AKGt14
         Z+c60/rlW96w2dpWD9uhlbufZgoRP1VOxNUrDUc7wCcXzaPtFlwhSrlTmcgewnKNcTu9
         JduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HXFyDUscfdGi0ICO5wJP7agrZP67yVZV05e4YMvw9Tk=;
        b=BqHlwT0N9lbvci40/wiUpckkLRkXvGfWDz6YrINnj38bcRZ+6W2eArswmhgWLFUFvr
         3xpZ9KRAVhMGYojbqpB4RNfPR5CRJutui8dNVtQQMRTbr27vMfKFsVIzAOCA0YaBENWo
         wM4pYr3hjxvjXu8h8+GlRslhLMAkyc+TG3RUQyvsRQ6lFmg5J2RF/RrayJPy3lGoc2UO
         /gFJ4U0H+WD/kRXSdsK0or1h5AY8MWKLsjmaNrsgFkB9xa7JzmOeqz6YPnTRmQ/Mx4TS
         JZiyefC62tORyOePwromRAShvET0lgS6dAVQxQxL1SukzygJi4/8iSYTOjmC/Xtu9xSe
         1euw==
X-Gm-Message-State: AGi0PuYjN9KjYCZgNUN0Z/3IiwSq1ehwBrTKMsBW6zGWpL1gazzXhXaw
        R7wS4NMtQBIeypfn1QzWaniQhVkF0wxP7Du/Pn2rO9tFPc9TZGwsrJJ5XYWNNG9firlKkyr9Vnn
        5zRas+GcpQTtTsha2+sn8GTqrhxGtEPkwFp+EvEMbMThsJoYoRaOw6H/WUvAUPsQODQCAwAZuH5
        Ce
X-Google-Smtp-Source: APiQypIvlB975qVtUHW8r5SMV/AGZasaU/ovhAuMDblxEMPFfFpBNlIdJ50rrmnnKNenfqW3tauc3QF9uI2U
X-Received: by 2002:a17:90a:b884:: with SMTP id o4mr4075234pjr.8.1587455966342;
 Tue, 21 Apr 2020 00:59:26 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:59:14 +0800
Message-Id: <20200421155828.Bluez.v1.1.I6e4fbf41b1815dc3d497da5d9c94b18e9c912cba@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [Bluez PATCH v1] gatt: Fix service_changed characteristic permission
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth spec Ver 5.2, Vol 3, Part G, 7.1, the
service_changed characteristic is not readable. Therefore, this
patch marks it as such.
---

 src/gatt-database.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index f2da27694..8cbe09bae 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1197,7 +1197,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
-				BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_INDICATE,
+				BT_ATT_PERM_NONE, BT_GATT_CHRC_PROP_INDICATE,
 				NULL, NULL, database);
 
 	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
-- 
2.26.1.301.g55bc3eb7cb9-goog

