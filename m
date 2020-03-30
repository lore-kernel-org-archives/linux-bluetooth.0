Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7EDC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C2720774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hh8o6sDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgC3HFP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:05:15 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:36592 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3HFO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:05:14 -0400
Received: by mail-ua1-f74.google.com with SMTP id l19so7331093uar.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LqRKvlz2RXwyfDuS9QwSenyvzZ8B2ktok3zjnsNVt0c=;
        b=hh8o6sDLiYR1OU3kJsojsliWbt34KwwM6rMlHZdzz7bXK80ru2zB10uOksjJPm1LnB
         ed59lI0bM/a00uMmXmhUwX0PoeAdCWk9VLn2OakWIEiIzpN4o0Mxoh7ent6tGXlXkgNo
         JkS1OCy39fqXQZE2CRtniY9WXvKNbq1Xa0D9qbhIISKW7yopsTwgZUUSYZ4eqf8nIlTx
         Fgmc3rIX2Ldfv5ko44ZmtPsNIN6D6i1POVKyJMR/P6BRW3hY/aoEZU1dsLb1WlztEqrd
         lNkr6xo6eI4n02IctICYEeZ2hqkKr7eCaSxYHuO25tozEaLbTtbUre/djkFUgGCH2jh6
         FRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LqRKvlz2RXwyfDuS9QwSenyvzZ8B2ktok3zjnsNVt0c=;
        b=BaKTfxOkeUm2gMYdHPqt/3GgrtLEJMvuDT0Sa8lsrnKtqRxij+1JqB8jf+Fo12ZJvU
         +xojGkBG6AM10N//mBsrrri5dZ2hYW31xxpRI04Y8QwHEL9tYZEzIsKESWkkO6FHUDzs
         3UYP0D0u6N5gjXCpSHrleTqL4GEpZZHGKXG1/oHe7Gg8GGEstwNkz+pXBkFhJz0b+MBc
         EL8CuBV2aDEGLJ5mK9kFTflgz4scSPwiL8Vz86DxNwRWOQ1x7zQjdrVNEFZX2Q4Orq9A
         ZpIftVoVPJRoIJOoKVjfKOiONhnFu/jdfTlUwRu9k4i4yA7Bjr90TXG2V8UU3n5BHJ30
         gdkw==
X-Gm-Message-State: AGi0Pub4ndQUyUyi+pPhNKN2H3ZhaSGCUR3VL5tsQGbeapav5VYyJKt4
        kh4ifGyGkk0HzRoYc9LFrKcwQMmll/Sc26i3g39inOuOVME6ITzSpZHtB77xrh4O7txcDlaL0jq
        wKyoLatGJScEA33yqZdvfQYostCZlqzEjTKOYWNgdlj/63EDSzv+M0Gigs9fVkVvsiTr282jruk
        FN+x6K4njHIdw=
X-Google-Smtp-Source: APiQypLCxEEdrol1fNJu8Eh5Jqk+4ETihXlLuF5ofSlk/oXKc2C6kVnCJkZBJEhqC5BCNjkIkVuuzroi6VQuEnbjrA==
X-Received: by 2002:a67:f81:: with SMTP id 123mr7235556vsp.50.1585551911960;
 Mon, 30 Mar 2020 00:05:11 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:04:33 +0800
In-Reply-To: <20200330070438.37316-1-howardchung@google.com>
Message-Id: <20200330150424.Bluez.v1.1.I0c5d660478f6a1c2d70f4bf683460e11a96ec223@changeid>
Mime-Version: 1.0
References: <20200330070438.37316-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1 1/6] lib/mgmt: Add LE Set Advertising Interval definition
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>, josephsih@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Suggested-by: josephsih@chromium.org

Signed-off-by: Howard Chung <howardchung@google.com>
---

 lib/mgmt.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 7520c7ae9..75302f5fd 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -103,6 +103,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_ADVERTISING_INTERVALS	0x00040000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -602,6 +603,15 @@ struct mgmt_cp_set_blocked_keys {
 
 #define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
 
+#define MGMT_OP_SET_ADVERTISING_INTERVALS	0x0048
+#define ADVERTISING_INTERVAL_UNIT_TIME 0.625
+struct mgmt_cp_set_advertising_intervals {
+	/* A unit of the intervals below is 0.625 ms.*/
+	uint16_t min_interval;
+	uint16_t max_interval;
+} __packed;
+#define MGMT_SET_ADVERTISING_INTERVALS_SIZE	4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -898,6 +908,7 @@ static const char *mgmt_op[] = {
 	"Set PHY Configuration",
 	"Set Blocked Keys",
 	"Set Wideband Speech",
+	"Set Advertising Intervals",			/* 0x0048 */
 };
 
 static const char *mgmt_ev[] = {
-- 
2.26.0.rc2.310.g2932bb562d-goog

