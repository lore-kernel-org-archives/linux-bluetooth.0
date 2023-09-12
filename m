Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D550EE3F0C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjILTIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILTIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 15:08:46 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2A12E
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 12:08:42 -0700 (PDT)
Received: from github.com (hubbernetes-node-fe550a2.va3-iad.github.net [10.48.140.38])
        by smtp.github.com (Postfix) with ESMTPA id 21D2040A9C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1694545722;
        bh=KndxHfSIaEFNVYDpXSddk2STJoaqQRcDZuaiQhL42xg=;
        h=Date:From:To:Subject:From;
        b=CeT/e9MtRLgZojWAAxoRExLU/VYoJ1d5FhtD50M103Ae895vxblyu+gZtWIT3FSI3
         OE+IvEFWIm6bbHo2cgZpMJBBaaDwmBbWALPPNN9X0LNiwmTEYdTz7vbC+ADMsusCU6
         GHbVCQ3qw872HFbpy1cHZXXh2j/S8whVzktL+INI=
Date:   Tue, 12 Sep 2023 12:08:42 -0700
From:   vlad-pruteanu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/df658c-f83836@github.com>
Subject: [bluez/bluez] 53542d: main.conf: Fix parsing of uint32_t values
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
  Commit: 53542db3d6c6bc9991e3f9b0ab05e6ea6cee753d
      https://github.com/bluez/bluez/commit/53542db3d6c6bc9991e3f9b0ab05e6ea6cee753d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-12 (Tue, 12 Sep 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main.conf: Fix parsing of uint32_t values

Passing UINT32_MAX as int may overfollow causing errors such as:

bluetoothd[2688495]: src/main.c:parse_config_int()
General.TemporaryTimeout = 60 is out of range (> -1)

Fixes: https://github.com/bluez/bluez/issues/583#issuecomment-1713447461


  Commit: 2d2389d967025a5629f00f125abffa9d2c1b4771
      https://github.com/bluez/bluez/commit/2d2389d967025a5629f00f125abffa9d2c1b4771
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-12 (Tue, 12 Sep 2023)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix not handling initiator properly

Previously initiator would be set whenever a central key was found
which turns out to be unreliable besides the MGMT New Connection event
does in fact inform if the connection was initiated locally or not.

Fixes: https://github.com/bluez/bluez/issues/598


  Commit: feadcbbed50dc7c5b9c2334eeb73d8236797b53e
      https://github.com/bluez/bluez/commit/feadcbbed50dc7c5b9c2334eeb73d8236797b53e
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2023-09-12 (Tue, 12 Sep 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Use defer setup when syncing to a BIS source

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.


  Commit: f838361bf0a306de0d0de33f0253e082ebeb10af
      https://github.com/bluez/bluez/commit/f838361bf0a306de0d0de33f0253e082ebeb10af
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2023-09-12 (Tue, 12 Sep 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Use proper name for CIS bit

In the Bluetooth Specification the complete name for bit
number 32 is "Connected Isochronous Stream (Host Support)".


Compare: https://github.com/bluez/bluez/compare/df658c6c4ab5...f838361bf0a3
