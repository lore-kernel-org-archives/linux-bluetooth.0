Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFCC4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B2B21556
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc+8MAKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507077AbgJ0HDq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:03:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32939 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507074AbgJ0HDq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 03:03:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b19so280680pld.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lG8X8RsyhfFjEKr5VPAt+NARbR+xfZO+kQavdT+OFQ=;
        b=uc+8MAKRykjX0YYr5ptkKVOtbQtM+bweCvRG/nQL4mhn2n7qmWhgMbthl1g/dAGpKc
         G3Sv2uIpF9UPIeFiMrFFegk2Z9bHyeLzuXYXudmXceqotSUlCFpAsAbJF4WPpkzWCXKd
         8+aVUGK9Tvdz7BWbFMQXFIy1/y603+FozZLkAZIEgb5JIIC50pzkg8S7VYmxrpanygZk
         JrkRTkOse/NoETxenE05HK8KWDf0027QG6nNSEyG2bxtYb8vjFiYDaxQg/5HXYNAwgVk
         nzRmlxd2hjhAvvKJKqWbj0M+ER7PXqfyTV71iJnxS6wzks7fDBgyZjy9XkQ3mv88acWX
         HcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lG8X8RsyhfFjEKr5VPAt+NARbR+xfZO+kQavdT+OFQ=;
        b=Q69SVtKIX66DRS4wFngL7GGV537MeIGu+/DTAtzQ4RSsOxXtdzPyGcF1iq/kTcwPR/
         1r+NhEejPOW0s8aApAtDykIC+eRl20j1MOrsmCciGXdER2w8IUSfefhNECglRBexwae5
         b9Sxbi9HF/2UUqKijaDXdTiapikIpt1Ae2Be8oI+BHJVWtXp3iPe/DPIEq6eM60RdN+S
         5hJdqK4OIJ7U9rTAQpwF+nhFqdokUSHTxEGiBySQ8kBzUXc1AZibjJE73nK2d6CgyiiZ
         DkNVlJ6yC3sz7CWhmOFYDS2HFapypHW/4X5fgbB6GruPBY+rQnJVrpaoSnDAgq5HtxqM
         I2ZQ==
X-Gm-Message-State: AOAM531sUNfhhXu14ebQustryf1UmJAAkRXf3ykleFZNqXTI+6BqC4uB
        V2L1cYrKfcWYLwzvw4VB7ocwIGXf+UPuRQ==
X-Google-Smtp-Source: ABdhPJwdEfDFDIcpCvWpE7RCbtRVzdAsIV3NGdTmoSTPKbwwqclBBUDosObkZLpTX2s1ttalQ/EJkg==
X-Received: by 2002:a17:90a:7802:: with SMTP id w2mr785392pjk.160.1603782225453;
        Tue, 27 Oct 2020 00:03:45 -0700 (PDT)
Received: from localhost.localdomain ([2605:e000:151f:8908::7b32])
        by smtp.gmail.com with ESMTPSA id kk14sm779584pjb.47.2020.10.27.00.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 00:03:44 -0700 (PDT)
From:   Edward Vear <edwardvear@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     edwardvear@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Subject: [PATCH] Bluetooth: hci_core: Fix attempting to set RPA timeout when unsupported
Date:   Tue, 27 Oct 2020 00:02:03 -0700
Message-Id: <20201027070203.13561-1-edwardvear@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During controller initialization, an LE Set RPA Timeout command is sent
to the controller if supported. However, the value checked to determine
if the command is supported is incorrect. Page 1921 of the Bluetooth
Core Spec v5.2 shows that bit 2 of octet 35 of the Supported_Commands
field corresponds to the LE Set RPA Timeout command, but currently
bit 6 of octet 35 is checked. This patch checks the correct value
instead.

This issue led to the error seen in the following btmon output during
initialization of an adapter (rtl8761b) and prevented initialization
from completing.

< HCI Command: LE Set Resolvable Private Address Timeout (0x08|0x002e) plen 2
        Timeout: 900 seconds
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 2
        Status: Unsupported Remote Feature / Unsupported LMP Feature (0x1a)
= Close Index: 00:E0:4C:6B:E5:03

The error did not appear when running with this patch.

Signed-off-by: Edward Vear <edwardvear@gmail.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 502552d6e9af..c4aa2cbb9269 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -763,7 +763,7 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
 		}
 
-		if (hdev->commands[35] & 0x40) {
+		if (hdev->commands[35] & 0x04) {
 			__le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
 
 			/* Set RPA timeout */
-- 
2.29.1

