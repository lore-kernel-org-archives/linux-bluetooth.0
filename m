Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4199AC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCMWwo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCMWwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 18:52:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CAA1ACF0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b16so5661206iof.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+EN9OUaogNwRfiIOclXnMRtoFqwv1MT6o/6kwBg+6c=;
        b=MxrVe4hP+Y8ue1taxlvSc3eAi+w7Mrc5RnN3l7UrwJmMi3XsRTuqI5vviLGOh69/s0
         gYgRZRNoSFqtUnMbMXrncs7o08fn+OTja3EbhKpP9d+69kjeK2NEaMDHgt+7I1rS26g6
         oFMM6SnwYanZUdsGvRUxjtl03MZNMWV4y5230FhM6zNycEj+oEFr/f48oPeL4FXNiK5T
         fxGZ+NRfk2+NRbRhSeejhObGIqspRozlhODV8DWlu+B4kYp38s8rcCpyuBkmX4FIhxzS
         e6pFxvOcrcLpM2YN2gZSt539m+g6O7Qtop2JNQeoOY8VZIJRJ8PoOUXgf1oRmMrHpRxV
         ovsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+EN9OUaogNwRfiIOclXnMRtoFqwv1MT6o/6kwBg+6c=;
        b=5qptWqKbpRNXQDbiZebD+6Ap85IIRC613S1qHjJ17lwPGVt7DD9NNgn1/AxsG2RMX9
         G45FSbVjjCrkXHI1CPRc8pvcFbY8VgTmQSeqdm1bwg8NVNysRpiFJpg197afrGFyEo0y
         kxOk7Fvmo0d6QEz8W1EoHd/fGpG2skSsv9++YMkGKJuDsJGLHp1KMuEtVzX+4b0dENLE
         i6LcapOfeWHHSIwD3bxcHKII4aANuaUyIoEa6+rUJKwIi1kFrWuiKytz0HuafTK7vTku
         2IX2jec5iIYforKx20VLlGLMmbSwRSKBUpBBWwBJmVVcKRdP1SQrii/OXoU8pCPkemcz
         rRWw==
X-Gm-Message-State: AO0yUKVcuTRou/z7jvth4aaqXay3wQNvy6BawfH7QDqBJ0YWUKWQHlu3
        B7MWCltAJwey0edn8g8sxG6HNsDU+tY=
X-Google-Smtp-Source: AK7set/q24cA8klnf0U9Wc9jEldm5nA1fzecQEhPZrjCsKUTChgZhz0XyTtKfPI9s0ij/6EexpTdoQ==
X-Received: by 2002:a5d:8886:0:b0:74c:d689:64bd with SMTP id d6-20020a5d8886000000b0074cd68964bdmr23902198ioo.19.1678747912696;
        Mon, 13 Mar 2023 15:51:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m17-20020a02cdd1000000b003c4d71489aasm278318jap.6.2023.03.13.15.51.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:51:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/bap: Fix not unregistering idle callback on detach
Date:   Mon, 13 Mar 2023 15:51:47 -0700
Message-Id: <20230313225150.267896-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make sure idle callback is unregistered before bt_gatt_client is
unref.
---
 src/shared/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 952b7be260ab..7a53fbc3e91c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3818,6 +3818,8 @@ void bt_bap_detach(struct bt_bap *bap)
 		bap->req = NULL;
 	}
 
+	bt_gatt_client_idle_unregister(bap->client, bap->idle_id);
+
 	/* Cancel queued requests */
 	queue_remove_all(bap->reqs, NULL, NULL, bap_req_detach);
 
-- 
2.39.2

