Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F3AC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99D206F8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F472nuT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDFLtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:49:00 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:38910 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDFLtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 07:49:00 -0400
Received: by mail-pj1-f74.google.com with SMTP id l12so14010495pjh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JFPo/1rvuFK+mgvdnctPIQYZT6lfRybB1suSP7skuPM=;
        b=F472nuT8ic6aJCOEK9+M30kaU/tVB6jJlC3sUxzuuYH3ctW94TJVXrK5qcoHI8x950
         MtuYE5CZqUGgYVPES3hkjPqsfbcLZE4glftla0c+wPoI27JvxqlqpJYMFdKl1jkRAkIc
         3tIHkVQkRXKOG32JmYfgZZ7JfSXA+NONNe+biodRJktEzkt+Kx7c6hXBVGywXfSo6vC6
         Vdp3GxT8JLfVTmVyuKlB7O/4fvMPpUDoB1aHLkeYkaprz84jeS6DpBPbOLC2LphGD/8H
         fJLFLVjiCNh55mXdNqoYNJ4XgM2jXM9rGRHZ/7/VavMF7ixJQCeWAPKjsw2Pdk/7k210
         662Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JFPo/1rvuFK+mgvdnctPIQYZT6lfRybB1suSP7skuPM=;
        b=baX161J8sYOWS5cr5Crau7GX61qRmr98TGSH1auv8qblezrmafqtvu+T+8TMIdZ9Gn
         rgGynyIm5nKwk5vjo7/LzZO7pEWwpJN7L5Fz+U6+ac/NgRDL9Dxg5uEuN/nlGPxj130u
         89zgCgHdIAt6yZ+0NUPDu+kkN2Fj+t/i1sMFyG0JwR1zGU5dsn7pJ2eq9NSbHQFCv7JX
         RLjiDZniw0W75f2pJSupQjOO/IhpaL06/viYIvy8aBoY6UUreA7IbvB1p0IBzI95vtTY
         luvpJfQkdTI7qyFappvZLt2mZI2qQ/X2VNV29P0P2ChuaMSIu2XQIKBqc3QYFkn4MuX+
         ACVw==
X-Gm-Message-State: AGi0PubvA1ihHPv5K6yChH+PJNd4zVo3iJv1THNqGW9DCfJ6m0v9SgoH
        fIW8a65Ml+IujK3u+XGOifLwiSbt312LDpSoZMTGtMsX4NfAaCdBFGD0hP4J8VGVzkyRLYCkwsh
        g2Kq0j1xend4jp0vIZwJG/IIg1CEYiTXPB3z5OhFwpx9+LfjMKUr6yBLg0GEowrKL04W56p7RLH
        VH
X-Google-Smtp-Source: APiQypIi3G+MNGTSGiImCp7GZTiz8jVzqTuwv02SK3HubHnzx0pvfxY1ySS17S5w0SUZsPuUD5ufg+Yknb1l
X-Received: by 2002:a63:81c8:: with SMTP id t191mr21046750pgd.124.1586173737251;
 Mon, 06 Apr 2020 04:48:57 -0700 (PDT)
Date:   Mon,  6 Apr 2020 19:48:42 +0800
Message-Id: <20200406114845.255532-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v3 0/3] Check the signature of att packets
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
A device receiving signed data shall authenticate it by performing
the Signing Algorithm. The signed data shall be authenticated by
performing the Signing Algorithm where m is the Data PDU to be
authenticated, k is the stored CSRK and the SignCounter is the
received counter value. If the MAC computed by the Signing
Algorithm does not match the received MAC, the verification fails
and the Host shall ignore the received Data PDU.

Currently bluez ignore the signature of received signed att
packets, as the function bt_crypto_sign_att() only generates the
signature, and not actually make any check about the genuineness
of the signature itself.

This patch also fix a wrong boolean condition which prevents
handle_signed() to be called.

Tested to pass these BT certification test
SM/MAS/SIGN/BV-03-C
SM/MAS/SIGN/BI-01-C

Changes in v3:
- Add check for the case where pdu_len < ATT_SIGN_LEN
- Add unit test
- Separate into three patches

Changes in v2:
- Move the signature verification part to crypto.c
- Attempt not to copy the whole pdu while verifying the signature
  by not separating the opcode from the rest of pdu too early, so
  we don't have to rejoin them later.

Archie Pusaka (3):
  shared/crypto: Add bt_crypto_verify_att_sign
  unit/test-crypto: test for bt_crypto_verify_att_sign
  shared/att: Check the signature of att packets

 src/shared/att.c    | 25 +++++++++----------
 src/shared/crypto.c | 28 +++++++++++++++++++--
 src/shared/crypto.h |  2 ++
 unit/test-crypto.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 15 deletions(-)

-- 
2.26.0.292.g33ef6b2f38-goog

