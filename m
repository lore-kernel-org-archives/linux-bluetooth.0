Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6DC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453DC218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="VKkw2dqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGCLmV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:42:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 07:42:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so2029266wmj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7suNSuFecN6+RaBgJkcQ/TiiVf/sK5y0xE3pl1MfEU=;
        b=VKkw2dqwNF740EnZ8TwgwfNZKVM6fkc6kfX6ycsUgju/taIsyWZcgNeUO/EF1U23FG
         86lTdO3cmBeijD11JrDdszvGhIRccTc/0q4fOUXWupmbG6v9bu8RQJaKfZVDZ1ylwVrW
         FOMk4wKjYwJaaAGQI1U0wLEy7hfZQjMJUKUrg6UgmDxBJJZ7R0VghcErDCKFg4YqBgWM
         FZOTzs7kX0SyoG95VVoAQC+yOOcE+x5KeSneuLO3o/+16bq6Rg0uKH7IMOAABGGioco7
         oVsUSIsNxckZLgX7Vv1q5qBiTOSc4Q6XIAHntn/QCZvW6iKLu+x6hbI/ovNf2D6StuMQ
         2w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7suNSuFecN6+RaBgJkcQ/TiiVf/sK5y0xE3pl1MfEU=;
        b=if+VN2uTUMFFtRRBPbd0MMZS5cSbOSRjElfkFmh+Mk1zlTRJp+cRJQVLQIPz3rtbv+
         /3imUgkFKNx87XIGMglBUJReQq0PvH1sjPSsesmX/mBK2R36sq4Ba0TT7jEn7ziTRrOQ
         b+MoAJgVJ4LhDdt6EYxB9SKSnoOPrIQFmknEKkXGg/QUOb+RBwV5o9MyrCuktxkhbz53
         xmjA22RydfF/ubBgzU7CuUCLuq2C+pIP22MohmNjhFA3g+Qwt7xev4nY17COLpkBpMOt
         A5movt5/H6l2MDPitn400blX2KWDUWidsVVhTczqxI59t/+y3YnVhdFlzpubPXrYEGfY
         kGVw==
X-Gm-Message-State: APjAAAX2Ek9SpAubpu2GGH7R9PzHB+5uHXk4MY2snNOHrqIO2qS6HB/5
        GqU4tkXPyU0J+XsyOsLNhY+C5yHg5Qc=
X-Google-Smtp-Source: APXvYqwFsY2iNP5MDN6Vq+VE7UJFucLCimRx/YWOINxt0UWnZnvILyzz+Zlo4y9c1H8lXDfZckyU0A==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr8254302wmk.127.1562154139141;
        Wed, 03 Jul 2019 04:42:19 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x6sm2556816wru.0.2019.07.03.04.42.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 04:42:18 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/3] Add possibility to use remote device keys
Date:   Wed,  3 Jul 2019 13:42:11 +0200
Message-Id: <20190703114214.22320-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Fix build/checkpatch errors
+Remove unused APP_IDX_NET and APP_IDX_ANY
+Fix handling of incoming packets marked with APP_IDX_DEV_REMOTE


This patchset adds support for sending and receiving messages encrypted
with remote device keys.

This plugs a 'leak' in the API where it was possible to exchange such
messages using Send()/MessageReceived() API by using 0x7fff app key
index.

In order to allow the application to receive responses from a local
Config Server model, messages originating from a local node and
encrypted using local device key are also forwarded to the application
via D-Bus (assuming they were not handled by one of internal models).

Michał Lowas-Rzechonek (3):
  mesh: Split APP_IDX_DEV into APP_IDX_DEV_LOCAL and APP_IDX_DEV_REMOTE
  mesh: Implement DevKeySend() method on Node interface
  mesh: Handle messages encrypted with a remote device key
*** BLURB HERE ***

Michał Lowas-Rzechonek (3):
  mesh: Split APP_IDX_DEV into APP_IDX_DEV_LOCAL and APP_IDX_DEV_REMOTE
  mesh: Implement DevKeySend() method on Node interface
  mesh: Handle messages encrypted with a remote device key

 mesh/cfgmod-server.c | 15 +++----
 mesh/model.c         | 98 +++++++++++++++++++++++++++++++++++++-------
 mesh/net.h           |  8 ++--
 mesh/node.c          | 59 +++++++++++++++++++++++++-
 4 files changed, 152 insertions(+), 28 deletions(-)

-- 
2.19.1

