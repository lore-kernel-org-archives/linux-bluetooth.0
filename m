Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B7CDB474
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Oct 2023 01:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJUBJg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 21:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUBJf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 21:09:35 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F19F
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 18:09:33 -0700 (PDT)
Received: from github.com (hubbernetes-node-15a5d0f.ash1-iad.github.net [10.56.14.13])
        by smtp.github.com (Postfix) with ESMTPA id B90E8341191
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 18:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1697850572;
        bh=1oD5ZpfzjoMCCBRGVHp9zIUZgLayJCaBanMYw0Wd1DM=;
        h=Date:From:To:Subject:From;
        b=aFsijClb3jsrIWd0rDPtL0rrrQNo4Ibfj0nRCGQRck2CCW5T9JruONxnp9xeQ9/J3
         Len5SfAp3u7Lj5YnxBPsRDXWsStx+IlFzAR3pPjjwKC6Il0mrF9D/kKC0DwLm65WT/
         aIGnDv/0iyY+Y9nTazMZQOmLXbtCARxPDhSKEHhs=
Date:   Fri, 20 Oct 2023 18:09:32 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f02e0c-e126cf@github.com>
Subject: [bluez/bluez] 5fd6d8: shared/bap: Remove Locations, Support Context
 and ...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5fd6d8cf905b790b30ff672c450b7e5c34238eda
      https://github.com/bluez/bluez/commit/5fd6d8cf905b790b30ff672c450b7e5c34238eda
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Remove Locations, Support Context and Context defines

These values shall come from the upper stack.


  Commit: e126cf204907bb98f8b60d23bcb3dfa46064b9a3
      https://github.com/bluez/bluez/commit/e126cf204907bb98f8b60d23bcb3dfa46064b9a3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Add support for setting Locations, SupportedContext and Context

This adds proper defaults for Locations, SupportedContext and Context
properties since bluetoothd no longer automatically set proper
defaults.


Compare: https://github.com/bluez/bluez/compare/f02e0c8664a6...e126cf204907
