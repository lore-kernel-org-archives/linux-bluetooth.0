Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19689C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJSUt4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiJSUtz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 16:49:55 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7936DAD5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 13:49:44 -0700 (PDT)
Received: from github.com (hubbernetes-node-4109849.ash1-iad.github.net [10.56.15.43])
        by smtp.github.com (Postfix) with ESMTPA id 4E0848400E7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1666212576;
        bh=mT1Vo3b1iJ9cIXRlFHt/fh+feZ9KdvnZEYP3NUccLgY=;
        h=Date:From:To:Subject:From;
        b=x0mII04u9uYxMQY2/EhzfiiokDGDYGFUWLzkolk7RsCTh+u6ebwlng+4gnrGfL7yu
         PE0i3XLF7wP8fDfDRg4+FhsIYaATO4nD+yi1fpBK6efBj6OxQjIi4Gg9ftFRJMPT4I
         mW2vIBm4YloIvJ43PoFWrU5dYdpij2VKCEfnc3sk=
Date:   Wed, 19 Oct 2022 13:49:36 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/07fd4b-68155e@github.com>
Subject: [bluez/bluez] 9c739b: settings: Fix scan-build warning
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
  Commit: 9c739ba22f094496381a6bce88ed4c118ef020b9
      https://github.com/bluez/bluez/commit/9c739ba22f094496381a6bce88ed4c118ef020b9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M src/settings.c

  Log Message:
  -----------
  settings: Fix scan-build warning

This fixes the following warning:

src/settings.c:281:7: warning: Branch condition evaluates to a garbage
value [core.uninitialized.Branch]
                if (ret) {
                    ^~~


  Commit: a49b47f241ce0e28f721efaaf821b79e33a44b31
      https://github.com/bluez/bluez/commit/a49b47f241ce0e28f721efaaf821b79e33a44b31
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Detect cache changes

This attempts to detect if the were any changes on cache files since
they were last loaded and then attempt to reload them.


  Commit: 68155e2f7e66c92617696f4731a7422a19f5bb0a
      https://github.com/bluez/bluez/commit/68155e2f7e66c92617696f4731a7422a19f5bb0a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Revert treating Notification/Indication as a request

Notification/Indication shall be treated as response (rsp=true) so the
correct database is used:

> ACL Data RX: Handle 3585 flags 0x02 dlen 14
      ATT: Handle Value Notification (0x1b) len 9
        Handle: 0x002a Type: Report (0x2a4d)
          Data: 0000feffff0000


Compare: https://github.com/bluez/bluez/compare/07fd4b948251...68155e2f7e66
