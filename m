Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D85C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E7E22582
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAEDOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 22:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbhAEDOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 22:14:16 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD4C06179A
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 19:13:19 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id p21so24576142qke.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 19:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+kuRzAf5tlJa1UqazyMjV+Q4SL+lpI6Q88s7q7eUe+E=;
        b=tc/tN88xOqh1XVkjPWh1y7QVBnzHcdj8nk9tTaJHuH8CesNyqa5y2OzlmU8R1w9PXJ
         Rc+g8jKZ8WSafa6LJbaGChmt7Q3qZTO63dqMqM2FTu6kGvgCp/2W188ibsxz3EIePt3x
         eKXIr66LVygsF59Kz+Bvl1gu1rQqQT2pUumW475ADFmpzgDCsE1Ydzb4FMnSObAS/4N7
         +Mb632ApqS821mxbJSxH0pOBYXrGIYFl9SLyhzY5wJ6OllTbM07eW0vr+w/0ZUHLWg/6
         ZACoQ8PYGVslsaI2GInS4c4HcFxKKhP5ZWbxcc+LkvW2xPTmV08RC10U//51szF1t4j4
         M86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+kuRzAf5tlJa1UqazyMjV+Q4SL+lpI6Q88s7q7eUe+E=;
        b=TdMBlu9/JsqZJxZUWqDk0PKv4H60dl/EgvNXOKzq36jjnv1qPtrodMz8kcTMNWk3AX
         5buWrAOxf/ijZZ4ZtWb5ULwmEALK6OQ+h7mnMHtOzs7FFLTMTP7UaIvwqfj6gYM3otPL
         Z5rrC/T0kT/pkLQ9IGsnG3w1Br53bzTEyevHvBggNwX5bOu5jHYkl3aW3bIeXlfpTSx4
         C4R1cVcMiL6R2QHSKt5S22efCJzmeVFFlLNC8gYjmufdQZEpzE85CuXsmpjb5pFuzGv4
         O0yZVj6xGr0vsAvCaoGj0LbNco9Cvi1vxKVbIksKQwNmWdvLzmeeiFQvQu7WITltdPhI
         SiLQ==
X-Gm-Message-State: AOAM530BYMpwBdx9zgty6kriUb67MdIwSpoI5AVDWmWeQ39ozqTikZBr
        AQ99SO+6Oqm3lpdYKo94j2cooWLakz82VmgltpCcWvW/VyzBf4FSOyyzmXpzASyKA3uIgQjI4C5
        J5JFF1AR8pqYvgQWcRnikWSGWCwsnQE557BMWYE5pKir+7EIG0fwj5iF2CUR7JWoOpMDQ4G/mjK
        IJJBxvDue/V2s=
X-Google-Smtp-Source: ABdhPJya8bkWC8owYStigAV/hpkqFN/AdF1Q0J97L302XDeeydzF8KrdDO4NC1IRsIS4mXfGg3AsYtlPCtfoey9zcQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5904:: with SMTP id
 ez4mr79765528qvb.30.1609816398456; Mon, 04 Jan 2021 19:13:18 -0800 (PST)
Date:   Tue,  5 Jan 2021 11:12:57 +0800
In-Reply-To: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20210105111219.Bluez.v4.4.I43884adadc00a5095dd03d2261a71dc2ba80d986@changeid>
Mime-Version: 1.0
References: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v4 4/4] shared/mgmt: Fix memory leak in mgmt_tlv_list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, apusaka@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch freed the mgmt_tlv properly in mgmt_tlv_list_free.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mcchou@chromium.org
---

Changes in v4:
- Simply use free instead of mgmt_tlv_free

Changes in v2:
- Fix incompatible pointer type error of mgmt_tlv_free

 src/shared/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index dc8107846668..3e9b9ee26472 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -595,7 +595,7 @@ static void mgmt_tlv_free(struct mgmt_tlv *entry)
 
 void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
 {
-	queue_destroy(tlv_list->tlv_queue, NULL);
+	queue_destroy(tlv_list->tlv_queue, free);
 	free(tlv_list);
 }
 
-- 
2.29.2.729.g45daf8777d-goog

