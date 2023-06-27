Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491DEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 20:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjF0UDD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0UDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 16:03:03 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403CD1BEA
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 13:03:02 -0700 (PDT)
Received: from github.com (hubbernetes-node-5d7b63a.ac4-iad.github.net [10.52.206.37])
        by smtp.github.com (Postfix) with ESMTPA id 5D5431E1232
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1687896181;
        bh=ghczyVfnl22sk3nbBS7r3uVkiy3CXl9aidKRhJA/aAc=;
        h=Date:From:To:Subject:From;
        b=ZwU+D+Zdzjwl2gaX6YmFR6aRboWLJ/QwDil82VAnZ4QEeszkU5KVA6nbR/foi9OYg
         l54/6d0uuzOHXAlSkKvMFqRs52kMJFslDCx6ysc0cQYOE7wn4iY8UEXTF9v2vWaboN
         JDn7WTpRb/eg6o76sxycUbRr8zccxrdBa6IvQ55M=
Date:   Tue, 27 Jun 2023 13:03:01 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6b9d16-d6bfbd@github.com>
Subject: [bluez/bluez] d6bfbd: shared/bap: Fix parsing of vendor specific
 codecs
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
  Commit: d6bfbd28420edf91382635b229b9f8b2f94dc060
      https://github.com/bluez/bluez/commit/d6bfbd28420edf91382635b229b9f8b2f94dc060
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-27 (Tue, 27 Jun 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix parsing of vendor specific codecs

While parsing vendor specific codecs cid and vid fields need to be
converted using le16_to_cpu.


