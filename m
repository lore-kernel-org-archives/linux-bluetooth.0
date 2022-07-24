Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C34C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jul 2022 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiGXVSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jul 2022 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiGXVSI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jul 2022 17:18:08 -0400
Received: from smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4310FCE
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 14:18:08 -0700 (PDT)
Received: from github.com (hubbernetes-node-7dc6fac.va3-iad.github.net [10.48.125.31])
        by smtp.github.com (Postfix) with ESMTPA id AAAC05C0537
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1658697487;
        bh=H8QlTip7bLTks43l4+oHc4UrTXsnMNVZMd1ZOk1yTQM=;
        h=Date:From:To:Subject:From;
        b=P+Grl1jQoxxlRPsmpEgEOrH/yoDVyIi+88v5VCoLFnvfFg1LwOuerY/xlgn4X3Ms+
         n3LYOqCEhJy+jju7/Ool77LJrCqBwpnYq5vLMPhwlEateiS9Y21DRVRbwr3hhk9qnX
         Fl+0Ocnvc6HclU4v6mQ1B9X3I4yZYeHMd9p2o9U4=
Date:   Sun, 24 Jul 2022 14:18:07 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.65/000000-9ca140@github.com>
Subject: [bluez/bluez]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/tags/5.65
  Home:   https://github.com/bluez/bluez
