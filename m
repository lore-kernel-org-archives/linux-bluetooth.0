Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 01:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiGBB5V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 21:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBB5U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 21:57:20 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FAD36B54
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 18:57:17 -0700 (PDT)
Received: from github.com (hubbernetes-node-6c29bc1.va3-iad.github.net [10.48.219.16])
        by smtp.github.com (Postfix) with ESMTPA id 29BF5E015E
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1656727037;
        bh=jsiFfHXlpR8F7zytkWazFKLCDAu/a3KKNwamwpQxCUw=;
        h=Date:From:To:Subject:From;
        b=mTLusZ7eklB1euczqGO5XjbMzQWwexSaJF7SyI+ozqpaG0J6mynWYheCd8zYVE5UZ
         kN+dLlEXGOY6NBYLq33YgkZWt09D4XsZYwvfQSk21MLlFhdX7aUhR9Z69eRDt7Bqio
         Cee7CtQLrRTuq/dENgnV/KLdBvjDW54wg1Rz8jsE=
Date:   Fri, 01 Jul 2022 18:57:17 -0700
From:   Tedd Ho-Jeong An <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/433a9f-dd12ff@github.com>
Subject: [bluez/bluez] c1f0b1: tools/btmgmt: Fix errors reported by scan-build
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
  Commit: c1f0b1a747bc47a984fd7068619923d24adc6b87
      https://github.com/bluez/bluez/commit/c1f0b1a747bc47a984fd7068619923d24adc6b87
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-07-01 (Fri, 01 Jul 2022)

  Changed paths:
    M tools/btmgmt.c

  Log Message:
  -----------
  tools/btmgmt: Fix errors reported by scan-build

This patch fixes the errors reported by the scan-build.

tools/btmgmt.c:2699:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:2859:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:2860:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:2934:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:2935:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:3000:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:3001:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:3261:11: warning: Value stored to 'index' during its
initialization is never read [deadcode.DeadStores]
        uint16_t index = mgmt_index;
                 ^~~~~   ~~~~~~~~~~

tools/btmgmt.c:3450:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:3451:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:4822:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes, adv_data, adv_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/btmgmt.c:4823:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/btmgmt.c:5244:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes, adv_data, adv_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/btmgmt.c:5245:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  Commit: dd12ff1ed1f0b3d631be46fef56c5b401d684e3f
      https://github.com/bluez/bluez/commit/dd12ff1ed1f0b3d631be46fef56c5b401d684e3f
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-07-01 (Fri, 01 Jul 2022)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: Fix errors reported by scan-build

This patch fixes the errors reported by the scan-build.

tools/test-runner.c:315:2: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        execve(argv[0], argv, qemu_envp);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/test-runner.c:554:6: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        if (chdir(home + 5) < 0) {
            ^~~~~~~~~~~~~~~

tools/test-runner.c:638:6: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        if (chdir(home + 5) < 0) {
            ^~~~~~~~~~~~~~~

tools/test-runner.c:695:6: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        if (chdir(home + 5) < 0) {
            ^~~~~~~~~~~~~~~

tools/test-runner.c:984:3: warning: Value stored to 'serial_fd' is never
read [deadcode.DeadStores]
                serial_fd = -1;
                ^           ~~


Compare: https://github.com/bluez/bluez/compare/433a9fd13d46...dd12ff1ed1f0
