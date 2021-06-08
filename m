Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84082C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2B26128E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhFHRnM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:43:12 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53118 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhFHRnM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 13:43:12 -0400
Received: by mail-yb1-f201.google.com with SMTP id a17-20020a5b09110000b0290547160c87c9so7647955ybq.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yN9GR9yn0BfU6/EEd8zjvhTrSdkHYvbwqIDx2oegE6M=;
        b=lUKVI2qSP+0mXSfM0vF4+/X/1ZcFEcNyZRvgUexZxFn4DeSpOeA3maKp3/PVblMk1D
         Gt0Z/SQaRYszCeb3NKqHNDW0bn6/gT2aoYAHYEtgsg5N6fX/HOP1KnPwUZTk33DtPN2v
         mzJMnUs8ccvLO6zImuSG7VTgKLqf36ekCZk4l/WzqITTNBzPOgzS3JK8KSMTZbkYtvjG
         d6QAX1cI7DOYsfejly1f8a99mOK9ymU9JjZgi3ybgRxXiRVaTEt3fIQeQqCLAjURSVhI
         aPO+rIyv27cBGdiXnbSthJlfUnBv3w3P7zG91yRQXzMJ05TK9HIQjVT6eVHtP0plOG0E
         msdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yN9GR9yn0BfU6/EEd8zjvhTrSdkHYvbwqIDx2oegE6M=;
        b=BXTHoYi7eBMORzNCL4qbKLX7CJeI6KFSHhVL8l9DY1Jr7a251/PPlLnUozx9drHll3
         b32HelzVffOfzH7ODaQCfHwtrCjxNJEAwT07sMvAeXFb4MEFbaJ3LXBh1uuKhLouaV+r
         BIyaFHUChCBC0qvWYS4AiKyeDvj4Q7Dj9QB9Sw92Cj8A0M5hrOS0AIchtz2ohlz4sJm2
         J+hZw5UpZzlM9QfqQUStTr/9UzSTtbxoR93uj+0Aj2CLWBZWQg01mvi8I8qA8aNfMH6a
         wogzuEqBzuW6fKAZFjEJdpYV9bhBXPWHlM/aRjF59i81+gNj9vGpjG06f1eT1HOjBob1
         uhkQ==
X-Gm-Message-State: AOAM533BhrajFiIcFjYjS+xY68d3k5rNUgUusuGQF2/8bYCzrFr82Mpv
        esgqI+bcL144lrfsC74bhRcl0xPTjMMRvupsxNcfHtuUpNkrWjd4YD+i+CaVRca/E9PCvf8pNa2
        cWk+OfgtPT5YIbwFhJXfr3j4c4BxCvsDNcKa94XFTpj0bOjmHjGVgw/sEoRcxKrpA4lF1uSgnOR
        6xSj21zYlsLSs=
X-Google-Smtp-Source: ABdhPJwaYn8Kt0V/szqHTy6YllqdCPcVkJvLyAz3FakPBT1MPahvJtMnxHAqF4UjTF9FKsZQoL8XHLKtjgApP6Apgw==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:46ba:c169:c41a:2166])
 (user=michaelfsun job=sendgmr) by 2002:a25:389:: with SMTP id
 131mr33526913ybd.306.1623174002354; Tue, 08 Jun 2021 10:40:02 -0700 (PDT)
Date:   Tue,  8 Jun 2021 10:39:50 -0700
Message-Id: <20210608103940.BlueZ.v1.1.Ifed45e2dfac25b2627fcaabc66cd29f6894ba07b@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [BlueZ PATCH v1] avrcp: fix byte order of PDU parameter length compare
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix the issue that directly uses params_len, from received PDU data,
for arithmetic calculation and comparison.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ccf34b220..2265f87ab 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1923,9 +1923,9 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	operands += sizeof(*pdu);
 	operand_count -= sizeof(*pdu);
 
-	if (pdu->params_len != operand_count) {
+	if (pdu->params_len != htons(operand_count)) {
 		DBG("AVRCP PDU parameters length don't match");
-		pdu->params_len = operand_count;
+		pdu->params_len = htons(operand_count);
 	}
 
 	for (handler = session->control_handlers; handler->pdu_id; handler++) {
-- 
2.32.0.rc1.229.g3e70b5a671-goog

