Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF26C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 03:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJVDN5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJVDNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 23:13:54 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DA8E2A58FE
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=66aCQ
        wLsRPDsoUmp9yQ4/Uw6dCVDoBkaifmWCpaFZNU=; b=FFUhDaP8a6Im6CpM3jxtk
        vPSct3O0jedMbeKxWNQNq9BaGC3qcjLLmFg3vtNWKqcla/91mYauxPHBcnwVanhN
        AI0Mkna49QRlH2TSNQvZ5UC7KTYexeQJVv+j2YT2ikAKR8utma1PhtLPX7rWPaH0
        Nl1TvF/QkMIgNJQ20SIlvg=
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp10 (Coremail) with SMTP id NuRpCgBXdpLsX1NjR01bEQ--.39790S2;
        Sat, 22 Oct 2022 11:13:50 +0800 (CST)
From:   xiaokeqinhealth@126.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Yao Xiao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ 1/1] monitor: Ellisys: Add iso packet support
Date:   Sat, 22 Oct 2022 11:13:33 +0800
Message-Id: <20221022031333.4333-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBXdpLsX1NjR01bEQ--.39790S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW3WF45WF4DXF18uFW7Jwb_yoW3XFc_JF
        yUAa40yrW5AF4xZrykWayY9r4UKw4kWa4kua9IqryqqayDG3Z8Jr1DXrWSv3sxKF40yF9I
        kr17u3W8Cr17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeUfHUUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi7w6i1V-1Vf08NQAAsd
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yao Xiao <xiaoyao@rock-chips.com>

Ellisys Bluetooth Analyzer Injection API Services.pdf

HCI Packet Type Object
Value   HCI Packet Type
0x05    HCI ISO Data (host to controller)
0x85    HCI ISO Data (controller to host)
---
 monitor/ellisys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor/ellisys.c b/monitor/ellisys.c
index 61ac24c23..56d280e9b 100644
--- a/monitor/ellisys.c
+++ b/monitor/ellisys.c
@@ -131,6 +131,12 @@ void ellisys_inject_hci(struct timeval *tv, uint16_t index, uint16_t opcode,
 	case BTSNOOP_OPCODE_SCO_RX_PKT:
 		msg[20] = 0x83;
 		break;
+	case BTSNOOP_OPCODE_ISO_TX_PKT:
+		msg[20] = 0x05;
+		break;
+	case BTSNOOP_OPCODE_ISO_RX_PKT:
+		msg[20] = 0x85;
+		break;
 	default:
 		return;
 	}
-- 
2.25.1

