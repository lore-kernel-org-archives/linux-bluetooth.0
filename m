Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C922FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 21:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiJFVTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJFVTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 17:19:05 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089CE31A7
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 14:19:04 -0700 (PDT)
Received: from github.com (hubbernetes-node-9a97254.va3-iad.github.net [10.48.201.64])
        by smtp.github.com (Postfix) with ESMTPA id 0DCB3E00DC
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1665091144;
        bh=ExuGlj4KF5VLncak9pwr+ytA29kukCZySbaYcbfJv4o=;
        h=Date:From:To:Subject:From;
        b=aw0Pmpd1YaL7BKoGcvnB/mL8XKHVk6+31oLtnwsoznDoBEleNehFLz6AvGU2SQdP4
         fWMu0kVzVf/BXLkBLD6+kdfzeid2G0/29jki88Vcg1ON+QKujit7qmyG4MPt8FaTn6
         qF0/X50JLwsqUq3DBCD88Nq2c0FLmwKJx7fSE5Sk=
Date:   Thu, 06 Oct 2022 14:19:04 -0700
From:   Isak Westin <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e71e11-838ddc@github.com>
Subject: [bluez/bluez] e9a8e8: mesh: Correct size of friend cache
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
  Commit: e9a8e884109c1fb3ee075115cb28312dd2716669
      https://github.com/bluez/bluez/commit/e9a8e884109c1fb3ee075115cb28312dd2716669
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/friend.c

  Log Message:
  -----------
  mesh: Correct size of friend cache

The cache size communicated to the Low Power node should be the same as
the cache size actually used.


  Commit: 7ff3e10d92bac299f541d365057f422d0282e483
      https://github.com/bluez/bluez/commit/7ff3e10d92bac299f541d365057f422d0282e483
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Verify padding bits in Friend Poll messages

The padding bits in a Friend Poll message must be zero.
See MshPRFv1.0.1 section 3.6.5.1.


  Commit: 3f3a7b8e192f210b7119b30e8c840e13993134a9
      https://github.com/bluez/bluez/commit/3f3a7b8e192f210b7119b30e8c840e13993134a9
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Queue a friend update on IV Update change

A friend update should be queued when we receive a Secure Network beacon
that changes the IV Update state.


  Commit: c89e9c4b22b4f32c5b4dee396caf5fc54b434da2
      https://github.com/bluez/bluez/commit/c89e9c4b22b4f32c5b4dee396caf5fc54b434da2
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Always relay messages from Low Power nodes

If we receive a message from one of our Low Power nodes, which is
encrypted using frendship credentials and where the destination is not
us, we must relay that message using master credentials.
See MshPRFv1.0.1 section 3.6.6.2.


  Commit: 95bf980b015ee4cb549568d18dd4db6c3f74aa4a
      https://github.com/bluez/bluez/commit/95bf980b015ee4cb549568d18dd4db6c3f74aa4a
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/node.c

  Log Message:
  -----------
  mesh: Update Key Refresh flag after provision

The Key Refresh flag in the Secure Network beacon is now correctly
updated based on provisioning data after being successfully provisioned.


  Commit: c1f1a49aeb1518fa8a808e107573399acab2bd86
      https://github.com/bluez/bluez/commit/c1f1a49aeb1518fa8a808e107573399acab2bd86
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: provisionee: Handle unknown PDUs

If an unknown PDU is received during provisioning, the provisioning
should fail with "Invalid PDU".


  Commit: 77da94eb7a8c8cbeb6db0e0ce31501d08f02ca86
      https://github.com/bluez/bluez/commit/77da94eb7a8c8cbeb6db0e0ce31501d08f02ca86
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: provisionee: Handle failed provisioning

When a provisioning fails, all additionally received PDU should be
unexpected until link is closed by provisioner. See MshPRFv1.0.1 section
5.4.4.


  Commit: 838ddc931263b5582b6170e09878fc0c4337506b
      https://github.com/bluez/bluez/commit/838ddc931263b5582b6170e09878fc0c4337506b
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: provisionee: Check prov start parameters

Verify that all parameters in a Provisioning Start PDU are valid, also
compared to the capabilities that has been sent.


Compare: https://github.com/bluez/bluez/compare/e71e1103abc6...838ddc931263
