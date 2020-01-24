Return-Path: <SRS0=uVZl=3N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79BC35242
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 01:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F52087E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 01:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828777;
	bh=yi3SPWfrdUc2hmBaEB9c9QudFRVizN2qqqi3ustrzIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ygJom02rBzxMvc/qe28RLEriCIPYoP96kS6XhcXa0V46I7l7qQwUQsk1/5iuS0Dz1
	 uWjs1hOb9/R0dDEvMv4JjEUkcGy+vWMUm4sXhvyM6Spb6N0aBVSQme5p0udDJqGnxi
	 059ztsXBwqQaS1DBqb7jog7Yh6Af85O0ytUoFzDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgAXBRm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgAXBRl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB4D2467E;
        Fri, 24 Jan 2020 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828661;
        bh=yi3SPWfrdUc2hmBaEB9c9QudFRVizN2qqqi3ustrzIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zatxfaj0W2RlSuKJSVrjxITHkBgbhvydFnHszMq4GNjdWMJYk9E4S6W78bVPiZqTf
         sANufA6NyV1ohgqh4iCAVJL+eIwXdLFNcJ9jlVhW+EBhFHEwmWjJPbCKZDVRJLTaKD
         4CEGX1ZpnKJi5GNwB5UF1fH0Zm7sqyP8QXDYW5fo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Heider <a.heider@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/33] Bluetooth: btbcm: Use the BDADDR_PROPERTY quirk
Date:   Thu, 23 Jan 2020 20:17:03 -0500
Message-Id: <20200124011708.18232-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Andre Heider <a.heider@gmail.com>

[ Upstream commit a4f95f31a9f38d9bb1fd313fcc2d0c0d48116ee3 ]

Some devices ship with the controller default address, like the
Orange Pi 3 (BCM4345C5).

Allow the bootloader to set a valid address through the device tree.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btbcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d8620681..f02a4bdc0ca75 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -440,6 +440,12 @@ int btbcm_finalize(struct hci_dev *hdev)
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
+	/* Some devices ship with the controller default address.
+	 * Allow the bootloader to set a valid address through the
+	 * device tree.
+	 */
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_finalize);
-- 
2.20.1

