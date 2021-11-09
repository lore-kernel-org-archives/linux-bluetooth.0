Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB546C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABE6610C8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhKIQoY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhKIQoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 11:44:23 -0500
Received: from sipsolutions.net (unknown [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9633C061767
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=r+PBFOa68zz/WZyxgEbpEZiQ9ozgU21z6q9dCnIR5GA=;
        t=1636476097; x=1637685697; b=PZkQflSJYQlZe4BGNZ1zoGi91mzfvvZROFnAhmT9Q4/kjWd
        VIamlgndTo22C2vG6pbDOEOJET/hvJANf8wMNdn3Wknpa5nDAeLHGrrW0CtjbQE+VuRpzPJQq1trr
        dMuggc7MLtEiS7Wn/jGE7A2bKO0jPw/nnnnr5obFP5BwbR5vrMnqSu5wk4aW1ZPQU4IiLrz93mis+
        CGgB6fY+y3Tyg7/zIFMjcW5lJ5rgc/JP5Is3FG8eVbZ7bfhS7/GTvJWe1kq9sqT3rFql+p47WW+KE
        zK3dGp7d2x2c1Ga61Q7q8gmIjIgeOq+msU0dcbREV8c3Wb1Jt3+xWyR6qpoc13HA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkUBh-00D1dY-RV;
        Tue, 09 Nov 2021 17:41:34 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <bberg@redhat.com>
Subject: [PATCH 3/4] Bluetooth: hci_core: Signal TX failure if sending a frame failed
Date:   Tue,  9 Nov 2021 17:41:12 +0100
Message-Id: <20211109164113.65981-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211109164113.65981-1-benjamin@sipsolutions.net>
References: <20211109164113.65981-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

Call the hci_tx_error handler in case a frame cannot be send.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bbb35188e41f..8664c2fbacdb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4200,6 +4200,8 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	if (err < 0) {
 		bt_dev_err(hdev, "sending frame failed (%d)", err);
 		kfree_skb(skb);
+
+		hci_tx_error(hdev, -err);
 	}
 }
 
-- 
2.31.1

