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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA59C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C33664EF4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352283AbhCDAd7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbhCCTV1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 14:21:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD4C061761
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 11:20:26 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s3so4824862pjn.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Mar 2021 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FgrjZxNne3mbySUDq5jeuKhrAxqdbLLhnEKsdJAGRVY=;
        b=SVe1+DXfsRjqYGfHOdAtnb5xiamfY47HVQFZTuqnl3m9X9G4mFNDF1PSP8rz5c18gA
         kH1z8ueCIoPQghxGBKiVVrYKEP51//sPnnxg7Qu4LaAFvHn+alqp5ZxPh6n2cMF2rG9m
         KxcUYPrzSONRHJLvaoccn0e24iSMzTn8X3yAkL26Hv88yVVM2tcwCKXcRS5Hquo3RN0a
         QJyjVKY3Q+vQFa5KOMYxndmxlIc+Emxpp6YF+1HfBpv3Y1g47KXIyzfTpH4C4ZVcoRh7
         TcNcc/hnX1cgEnpX8p+PIjSHeBwzgbhTddqb+D5y8tHCwBvNGmo7BF93uAKPhmLLFxAg
         aR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FgrjZxNne3mbySUDq5jeuKhrAxqdbLLhnEKsdJAGRVY=;
        b=YaBqIUVQGRWqeLZ0lS1JPtPbytbMEaHb0jwr4AJnrfk0UP+W1XdQ4u7TebCnYUDt7h
         C9oSG0sSF9rbpaGmUqsQZ3oBdGNB0nLENMb1Ol/LKiRNJD9mQrBUJ5PUh6S3vPiZ+j+o
         OYXwDAclmX9cSQmGVcRSaFF7Eu2c15holS+cfG7Exrkj443/mCKB5sDN5zcK2Ez9oeFQ
         xZEQPKNQKGTbe2L0F3fTyzPvVEGhTpr6vR/D45+SF2/zXNxGo9kzAmPnJkOkfAJRB89x
         daHs20++MUXtwjwzLAgCJvneCmZ//514wQ6E1xE4w12zzpAJpFRT/OYZtilNrO3hjoMb
         UFxQ==
X-Gm-Message-State: AOAM532HxKxAFu+7bmN3V9tbN7CZDKwZQY8n50VBmrSdAj/pIRCR8vOo
        6nrtA546jU2VGnCu4u4f5aA6vPR5DE1HraoWwODzKMjfA54ZFBe6Is4Vb9ZGrKBXHK5r/MdpJAt
        Kc4DD8sM7Stjr8KNhnJRRWARoqTHbNUQBQWyNp33zHW8UTxdXI2jvOgXSdNyI1HPunluNGAxGgo
        LDdvvfUuKMz+2y8BPx
X-Google-Smtp-Source: ABdhPJxYfClsqTpp8zoDy0vHNyTlI7KbcYtV76b1fWpNKTgzBpG16j5TEUNPP3hvI1xBun2qU03UBsh6Xek1lRziuY2Q
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:45cc:69de:aba1:a948])
 (user=danielwinkler job=sendgmr) by 2002:a17:90a:4494:: with SMTP id
 t20mr619027pjg.33.1614799226233; Wed, 03 Mar 2021 11:20:26 -0800 (PST)
Date:   Wed,  3 Mar 2021 11:20:10 -0800
In-Reply-To: <20210303192012.1695032-1-danielwinkler@google.com>
Message-Id: <20210303111817.Bluez.2.I45b896f4512038309cbeab7a01f51e503141edab@changeid>
Mime-Version: 1.0
References: <20210303192012.1695032-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH 2/3] advertising: Create and use scannable adv param flag
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In order for the advertising parameters hci request to indicate that an
advertising set uses a scannable PDU, we pass a scannable flag along
with the initial parameters MGMT request.

Without this patch, a broadcast advertisement with a scan response will
either be rejected by the controller, or will ignore the requested scan
response. The patch is tested by performing the above and confirming
that the scan response is retrievable from a peer as expected.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

 lib/mgmt.h        | 1 +
 src/advertising.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 76a03c9c2..7b1b9ab54 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -507,6 +507,7 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
 #define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
 #define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
+#define MGMT_ADV_PARAM_SCAN_RSP		(1 << 16)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
diff --git a/src/advertising.c b/src/advertising.c
index f3dc357a1..38cef565f 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -945,6 +945,10 @@ static int refresh_extended_adv(struct btd_adv_client *client,
 		return -EINVAL;
 	}
 
+	/* Indicate that this instance will be configured as scannable */
+	if (client->scan_rsp_len)
+		flags |= MGMT_ADV_PARAM_SCAN_RSP;
+
 	cp.flags = htobl(flags);
 
 	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
-- 
2.30.1.766.gb4fecdf3b7-goog

