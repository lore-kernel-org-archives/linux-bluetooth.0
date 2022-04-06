Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BE8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 23:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiDFXhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiDFXht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 19:37:49 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B4D1E533D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 16:35:51 -0700 (PDT)
Received: from github.com (hubbernetes-node-6c82970.va3-iad.github.net [10.48.200.77])
        by smtp.github.com (Postfix) with ESMTPA id D035FE057F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1649288150;
        bh=ymg8VVfVl7+uqvGNg8Pmbua23xd76a7nZGgKKrC5jkw=;
        h=Date:From:To:Subject:From;
        b=opNDVEyRvwBsf0EhVtl9+tO9W0hUxoc0FEqWhjuJxfgoP1MO9ujKGG8qe1Jxa5Mbw
         KLBHmzhws+iEwMt1bAnEgy5R/CsPBlwu68v/sQ/yldAmeepycq0wGmYGztADLRQYSe
         qMV0/FH62BAKkRkD+h/DuM6xYRxbb0JxvweBqH/s=
Date:   Wed, 06 Apr 2022 16:35:50 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3627ed-d1871f@github.com>
Subject: [bluez/bluez] bbeabc: gap: Don't attempt to read the appearance if
 alrea...
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
  Commit: bbeabca44a3da3e1efd8e57b0366bbb45aadbb5b
      https://github.com/bluez/bluez/commit/bbeabca44a3da3e1efd8e57b0366bbb45aadbb5b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-04 (Mon, 04 Apr 2022)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  gap: Don't attempt to read the appearance if already set

Devices are unlikely to change appearance over time which is the reason
why we cache then on the storage so this skips reading it on every
reconnection.


  Commit: 0533085d22ba0bc314378524f1cccdea901da434
      https://github.com/bluez/bluez/commit/0533085d22ba0bc314378524f1cccdea901da434
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-06 (Wed, 06 Apr 2022)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for LE BIG Info Adverting Report

This adds support for LE BIG Info Advertising Report.


  Commit: 10948891336d8ca43055c465e3d00f428a035c4c
      https://github.com/bluez/bluez/commit/10948891336d8ca43055c465e3d00f428a035c4c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-06 (Wed, 06 Apr 2022)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Add support for sending LE BIG Info Adv Reports

This adds support for sending LE BIG Info Adv Reports if LE Create BIG
has been called.


  Commit: d1871fc935228f034741e1f5064a0f3e2234ffcd
      https://github.com/bluez/bluez/commit/d1871fc935228f034741e1f5064a0f3e2234ffcd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-06 (Wed, 06 Apr 2022)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix BIG Create Sync

This fixes status return to BIG Create Sync command.


Compare: https://github.com/bluez/bluez/compare/3627eddea130...d1871fc93522
