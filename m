Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B89C76195
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60392205ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201708;
	bh=k6hq1JSeyIt+lIV8T06m/B9W6PrT0IV/AV1f4Wnq6TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GaRaQ/QV7lgz5KMFpLoV1T3aaEllwYNX8LMcmnv7rF3Oli+NM+xEDhCnYv49jY7qs
	 /d3kMwLr0QF5YyLlHERRnQEKTyhx7OoBbiSuLWvGMci1SKGxd2psrDRs/qLHWiiTOe
	 OlrNitUtB7TYUkA/6MP4P2+3IydSvIg468jiPLOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404863AbfGOOlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404853AbfGOOlN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 10:41:13 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32241205ED;
        Mon, 15 Jul 2019 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201672;
        bh=k6hq1JSeyIt+lIV8T06m/B9W6PrT0IV/AV1f4Wnq6TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkYAQ91MX7sN4YejULGIAWqH4MzF4eq4EnoABT+4HVskADB/ckgxaHKCaY6YZO6Zn
         9m3k+MJsSVKzhK3TERNPN1J9gik3CKnpsz1aKsyTVaEh7wOWMSnHIHdriRo2lXpvPG
         a96Uclr9ZQofuruIw+M15jxUVdk8JHfdAAtcb23M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Michael Scott <mike@foundries.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 69/73] Bluetooth: 6lowpan: search for destination address in all peers
Date:   Mon, 15 Jul 2019 10:36:25 -0400
Message-Id: <20190715143629.10893-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715143629.10893-1-sashal@kernel.org>
References: <20190715143629.10893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Josua Mayer <josua.mayer@jm0.eu>

[ Upstream commit b188b03270b7f8568fc714101ce82fbf5e811c5a ]

Handle overlooked case where the target address is assigned to a peer
and neither route nor gateway exist.

For one peer, no checks are performed to see if it is meant to receive
packets for a given address.

As soon as there is a second peer however, checks are performed
to deal with routes and gateways for handling complex setups with
multiple hops to a target address.
This logic assumed that no route and no gateway imply that the
destination address can not be reached, which is false in case of a
direct peer.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Tested-by: Michael Scott <mike@foundries.io>
Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/6lowpan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index de7b82ece499..21096c882223 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -187,10 +187,16 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	}
 
 	if (!rt) {
-		nexthop = &lowpan_cb(skb)->gw;
-
-		if (ipv6_addr_any(nexthop))
-			return NULL;
+		if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
+			/* There is neither route nor gateway,
+			 * probably the destination is a direct peer.
+			 */
+			nexthop = daddr;
+		} else {
+			/* There is a known gateway
+			 */
+			nexthop = &lowpan_cb(skb)->gw;
+		}
 	} else {
 		nexthop = rt6_nexthop(rt, daddr);
 
-- 
2.20.1

