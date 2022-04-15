Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17802C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 05:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiDOFTU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiDOFTU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 01:19:20 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DCEF13
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 22:16:53 -0700 (PDT)
Received: from github.com (hubbernetes-node-3f5a5f8.ash1-iad.github.net [10.56.128.15])
        by smtp.github.com (Postfix) with ESMTPA id 40EC884075F
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 22:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1649999812;
        bh=llGRKnbLKMDlrzRmLXVlvJqWUuCXuTDvDUXThzhs9k0=;
        h=Date:From:To:Subject:From;
        b=rrIrOfn5h5O8PCSGJsiZDixfivMK7MfO9xn17ZpLPNteGjJ4gaLY2pKpWvx1ENYZy
         knosZqkoC/gEBcC4RhVI3K0tQuz6FO6v2fviHiz0EWk1hrgp+8F5tJF+T9Cm7FVbbk
         8bktEZEuMK/7HM33iJjVMpJHPIhnGilnraBn83BM=
Date:   Thu, 14 Apr 2022 22:16:52 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7903bb-036024@github.com>
Subject: [bluez/bluez] 1967b5: btdev: Fix not cleanup ssp_status and
 ssp_auto_com...
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
  Commit: 1967b5311525846d94fca3a2a73f9efc743b0572
      https://github.com/bluez/bluez/commit/1967b5311525846d94fca3a2a73f9efc743b0572
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-13 (Wed, 13 Apr 2022)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not cleanup ssp_status and ssp_auto_complete

This resets ssp_status and ssp_auto_complete flags on auth_complete.


  Commit: dc1b309901e5a1af4fdb5dc36c4af87ea9f7fae3
      https://github.com/bluez/bluez/commit/dc1b309901e5a1af4fdb5dc36c4af87ea9f7fae3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-14 (Thu, 14 Apr 2022)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: Add support for Create CIS

This introduces bthost_set_cig_params and bthost_create_cis.


  Commit: f9f2b28d457a63aba3de85d930513b1a1990732c
      https://github.com/bluez/bluez/commit/f9f2b28d457a63aba3de85d930513b1a1990732c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-14 (Thu, 14 Apr 2022)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Fix not setting all parameters when using Create BIG cmd

Create BIG shall set proper values for interval, latency, rtn and phy.


  Commit: 03602479bd7bb3c32c718431b45441d03e6f9ce4
      https://github.com/bluez/bluez/commit/03602479bd7bb3c32c718431b45441d03e6f9ce4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-14 (Thu, 14 Apr 2022)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix CIS Established

CIS Established was using the ISO latency instead of SDU interval for
transport latency.


Compare: https://github.com/bluez/bluez/compare/7903bbe1005b...03602479bd7b
