Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090BEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGQUDN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGQUDL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jul 2023 16:03:11 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDEC99
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 13:03:10 -0700 (PDT)
Received: from github.com (hubbernetes-node-c2ec55c.va3-iad.github.net [10.48.204.68])
        by smtp.github.com (Postfix) with ESMTPA id 87E509407A4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1689624189;
        bh=D2ZGGkhvkJOZ0i3IvyLaV4XEQD8fPnikKxugGsBxsBc=;
        h=Date:From:To:Subject:From;
        b=MBhV12NLlWr7g9d4m6951WpoxhEq1inCDtu9WH7ZHNNArI5Afd54cj34kKtYT8oTE
         zi6oin9tCbGCjVapSHBFrxK8YSTHQwg2JR9qmCfZmp8I+hsgnYCeQE6pAo5G0eDSh+
         VCJQW8DPeq/SRC8ZJoa8bd6AiSGtKWYhRK3YraVA=
Date:   Mon, 17 Jul 2023 13:03:09 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9aff3f-b9e93e@github.com>
Subject: [bluez/bluez] 92bb38: bthost: Add support to set ISO Packet Status
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
  Commit: 92bb384f5f409517027b315effd66bc776a6ee16
      https://github.com/bluez/bluez/commit/92bb384f5f409517027b315effd66bc776a6ee16
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-14 (Fri, 14 Jul 2023)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c

  Log Message:
  -----------
  bthost: Add support to set ISO Packet Status

This adds support to set ISO Packet Status to bthost_send_iso.


  Commit: 17b229e8e451da95a7b2fd8a0d9b8fb42b36763b
      https://github.com/bluez/bluez/commit/17b229e8e451da95a7b2fd8a0d9b8fb42b36763b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-14 (Fri, 14 Jul 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for BT_PKT_STATUS sockopt

This adds a test for setting BT_PKT_STATUS sockopt and checks if
BT_SCM_PKT_STATUS is properly received.


  Commit: 2b063f47ab7044e4c744b51f5d400b77b1ea3b2f
      https://github.com/bluez/bluez/commit/2b063f47ab7044e4c744b51f5d400b77b1ea3b2f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-14 (Fri, 14 Jul 2023)

  Changed paths:
    M Makefile.tools
    M client/main.c
    A client/mgmt.c
    A client/mgmt.h
    M tools/btmgmt.c

  Log Message:
  -----------
  client: Add support for mgmt submenu

This moves the functionality of btmgmt into client/mgmt.c so its
commands become available on bluetoothctl via mgmt submenu.


  Commit: b9e93e01161cf5392f0cbea3400cfa2dae54643d
      https://github.com/bluez/bluez/commit/b9e93e01161cf5392f0cbea3400cfa2dae54643d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-17 (Mon, 17 Jul 2023)

  Changed paths:
    M profiles/midi/midi.c
    M unit/test-midi.c

  Log Message:
  -----------
  midi: Fix build errors

This fixes the following build errors:

unit/test-midi.c:541:82: error: function definition is not allowed here
void compare_events_cb(const struct midi_write_parser *parser,
					void *user_data) {
							 ^
unit/test-midi.c:587:17: error: use of undeclared identifier
'compare_events_cb'; did you mean 'compare_events'?
                                     compare_events_cb, &midi_data);
                                     ^~~~~~~~~~~~~~~~~
                                     compare_events

profiles/midi/midi.c:61:75: error: function definition is not allowed
here
void foreach_cb(const struct midi_write_parser *parser, void *user_data) {
                                                                         ^
profiles/midi/midi.c:78:40: error: use of undeclared identifier 'foreach_cb'
                midi_read_ev(&midi->midi_out, event, foreach_cb, midi);
                                                     ^


Compare: https://github.com/bluez/bluez/compare/9aff3f494142...b9e93e01161c
