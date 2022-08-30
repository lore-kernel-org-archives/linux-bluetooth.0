Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E6ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 14:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiH3Or7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiH3Or6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 10:47:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2430CAC43
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 07:47:55 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 626D46601D85
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:47:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661870874;
        bh=yBLLzM38LyUdbeZVO1SWqH9gshr9zWyT818gF127xvg=;
        h=From:To:Subject:Date:From;
        b=RjiQawwcgU6Zj1QsvxilveC1qWmBHvVMG2ZKUDrrx5Fn0zhpip4HNEhbCaMy0YkzW
         f3hx/vecD5agWAzNWUktyjEGfkdqk3KoiqeLjaKaUwg/6d/tm2b67UntitTRy/h5eX
         xAC2c2ZhTt0lraOuR71RxfV0jtOZNQFmZvnQhBFgB4gNzivPPFljtc6gQyy1eUV2C2
         1ZoWwS+QAckbod2olVtxEF2O5OPEJFGWbfMDKdOJTSUOWxTODm4AmXtLktjd+2SWj3
         bwTZszqVZZ+6RFzsTS6R4roFi7vrvaJMzM8uKk5oNOz1XbzsyPNFwfTRm3NNlO9nx3
         u9onaH7iZePzA==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] profiles: Add remote endpoint path to SelectProperties
Date:   Tue, 30 Aug 2022 16:47:31 +0200
Message-Id: <20220830144734.55263-1-frederic.danis@collabora.com>
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

Changes in V2:
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

