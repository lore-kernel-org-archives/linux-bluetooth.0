Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4EAC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBKK5L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBKK5J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:09 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712230D7
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:08 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id EFB03240769
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:06 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGp2QjJz9rxM;
        Sat, 11 Feb 2023 11:57:06 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/9] doc: remove unimplemented Quality Report from MGMT settings
Date:   Sat, 11 Feb 2023 10:53:45 +0000
Message-Id: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Set Quality Report command was removed in
commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
but the settings bit was not removed. It's also not implemented on
kernel side, so remove it now.
---

Notes:
    v2: split to two commits

 doc/mgmt-api.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 90d612ed8..0e0b4fdf0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,7 +332,6 @@ Read Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
-		18	Quality Report
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -2925,7 +2924,6 @@ Read Extended Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
-		18	Quality Report
 
 	The EIR_Data field contains information about class of device,
 	local name and other values. Not all of them might be present. For
-- 
2.39.1

