Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1730FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEFE64E5C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 06:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhBVGIn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhBVGIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 01:08:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EE5C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 22:08:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v126so3781629ybc.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 22:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=2jtGB32CbyaD+tOJ+LPftMPg0AFSsPxe9aDn1Xi0FlE=;
        b=WPeQTm3ChJlDpEaT2XKlqM6KGk27YEVPiGWZPKGcKAjogPyz0i/JfsyTetVlRFxXkB
         sblPOuXT1/GOJGc7rArzBqvJpGzI0ZN7Ib4zSDVvcBN62mlUbXNxi7jQQ6/OpXRMgj3h
         BfgaOSG+IKDNt909Rm1irufO71vA2Sl9Vgt5J8io1OWEs58vhtIlyohkPd3yMGUW7M7p
         oOnyzGcuqsz6OHA20FtT0xZhPlJmoHF7YbXc36ih+EKEdcsdQ03pwaY19ZZUjBGB5hzX
         hB6TxNjURBhiUFFwXRoX+S2fNyMk8Qu6gdl24odCR3J4kF/d04OwaEzn+ttpq6AKDciy
         BmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=2jtGB32CbyaD+tOJ+LPftMPg0AFSsPxe9aDn1Xi0FlE=;
        b=GZW7lokKg5VdXP9LL0jTl3xwcpVoyEfUi6T6xn09Lel6VT3jq+2zyvf0F2f8HfFig9
         VDh7SzkIKGP5Da3vJA7Jy2VLIBSIDdO2kVj1fTNmSK+feXJ9XasN/uSVF4Nf/Dy6WrCJ
         1BshONd5h1fDmSKB16rFbofisJg+cnK1lVbNTNvv+xuVaHTkhwn8nyhtS7eJtAy6d7w7
         kY7sUujFQNNvqrNiafhXhSSUAr8q378Bodi6EFsoVlIgKcbuZn3n8oKlsPPn5t5R7A1+
         KeH0eyREcEw3WJtI2UrUuMUHfTtDxqGdr3cta1uA1wPL4FS0vrC+J728rMiiYnpHiDch
         4vsw==
X-Gm-Message-State: AOAM530xY1O8rIRytqxX0gez2lRqUM8Zyh0sZyGHZtfwXS/r/oZcIgzl
        dSZE/Q1BYlgx5g/Lqlylh1JNS1BOP7RJESUBRKDAnml4LJSDZqmoZTus35sKSsfvytCB6S/Binu
        wwV3He1JpJnIO5du5VEClsnA1N0lA7id8VIvkr3wHRqEZ80Uen8wiYg3lNne5NRQ70WMFB3d/Nm
        GG
X-Google-Smtp-Source: ABdhPJxeK+qIplZVJY+EcFe3gTMjxVwpKzaCJP7+j8M9m1sDED6LkXLe5z9ttUq6AWcTgCCeV+hH8umZw0lj
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:167:3326:108b:47b8])
 (user=apusaka job=sendgmr) by 2002:a25:38d6:: with SMTP id
 f205mr31716211yba.448.1613974081779; Sun, 21 Feb 2021 22:08:01 -0800 (PST)
Date:   Mon, 22 Feb 2021 14:07:43 +0800
Message-Id: <20210222140727.Bluez.1.I127ac7b2fadba6ef4cce42360efd9b8129251753@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [Bluez PATCH] adapter: fix set_mode MGMT_OP_SET_BONDABLE
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Currently pending_settings is assigned MGMT_SETTING_DISCOVERABLE,
but it should have been MGMT_SETTING_BONDABLE instead.
---

 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index c1f976323e..ae1a70b5ba 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -646,7 +646,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 		setting = MGMT_SETTING_DISCOVERABLE;
 		break;
 	case MGMT_OP_SET_BONDABLE:
-		setting = MGMT_SETTING_DISCOVERABLE;
+		setting = MGMT_SETTING_BONDABLE;
 		break;
 	}
 
-- 
2.30.0.617.g56c4b15f3c-goog

