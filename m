Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB613C7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjDFVMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDFVMj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:12:39 -0400
Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F77ECB
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:12:38 -0700 (PDT)
Received: from github.com (hubbernetes-node-15dbfcb.ash1-iad.github.net [10.56.153.34])
        by smtp.github.com (Postfix) with ESMTPA id 11F315E0C13
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1680815558;
        bh=dakdTW6NtLsUdJ9spltRT/hXJde8sbq7T7qVqm+aWdM=;
        h=Date:From:To:Subject:From;
        b=O/UIL+KL9BPQ5iaqKLKqHlIK1f2U9vqXPlVs0pl0qe7lWEkH3fTKYXUSskaF7g5SU
         o8cpsypREkAktmRdXvYI+TimpiwJKgmwaSWl04ZCqpY0Dy41w/Q3XJ3IW0uXLE3TIM
         bGrahNBzTddLjaQlGlDwZo3JN2ma9v13wxEK0JV8=
Date:   Thu, 06 Apr 2023 14:12:37 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/61971f-070c78@github.com>
Subject: [bluez/bluez] a1b93d: main.conf: Fix parsing of CSIS group
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
  Commit: a1b93db14da6772a299492a0c0673be70bea9ea6
      https://github.com/bluez/bluez/commit/a1b93db14da6772a299492a0c0673be70bea9ea6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-05 (Wed, 05 Apr 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main.conf: Fix parsing of CSIS group

There was a typo in the group name using CSIP instead of CSIS.


  Commit: 759d1442a5dcc96466ee0758c695e83b8524ab64
      https://github.com/bluez/bluez/commit/759d1442a5dcc96466ee0758c695e83b8524ab64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-05 (Wed, 05 Apr 2023)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Fix bt_ad_has_data not matching when only type is passed

bt_ad_has_data attempts to match the data portion even when not set
which is useful the user is only interested in actually mataching the
type alone.


  Commit: 23bc47437a353ddf19ce6487544fd63f364d10b1
      https://github.com/bluez/bluez/commit/23bc47437a353ddf19ce6487544fd63f364d10b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-05 (Wed, 05 Apr 2023)

  Changed paths:
    M doc/advertising-api.txt

  Log Message:
  -----------
  advertising-api: Add rsi to SupportedIncludes

This adds "rsi" as possible value to SupportedIncludes so when it is
available it means client and set it on its Includes property so a
proper RSI is generated and included as part of the Advertising Data.


  Commit: eef2e62a5bc4eb4d90a507b3834937102d906b95
      https://github.com/bluez/bluez/commit/eef2e62a5bc4eb4d90a507b3834937102d906b95
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-05 (Wed, 05 Apr 2023)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Add support for rsi as Includes

This adds support for "rsi" when a SIRK has been set on main.conf, the
clients can then enable it via Includes property which will make the
daemon to automatically generate an RSI (hash+random) and include it as
part of the advertising data:

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 15
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0b
        Resolvable Set Identifier: E2-4E-AA-1B-2B-61
          Hash: 0x1b2b61
          Random: 0xe24eaa
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported


  Commit: 070c78c4269c66cfaea75bc9f77fad9b5c4d511c
      https://github.com/bluez/bluez/commit/070c78c4269c66cfaea75bc9f77fad9b5c4d511c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-05 (Wed, 05 Apr 2023)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client/advertising: Add support for advertise.rsi command

This adds support for advertise.rsi command which can be used to request
the generation of RSI and include it as part of advertising data:

[bluetooth]# advertise.rsi --help
Show/Enable/Disable RSI to be advertised
Usage:
	 rsi [on/off]
[bluetooth]# advertise.rsi
RSI: on
[bluetooth]# advertise on
...
Advertising object registered
Tx Power: off
Name: off
Appearance: off
Discoverable: on
RSI: on
[bluetooth]#


Compare: https://github.com/bluez/bluez/compare/61971f026466...070c78c4269c
