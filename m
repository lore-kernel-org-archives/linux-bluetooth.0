Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1CFC2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA862074F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aofYEHqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGI4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:56:18 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39466 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGI4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 04:56:18 -0400
Received: by mail-qk1-f201.google.com with SMTP id a21so2493709qkg.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MsletKaS9d38EHgVig7lT8fVNs9FCtETCC+O92XYQKc=;
        b=aofYEHqwgI1ki+uweyFbtZh9+Edg1qkGZwlDx9hcnNEOCT8i6prY8DfW6Kf4ocrZht
         X9AxdITpr56vdGak7/WH0Q/tVcyRlbQVCjiqaCudFWQxvkABLy0MXx8p7v8ZmKikw/0L
         30kq9wwVg2EYxU7GzoTaXn2rDz/kmK1G0PDRnhh8e0QvDEdQpncuVgjsuJvM+Li35Hk8
         3e2EJxjQYtQoO3HLGd8BCqeE8hK/a2noAaL8c6X/XjM6qiJU2vEKB+H9QaslkM8NNSUf
         CgCgeFwJuEuLqCKAqxqtOD5UgfYMWa0dB5Hh4F0sxT/XzVsA2Q1Bz4eYnsuv/Awsy9+b
         Xmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MsletKaS9d38EHgVig7lT8fVNs9FCtETCC+O92XYQKc=;
        b=PeS9sCbr75ycCOQW0CHg6F4W8pI8QlZwd79lKx5QRx4ELrgno1eP1NryYTUsJU7QTE
         saapJ6jPDOmlkG4ky6xOEwbDEArqq95Yb1cKdpMFH8h7Rw6hBecCtJ6b/9lsibAs8Q4N
         ZW18kV03z4+5fRSufUtF8DOshraB74VtvM2i+xyk6nS17MFj3jPMAzbh9YFk70SvoxY+
         z+7R1hsW+HiBKSLnUvyS0qB9tWA7Jxucj4+pfVHRy9oxzUSaFMrOTa0w+UrQBicXLK3R
         eLIFZk8Y3+wMsTYlmeNDYgu6TM56tWqpBaXSwQM1p85raFJpaAr7MKkUGU+awXovc9Zj
         iuig==
X-Gm-Message-State: AGi0PuYdn1MDPGWlaLA2J9qBnrOmiRipYYm2XA7yDwbJ7VxFGBEkTJI7
        eiCYrYYCzAGgfcX49ZEimmcJ2SuslyZFRYlGA8Tq7182v7tCsHlJqqPyJ6kk1sjRg99cJ7fpm/i
        Zs1pUD+gNE/i2Xma15sw8d/Kafy2pNw73N5K9B+Sf6m3/Y0Qzsa3way02xls1UixjcPMHcPVq2Q
        CT
X-Google-Smtp-Source: APiQypLBaLzbcnB2BaOX44/ob0K4WMUxBXmHNcqImJjGdtGti6q0oUpKRGCJTQklu/cbwSg5I1kdB04gBHc5
X-Received: by 2002:ac8:7752:: with SMTP id g18mr1172115qtu.125.1586249777280;
 Tue, 07 Apr 2020 01:56:17 -0700 (PDT)
Date:   Tue,  7 Apr 2020 16:56:06 +0800
Message-Id: <20200407085610.231013-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v4 0/4] Check the signature of att packets
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

Changes in v4:
- Fix wrong variable assignment
- Fixing test-gatt.c

Changes in v3:
- Add check for the case where pdu_len < ATT_SIGN_LEN
- Add unit test
- Separate into three patches

Changes in v2:
- Move the signature verification part to crypto.c
- Attempt not to copy the whole pdu while verifying the signature
  by not separating the opcode from the rest of pdu too early, so
  we don't have to rejoin them later.

Archie Pusaka (4):
  shared/crypto: Add bt_crypto_verify_att_sign
  unit/test-crypto: test for bt_crypto_verify_att_sign
  shared/att: Check the signature of att packets
  unit/test-gatt: Fix unknown request with signed bit

 src/shared/att.c    | 25 +++++++++----------
 src/shared/crypto.c | 28 +++++++++++++++++++--
 src/shared/crypto.h |  2 ++
 unit/test-crypto.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++
 unit/test-gatt.c    | 32 ++++++++++++++++++++----
 5 files changed, 126 insertions(+), 20 deletions(-)

-- 
2.26.0.292.g33ef6b2f38-goog

