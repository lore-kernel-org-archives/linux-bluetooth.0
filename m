Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F9C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC58E21783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKx6OJDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeLWKkj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeLWKkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so9271592wrs.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UUOTCoemnyDLR/y2tiBS2/Nst6qwpbpf8sJneZr22i4=;
        b=nKx6OJDCDKh2+1Pe3/Ij4UWYzwnf4dQaNEBz+9mYAzlC2gH9/xkXTsUlkTC0bHbKbr
         tzGXP/Y4jYuZryIQNiRoqWJZOEwgDH1gyOtF7fehVWInVL8vK+eMLWpYvwR0d2g3m1Bu
         Bf3VeVVZ+N4i7Eiyq9uagZd29FBcl/3I+wEiEPlG8+xAgeToOAtcpiNFiWY0Zt0z7jMu
         CxTYllihGMm/06uA9OPZHLSIa/r+fSUiPFVtRLSXxNo+Oo4M4lv4NGaUiUgrdJGJ4PB/
         +XCwk3M6m6ZYS/N/kObtUDV3s2EU1QlYU8C5zbcziUN2ZbwyxfzaVMmeJePySM3TIu4f
         iu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUOTCoemnyDLR/y2tiBS2/Nst6qwpbpf8sJneZr22i4=;
        b=uGPE/nC35hzou07NT5pmqSestN6dQFxTRgX6mrgOjPcVmXLGZT43GqxWqGOcUAoMjQ
         HXH5zziYWSAca/qffbPtr+mRtUSc+iMTlkBkGQNlwgtRXnelQLBPaE3juJU1xJDnO0oC
         Ohqh+YE6w+LJtaFr4jQeCnC3tdHT+KA552+LgR5u8bdHjI3MZqdxnmjB43pu9qL4OBFR
         689M7KwX+LaF4o0VzcysVqEmX7RGbCgeQvRvSclOzbO5dTmHTbyBX1YVBzHzTKqd29FC
         qlsE9L/l3QtVA3u3c/e2LCcCkEQWJu6IuRcUddKw9NhWeohHOw+8k9Fk+CTQDG4me9hM
         y/8g==
X-Gm-Message-State: AJcUukftyWXEfQbEZXxZryCVuUkWTRFi9BXQwDM73GhcGAjzzbhEc0ax
        88MMEiFZv5qiZm3sN2QChxCDW2tou7g=
X-Google-Smtp-Source: ALg8bN6tP9cCXf/V2gFOYZtKhMKTrZnOtnPJIrbq/Wazf+F2Y4RNqB7GKEoePAV4NZjIf5PV6Go/bQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr8862730wrn.187.1545561634131;
        Sun, 23 Dec 2018 02:40:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:33 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/10] A2DP: Fix endianity and define new A2DP codecs
Date:   Sun, 23 Dec 2018 11:40:11 +0100
Message-Id: <20181223104021.18620-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series try to fix endianity problems in a2dp-codecs.h file,
then fixes parsing MPEG bit rate values, extend a2dp-codecs.h file for
new A2DP codecs FastStream, aptX Low Latency, aptX HD and finally adds
support for parsing information about FastStream, aptX Low Latency,
aptX HD and LDAC codecs in avinfo utility.

Changes since v1:
* Fix style issues

Pali Rohár (10):
  avinfo: Fix buffer overflow when parsing broken/malicious data
  avinfo: Show Vendor Specific Data
  a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
  a2dp-codecs: Fix codec id for ATRAC
  a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
  a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
  a2dp-codecs: Add needed includes and properly check for endian macros
  a2dp-codecs: Properly define macros and struct for LDAC codec
  a2dp-codecs: Add macros and structures for new codecs
  avinfo: Parse new A2DP codecs

 android/a2dp.c               |   8 +-
 android/avdtp.c              |   6 +-
 android/hal-audio-aptx.c     |  18 +-
 android/hal-audio-sbc.c      |  12 +-
 profiles/audio/a2dp-codecs.h | 267 ++++++++++++++++++++++++++----
 profiles/audio/a2dp.c        |   9 +-
 tools/avinfo.c               | 380 ++++++++++++++++++++++++++++++++++++-------
 7 files changed, 586 insertions(+), 114 deletions(-)

-- 
2.11.0

