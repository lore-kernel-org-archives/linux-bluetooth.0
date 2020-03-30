Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB155C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A9420748
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXYNFLRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgC3IEV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:21 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49017 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgC3IEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:21 -0400
Received: by mail-pl1-f202.google.com with SMTP id w3so12381423plz.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oOIxK3ZqM6LAAqkV1X/+V85HxrPtsXuK8F3nIXKiwNw=;
        b=FXYNFLRhaCq6XHrYgg4fWOre+j9fLqwuoc9GbelSkdVsYcXrUXg3xr+qiGG5XNlIAm
         2Big+71X0uGHSXe6T0g4+zMYUxvAHOAwofHgPfMnrxIbjjgoJwiJyMpkimqLIbSMqB01
         QLiuC/vWF8BtI8BjhsEFw15YXMBwULQfpBYCTM9xzGSE7WBoPVkveQE1MHEVRQnC7sGk
         erbai/tjC/QsVlYY6r8nMO94BlsvYWRaegIlXfIfocUGhFPDV3qvCXw5ssccrMYRO0zz
         9v3KsU6oTwtw0DD81qdjMEhaoaO9N89qT0xSzYT7Yu05p8HpzhB/91W636lIx+ZESQVm
         Cibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oOIxK3ZqM6LAAqkV1X/+V85HxrPtsXuK8F3nIXKiwNw=;
        b=l2gRb54wpVkEFbiQL+vkXFNkqq52/0nb49TtalM2C4aG2ZKpgB+zk3iqLrXNAR1UlU
         bphS1trBlEaTgvo5W7lYeZcpnTQTXHN2EVkuB6ZcpW4GhIpRG5Cn1A2Qerpt0y0o0364
         F6QCuYUW2SVPazivCUXU3uixPA66dgepZ4czC9yoBvQxSFqcp1YbngMLV4XamjZ80rCR
         0nmg/MQdkDznvm6D5Y9JCniidTZaklhC9+E+wVEGQZ4/0gIFQf8/Ow94Bjagjp5z1ikf
         lEnnOzxjkTKYJek5IaTz5vP8V5yucNabkuPlWyo5mQ4Ni+LHCFmCLXi4CjBg1P60kGQA
         OirA==
X-Gm-Message-State: ANhLgQ1YTXBgeEBH1LHF7Q8zr+r+7D4lMmtzcJK6vsi5AHSOXJ0tIX1d
        A48rIH9jzzYrQLDFCx/VPsdKBISDn8lFnfhhlBsJTbOdHlws4Cs9zh/y/noMxk8Mki/aElQuQb/
        cHhFrI4LyTPooa3myEStsnPGRzjumU4sb2qLpuoV3wfQA99YCjc+tDA6uU4pIxje1bk4hGp8P23
        Bzdhw5IlhSko0=
X-Google-Smtp-Source: ADFU+vuVXlyYF1UEpqbgBbsSsKB7dcFdgPJqh+YYyV2fnIAQwDBSJqHLK8d+ll0N2iCcZg/Bw4mvRksr6o8iyJrOmg==
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr14060702pjb.86.1585555459981;
 Mon, 30 Mar 2020 01:04:19 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:54 +0800
In-Reply-To: <20200330080357.96989-1-howardchung@google.com>
Message-Id: <20200330160343.Bluez.v2.3.Ia74c1ab0a71d90f46f10b4e32743cab722a97bbb@changeid>
Mime-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 3/6] doc: Add documentation for LE Set Advertising Interval
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v2: None

 doc/advertising-api.txt | 13 +++++++++++++
 doc/mgmt-api.txt        | 25 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..9264cdb27 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -209,3 +209,16 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		void SetAdvertisingIntervals(uint16 min_interval_ms,
+					     uint16 max_interval_ms)
+
+			This method sets the advertising intervals.
+
+			The parameters min_interval_ms and max_interval_ms
+			are specified in milli-seconds. Valid values of
+			the intervals must fall between 20 ms and 10,240 ms.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.InvalidArguments
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 27a41f334..5eff87e24 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2925,6 +2925,31 @@ Read Extended Controller Information Command
 				Invalid Index
 
 
+Set Advertising Intervals Command
+=================================
+
+	Command Code:		0x0101
+	Controller Index:	<controller id>
+	Command Parameters:	Min_Interval     (2 Octets)
+				Max_Interval     (2 Octets)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is used to set advertising intervals. The intervals
+	are expressed in multiples of 0.625 ms. The default values of
+	both intervals are 0x0800. Valid Min_Interval and Max_Interval
+	values must fall between 0x0020 and 0x4000.
+
+	The advertising intervals are first kept in hdev struct. The values
+	would be sent to the controller and take effect when advertising is
+	actually enabled. If the advertising intervals are set when
+	advertising is already on, the advertising would be disabled and
+	re-enabled to make the intervals take effect.
+
+	Possible errors:	Busy
+				Rejected
+				Invalid Parameters
+
+
 Set Appearance Command
 ======================
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

