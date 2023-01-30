Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BCC54EED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 09:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbjA3JOd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 04:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjA3JOc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 04:14:32 -0500
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97241166D4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telink-semi.com;
        s=lgqu2209; t=1675070061;
        bh=e5tdljEJvw/+kd9HqfPocsKcx8f1yMmOSylI5TsJ4IY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ifWy8s0aGiXy0ecOmSjuW5RUIyc+zEEIXhSPzW/l4sYMIgar8uoZkzatwHBF2DXlF
         zhnLo6y6CzFjX1rq88NEBBGjqih3W/p97UmlzQVqUqulBBTBOY+i/2p9h0O/tK8L3O
         G4a6YPvOn23KLx71kP/2nVKqGdhlI+Lg+F0tFGE4=
X-QQ-mid: bizesmtp90t1675070059ti9m5h4l
Received: from fedora.. ( [85.31.249.147])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 30 Jan 2023 17:14:12 +0800 (CST)
X-QQ-SSF: 0140000000200070D000B00A0000000
X-QQ-FEAT: CR3LFp2JE4nuRAt3y5hdzUGhalcrmFhxI1XGtMqdcOeniUiLQXeZFVgLMg8ev
        EomLycfo8iqfpUNSldyx2XeYaGUnzI7B43qO0WGY3iIz+wRGDHqojP3IR+B5CPtYbTx94om
        DD0ws3hkLqXJ5T/4GrUhK+KtR9HorHgfH2wiB99O2ozZGbUupNvD4oxhLMR7ZbCSyHu6DmR
        6YcFTc82SKSmTAzkoWcDVm4PZpTjkVmfOGns5ElgeIrOEyyJA6944BKLmM3uN1PYajGTONm
        m2kTmuxiWez25Mhs0tEAiu2TUQkZKP/w4FlS1XA8wPxZZ4zL20wiDkPPHHfwJAYMSTYZ3CV
        mdl/gtXZHZA50H6p18V/aRhuiKFjZ4S5vEVdj2lVkZeieWwYyA=
X-QQ-GoodBg: 2
From:   Marcin Kraglak <marcin.kraglak@telink-semi.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Subject: [PATCH] monitor/att: Fix Set Member Lock decoding
Date:   Mon, 30 Jan 2023 10:13:36 +0100
Message-Id: <20230130091336.19098-1-marcin.kraglak@telink-semi.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:telink-semi.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to CSIS specification v1.0.1: "Allowed values for the Set
Member Lock characteristic are Unlocked (corresponding to the
numeric value 0x01) and Locked (corresponding to the numeric
value 0x02); all other values are RFU".
---
 monitor/att.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 3b78884bc..05784e9f4 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1760,10 +1760,10 @@ static void csip_lock_read(const struct l2cap_frame *frame)
 
 	switch (lock) {
 	case 0x01:
-		print_field("    Locked (0x%02x)", lock);
+		print_field("    Unlocked (0x%02x)", lock);
 		break;
 	case 0x02:
-		print_field("    Unlocked (0x%02x)", lock);
+		print_field("    Locked (0x%02x)", lock);
 		break;
 	default:
 		print_field("    RFU (0x%02x)", lock);
-- 
2.39.1

