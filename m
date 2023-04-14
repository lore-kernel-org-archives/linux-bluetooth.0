Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E89C77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 23:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDNXPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 19:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNXPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 19:15:46 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9330D8
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 16:15:46 -0700 (PDT)
Received: from github.com (hubbernetes-node-4624538.va3-iad.github.net [10.48.130.39])
        by smtp.github.com (Postfix) with ESMTPA id 5D135340050
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1681514145;
        bh=BEgNmWBzmEYwJFPj8OyPAtQqKk+ZisiVMRsPt+iGdNY=;
        h=Date:From:To:Subject:From;
        b=DGPJAG27iLcjc1OXzeVHxN1ODFM/lD835Fws/DMLuf1tTiqjZ6QjlKQqCtTmLp0dV
         7HxXPWcoBasxyrb1m1bYowqCrHyUYH1PdgiMaUkNjnHAxnkjA1ofuhJxDcrn54EVze
         qo212De6Yn+y18ze/gkNXlgebEHukgFvvTPk2mxw=
Date:   Fri, 14 Apr 2023 16:15:45 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e122a0-4d197b@github.com>
Subject: [bluez/bluez] 57b679: btdev: Fix not setting CIS parameters properly
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
  Commit: 57b67987d4d88ce9b1485ce6e3943205fb35f9f2
      https://github.com/bluez/bluez/commit/57b67987d4d88ce9b1485ce6e3943205fb35f9f2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-12 (Wed, 12 Apr 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not setting CIS parameters properly

The code was assuming only index 0 was to be used which doesn't work
when there are multiple CIS being programmed with different parameters.


  Commit: 4d197b859e57a9101e26a9ff341dba3da32ebf77
      https://github.com/bluez/bluez/commit/4d197b859e57a9101e26a9ff341dba3da32ebf77
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-13 (Thu, 13 Apr 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add BAP Audio Configuration tests

This adds the following tests based on BAP Audio Configurations:

ISO AC 1 & 4 - Success
ISO AC 2 & 10 - Success
ISO AC 3 & 5 - Success
ISO AC 6(i) - Success
ISO AC 6(ii) - Success
ISO AC 7(i) - Success
ISO AC 7(ii) - Success
ISO AC 8(i) - Success
ISO AC 8(ii) - Success
ISO AC 9(i) - Success
ISO AC 9(ii) - Success
ISO AC 11(i) - Success
ISO AC 11(ii) - Success


Compare: https://github.com/bluez/bluez/compare/e122a0708896...4d197b859e57
