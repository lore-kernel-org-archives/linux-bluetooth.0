Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9AAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4FD60F41
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 11:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhIVL7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:59:30 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:50374
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235860AbhIVL73 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 07:59:29 -0400
Received: from localhost.localdomain (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 050AC412AC;
        Wed, 22 Sep 2021 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632311878;
        bh=oQNtx4Pz+fTUuURfnHGtu9bs1jMnEIeoOCyz8TjXMNk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=a8vg/pQaavufWoMpUCKs29M/DOwjnv/Jn9LzTfUFp1xpswMA3SOV51RrkiJOZbdRD
         HXZs9hpxHBVvijUUdRd5SPPTUW/waGByRSaUFNKvN423VKHqkElcApWsj9qDzpAZNj
         /4F2iemRuFU/NNpE5SILqVWfBC2Tmn1UKqFo0+eSE3FwTBYVjWXrFZwBK3Eu0AA98C
         DpTuX8kzjzqRbIO9B7lx+W644+Kj7VmNxNb2GtaOWh9thk05Vq5KCBeamA3/qnjULQ
         STSrTpUi5i71Ab2/jKRQ1c6vEK5p20kiy5d9K4HQe0JyOhQPzzchpaHvmVkt8mJQav
         OvGRyUFC6cDuQ==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] Bluetooth: hci_ldisc: require CAP_NET_ADMIN to attach N_HCI ldisc
Date:   Wed, 22 Sep 2021 08:56:56 -0300
Message-Id: <20210922115656.97723-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Any unprivileged user can attach N_HCI ldisc and send packets coming from a
virtual controller by using PTYs.

Require initial namespace CAP_NET_ADMIN to do that.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5ed2cfa7da1d..5e32e4d5367a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -479,6 +479,9 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	/* Error if the tty has no write op instead of leaving an exploitable
 	 * hole
 	 */
-- 
2.30.2

