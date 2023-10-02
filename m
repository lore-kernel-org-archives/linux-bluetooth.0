Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A23E776D4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbjJBXNV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbjJBXNU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B646AC
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:13:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5db4925f9so1955415ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288397; x=1696893197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXfx1LMcF2ZoyM6EdfEh52gSmxJjZ/+b1hClxDBVCaM=;
        b=QhYiUB+xyQ0Szk6Aw0mnaf10msNzj2RMNGNmEtNi4bWBTRiVlr9bG9/nZd50mjclx8
         B1QH3IGSCKXlL9xtPVA8n8RCw8j6NfjT6P5xzgpxt8VqwPniFZLFCFPyLN7Q/DbDH9Ie
         yGQN5H6Jrh/vSjS6frRHEax9YYeGpf2sFkCPH3eFDYdvi7ChXmdCOntSwtfB1Z7iv4Wp
         6gA/T+b0yy03NrX/KO6amo+b/ZiVPMIitpaRzH3xbiDnlIKvf4CMyRUPhMUop4gva5PL
         yddcQdnTnffCa3arJZOuTsxw8QUdaw2UbhNqvmAHk/K0IdgvyJMA+M1L6j3uxndfZfy+
         gwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288397; x=1696893197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXfx1LMcF2ZoyM6EdfEh52gSmxJjZ/+b1hClxDBVCaM=;
        b=Lkbw/nBcLvvPhwGZG6lOnALWZ2MgIuSSf8Aob6ewJxt0qCLzwCtVQHbiogqcFOAJ0I
         VSrVWTXrOSyXksHKI0TMorNBpaw5kKBAnDY4dkvJ/7uF4wwCl4ilKSmHHYCRUYdpqmWr
         FjZljMzo52aHJ7oNHq0dvgzAG4nqXvZSfMUoD8TeyRw1zwpDoMb2dT+xQpH1vGiOlQRd
         sy0hmWInB8N+1skNST9wkxQgkEj4etquQ9oEbsxwsHf/u9j8JLEL4BdFOhwsYyc31DPB
         270b0jM9m5xEXzmNZUmEP8Ss0v+DrbU4mxrmatMevzgPwdXbhzjtcEWPxSPIEQDrD5f8
         XZiA==
X-Gm-Message-State: AOJu0Yzrly9RUm45ohv7Qh97FoAwCQBnYsBC/8vuRfCtdQUHIFFJpPRo
        /qs4qjxL+ri9BtgfzJgsRuI4Md1di4N43b+J
X-Google-Smtp-Source: AGHT+IGf0jikbCpGXJFNofhKsj0CWsja8DZeb53t2YwB6r5Yns7ayiX5x9AJWCijKUnRaypOZ+CflQ==
X-Received: by 2002:a17:903:18e:b0:1c6:de7:add9 with SMTP id z14-20020a170903018e00b001c60de7add9mr1424616plg.19.1696288396642;
        Mon, 02 Oct 2023 16:13:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b001c75627545csm5181817plk.135.2023.10.02.16.13.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:13:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] shared/csip: Fix not always reading SIRK value
Date:   Mon,  2 Oct 2023 16:13:07 -0700
Message-ID: <20231002231311.3104749-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure the SIRK value is always read otherwise its value can
be outdated or not even read if the connection was interrupted before
read procedure was completed.
---
 src/shared/csip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index eb80bbc3b26c..85de63ea626b 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -597,7 +597,7 @@ static void foreach_csis_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(csip, "SIRK found: handle 0x%04x", value_handle);
 
 		csis = csip_get_csis(csip);
-		if (!csis || csis->sirk)
+		if (!csis)
 			return;
 
 		csis->sirk = attr;
-- 
2.41.0

