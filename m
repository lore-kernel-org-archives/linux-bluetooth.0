Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D4DC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0677A20774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExilzM/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgC3HFg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:05:36 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49000 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgC3HFg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:05:36 -0400
Received: by mail-pf1-f201.google.com with SMTP id d16so7501036pfo.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1A8ERe+jjCXUJhlc7waAuAvi0lXDAcxG3TaIXHLmUDs=;
        b=ExilzM/DR+pArc4TRsrmIC9FTyqh4RW0IZ0N78AWhxduYu+Kfk6W5PQ5xXpY08kkbI
         XwJpjUMGMDrrXlAxxM8faw185Vqlb3K1QcDwrDvk26Uk10i8x6HSn3wYWidD+xRxjzSK
         ryijFeTOf7kMHS/pG8JfmNiMLmT0TdYa9YnC1vOlFZW9yFUrSYyHpKT1dmU7c3B60tcq
         aiuslyjyUjWlm3hHAM2MlYBDEFDEV8EODf7XNYfsFMmkOw2sxAcxMEoCGIEYYRur0H82
         8RdZzs+2ycrYuOd3Oe6uIyER7SF29Cvn4GABVd3/w+S6A3nlsKdpPVcGzzI0ENdiL9jB
         dgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1A8ERe+jjCXUJhlc7waAuAvi0lXDAcxG3TaIXHLmUDs=;
        b=IAf5+U5KnEpW/LE7tEfeiwcLfWKyEKdZ8Oe/Z4AMBa/13q7FzQkToozYcym8LnNMh+
         9JsEv+YBGNrOwAWc8jlmD5Pp1HKJNITXzHjgD3QLUblWc1J3c5YUzZJHIZzvY0GVSfL5
         HIpRGkMcSBuphMFxW3Y7IKbj5g3XQtL42QmuiUH1ibpMPfmum4sKocAPhZWLkWzl8Alb
         gce2DRih3Mw4+XsjRmNALF51aq1CIN4B6tcCLr1va4UXsIoC6XJTLkTLHaQ7I/g9AQcH
         rg71NQ7yXLbQxdB0FLd0tSry2S5nfbBDUOKfdRNPKEAFEtev1IivUPViAeeFNJzbGKdM
         FVgQ==
X-Gm-Message-State: ANhLgQ0Nvkf4bLiRj8VGpzEbnpe2PDjo6Frf3Y/2Ix2CBtsUFQ04tesa
        xXSJZA9g0dtFGLdNxUsk3X8dacvfu3yEqF+LRmVuclPZeE4JyWFY930kNxS3NF0QadJi+viSnCO
        FfUODBA5jkD3aLHCTFy9bhBbOHjegFv1f8jaR8XYO2mBopE3zXp04quV2RftKtdUsv2NhcbCryC
        QroNZlVjqmoGc=
X-Google-Smtp-Source: ADFU+vvxKAsicVDxXQbx5V5UGYl7sBBieBnKQRsQSW7VHyuggSePvq7RWTWMgAa0p73jdzRMAK572jZuct/dHDwnYg==
X-Received: by 2002:a17:90a:3ad0:: with SMTP id b74mr14870076pjc.58.1585551933518;
 Mon, 30 Mar 2020 00:05:33 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:04:36 +0800
In-Reply-To: <20200330070438.37316-1-howardchung@google.com>
Message-Id: <20200330150424.Bluez.v1.4.I0a98775e764e9f8dba1652853b6e7ba440f4c75b@changeid>
Mime-Version: 1.0
References: <20200330070438.37316-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1 4/6] monitor: Add support for decoding LE Set
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

 monitor/control.c |  1 +
 monitor/packet.c  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/monitor/control.c b/monitor/control.c
index 790890fb4..cbf8d41da 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -201,6 +201,7 @@ static const char *settings_str[] = {
 	"bondable", "link-security", "ssp", "br/edr", "hs", "le",
 	"advertising", "secure-conn", "debug-keys", "privacy",
 	"configuration", "static-addr", "phy-configuration", "wide-band-speech",
+	"advertising-intervals",
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

