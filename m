Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC02C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 11:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiI2LEO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiI2LEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 07:04:12 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE198E0FE
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:04:10 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1odrKq-0007JU-0k
        for linux-bluetooth@vger.kernel.org; Thu, 29 Sep 2022 13:04:08 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28TB45CF3109252;
        Thu, 29 Sep 2022 13:04:06 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 1/4] mesh: Ignore Secure Network Beacon from subnet
Date:   Thu, 29 Sep 2022 13:03:41 +0200
Message-Id: <20220929110344.26130-2-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220929110344.26130-1-isak.westin@loytec.com>
References: <20220929110344.26130-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If this node is a member of a primary subnet and receives a Secure Network
beacon on a secondary subnet with an IV Index greater than the last known
IV Index of the primary subnet, the Secure Network beacon shall be ignored.
See MshPRFv1.0.1 section 3.10.5.
---
 mesh/net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 7fec98531..dc3d1fd80 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2708,7 +2708,7 @@ static void process_beacon(void *net_ptr, void *user_data)
 	struct net_beacon_data *beacon_data = user_data;
 	uint32_t ivi;
 	bool ivu, kr, local_kr;
-	struct mesh_subnet *subnet;
+	struct mesh_subnet *subnet, *primary_subnet;
 
 	ivi = beacon_data->ivi;
 
@@ -2723,6 +2723,17 @@ static void process_beacon(void *net_ptr, void *user_data)
 	if (!subnet)
 		return;
 
+	/*
+	 * @MshPRFv1.0.1 section 3.10.5: IV Update procedure
+	 * If this node is a member of a primary subnet and receives a Secure
+	 * Network beacon on a secondary subnet with an IV Index greater than
+	 * the last known IV Index of the primary subnet, the Secure Network
+	 * beacon shall be ignored.
+	 */
+	primary_subnet = get_primary_subnet(net);
+	if (primary_subnet && subnet != primary_subnet && ivi > net->iv_index)
+		return;
+
 	/* Get IVU and KR boolean bits from beacon */
 	ivu = beacon_data->ivu;
 	kr = beacon_data->kr;
-- 
2.20.1





