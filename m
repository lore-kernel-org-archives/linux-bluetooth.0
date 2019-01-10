Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1FEC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D0B20685
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 16:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq6uyjQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfAJQ6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:58:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33316 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfAJQ6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 11:58:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so12275304wrr.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=nOxpJlFN51Jih3qY768L/BkBvVLaE+JZgeVEa9vS7mQ=;
        b=fq6uyjQ8c9qlNJOIdaHtdkgGktZBNWn1Ey4D2r1dvi2I2ZO/xpjiK8Kg7b020aT5dN
         RXu3k9KubCvyP0MFPfDacL83t+ve+MfaBi0AZWuHdaLN4S+J4tx/gBvn0YjAdw7HBM53
         fWdjHq9lTOX5wAu0GEd0JfvC3gdp4UtsPkVTAINHwKaWjdgb7cxUp4iX2a9bnyZv+98p
         gMxeTFPk0qqQW0HcOU4ELBLjlQVKUzGukWzMrxFNF6cKrIdcYdx2+i6vv3eT2cJ7Lg9a
         7Nugbtyeq/6ydCZY/HLz9HCbkoIFoE0D26AqO84v8fBLHEAM1UKMQWfBZK9okdVAy5vJ
         bbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:mime-version:content-language:content-transfer-encoding;
        bh=nOxpJlFN51Jih3qY768L/BkBvVLaE+JZgeVEa9vS7mQ=;
        b=Hw+HsUbOKgzrJ6N8z5tqWrCsJraxr90EyHjREkJqrqeRBEHpJMoY4/1UmO4De0fVEQ
         Gg/h4IA/9I3XTSOF/5+ab8c/EVUQvtH+FQjJ3RzG5S8NW0LXgL/i+RvzECHxYlMgUtzo
         DhhiZdVt9Q/mT8n/ruMFhOVzWlMSy6dkaktmFWZyY56V+Wea64mxe4p7weZmMN3VGQP5
         1gSgWC5MK+0zzuiBrZTJwDwF1CAV3dRW2frwT5P41Bs52hPL9hJ9lrCrZ9VllFiiPuC0
         f0FKyN1mu6CYQmtTan+KLxBK+r222ZvBY9HMq5IIRiq0365x84BB7PaPeU8sE9JfPUP5
         aQpw==
X-Gm-Message-State: AJcUukd1FNfFylgiVjEQsh4CCw07SIxt6WCttzRbfBqIvnCjqjhwTsb3
        GLlu4JUvqhEnbqAZ0W4LNppWBo1v
X-Google-Smtp-Source: ALg8bN6dZqUxBExOffdSOHkb1IBOPSMAAm3B0FMi7zP4jr4Dh8F9OlZoKnq2rMzkyaLy8OCamn8ccA==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr9701932wrt.193.1547139531788;
        Thu, 10 Jan 2019 08:58:51 -0800 (PST)
Received: from [192.168.2.164] (p5B08A983.dip0.t-ipconnect.de. [91.8.169.131])
        by smtp.gmail.com with ESMTPSA id o81sm27966927wmd.10.2019.01.10.08.58.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 08:58:51 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   Josua Mayer <josua.mayer97@gmail.com>
Subject: [RFC] bluetooth_6lowpan: search for peer by host part of address only
Openpgp: preference=signencrypt
Autocrypt: addr=josua.mayer97@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f13ab373-1526-d457-05dd-114c77106aa4@gmail.com>
Date:   Thu, 10 Jan 2019 17:58:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Josua Mayer <josua.mayer97@gmail.com>

A peer may have multiple addresses, one being the link-local address
based on its Bluetooth MAC address, and then some assigned dynamically
from router advertisements, and published by neighbour advertisements.

For direct peers neither routes nor gateways are known.
Maybe the destination peer should be matched by the mac address from the
table of ipv6 neighbours.

As a quick hack, match only the last 64 bit of the address to ensure
that addresses using SLAAC can be mapped to their corresponding peer.

Clearly this hack is plain wrong. What is the proper method for finding
the peer that advertised a given address?
---
 net/bluetooth/6lowpan.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f706b8a13fad..989e5685b3df 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -172,6 +172,17 @@ static inline struct lowpan_peer
*peer_lookup_dst(struct lowpan_btle_dev *dev,
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int count = atomic_read(&dev->peer_count);

+	// match only host part of address
+	struct in6_addr hostmask;
+	hostmask.s6_addr16[0] = 0x0000;
+	hostmask.s6_addr16[1] = 0x0000;
+	hostmask.s6_addr16[2] = 0x0000;
+	hostmask.s6_addr16[3] = 0x0000;
+	hostmask.s6_addr16[4] = 0xFFFF;
+	hostmask.s6_addr16[5] = 0xFFFF;
+	hostmask.s6_addr16[6] = 0xFFFF;
+	hostmask.s6_addr16[7] = 0xFFFF;
+
 	BT_DBG("peers %d addr %pI6c rt %p", count, daddr, rt);

 	/* If we have multiple 6lowpan peers, then check where we should
@@ -216,7 +227,8 @@ static inline struct lowpan_peer
*peer_lookup_dst(struct lowpan_btle_dev *dev,
 		       &peer->chan->dst, peer->chan->dst_type,
 		       &peer->peer_addr);

-		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
+		if (!ipv6_masked_addr_cmp(&peer->peer_addr, &hostmask, nexthop)) {
+			BT_DBG("!ipv6_masked_addr_cmp(%pI6c, %pI6c, %pI6c)",
&peer->peer_addr, &hostmask, nexthop);
 			rcu_read_unlock();
 			return peer;
 		}
-- 
2.20.1

