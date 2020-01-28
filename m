Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F93C33CB7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1422467C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkdqcTpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA1CFM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:05:12 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:33175 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA1CFM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 21:05:12 -0500
Received: by mail-pj1-f42.google.com with SMTP id m7so246922pjs.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 18:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oESsgnjn3tlPnw7isobWu7ye1ZgRvVYgV6MEBPxlQMk=;
        b=WkdqcTpYSKEZ91Ra8Yk2J4AQz5gYroTjm0QQFIBFklYBSZJpEgBIaKoXrPwxZsyNSU
         kfsGP7Uftxd0x0FCdvsT4A4JQXoF/ub+IiETIsllmfBB389wovkfKZ4u4X8fr97Rkspj
         h/89JtsdDzrg3YMcZDLtXTq2gl6YmeOmaywLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oESsgnjn3tlPnw7isobWu7ye1ZgRvVYgV6MEBPxlQMk=;
        b=Gia5CIKY2V714m77WIGijKbohTFWyfRLLPsJH08zfAhAzQhU4rIXHH1+52T2Br8uPA
         S6u56hXHPYrjRPDt/toLgmsXxK8rfufF3ISzT2msBm8OHj52cBaTOJjAGFp9J0DTykqm
         1MM5hmsYTYA59XL+fDgtanGkC+zANXuG1CwEUaIYdvMnF+L2Sy69dipgxkm1YHDPIlXB
         2TgImzWdwFGvPPyqmCOr/R94HWbGk39/2UPsKYuQfnhazsADXbMzMgr7CSa7sP0tNQGC
         x+GD6R301jzhhqCXScv9FWtct3Lb9E4ViiDOTkuTIKRDTFOM8GIIflCzuF4XPleZxtHz
         ldpw==
X-Gm-Message-State: APjAAAUywNx2m+OW5xwpczKmkAThfq5qM35CrIiUxnatUfmafn0MZTUm
        RCkCU4NpAmOBdR2Kw8NtMiJiWQ==
X-Google-Smtp-Source: APXvYqxEipU4Zqdk6Ay2JYw1QbiRaFUQ6kzBVZPUq400Ir5nh9isdqrlVaChcvwMWJxpmTqEnzv6gw==
X-Received: by 2002:a17:902:7c95:: with SMTP id y21mr20356240pll.186.1580177111900;
        Mon, 27 Jan 2020 18:05:11 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id z19sm17119015pfn.49.2020.01.27.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:05:11 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 1/5] mgmt: Add docs for Set Wake Capable
Date:   Mon, 27 Jan 2020 18:05:01 -0800
Message-Id: <20200127180433.BlueZ.v3.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200128020505.239349-1-abhishekpandit@chromium.org>
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add docs for new management operation to mark a device as wake capable.

---

Changes in v3: None
Changes in v2:
* Separated docs/mgmt-api.txt into its own patch

 doc/mgmt-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1e59acc54..8a73a9bb9 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3047,6 +3047,25 @@ Load Blocked Keys Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Set Wake Capable Command
+===========================
+
+	Command Code:		0x0047
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Wake Capable (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Wake Capable (1 Octet)
+
+	This command sets whether a bluetooth device is capable of waking the
+	system from suspend. This property is used to set the event filter and
+	LE whitelist when the system enters suspend.
+
+	Possible errors:	Failed
+				Invalid Parameters
+				Invalid Index
 
 Command Complete Event
 ======================
-- 
2.25.0.341.g760bfbb309-goog

