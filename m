Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD1C07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 20:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIZUUw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZUUu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 16:20:50 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521AE48E8D
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 13:20:47 -0700 (PDT)
Received: from github.com (hubbernetes-node-62aa549.va3-iad.github.net [10.48.201.74])
        by smtp.github.com (Postfix) with ESMTPA id 2A8D5E0DD4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1664223647;
        bh=QUdQtK6Jvp0N8BcsPCx1vqN9afXEQaN8YWjHAnudx6o=;
        h=Date:From:To:Subject:From;
        b=QfFz75Yfifr2IsZvoQtTK+g1DCCwi8dLO1wbYGbyfCOhSSnOQaGTuu1VJZaIj26g1
         qKabeWsLBApsbWaIcq5wt4stYNx1udEi/T8QxABYOtci4+OUOlrBMe4Q8uDzMxeVO9
         Mm4kBjNH0GyHjZN09Otz209HdGtWo+BIGdRdC/Sw=
Date:   Mon, 26 Sep 2022 13:20:47 -0700
From:   Isak Westin <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7738e9-d763bf@github.com>
Subject: [bluez/bluez] 491be4: mesh: Improve PB-ADV timing for reliability
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
  Commit: 491be481a91c39d31f7908da8a2beea60237646e
      https://github.com/bluez/bluez/commit/491be481a91c39d31f7908da8a2beea60237646e
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M mesh/pb-adv.c

  Log Message:
  -----------
  mesh: Improve PB-ADV timing for reliability

Because provisioning is not speed dependent, Timing on outbound PB-ADV
packets have been modified to be less likely missed by remote controlers
with looser timing capabilities.


  Commit: 9966cb8b6999a5f54fc13acbd7e1526512a84342
      https://github.com/bluez/bluez/commit/9966cb8b6999a5f54fc13acbd7e1526512a84342
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M Makefile.mesh
    M mesh/main.c
    M mesh/mesh-io-api.h
    M mesh/mesh-io-generic.c
    A mesh/mesh-io-mgmt.c
    A mesh/mesh-io-mgmt.h
    M mesh/mesh-io-unit.c
    M mesh/mesh-io.c
    M mesh/mesh-io.h
    M mesh/mesh-mgmt.c
    M mesh/mesh-mgmt.h
    M mesh/mesh.c
    M mesh/mesh.h

  Log Message:
  -----------
  mesh: Add new kernel MGMT based IO transport

1. Re-structures MGMT handling such that it is used to detect kernel
   support of the mesh MGMT opcodes and events before selecting between
   using MGMT or the legacy raw HCI socket method.

2. Re-structures main() to allow command line to prefer MGMT over HCI or
   visa versa, plus optionally pass an explicte controller.

3. Adds mesh-io-mgmt as a transport.


  Commit: 5b569e3d14a38247c69a16d80c5f7c8b77482505
      https://github.com/bluez/bluez/commit/5b569e3d14a38247c69a16d80c5f7c8b77482505
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Correct u32 to u8 log transformation

Fixed the log transformation to correctly follow the value mapping
defined in the mesh profile (section 4.1.2).


  Commit: 1ef221ca020581575a3775ec60c0a28e384081be
      https://github.com/bluez/bluez/commit/1ef221ca020581575a3775ec60c0a28e384081be
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Reply to HB pub set with same fields

If a Config Heartbeat Publication Set message is unsuccessfully
processed, the fields in the status reply should be the same as in the
original message. See MshPRFv1.0.1 section 4.4.1.2.15.


  Commit: 902389f3e7a33e5730d7e2318b1f1868170dc092
      https://github.com/bluez/bluez/commit/902389f3e7a33e5730d7e2318b1f1868170dc092
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M mesh/cfgmod-server.c
    M mesh/net.c

  Log Message:
  -----------
  mesh: Correct HB sub state updates

If heartbeat subscription is disabled, all fields should be set to zero
but collected data should be preserved. If HB subscription is enabled,
the collected data should be reset (which includes Min Hops = 0x7f).
HB subscription is disabled by setting any of the following fields to
zero: Source, destination or period log.
HB subscription is enabled by setting all the same fields to valid values.


  Commit: d763bfa4d0892b4b3b004577491d2493a999648e
      https://github.com/bluez/bluez/commit/d763bfa4d0892b4b3b004577491d2493a999648e
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Clear HB sub status field if disabled

When replying to a HB subscription get message, and the current state of
source or destination fields is zero (which means that HB subscription
is disabled), all fields in the status reply should be zero.


Compare: https://github.com/bluez/bluez/compare/7738e9ac416b...d763bfa4d089
