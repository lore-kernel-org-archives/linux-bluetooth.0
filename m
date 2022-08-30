Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54888ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 20:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiH3Uy0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiH3UyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 16:54:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F486710
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 13:54:22 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 575C966017ED
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 21:54:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661892860;
        bh=XOPQVw8xgvGp0EXhaVo7if00Q7OzQNQZHNmeXZqlQKc=;
        h=From:To:Subject:Date:From;
        b=i3p64yJWqszZJuq5BlxNhkKp8jgddwNNNnF56dX7LlsGFUeDNBxlc7RKkb4dyKjj0
         +AJuLl/S15gsYB/SMK3UQ2fkzxBNrVqsehlWrAAelUHd5j7JSoRdsNQT50Yqjy90YU
         1yOz/aY2ZhwBIv5my1vTxqFdtbkpWONn3ADirIm2YLWImVEC+mAIWajp2SMCgF8pTS
         emxDya0DOzAfDRcvA/SA5YuHvjZGTFQjzOOeXio6g4HhdkE0hORzJ9gzIEcY2+f+UW
         EhKPojhCbu8SnC8/e5dg19Q1sEuhSCj+46mfRBfyWexb2BuiFrNLIEUT2jApmAvznH
         dtj2uM/YZel8g==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/3] profiles: Add remote endpoint path to SelectProperties
Date:   Tue, 30 Aug 2022 22:54:08 +0200
Message-Id: <20220830205411.68299-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The SelectProperties method is only called on the central (initiator)
device. But there's no information related to the remote device for which
is call is done.
These commits allow the audio server to link this call method to the
appropriate remote endpoint.

Chnages in v3:
- Fix GitLint issue

Changes in v2:
- Set endpoint part of the dictionary properties
- Pass rpac to select function instead of DBus specific path
- Add a new commit to keep consistency after fixing previous
  patch for a checkpatch warning

Frédéric Danis (3):
  profiles: Add remote endpoint path to SelectProperties
  doc: Add remote endpoint path to SelectProperties
  profiles: Fix function definition style

 doc/media-api.txt      |  6 ++++--
 profiles/audio/bap.c   |  2 ++
 profiles/audio/media.c | 15 ++++++++++++---
 src/shared/bap.c       | 12 +++++++++++-
 src/shared/bap.h       | 11 +++++++----
 5 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.25.1

