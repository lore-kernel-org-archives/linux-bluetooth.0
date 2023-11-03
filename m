Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55837C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Nov 2023 18:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjKCSWD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSWC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 14:22:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFBAD42
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 11:21:59 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SMTbj5KGyz9t0M;
        Fri,  3 Nov 2023 19:21:53 +0100 (CET)
From:   =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To:     linux-bluetooth@vger.kernel.org
Cc:     zbrown@gnome.org, =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 0/4] Fix an allocation oversight in SDP parsing
Date:   Fri,  3 Nov 2023 19:21:46 +0100
Message-ID: <20231103182150.60088-1-verdre@v0yd.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SMTbj5KGyz9t0M
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There's fairly old oversight in the SDP parsing code where it was forgotten to
add a NULL termination byte to strings that are later handled using strlen().

This series fixes that oversight, with a few commits to better follow best
practices on top.

Found by running with address sanitizer.

Jonas Dreßler (4):
  lib/sdp: Allocate strings in sdp_data_t with NULL termination
  lib/sdp: Don't assume uint8_t has size 1
  lib/sdp: Use correct string length in sdp_copy_seq()
  lib/sdp: Pass size_t to sdp_get_string_attr()

 lib/sdp.c     | 15 ++++++++-------
 lib/sdp_lib.h | 14 +++++++-------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.41.0

