Return-Path: <SRS0=tsxM=QP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D7C169C4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924422080F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="pC7BN3dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfBHPcB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:32:01 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:33135 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBHPcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Feb 2019 10:32:01 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 10:32:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549639919;
        s=strato-dkim-0002; d=jm0.eu;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=5/iNr7CSdfvbSI/K8Fvikov4s9NUDXhdT1pbuLuxMds=;
        b=pC7BN3dqjjZgpGUrfDieRPACevEVQXo2TvpBS/K0c5lo68YPTB2+vA1CToYy+Iv74f
        WXmYoA2E4GCiSoMg2KiVEFt44hYbA01AP0JznTVYhvGduGPzpdMap5iFB1I2XiPhvK0T
        RK+bDyFLECSju+wwNA95N4dFvSUfPTzEunWzNV9p4/NvUVSHWLRJ0wWSeVsizofzdE06
        WbIxB5R/+VTXLJOUwYWGVu6UdBOPXPiGy+4MeYnJlqj3sZD54Rq6wPz0aZFnGYN1RVdm
        awA3Vq5Ygj5b8fKRuWHMqMD+qvSpYE+k/jv0J9NQu0fW+vmSIpYOooqItml+k5r44W08
        slsw==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPUekEaRuJYlK+4Zv6s2ratDZ+mCAH"
X-RZG-CLASS-ID: mo00
Received: from josua.mayer@jm0.eu
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id V028b8v18FPd0Am
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Feb 2019 16:25:39 +0100 (CET)
Received: by josua.mayer@jm0.eu (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:25:39 +0100
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>
Subject: [PATCH 0/3] bluetooth: 6lowpan: multiple peers and addresses
Date:   Fri,  8 Feb 2019 16:25:16 +0100
Message-Id: <20190208152519.16181-1-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear maintainers,

This patch set deals with an issue I reported earlier this year, where
1) packets addressed to a non-link-local address
2) any packets when at least 2 peers are connected
were not delivered if they matched a direct peer i.e. no routing.

The full explanation of the issue including steps to reproduce are:
https://www.spinics.net/lists/linux-bluetooth/msg78486.html

Please comment if I am on the right track here, especially on the
second patch in this series where I am nto completely sure if I found
the right api call to the neighbour cache.

Josua Mayer (3):
  bluetooth: 6lowpan: search for destination address in all peers
  bluetooth: 6lowpan: check neighbour table for SLAAC
  bluetooth: 6lowpan: always check destination address

 net/bluetooth/6lowpan.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.20.1

