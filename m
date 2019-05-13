Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA0C04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 10:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B620989
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 10:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="P76wg49C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfEMKOm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 06:14:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:34799 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfEMKOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 06:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1557742478;
        s=strato-dkim-0002; d=jm0.eu;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RV2nAPevilQVXczqJcsC0oxc+HiBNu3S8JXClGRtCgA=;
        b=P76wg49CDcvdd1f+T7xb191A5Y6RCvjTiJLniMfClTsx8B14rHnwEc+PbgTztvh8+u
        WGxnDW8sfE4Q9zsmmEqPADbDSkWM73RSG25R4G+oYXe9woOAzWPJPw3he4gIYA0TWtbH
        QGBrecB+YCxMRlYolsO9f+dpICHSfsXnE6/38fTkqOy+kRtI94XZyjN5bx2E/6Rz0dcf
        LrKnGVHD81VUKIvKvRjSeh3RNlbrswbVkb35GSRWAmuREtxFW9vk3Fd3e6+WuPFOvaVg
        qWMhZ29tfoNCq5mur6Yv26Up+TjPeQdRpp9TSoS5yAA9GLxFi8egwIm3lQylEUDF/wtj
        1RVA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPXvQCbXgI7t69COvtk81MihidtEo/aQAAqA=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.163]
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id y08c83v4DABSgEI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 13 May 2019 12:11:28 +0200 (CEST)
From:   Josua Mayer <josua.mayer@jm0.eu>
Subject: [PATCH RESEND v2 0/3] bluetooth: 6lowpan: multiple peers and
 addresses
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>, johan.hedberg@gmail.com,
        davem@davemloft.net, marcel@holtmann.org,
        jukka.rissanen@linux.intel.com, mike@foundries.io
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=josua.mayer@jm0.eu; prefer-encrypt=mutual; keydata=
 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
 Si21CLNeIbliI0CNR5kPUY1ntw1JCOmOjKZm
Message-ID: <86192f8a-0ec7-79d5-95a8-ebe040fc14fa@jm0.eu>
Date:   Mon, 13 May 2019 12:11:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190208152519.16181-1-josua.mayer@jm0.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

