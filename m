Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250EBC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCKAjQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCKAjI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:39:08 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D91135CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:39:01 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DDBFF20081;
        Sat, 11 Mar 2023 01:38:55 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v3 0/3] audio/avrcp: Determine Absolute Volume support from feature category 2
Date:   Sat, 11 Mar 2023 01:38:23 +0100
Message-Id: <20230311003826.454858-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes since v2:

- New patch to guard target-less SetAbsoluteVolume calls with main.conf
  config;
- New patch to more strictly require category-2 _and_ peer CT/TG 1.4;
- Use main.conf to relax 1.4 version constraint for TGs registering
  AbsVol notifications;

v2: https://marc.info/?l=linux-bluetooth&m=163519566912788&w=2

I'd rather revert 179ccb936 ("avrcp: Set volume if volume changed event
is registered") entirely, paired with additional checks in common
codepaths for controller and target not being NULL when sending and
receiving control messages respectively (which then don't need to be
double-checked in the AbsVol codepaths for example).

Marijn Suijten (3):
  audio/avrcp: Guard SetAbsoluteVolume without target behind config
    value
  audio/avrcp: Only allow absolute volume call/event on category-2 peers
  audio/avrcp: Determine Absolute Volume support from feature category 2

 profiles/audio/avrcp.c | 53 ++++++++++++++++++++++++++++++++++++------
 src/btd.h              |  6 +++++
 src/main.c             | 21 +++++++++++++++++
 src/main.conf          | 12 ++++++++++
 4 files changed, 85 insertions(+), 7 deletions(-)

--
2.39.2

