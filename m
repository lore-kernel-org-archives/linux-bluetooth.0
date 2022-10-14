Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F720C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Oct 2022 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJNUvQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiJNUvP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Oct 2022 16:51:15 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217018D44F
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 13:51:14 -0700 (PDT)
Received: from github.com (hubbernetes-node-5c9502f.ac4-iad.github.net [10.52.208.87])
        by smtp.github.com (Postfix) with ESMTPA id B9DD56003FE
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1665780673;
        bh=fxbL6faJ9PMMrIIFpIqqWsZpxBe5uHw160PX67yiEY4=;
        h=Date:From:To:Subject:From;
        b=MalZOQdb6ikHZjsR70VnbQks8MHI9lfbIHz3bQ4oNnGKN6GHTmZ0xe3Xj2Y9xxbD7
         8T9Sw+XQ1NMNaxIi7/F+Y/5megKUFpS3xjzkD/G9Dr/qdmlfDPjPU/RGaVhz+od4li
         WyruSio1VycUJvuAJSLVNE9kqzuk1qyfNKA2yAKo=
Date:   Fri, 14 Oct 2022 13:51:13 -0700
From:   Tedd Ho-Jeong An <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5f0647-1096a9@github.com>
Subject: [bluez/bluez] 1096a9: monitor: Fix incorrect vendor name for vendor
 cmd ...
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
  Commit: 1096a99cadfa995ad22311a3c53620a2d9a9008f
      https://github.com/bluez/bluez/commit/1096a99cadfa995ad22311a3c53620a2d9a9008f
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-10-14 (Fri, 14 Oct 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix incorrect vendor name for vendor cmd and evt

This patch fixes the issue that the vendor name for all vendor HCI
command and event are display as Microsoft.


