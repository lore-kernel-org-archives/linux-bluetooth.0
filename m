Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6D4EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 19:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGJTb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGJTbY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 15:31:24 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77627BC
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:31:22 -0700 (PDT)
Received: from github.com (hubbernetes-node-87060a8.va3-iad.github.net [10.48.141.17])
        by smtp.github.com (Postfix) with ESMTPA id BE788941053
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1689017481;
        bh=xys7gJWYG9DDcMdtDT4rsyrFAmMJgBl4heDEupje4gw=;
        h=Date:From:To:Subject:From;
        b=XtyXLIgyramBpB6rH9me3y7O3bYojfgzWXgnaNUuCbYYt8BRPpKzUvHFz5Ie0v7W9
         PVAQYTFJDgmOJ+bYLc4QlXh8ap9sGGYmMM7SSXBMlsh2xmwaBgphcZN3Ym0hNO0Iwv
         jRaspKrGrEuHKGFOWA+iUzr+K+/PGk7IG4x0UtcA=
Date:   Mon, 10 Jul 2023 12:31:21 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b74146-838e15@github.com>
Subject: [bluez/bluez] da8536: btio: Add options for binding iso broadcast
 address
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
  Commit: da85360a956f5805f680ac75b45b9e1ae4abcf54
      https://github.com/bluez/bluez/commit/da85360a956f5805f680ac75b45b9e1ae4abcf54
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M btio/btio.c
    M btio/btio.h

  Log Message:
  -----------
  btio: Add options for binding iso broadcast address

This adds additional btio options, to allow binding a socket
to a broadcaster address.


  Commit: 8a8f8c143b18519780c87d4689cf3840b8aea243
      https://github.com/bluez/bluez/commit/8a8f8c143b18519780c87d4689cf3840b8aea243
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M Makefile.am
    M profiles/audio/bass.c
    M src/shared/bass.c
    M src/shared/bass.h
    M unit/test-bass.c

  Log Message:
  -----------
  shared/bass: Introduce Add Source opcode handler

This implements the Control Point handler for the Add Source operation.


  Commit: c96eb3ea5537b3b144d47a215c3828ffb7cd333d
      https://github.com/bluez/bluez/commit/c96eb3ea5537b3b144d47a215c3828ffb7cd333d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    A tools/test-runner.rst

  Log Message:
  -----------
  test-runner: Add documentation

This adds test-runner.rst documentation with a few examples of how it
can be used to run kernel testers like mgmt-tester and also bluetoothd,
audio and Bluetooth controller plugged in the host system which is quite
useful when trying experimental features such LE Audio, etc.


  Commit: b9e7ca94d458a4f5e13565d3486b1d84784ef169
      https://github.com/bluez/bluez/commit/b9e7ca94d458a4f5e13565d3486b1d84784ef169
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix tests that consider 31 bytes the max adv lenght

This fixes a couple of tests that consider 31 bytes the max advertising
length since in case of extended advertising that number is actually
251.


  Commit: 2cb07aa669e58cc8b80700088de5dd71a877dd42
      https://github.com/bluez/bluez/commit/2cb07aa669e58cc8b80700088de5dd71a877dd42
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M src/shared/ad.c
    M src/shared/ad.h

  Log Message:
  -----------
  shared/ad: Fix hardcoding maximum data length

Instances shall not assume BT_AD_MAX_DATA_LEN is always the maximum
length as they could be used with EA which supports bigger length.


  Commit: 153aaeda2b21012501b22b73c50412edf458ee87
      https://github.com/bluez/bluez/commit/153aaeda2b21012501b22b73c50412edf458ee87
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Use bt_ad_set_max_len

This uses bt_ad_set_max_len to properly set the maximum data length of
the bt_ad instances based on what the kernel returns.


  Commit: 4578395b5370716b7fecd60d109fc2c01932c891
      https://github.com/bluez/bluez/commit/4578395b5370716b7fecd60d109fc2c01932c891
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client/advetising: Allow use of EA data length

The code was supporting a maximum of 25 bytes (31 - 6) to be entered as
advertising data, but in case of EA is used that allows up to 245 bytes
(251 - 6) to be entered.


  Commit: 838e1578072900d1f98dfb31cc538940d2fad876
      https://github.com/bluez/bluez/commit/838e1578072900d1f98dfb31cc538940d2fad876
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix build warning

This fixes the following warning:

src/advertising.c:942:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Compare: https://github.com/bluez/bluez/compare/b74146068892...838e15780729
