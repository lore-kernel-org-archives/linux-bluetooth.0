Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B0C43465
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 11:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F69206B6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRLKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:10:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54106 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRLKy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 07:10:54 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:10:54 EDT
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08IB5NfX4016857, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08IB5NfX4016857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Sep 2020 19:05:23 +0800
Received: from laptop-alex (172.29.73.42) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 19:05:22 +0800
Date:   Fri, 18 Sep 2020 19:02:23 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: Fix the vulnerable issue on enc key size
Message-ID: <20200918110223.GA10235@laptop-alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.29.73.42]
X-ClientProxiedBy: RSEXMBS01.realsil.com.cn (172.29.17.195) To
 RSEXMBS01.realsil.com.cn (172.29.17.195)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When someone attacks the service provider, it creates connection,
authenticates. Then it requests key size of one byte and it identifies
the key with brute force methods.

After l2cap info req/resp exchange is complete. the attacker sends l2cap
connect with specific PSM.

In above procedure, there is no chance for the service provider to check
the encryption key size before l2cap_connect(). Because the state of
l2cap chan in conn->chan_l is BT_LISTEN, there is no l2cap chan with the
state of BT_CONNECT or BT_CONNECT2.

So service provider should check the encryption key size in
l2cap_connect()

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ade83e224567..63df961d402d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4150,6 +4150,13 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan, false)) {
+			if (!l2cap_check_enc_key_size(conn->hcon)) {
+				l2cap_state_change(chan, BT_DISCONN);
+				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
+				result = L2CAP_CR_SEC_BLOCK;
+				status = L2CAP_CS_NO_INFO;
+				goto response;
+			}
 			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 				l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
-- 
2.21.0

