Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB3C2D0F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A3D2071A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrciOFRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbgDAV1i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:27:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46409 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAV1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 17:27:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id s23so475584plq.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY3SG64yEBGy5hTOEzBLQ0iUTKUMeln58PvTbj9GgC0=;
        b=GrciOFRmyE03b5t491NMhfnKruyVC0a7wp5fFxiiz4WD5UMub4Aj9Yt8khpiemtXZh
         Qvofze3M0xvgBYJ2gvpVg1yVVBAYXtJnNeZ+E8uwI/T1oNK5Wf4MepsZAzufvs5TBXR2
         Oxs6OkBChW+Pb8XTwbMRE2iwFZgG1OGTXjKJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY3SG64yEBGy5hTOEzBLQ0iUTKUMeln58PvTbj9GgC0=;
        b=TgCsr3rW0V3Iv/1XVBUvzP4cDcJBm1i2GYviPMDvFiAe0nAj0n4xEvyXTvy98JrIx/
         EoemgN3yFJ6lFHdLsOPfy6oi3g3GbD5nVYfV2YCHEdBXKReS0+8T0zIlPIYgGG3fPscS
         9vVNNXhybTljUUec636IaTglivlmOQa20QvVgRO8WLxIt7HqcKAAhJ7V9QbnpfpGj7oT
         cUiHTXlsPT7IBgzjnrPQWid1Q6Ztxf/THKMX+BqvxbkhGnjmFq7PM1w6IaZF/7p7djJB
         W8nI803UsrNx7BF6wCX5KRMGKCW7yxk9TDkZRW6RpU+UCpTVJvrmcsP3K2+NbsaNbYUY
         3Qxw==
X-Gm-Message-State: AGi0PuaWVVmflwk9hNGs9/A9zg9NA50FzE2V7GC6tkSTwcVA/YYycYXS
        UvU/F2GzMx+WiR2mQes1FHGCSQ==
X-Google-Smtp-Source: APiQypJ84M3AbUx8+m2Fc5K8QmKypp5GTpAIld2qFJzzdXr6D/t5nUJTfUSvYO3f1Ff6I608hKGC/Q==
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr119836pjp.77.1585776453395;
        Wed, 01 Apr 2020 14:27:33 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id s62sm2117427pgb.94.2020.04.01.14.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 14:27:32 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, ningzhao@qti.qualcomm.com,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] ar3k: Support HCI Read Encryption Key Size command
Date:   Wed,  1 Apr 2020 14:27:20 -0700
Message-Id: <20200401212720.11022-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The new firmware supports HCI Read Encryption Key Size command.

Signed-off-by: Ningzhao Zhou <ningzhao@qti.qualcomm.com>
---
 ar3k/AthrBT_0x11020000.dfu | Bin 36828 -> 37116 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/ar3k/AthrBT_0x11020000.dfu b/ar3k/AthrBT_0x11020000.dfu
index 792aa3becb6cfd03524d89b6f824bf4eb5397c51..69c3d9ea579555ffe4f9f266d576afa52e2b3d91 100644
GIT binary patch
delta 10360
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

delta 10261
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
F{6E68x+VYs

-- 
2.24.1

