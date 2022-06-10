Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 16:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349742AbiFJQin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349815AbiFJQif (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 12:38:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BA56F83
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 09:38:31 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0E8E6601721
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 17:38:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654879109;
        bh=izlEZaezL34zoWbfgV3pe1GA9MXTUm9qBX5V4+pslP4=;
        h=From:To:Subject:Date:From;
        b=MwlZgCXgyxtR8UfScEeE1Cq1P2Ay4WySFXE1UP66EA0uoAqcxhxwHuY+clqMTppUv
         5VM8+xQK5iE22sQEQ8bKxVHq8eJ57tXWyvp78hCX3GOEbv2BTlUDhudmHfw+KmXH4r
         H84/AwuQc0nzg1bVJzmcQNwX5x1yyJBYSy3A2QecvCTWCNduPUKjKdtp66QUH1ygtM
         TsFzrOoXNBsELH1GAT61N0mQtJv1Ehqa/ql9SSjB8ZSU+QtgLHVbPBSByYlgsLUy3F
         jxtSA5WrSuLCogIyIRxtZUL6CdhaUziizYDdFPXM1LXImlOQyJFuW+GadtEpDhUUvS
         IemKaGvhKLrzQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/4] test-runner: Add support for audio daemons
Date:   Fri, 10 Jun 2022 18:38:16 +0200
Message-Id: <20220610163820.79105-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Those patches add DBus session and an audio card so it should be possible
to start an audio daemon like PipeWire in the VM.

Frédéric Danis (4):
  test-runner: Add DBus session support
  doc/test-runner: Add audio config options
  test-runner: Add audio card support
  test-runner: Add udevd and trigger events

 doc/test-runner.txt |   5 ++
 tools/test-runner.c | 197 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 189 insertions(+), 13 deletions(-)

Since v2:
- move doc/test-runner changes to its own patch
- replace AUDIO_SUPPORT by TESTAUDIO to be consistent with the other
  parameters
Since v1:
- Fix checkpatch errors

-- 
2.25.1

