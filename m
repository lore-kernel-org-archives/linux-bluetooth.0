Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ECFC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 19:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjE3TB3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjE3TBZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 15:01:25 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E4134
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 12:01:04 -0700 (PDT)
Received: from github.com (hubbernetes-node-d944e43.va3-iad.github.net [10.48.125.89])
        by smtp.github.com (Postfix) with ESMTPA id 951FEE0547
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1685473263;
        bh=ZBHKaUMkGXZEkzgA3SvP//j6cpNlo86/F6bkaMv8qa0=;
        h=Date:From:To:Subject:From;
        b=iaftjUZiEKxa/9Oj+pLx40GZYKh6ANNa0SleLubfUmNfgCbfejrZt9zKWYLpUP8pR
         sph5a+964nofXsbxC1/HELmtxWnxyHxTljQ7kFRCIfdQ24NU5jgHRGjUz3Cyqm3Csr
         oDn/vfBAVJVzchmbt9hOIaFnxnj5GY0OJhdFCXLY=
Date:   Tue, 30 May 2023 12:01:03 -0700
From:   Pauli Virtanen <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7002ec-15eb57@github.com>
Subject: [bluez/bluez] 000c20: iso-tester: Add tests for AC configuration
 reconnect
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
  Commit: 000c2012f38afffd476b43fbf0695886e7381eed
      https://github.com/bluez/bluez/commit/000c2012f38afffd476b43fbf0695886e7381eed
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for AC configuration reconnect

Add test for reconnecting a CIG with two CIS, either both with same peer
or with different peers.

ISO Reconnect AC 6(i) - Success
ISO Reconnect AC 6(ii) - Success


  Commit: a8b927e34733900c213b75348e7f6ef714590d39
      https://github.com/bluez/bluez/commit/a8b927e34733900c213b75348e7f6ef714590d39
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: fix inactive CIG configurable status

CIG shall not be configurable after the first Create CIS until Remove
CIG is issued (Core v5.3 Vol 6 Part B Sec. 4.5.14.3).  We currently have
it configurable in the inactive state (Create CIS done and all CIS
closed), which is incorrect.

Track CIG state and allow reconfigure only in nonexistent/configured
state, i.e., when no CIS have been created yet.


  Commit: d214fe5f75229e4c761a458b33651d6316d3562a
      https://github.com/bluez/bluez/commit/d214fe5f75229e4c761a458b33651d6316d3562a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M emulator/btdev.c
    M monitor/bt.h

  Log Message:
  -----------
  btdev: check LE Create CIS error conditions

Check LE Create CIS input parameter are valid and return correct status
codes (Core v5.3 Vol 4 Part E Sec. 7.8.99).

On current bluetooth-next kernel, this results to

ISO AC 6(i) - Success                                Failed
ISO AC 7(i) - Success                                Failed
ISO AC 8(i) - Success                                Failed
ISO AC 9(i) - Success                                Failed
ISO AC 11(i) - Success                               Failed

as in these tests the kernel is sending new Create CIS commands before
it has seen all events from the previous, which is not allowed:

< HCI Command: LE Create Co.. (0x08|0x0064) plen 9  #129 [hci0]
        Number of CIS: 2
        CIS Handle: 257
        ACL Handle: 42
        CIS Handle: 258
        ACL Handle: 42
> HCI Event: Command Status (0x0f) plen 4           #130 [hci0]
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 29           #131 [hci0]
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 257
        ...
< HCI Command: LE Setup Is.. (0x08|0x006e) plen 13  #132 [hci0]
        ...
> HCI Event: Command Complete (0x0e) plen 6         #133 [hci0]
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        ...
< HCI Command: LE Create Co.. (0x08|0x0064) plen 5  #134 [hci0]
        Number of CIS: 1
        CIS Handle: 258
        ACL Handle: 42
> HCI Event: Command Status (0x0f) plen 4           #135 [hci0]
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: ACL Connection Already Exists (0x0b)
> HCI Event: LE Meta Event (0x3e) plen 29           #136 [hci0]
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 258
        ...

The emulator uses Already Exists error code here, not Command
Disallowed, since the Established events are logically generated
immediately after the first status event, even though the kernel hasn't
yet processed them.


  Commit: 15eb57049b19df89701cf6ad0ced2a0c7cecc475
      https://github.com/bluez/bluez/commit/15eb57049b19df89701cf6ad0ced2a0c7cecc475
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable no_hash_pointers=1

Set no_hash_pointers=1 to avoid printk printing "___ptrval___" for %p.
This happens with test-runner since the kernel is not running long
enough to gather entropy and so refuses to print addresses, and makes
debugging harder.  As test-runner is only used for testing and
debugging, pointer hashing is not needed.


Compare: https://github.com/bluez/bluez/compare/7002ecc8914a...15eb57049b19
