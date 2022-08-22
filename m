Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8EC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 23:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiHVXVl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbiHVXVd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 19:21:33 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C420D564DA
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 16:21:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1661210488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oxeDD6XMRAHMm4m+AX+BaZsEtu3GXOKkMCy48j/pNk=;
        b=tjTART7mFLBPk44JhUupMWG/z7gmFy8Yv0J1AW26j3sCbVpL75t+BwKRMJtAyiIHjPPp/C
        OEMh7gQwtd4UjxagyU+WB2G80+mtgQTU2Z7SNHm6zqyPEHXgiOkMGPG+jk9k7jaa+dewSk
        GP2Z7P0m3PRHtcblRKBqc/Aub9rE6f4=
From:   Ronan Pigott <ronan@rjp.ie>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] zsh: drop no more arguments message
Date:   Mon, 22 Aug 2022 16:19:10 -0700
Message-Id: <20220822231909.45606-1-ronan@rjp.ie>
In-Reply-To: <CABBYNZLe2ZhgQUVs3nN_7mVxnm90n31NhUMXF7mzqUsko96-3w@mail.gmail.com>
References: <CABBYNZLe2ZhgQUVs3nN_7mVxnm90n31NhUMXF7mzqUsko96-3w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: rjp.ie
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This usage of the _message as a completion function is invalid, and
will result in an error if invoked by _arguments when the user has a
format style set for completion messages.

We can just drop this message, since it is not necessary.

Before:
  $ zstyle ':completion:*:messages' format '%d'
  $ bluetoothctl connect <TAB>
  _message:zformat:42: invalid argument: -J

After:
  $ zstyle ':completion:*:messages' format '%d'
  $ bluetoothctl connect <TAB>
  31:41:59:26:53:59  -- Bose QuietComfort 35
  11:22:33:44:55:66  -- Pixel 5
---

Included an example of the erroneous output and style setting

 completion/zsh/_bluetoothctl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
index bf35e503e..610ca2b8d 100644
--- a/completion/zsh/_bluetoothctl
+++ b/completion/zsh/_bluetoothctl
@@ -68,8 +68,7 @@ _bluetoothctl() {
 		'(info)'{-m,--monitor}'[Enable monitor output]' \
 		+ 'command' \
 		'(info):command:->command' \
-		'(info):: :->argument' \
-		': :_message "no more arguments"'
+		'(info):: :->argument'
 
 	if [[ $state == "command" ]]; then
 		_describe -t commands 'command' all_commands
-- 
2.37.2

