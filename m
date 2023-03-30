Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDAC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjC3STn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3STm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:19:42 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74318E3BD
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:19:41 -0700 (PDT)
Received: from github.com (hubbernetes-node-50bb8f4.ac4-iad.github.net [10.52.138.36])
        by smtp.github.com (Postfix) with ESMTPA id C0FEA520492
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1680200380;
        bh=FdKKBjFPZRyWDq5kKJ54PF/63mmXi9mdd6dRO8QwkMk=;
        h=Date:From:To:Subject:From;
        b=FF76tiXJVV+Rq6+RMXQ4VDMYbQie0OmxL+5+8asqluE91qwJi1bWDKESxdQCuDwe6
         WsjYPKUADWIXFCYmxOO0RYgW5GXnr/lUou54iK3wgXgThPorRH8GXJgfhcwBEmka59
         nHwWuvyB/EQ+oR4ukTuALaDd5CM2aI8+siBJExA8=
Date:   Thu, 30 Mar 2023 11:19:40 -0700
From:   liveusr <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/54601c-5106fe@github.com>
Subject: [bluez/bluez] ca07d1: bap: Mark devices to auto-connect
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
  Commit: ca07d198f9c7d289e95091c30ed15bff2106a7db
      https://github.com/bluez/bluez/commit/ca07d198f9c7d289e95091c30ed15bff2106a7db
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-29 (Wed, 29 Mar 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Mark devices to auto-connect

This makes devices with BAP support to auto-connect once they start
advertising.


  Commit: 2b022fa5297a56875f06c2b5612258cd99dcbe74
      https://github.com/bluez/bluez/commit/2b022fa5297a56875f06c2b5612258cd99dcbe74
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-29 (Wed, 29 Mar 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not setting initiator flag when auto-connecting

If the device is marked as auto-connect the kernel may initiate the
connection spontaneously causing new connections to not have set the
state->initiator flag properly.


  Commit: 8bd2f29617743a5587ca9679957c2e4bf3b78aa9
      https://github.com/bluez/bluez/commit/8bd2f29617743a5587ca9679957c2e4bf3b78aa9
  Author: Manish Mandlik <mmandlik@google.com>
  Date:   2023-03-30 (Thu, 30 Mar 2023)

  Changed paths:
    M emulator/vhci.c
    M emulator/vhci.h

  Log Message:
  -----------
  vhci: Add support to trigger devcoredump and read the dump file

Add vhci support to trigger the hci devcoredump by writing to
force_devcoredump debugfs entry and read the generated devcoredump
file.


  Commit: 5106fe8c868d5ec69af70f299eeedad42b900f69
      https://github.com/bluez/bluez/commit/5106fe8c868d5ec69af70f299eeedad42b900f69
  Author: Manish Mandlik <mmandlik@google.com>
  Date:   2023-03-30 (Thu, 30 Mar 2023)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add devcoredump tests

Add mgmt-tester tests for hci devcoredump. These testa trigger the
devcoredump with a test data and verifies the generated devcoredump
file for the test data and correct devcoredump header fields.


Compare: https://github.com/bluez/bluez/compare/54601cbcf283...5106fe8c868d
