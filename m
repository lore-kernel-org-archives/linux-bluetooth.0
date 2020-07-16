Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D339AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3CA20739
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU/FMNwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGPXTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGPXTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 19:19:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB3C08C5DB
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:19:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a24so4429633pfc.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PDMHwDVtsDk5UMkcQwleT4i0giCi3Nlydh8pBuDrWH4=;
        b=eU/FMNwSC6iFYkrn6ugnLK6IWYy0FM1/D+KO46qIZ8kNgm1Ms9OKDEblKs5nS0LxY+
         qvlw0uihm+6X5uvZjzWQEa+a/km1GAJT9Fcf8Fapyh/7ElYkXw3Z6vO2mwBb5w3f3vNL
         Ulh4uhhvzR+WJK4h6Wba+LgG/HhDKV/l0OMAUKU/vsU355q5zybNkT+xcNXlPVF0gUl2
         1CQM1RjadXKwzqM9GBd3/6EEfZjykbOYNgRKdiSOwBb4C/dKo/jPPE4r4aHqTJT60Ssx
         Or+YOsSKRAvmccEYHo5jxkt6bUTmLor6fEuNZq49Ntgv0FvDfoPwj468SjyiaypbWTTo
         ugPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDMHwDVtsDk5UMkcQwleT4i0giCi3Nlydh8pBuDrWH4=;
        b=ZpNOhLlam9SN60qAEm+1K7fZi8FhubmoAQjwBUWIOgnwCyTQ8VnB1P1P/3kZiyFFjS
         M8IsbeMop9L60+k32+fuUzN+3kV5lE99Fgj23KYKzvEMKrcIP3rpkz0n7zGnW1ovdPUf
         Ju1th8X6XDbXnxHEJAZvrgZMMz1m2C9G8HgnxszpOOAniyNZ2ZO9di6riBJDbuV36DGI
         o0xRRetVF5+HVf6OwdlKbIanBK6HBddsrlLedf4OZ+et2S6x9J293GLMp5jg7Cae5V+u
         mHbXq4vP2yjokFI597YhoY65+IwQ911ph5u2yOf72URdVcNmy5dRTF0X/d3Cb4PHmgsH
         1xcg==
X-Gm-Message-State: AOAM533PE8MzJWDXkJ1iy0JUbNRUnK/gmHEh8VC6lFW09fyh73KU0RUi
        R7qsAh/od4bHRlmZlWpnaDVTKc71Vrg=
X-Google-Smtp-Source: ABdhPJwAcBI4xHNvuFN4ykd9hCIoZ/lS3nebdw3y0zL00Abf5QaTu2asFKNgLkThePTZgMwEvoXzRQ==
X-Received: by 2002:a62:ce88:: with SMTP id y130mr5699199pfg.37.1594941541956;
        Thu, 16 Jul 2020 16:19:01 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm6024530pgf.53.2020.07.16.16.19.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:19:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] share/gatt-client: Don't remove active services
Date:   Thu, 16 Jul 2020 16:18:57 -0700
Message-Id: <20200716231857.934396-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200716231857.934396-1-luiz.dentz@gmail.com>
References: <20200716231857.934396-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only remove services that have not been fetched completed as
unsuccessful discovery may be the result of an aborted connection the
attributes that have been fetched previously are likely to be valid.
---
 src/shared/gatt-client.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e21aca1f0..5ba8e83ba 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -407,11 +407,17 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 	gatt_db_unregister(op->client->db, op->db_id);
 	op->db_id = 0;
 
-	/* Remove services pending */
+	/* Remove staled services */
 	for (svc = queue_get_entries(op->pending_svcs); svc; svc = svc->next) {
 		struct gatt_db_attribute *attr = svc->data;
 		uint16_t start, end;
 
+		/* Don't remove services that already been marked as active
+		 * previously.
+		 */
+		if (gatt_db_service_get_active(attr))
+			continue;
+
 		gatt_db_attribute_get_service_data(attr, &start, &end,
 							NULL, NULL);
 
-- 
2.25.3

