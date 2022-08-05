Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACE5C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 01:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiHEB7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 21:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiHEB7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 21:59:07 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CF18B2E
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 18:59:06 -0700 (PDT)
Received: from github.com (hubbernetes-node-779a434.ac4-iad.github.net [10.52.12.69])
        by smtp.github.com (Postfix) with ESMTPA id 029CE600638
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 18:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1659664746;
        bh=2arBE/kxrtaSi2tdcQAr5hy33p/7Ouysqlw475mprKo=;
        h=Date:From:To:Subject:From;
        b=XNmLtpnln3FbPVDZNWNNTaotnA/bP6b9UcVcOqEYd4E0s/zJP1mZhKvIUOJr2i23B
         yMCiCtkHzcyjjqP/x0t7EdlyiyKCflfjkYmtVVS/dT1SGXmRvqh/wvfjGIcBUmF5Am
         +7HeNnJfxL7kdTfJ4/0PhJbS1t362HDs4kMvRW34=
Date:   Thu, 04 Aug 2022 18:59:06 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d9497e-e7fc74@github.com>
Subject: [bluez/bluez] e7fc74: build: Fix make check failing
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
  Commit: e7fc74a5dd1b4858df1c0127ea78bb65eeb2e01b
      https://github.com/bluez/bluez/commit/e7fc74a5dd1b4858df1c0127ea78bb65eeb2e01b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-04 (Thu, 04 Aug 2022)

  Changed paths:
    M tools/valgrind.supp

  Log Message:
  -----------
  build: Fix make check failing

This fixes make check failing because lack of suppression for bind on
bt_log_open.


