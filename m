Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C79C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21A220665
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="fLd39qFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGFQBP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 12:01:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:14445 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGFQBP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 12:01:15 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jul 2019 12:01:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562428874;
        s=strato-dkim-0002; d=jm0.eu;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=6A+A7RtPXKT9lfoWXn+Z8yfXxqnoLl9US9gfNIPpQwA=;
        b=fLd39qFdTpow26ZHcCNB3g8a3jBHnIFfjR80xN04/8mMjKZSDR8fhDM40cGxU/NUjI
        lRhJChqPUhAuGu4kZUJxEwLPF7hcKJ1Jwlmjhpb2D+7qYdIY+MLf+AeJ4nl6Z6xk1HKc
        MqKthle+B0VR6iKmxOag88eQn5Iv+Ys97L8ExHnLSQqXurh4fuZrp5T3rOzCRVNlny0s
        0u8IspefBXiz8oC2RKqce5LFbFOryIlTfpkcV1ron+wa/AoxUobXPm6kC1b90ly5d2xL
        vrJN9ss6Lg1coa4cOz2UOzjQGLQGEWDULQ2F61G5Si4KZYfXwzkl9rrBH88LR9sq+nqe
        lLOQ==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBaXaSiaF5/mu26zWKwNU"
X-RZG-CLASS-ID: mo00
Received: from linux-1tvp.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id h0a328v66Fsw6Ox
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 6 Jul 2019 17:54:58 +0200 (CEST)
From:   josua.mayer@jm0.eu
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>
Subject: [PATCH v3 0/3] bluetooth: 6lowpan: multiple peers and addresses
Date:   Sat,  6 Jul 2019 17:54:45 +0200
Message-Id: <20190706155448.13382-1-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.16.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Josua Mayer <josua.mayer@jm0.eu>

This patch set deals with an issue I reported earlier this year, where
1) packets addressed to a non-link-local address
2) any packets when at least 2 peers are connected
were not delivered if they matched a direct peer i.e. no routing.

The full explanation of the issue including steps to reproduce are:
https://www.spinics.net/lists/linux-bluetooth/msg78486.html

Changes since v2:
- rebased on bluetooth-next

Changes since v1:
- changed comment style to c++

Josua Mayer (3):
  bluetooth: 6lowpan: search for destination address in all peers
  bluetooth: 6lowpan: check neighbour table for SLAAC
  bluetooth: 6lowpan: always check destination address

 net/bluetooth/6lowpan.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

-- 
2.16.4

