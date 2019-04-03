Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B8C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119432075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3JLdii+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCXIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:08:45 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41001 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCXIp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 19:08:45 -0400
Received: by mail-pf1-f179.google.com with SMTP id 188so320143pfd.8;
        Wed, 03 Apr 2019 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OI5Pfiuljbjg8N16CY0UEZq+me77JsNqRgDjS1uUSzo=;
        b=Z3JLdii+c9b4HkzEsc99LcFv4p0rbDwNKBhqnsCcXPXdvGuTxuwkWXR1Bxb+oJKFPc
         veMCnSWiKRCBBpJCUp20lQVRgerPGA/YWEb8svZOlTDZ2Z0LEdGskyewkxlb11MDAgGl
         /srwcdwCakes3bbHKE4RCHXXoEpZClp4/ROfLv8wFmhzwQyE3Jtn5Cdx9uPbSo7IJxGt
         pH0VTOvHvrVgOvsIua+JjDOYPNEBN1YgDj0c7IVaKPWOi6/+KWXHnG7QvVnmmiBCx7yk
         lnog6cNEUmwX6KGvmhRbhJrJE/23eI3nXz5sDSeRj23Db+puaUDGe9VJJGKp3ZMZQzVj
         Z8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OI5Pfiuljbjg8N16CY0UEZq+me77JsNqRgDjS1uUSzo=;
        b=Y0hhiAPWAa6ebDm1jTopFhuccqjA1b8GpQShghMwJ1ib+Nk5izB6o93vwH9oiS5ePu
         /gDlRxayT8kVl6ypyCzFKr4ibamUQ38dOJ5R5BMCi1aQ95NdyBmSKX1rXxZvpCqkwEck
         205Y7UycJnbNHJEIJn6QNNJURpELC+CaVCw1STxxoBhL9Id6Q1LNNil+Us8ceBYPdJhd
         HeW/hk/tiGlx5Ep9/jVQszdPlvwm8YseZ1a/XsjffmkPBxy7G3vc7YOYMcQrfCzE5Tl2
         oADguvFW6ZLwyh4oibyMUFZzISsieWI5CzRnHeBjssx5sAcgVTn2iBjFjMsX5Fpwns5H
         3ezQ==
X-Gm-Message-State: APjAAAWkQTm9HVOltIsE4sJE6EfxPbXM5U64VureXuEVN/n1FhZvbskT
        iv0CAE/0TqeVc9bNTFt4cpWwOl3k
X-Google-Smtp-Source: APXvYqxuaBd+zN2dNrvYs9fY8bYGxB1OXQJH7wex4sfwAW9OxWPq1pcnpMKcd9+O83nm0QsTAH3zpg==
X-Received: by 2002:a63:6941:: with SMTP id e62mr2236607pgc.99.1554332924272;
        Wed, 03 Apr 2019 16:08:44 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id a7sm23439574pfc.45.2019.04.03.16.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 16:08:42 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 0/3] bluetooth: validate packet boundary carefully
Date:   Wed,  3 Apr 2019 16:08:32 -0700
Message-Id: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset fixes the out-of-bound access in bluetooth stack.
Although it is large, all of them follow the same pattern, so
it should not be hard to review. I try to group them as much as
I can. This patchset should cover Dan's patch too.

Please check each patch for details.

(Resending v2 as it is lost in netdev mailing list.)

---

Cong Wang (3):
  bluetooth: validate HCI_EVENT_PKT packet carefully
  bluetooth: validate HCI_EV_LE_META packet carefully
  bluetooth: validate HCI_EV_CMD_COMPLETE packet carefully

 net/bluetooth/hci_event.c | 627 +++++++++++++++++++++++++++++++-------
 1 file changed, 520 insertions(+), 107 deletions(-)

-- 
2.20.1

