Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465C2C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 21:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJTVOI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTVOH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 17:14:07 -0400
Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402C112
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 14:14:01 -0700 (PDT)
Received: from github.com (hubbernetes-node-86b434b.ac4-iad.github.net [10.52.135.17])
        by smtp.github.com (Postfix) with ESMTPA id 02D795E0923
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1697836441;
        bh=odw66pMoXBvNemXHmeH3AEzCu3ex4BNbo0KFYDALNBI=;
        h=Date:From:To:Subject:From;
        b=KXajmRWMZxRfJN6ZThoDOHC+sP44lXfMbSr1yK6Vm+1xMVdUzYnM+/hwpDg0VsPAm
         n8ZJWcpUnkSE4cWSV0Z+5NdW/w20ENIPZTy0IP1aGSfTjeeq+sHY8emtcW/XJkdiZo
         X7vQLgMxGpq+UzQdReHpKTtxpZorj5vtoMz2uDwg=
Date:   Fri, 20 Oct 2023 14:14:01 -0700
From:   kirankrishnappa-intel <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0c757e-f02e0c@github.com>
Subject: [bluez/bluez] ffc581: shared/util: Add util_debug_{tlv, bit} helpers
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
  Commit: ffc5819ce4122d53f5a2e7c2a02b1ac03166fe2d
      https://github.com/bluez/bluez/commit/ffc5819ce4122d53f5a2e7c2a02b1ac03166fe2d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-18 (Wed, 18 Oct 2023)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add util_debug_{tlv, bit} helpers

This adds util_debug_tlv and util_debug_bit which can help to print
debug information in their respective formats.


  Commit: e1ec086614224cb50918922dd88f71ae3652a8e5
      https://github.com/bluez/bluez/commit/e1ec086614224cb50918922dd88f71ae3652a8e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-18 (Wed, 18 Oct 2023)

  Changed paths:
    M monitor/att.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Make use of util_debug_tlv to decode TLV entries

This uses util_debug_tlv to decode TLV entries.


  Commit: 6d4491649e067c3338bc539226e146d14271cd69
      https://github.com/bluez/bluez/commit/6d4491649e067c3338bc539226e146d14271cd69
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M Makefile.am
    M profiles/audio/media.c
    A src/shared/bap-debug.c
    A src/shared/bap-debug.h
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add debug helpers

This adds bap-debug.{c.h} that implements function helpers that can be
used to print BAP/ASCS/PACS TLV entries.


  Commit: 8a335099bc1b211a672e4ea5c2bbb470e21021a0
      https://github.com/bluez/bluez/commit/8a335099bc1b211a672e4ea5c2bbb470e21021a0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Make use of bap-debug functions

This make use of bap-debug functions to decode Capabilities,
Configuration and Metadata.


  Commit: a1fb50fd5aa0a605c810543c8479016febf1cacc
      https://github.com/bluez/bluez/commit/a1fb50fd5aa0a605c810543c8479016febf1cacc
  Author: Kiran K <kiran.k@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Populate location to qos structure

Allow clients to register Location for endpoint.


  Commit: 5f8323f2aaa3c8c3d36bdf541f014ac9065a9398
      https://github.com/bluez/bluez/commit/5f8323f2aaa3c8c3d36bdf541f014ac9065a9398
  Author: Kiran K <kiran.k@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix update of sink location value

pac->sink_loc needs to be updated only if there is a change.


  Commit: 932e6420606930d412e1e9a0fec1f82afffbba46
      https://github.com/bluez/bluez/commit/932e6420606930d412e1e9a0fec1f82afffbba46
  Author: Kiran K <kiran.k@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Do not set default location for sink and source

let the clients register the required location for source
and sink endpoints.


  Commit: a564d6a0d533217480296558fa7d7b0f933dd1bc
      https://github.com/bluez/bluez/commit/a564d6a0d533217480296558fa7d7b0f933dd1bc
  Author: Kiran K <kiran.k@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix reading source codec capabilities

Sink ASE capabilities were read instead of source.


  Commit: f02e0c8664a6cfefbb39121a9c42363af2b6bf9a
      https://github.com/bluez/bluez/commit/f02e0c8664a6cfefbb39121a9c42363af2b6bf9a
  Author: Kiran K <kiran.k@intel.com>
  Date:   2023-10-20 (Fri, 20 Oct 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Parse Context and SupportedContext

Allow clients to register available Context and SupportedContext for
BAP endpoints.


Compare: https://github.com/bluez/bluez/compare/0c757e8eeef6...f02e0c8664a6
