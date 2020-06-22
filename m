Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37843C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1486420738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eq2IW+Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgFVXlM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbgFVXlL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:41:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFAC061795
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so8296805pls.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx9oioKmV1hXOmQeUskpAWObYiB+UYpRucZChdpRzZg=;
        b=Eq2IW+GjCM0u1hJlkNg1GfwuMVDDACpeBKR79YQMxfKhy/NTayT9Phk98M53Cw7iDX
         lN3w0ikLVUtiFtsaX+97Zoi6cz6yAsas71ntusxG3h2Nn8LAVsV/LJ+9xDcXFDfqlbSn
         Q8sLU7TG0Cgt/iXnQOu79NRcdR0jSKoNjPqbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx9oioKmV1hXOmQeUskpAWObYiB+UYpRucZChdpRzZg=;
        b=baezguNyew56aWEu/6MnZOyz4sDscj59ehWTQw0kgIvauv7YgrimNTI3gvp/2P3b0i
         w4aremmfTZEQrxvW/vOiz2kaMqdii47NsLmRMIYp5ACteGV45m7nSHi7RIrlSOQg+t7A
         7EwiMssxZvgcs9scC7M01D/hepypXS55XYzEK29imM8xXEctF7IG7tonZLPmgtMRwASf
         pvvjaUZaRQLoT0UqfUMr2xoFVf3lXGgki+/FC4mtEdwPPW3hOfk9YWX2F5bcpZvGUFK+
         scTWPsXk5Tp2KP1WkhNhWKSLzK0pbEHFf4OdjTGdAgr/VPITMVa3z2F8RZ/4m/qhwp35
         eIxg==
X-Gm-Message-State: AOAM532HP6U0j/f6671uvRyGDI61Yqn8DOv+yE5EhngsAcdmv9VUApbv
        xXsVQxdH96weT8tymZ++tJriS2r4IYc=
X-Google-Smtp-Source: ABdhPJzg6XBwEIzuNpsqSgMb+UzdqgVrs5RVKqOxtqCZy1zC7clv7aKB/H0FWehnjiyT8DWEdPAtTw==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr20906558pjv.100.1592869269731;
        Mon, 22 Jun 2020 16:41:09 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w22sm15049500pfq.193.2020.06.22.16.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:41:09 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 4/6] client: Display wake allowed property with info
Date:   Mon, 22 Jun 2020 16:40:49 -0700
Message-Id: <20200622164003.BlueZ.v5.4.I45dbf8ee15dff6c9346dc9754574a0be9bee1fa1@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622234051.206800-1-abhishekpandit@chromium.org>
References: <20200622234051.206800-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display whether the device is configured as wake allowed when queried
with cmd_info.

---

Changes in v5: None
Changes in v4:
* Renamed WakeCapable to WakeAllowed

Changes in v3: None
Changes in v2:
* Newly added to show whether device is wake capable
* Removed automatically setting wake capable for HID devices

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 422da5593..4953f50f0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1637,6 +1637,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
+	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
-- 
2.27.0.111.gc72c7da667-goog

