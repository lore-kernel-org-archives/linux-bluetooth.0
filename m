Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E6AC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4253217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfRtFfo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeLSQve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so20256927wrw.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebCtbg09jV7xM4Rhy50eYt4ORbECDGVuZZM/YYUjJYo=;
        b=vfRtFfo1ge53ZYK7cOi0JseKlx05g9q+nvMibHZVx27q/bZyJ+5lF2rSfi2Mio8/gu
         /Jqz6rhDZxhkmjr2HelqJw+g/cfsC6d9lZMy5XX2ocWOYMVNOs9m7z4v+LDGGj2WRenH
         LgCISSSlJe8+O2GdrXmP0uQsKx4wqqLzRVIex/272tXYKId13WahxASDPEkJusRIaNRR
         TTKV5GcrsP3PBMuX7lvoKSLoG9DR5t2vmS8k7tx55NnaavGZ/hQgnTPbW/GJMhIbEbng
         WiO4P8TFPcu/7ZxhCvt+OZj1tE8NsQDeGvkKPvd6vuAwVftR+brUhXrSDjrXCUjqxG0C
         fDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebCtbg09jV7xM4Rhy50eYt4ORbECDGVuZZM/YYUjJYo=;
        b=RwP/tvsktO1+n91oJc9gtOwnugWnmBY4r+nXInWb8Os5mupvepnfiXBtni21nAG9l0
         KCsL2O9snml7EXl9iZ5SXBzP/D5lqy88+f8FfeBYziUjE2w5JseRGgmhbV9QrHV8GIzr
         r4bZuDgtN/e1/KqXFJeVr22NDjzlsl6tK1tQetBAyNyftf1X2hyOmkl77FtSsrebm2YC
         m0VVqbJljQoUz2JAbtYPTplDERR4PisEUvIYuTnDcllo7/4tLWVQ614Y4QnwPpeskvKR
         Ae2i1LgJIxotBfG55+P1vDO05O40kNPvUXPjE/C0bS+W7K+HLzYflWqz+EfjzAh5hIyu
         +68A==
X-Gm-Message-State: AA+aEWY9mBwojZ63XiKkHqPE9iX8l3HZ8bg3+QEWjff05Rw4/Eeq/joY
        SDN5rcTt5OMvvjOY/eQTb8/7rrImoFY=
X-Google-Smtp-Source: AFSGD/U9Ir87+3W+enyJasGkSH0fHyMqNBZtPzredyPPit7j6YvFBON9pf4QNPeA6saA9vU5l+Bttw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr18892172wrr.155.1545238291787;
        Wed, 19 Dec 2018 08:51:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:30 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] A2DP: Fix endianity and define new A2DP codecs
Date:   Wed, 19 Dec 2018 17:50:59 +0100
Message-Id: <20181219165109.29088-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
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

Pali Rohár (10):
  avinfo: Fix buffer overflow when parsing broken/malicious data
  avinfo: Show Vendor Specific Data
  a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
  a2dp-codecs: Fix codec id for ATRAC
  a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
  a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
  a2dp-codecs: Add needed includes and properly check for endian macros
  a2dp-codecs: Properly define macros and struct for LDAC codec
  a2dp-codecs: Add macros and structures for FastStream, aptX Low
    Latency and aptX HD codecs
  avinfo: Parse information about A2DP codecs: FastStream, aptX Low
    Latency, aptX HD and LDAC

 android/a2dp.c               |   8 +-
 android/avdtp.c              |   4 +-
 android/hal-audio-aptx.c     |  15 +-
 android/hal-audio-sbc.c      |  12 +-
 profiles/audio/a2dp-codecs.h | 256 ++++++++++++++++++++++++++----
 profiles/audio/a2dp.c        |   8 +-
 tools/avinfo.c               | 362 ++++++++++++++++++++++++++++++++++++-------
 7 files changed, 551 insertions(+), 114 deletions(-)

-- 
2.11.0

