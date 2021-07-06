Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC8C11F68
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7348161F8A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhGFLtX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237261AbhGFLgD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jul 2021 07:36:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC8A261EE8;
        Tue,  6 Jul 2021 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570789;
        bh=kd+FoFbVXUKm0zQWMlCwp3ZNy6/THo/mmLuN2xDBe9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSSRavsBIsVljpBZqDueLtoADxLGiy6EDXRbl3tQT/mu/144rE3PRHt8yV9Z7/xP0
         94hPVSRwLdh0zV7LVp5kzbb9/w6xrgUCPOLCGWWx3rBbmW/2jhhSwnuIl6n2wwbnW5
         c1QX9FA5M4XgeUNt5GqATWXNugHuxQHLQcGuIODMEzyMQ+3ew6BFvYvU3blR+c+sP0
         R6vIyA6KMuGXYHBcqYHyNg5E0RXlrmlCuLK9+t9DB1tUwaO+van3au2REpG4CngeSF
         Te7H6CUO3hrcYvrx1dBril5OH4KES5HqNpJMXPp1gOEFawfAQGaGFAIghbgUfxBRsJ
         aJvjexQZC+mIg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Liu <yudiliu@google.com>, Miao-chen Chou <mcchou@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 68/74] Bluetooth: Fix the HCI to MGMT status conversion table
Date:   Tue,  6 Jul 2021 07:24:56 -0400
Message-Id: <20210706112502.2064236-68-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112502.2064236-1-sashal@kernel.org>
References: <20210706112502.2064236-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yu Liu <yudiliu@google.com>

[ Upstream commit 4ef36a52b0e47c80bbfd69c0cce61c7ae9f541ed ]

0x2B, 0x31 and 0x33 are reserved for future use but were not present in
the HCI to MGMT conversion table, this caused the conversion to be
incorrect for the HCI status code greater than 0x2A.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Yu Liu <yudiliu@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5fce559a61bf..bbe59cad95c2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -219,12 +219,15 @@ static u8 mgmt_status_table[] = {
 	MGMT_STATUS_TIMEOUT,		/* Instant Passed */
 	MGMT_STATUS_NOT_SUPPORTED,	/* Pairing Not Supported */
 	MGMT_STATUS_FAILED,		/* Transaction Collision */
+	MGMT_STATUS_FAILED,		/* Reserved for future use */
 	MGMT_STATUS_INVALID_PARAMS,	/* Unacceptable Parameter */
 	MGMT_STATUS_REJECTED,		/* QoS Rejected */
 	MGMT_STATUS_NOT_SUPPORTED,	/* Classification Not Supported */
 	MGMT_STATUS_REJECTED,		/* Insufficient Security */
 	MGMT_STATUS_INVALID_PARAMS,	/* Parameter Out Of Range */
+	MGMT_STATUS_FAILED,		/* Reserved for future use */
 	MGMT_STATUS_BUSY,		/* Role Switch Pending */
+	MGMT_STATUS_FAILED,		/* Reserved for future use */
 	MGMT_STATUS_FAILED,		/* Slot Violation */
 	MGMT_STATUS_FAILED,		/* Role Switch Failed */
 	MGMT_STATUS_INVALID_PARAMS,	/* EIR Too Large */
-- 
2.30.2

