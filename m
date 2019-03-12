Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C36AC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE25214AE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="n08f+/iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCLTWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:22:55 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:12482 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfCLTWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 15:22:55 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 15:22:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552418573;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RV2nAPevilQVXczqJcsC0oxc+HiBNu3S8JXClGRtCgA=;
        b=n08f+/iMvRXkOh7zo5oquO0htXb81MdpR3OG7BmpAH5x5Rc9FxaUcrlBizlDa4fJrL
        d8N77i8uqTzX1eHyR7un7Nz6hDwpJLjmvFb6JMhjrauYuj4Msmwu6GyPRKnuWBviGALe
        CB//VQqR9cqcitKU2ZrbcBYDyoRJu6f8HbSD1qXFd1pGFO/cLwziuire1gMaT4w6C6pv
        gTGq7wFB1f7CUZxo159GWPslBeC8n65uPRdObWne2PmvbfPwgUEpppadSOJji+rSfZIQ
        VulMZN8VW/qenKbgWidL5TLrZ0b+pN60XbUMw8V0uC0H13pyqbeQNuRzQyxj/voqD8Sw
        Q66w==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBarUSiWB4vmvjrsnNVyh"
X-RZG-CLASS-ID: mo00
Received: from unipc-suse.lan
        by smtp.strato.de (RZmta 44.13 DYNA|AUTH)
        with ESMTPSA id u08fcfv2CJGaxa6
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Mar 2019 20:16:36 +0100 (CET)
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>
Subject: [PATCH v2 0/3] bluetooth: 6lowpan: multiple peers and addresses
Date:   Tue, 12 Mar 2019 20:16:22 +0100
Message-Id: <20190312191626.20634-1-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190208152519.16181-1-josua.mayer@jm0.eu>
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set deals with an issue I reported earlier this year, where
1) packets addressed to a non-link-local address
2) any packets when at least 2 peers are connected
were not delivered if they matched a direct peer i.e. no routing.

The full explanation of the issue including steps to reproduce are:
https://www.spinics.net/lists/linux-bluetooth/msg78486.html

Changes since v1:
- changed comment style to c++

Josua Mayer (3):
  bluetooth: 6lowpan: search for destination address in all peers
  bluetooth: 6lowpan: check neighbour table for SLAAC
  bluetooth: 6lowpan: always check destination address

 net/bluetooth/6lowpan.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

-- 
2.21.0

