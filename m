Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E2C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E00F20748
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFIbd/iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgC3IE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:28 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37704 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgC3IE2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:28 -0400
Received: by mail-pf1-f202.google.com with SMTP id n28so14731646pfq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DK0WI8AjNOdJ0HpShf0kaJsDhms0l6HDXBAdYLD2yWg=;
        b=fFIbd/iQfmusNX5pncc1J3JWwI9WNrQZY6XwVEx/F2N7GTGG3T3xchIUQU9+p43jaY
         ZWtIOwxvLKDcbAwsFExbFD9W4tIz1dQn1pIceXnJ1cqH9ivo5uO/cTT2j0l4XAaETpGV
         imBijkNXLc4M60Fy94ORltp/dmtT/4huBN5HwKGEOEVvyumhqBLtpWIbH0pEbutICHgb
         l9WKxNCkt7BI6LJhisz/IcwLuEh4Cse9tBOCeE+8lxH+UPyEx9Tcqhh7JX5aP8HIKAoK
         MAtp9adLsJpDYWrob1jSQYI6cg10VTJrZZDAzn/u6JGrucwqndNho+a2erkQ5vXz9vSx
         8fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DK0WI8AjNOdJ0HpShf0kaJsDhms0l6HDXBAdYLD2yWg=;
        b=L+YIddl7Zb4frtVaRnDj8i5eQjpULU1slEEiVLb0AyL57jN6wu72Uy692JA5h5pxgy
         L3kT2z7GGY4jApZC30B0FHP5CVe6c8PWxzolo1VCF+6lj1MVlHkChk8mXOaTSXijg19p
         vMDcU0VgsnL0dGE6jCE41bXNW9a/ygolTTTGzDwFXI970MQ4pCciLEwzAPRa1SP7hKBB
         JkUeVIyN2gs6LaGe/qpzssEiyzusG8oVKH4eJWX/pn9vttorLWLkZ9e+3JugSKHcwaY4
         WI2XoULcGY/eZWgnmorvZIb67KZza7L1Gi+K+Uu3Iyyio8TiTzqO0Cbpz+KDpI6LsdbE
         kpgw==
X-Gm-Message-State: ANhLgQ1epwF8wv/qLo631ZnLf5dao2tm9ILlEY3szi0aVwQ6cqEO+yzy
        LK6cAz9lQTzPc8Gaz5pdVws7uECy6q+XohtOfJg/3H3222Go0LxEtVejUqU4y5Yr4cGs4DF4geN
        G0fi2UtrpdIpHU4HN5sVG/koRlq98TlJJEawAe4058clwja6EVR3gzMf7cnyzHPVYHRMy1ZAEZC
        as0NrZ31oIx9U=
X-Google-Smtp-Source: ADFU+vsgmP6FVXLRehP83QdCph8TdQ0tLd3SqQkx2uzuxuxn06s5YkevKEEz7EHCmOXDmltwsWpPoKis2BqxNNGk6g==
X-Received: by 2002:a17:90b:1985:: with SMTP id mv5mr14650899pjb.69.1585555464803;
 Mon, 30 Mar 2020 01:04:24 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:55 +0800
In-Reply-To: <20200330080357.96989-1-howardchung@google.com>
Message-Id: <20200330160343.Bluez.v2.4.I0a98775e764e9f8dba1652853b6e7ba440f4c75b@changeid>
Mime-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 4/6] monitor: Add support for decoding LE Set
 Advertising Interval
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following lines will show in btmon:
bluetoothd: Set Advertising Intervals: 0x0140, 0x0280

@ MGMT Command: LE Set Advertising Interval (0x0060) plen 4
        Min advertising interval: 0x0140
        Max advertising interval: 0x0280
@ MGMT Event: Command Complete (0x0001) plen 7
      LE Set Advertising Interval (0x0060) plen 4
        Status: Success (0x00)
        Current settings: 0x00040ad0

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v2: None

 monitor/control.c |  2 +-
 monitor/packet.c  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/monitor/control.c b/monitor/control.c
index 6dfefd05f..75457029e 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -200,7 +200,7 @@ static const char *settings_str[] = {
 	"powered", "connectable", "fast-connectable", "discoverable",
 	"bondable", "link-security", "ssp", "br/edr", "hs", "le",
 	"advertising", "secure-conn", "debug-keys", "privacy",
-	"configuration", "static-addr", "phy", "wbs"
+	"configuration", "static-addr", "phy", "wbs" "advertising-intervals",
 };
 
 static void mgmt_new_settings(uint16_t len, const void *buf)
diff --git a/monitor/packet.c b/monitor/packet.c
index 3d32563e6..00825cbb4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11669,6 +11669,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
 	{ 17, "Wideband Speech"		},
+	{ 18, "Advertising Intervals"	},
 	{ }
 };
 
@@ -12988,6 +12989,23 @@ static void mgmt_set_phy_cmd(const void *data, uint16_t size)
 	mgmt_print_phys("Selected PHYs", selected_phys);
 }
 
+static void mgmt_set_adv_interval_cmd(const void *data, uint16_t size)
+{
+	uint16_t min_adv_interval = get_le16(data);
+	uint16_t max_adv_interval = get_le16(data+2);
+
+	print_field("Min advertising interval: 0x%4.4x", min_adv_interval);
+	print_field("Max advertising interval: 0x%4.4x", max_adv_interval);
+}
+
+static void mgmt_set_adv_interval_rsp(const void *data, uint16_t size)
+{
+	uint32_t current_settings = get_le32(data);
+
+	print_field("Current settings: 0x%8.8x", current_settings);
+}
+
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -13207,6 +13225,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0045, "Set PHY Configuration",
 				mgmt_set_phy_cmd, 4, true,
 				mgmt_null_rsp, 0, true },
+	{ 0x0060, "LE Set Advertising Interval",
+				mgmt_set_adv_interval_cmd, 4, true,
+				mgmt_set_adv_interval_rsp, 4, true},
 	{ }
 };
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

