Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D995BC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC286650D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhCPQjw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:39:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43106 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbhCPQjh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 12:39:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id A82F21F44AEB
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH Bluez v4 0/4] adapter: Fix discovery trigger for 0 second delay
Date:   Tue, 16 Mar 2021 17:39:24 +0100
Message-Id: <20210316163928.27279-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When calling `StartDiscovery` the effective start can take around 10 ms or
up to 700 ms.
g_timeout_add_seconds() call doesn't ensure the time for the first call of
the timer if the delay is less or equal to 1 second.

v2: Fix issue found by CI
v3: Add a wrapper function for g_timeout_add_seconds and replace calls to it in
    src/*, profiles/* and plugins/*
v4: Fix issue found by CI

Frédéric Danis (4):
  shared/timeout: Add timeout_add_seconds abstraction
  src: Replace calls to g_timeout_add_seconds by timeout_add_seconds
  plugins: Replace calls to g_timeout_add_seconds by timeout_add_seconds
  profiles: Replace calls to g_timeout_add_seconds by
    timeout_add_seconds

 plugins/policy.c              | 91 ++++++++++++++++++-----------------
 profiles/audio/a2dp.c         | 17 ++++---
 profiles/audio/avctp.c        | 44 +++++++++--------
 profiles/audio/avdtp.c        | 61 ++++++++++++-----------
 profiles/audio/avrcp.c        | 13 ++---
 profiles/health/hdp.c         | 16 +++---
 profiles/health/mcap.c        | 21 ++++----
 profiles/input/device.c       | 33 +++++++------
 profiles/network/bnep.c       | 12 +++--
 profiles/sap/server.c         | 13 ++---
 src/adapter.c                 | 90 ++++++++++++++++++----------------
 src/adv_monitor.c             | 14 +++---
 src/advertising.c             | 28 ++++++-----
 src/device.c                  | 60 ++++++++++++-----------
 src/main.c                    |  7 +--
 src/sdp-client.c              | 13 ++---
 src/shared/tester.c           | 16 +++---
 src/shared/timeout-ell.c      |  6 +++
 src/shared/timeout-glib.c     | 27 +++++++++++
 src/shared/timeout-mainloop.c |  6 +++
 src/shared/timeout.h          |  3 ++
 21 files changed, 332 insertions(+), 259 deletions(-)

--
2.18.0
