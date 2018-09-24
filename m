Return-Path: <SRS0=ctyp=MG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2786ECE560
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888072087A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M26420oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888072087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeIYBiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:38:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46270 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbeIYBiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Sep 2018 21:38:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id d8-v6so2536625pfo.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Sep 2018 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWNO2NHWP//VmQYN8e1d8FN80wkhtUktnT/RAcvUozw=;
        b=M26420oIcY+biTPMillWesqB4URZatOSKqWq2TeMl0pMN4Ln+VI/rTd6lOOvS1iwh+
         N4fNPbBmm3Pk+bOZir/kwHyb6A4OBTHhkMh1EIrPNW8/3Oka9B0/bRPvhKHoKCEr9c//
         XKs7Bc8J/OfC3Na3YGJTnit7w8lzoPTLJkzdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWNO2NHWP//VmQYN8e1d8FN80wkhtUktnT/RAcvUozw=;
        b=YxeqL0LF4zh6lDxah1/qJTPkz6O9Mu7kGtho8dYD8hi5BBqWKgauWf3BlEdM3Wn+Pn
         g6aQzUnhlsV1sl9z40r2uCCS10IOhWQif35t58nxE3tzAGvtjmYymh7tUNxnSTb39cXj
         v9OXlD340RO+fDWnU1oMUTvOBL5NqAH4rLKw+Wk5R9m2rDeIYnTuJZC0bs54WGZ/BqAV
         oWV21gY1E/Ynxmr6Nq3HRAEn72goqN+eG4jaX0H+wRqNMkkEbxsIFqNLFizzCwI12ALy
         IA1+W+ZLs5S/fkxuwnNRK7xpk2uy2usM6ANy956KvLv791YLqKh7DR6CSaiIMNR3vkof
         nhhQ==
X-Gm-Message-State: ABuFfohgnQVSCLbdp++pDOUsSLRf8ESi4HC5rP2bhaPD/ZQr/oXidaRj
        shLLyEIehkELVjlMRbsKbCltrQ==
X-Google-Smtp-Source: ACcGV62YmUOTQpKZQSmAJQbloFoCiEvjEc0mh2aYco9DSOuv/Eh7WPJQzhCXHJvEk0gyDRcZYpEcjw==
X-Received: by 2002:a17:902:7001:: with SMTP id y1-v6mr224278plk.259.1537817705420;
        Mon, 24 Sep 2018 12:35:05 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 77-v6sm112234pfw.159.2018.09.24.12.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:35:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date:   Mon, 24 Sep 2018 12:33:52 -0700
Message-Id: <20180924193352.96335-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180924193352.96335-1-mka@chromium.org>
References: <20180924193352.96335-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the new API to get the BD address instead of reading it directly
from the device tree.

Also remove an unncessary pair of braces in the same area of code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- pass bdaddr_t instead of byte pointer + len
---
 drivers/bluetooth/btqcomsmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..ff74d2c46991 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -172,11 +172,9 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
 	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
+	if (!device_get_bd_address(&pdev->dev, &btq->bdaddr))
 		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
 			 &btq->bdaddr);
-	}
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
-- 
2.19.0.444.g18242da7ef-goog

