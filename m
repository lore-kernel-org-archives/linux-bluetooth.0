Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D7C2D0E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0C820784
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyUm7P1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgC3IEL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:11 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43821 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgC3IEL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:11 -0400
Received: by mail-pf1-f201.google.com with SMTP id 20so14727117pfw.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J6H28Klia+nbbPjZRhE37qHnAkPZWC0Dwshk4a+wzMs=;
        b=cyUm7P1KQPFg++nCDUmpuDPJgRF+fbJoqtUKfu2VaY1gHhG1kI3zVimZZYIT6tI8aJ
         xJla3/kRp43KiP47oYFCUi+F8yBP69T+BkXpK6Zl+Y7qCBMiHv3h1kEoPYaWmBCcZyQL
         OWkMsBcHYwhWTmJKYGYk4Imumvzf6tX15OHRSs6l0XCWrZQjeOLQQvbHnN3KD7Fs98h8
         jcA8g+rpUTxKn7TaucF1yNWIdTlOYGWVGl7KKXwM79ZOdBdEemHzNrHrztZ9Ofe7Yzll
         zkgDV66oprVUyE8TQqMm46z5hfpOFwY04ARvK+9B57raVx/BaFDWgWnLq/GW5mX/vUAN
         YShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J6H28Klia+nbbPjZRhE37qHnAkPZWC0Dwshk4a+wzMs=;
        b=ivM5uRAT6gU6PJCau99PcnT888A3aAUKa2WeNBBhcRlS8hfJ2RcWf96bmywxOz9C84
         EXHxQfLvmpaEdgjkhs+8k2qj8Jw+Y+kYJQi7Phs4DQjNYyiL7GO6skrBsnNQSwyh3b9H
         JCs66OKMj6uInIFx2UVppBEqem6+3x4/4ywHDMoI3zscIjYgUw0emvb4OBpnXCCFvGZX
         61q5WZURxaPehrP7MxvEFjBDAGFZ2k4OjB4PWNsfMHvC1BDZxuG8D6ooqcp6+OzGCkl/
         980yDV6m2NCRxv2n6R0jZPQ7WbMPLx+4esh+pa3t3nqduVH/th1lXdPwfRofWWR3CnAR
         2gmQ==
X-Gm-Message-State: ANhLgQ3L3W6l8G41hwal4uWDtJwerDWhjg2sCi353+HoYRjhM8EDVLfp
        ohL5aZeTRybMMo4Gaj1+HVLcvXk1usltM6ueJb42cp9IBO7IAyOpXEDDVHmrTzvlBireU2794u4
        sxbQXxCWDtkMjbroZRZfRzk96laDJFWMtNlfEAlwnU3bL3kIwsofnPrDifEIwvsw7j4yzd3btcQ
        zikVkimrCiH0s=
X-Google-Smtp-Source: ADFU+vv0IhByRpco9vm5vcXHGWuvf47bupyYbZ/7scNcRRGDTKdz/mPF7V0/y2RDK47sVCCmgR9dIXKRVwW3+95vkw==
X-Received: by 2002:a17:90a:bf18:: with SMTP id c24mr14308679pjs.125.1585555450046;
 Mon, 30 Mar 2020 01:04:10 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:52 +0800
In-Reply-To: <20200330080357.96989-1-howardchung@google.com>
Message-Id: <20200330160343.Bluez.v2.1.I0c5d660478f6a1c2d70f4bf683460e11a96ec223@changeid>
Mime-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 1/6] lib/mgmt: Add LE Set Advertising Interval definition
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

Changes in v2:
- Rebase and resolve conflict in monitor/control.c

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

