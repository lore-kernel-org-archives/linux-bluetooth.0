Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD79FEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 20:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFTUCO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFTUCM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 16:02:12 -0400
Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA131729
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:02:09 -0700 (PDT)
Received: from github.com (hubbernetes-node-fc80ebe.ac4-iad.github.net [10.52.138.37])
        by smtp.github.com (Postfix) with ESMTPA id 474565E11D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1687291328;
        bh=ToB3VZ/dCLEJUQD8MmTQU0o/SaCPnUzdWMhAliSeqIs=;
        h=Date:From:To:Subject:From;
        b=b7x8vP9kBn7KGFxY5/5/hEmYQ1RkivRB/kKPB312uGLPwfF9EElo8HfxbPNYCv7GI
         8vTU+OxSXBrsIJPVYiZXg2bm+emPpjiUpE/Gh+DieUbRfhp5z9XnuTPazOK97uOCnj
         Gh6u8bjURqy2sSBJRrOxtCKMkPOuNUqyy+NJLk2U=
Date:   Tue, 20 Jun 2023 13:02:08 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ddd095-95d3e6@github.com>
Subject: [bluez/bluez] 620323: shared/bap: Add unespecified bit in audio
 context ...
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
  Commit: 62032321bfe8ad13e1f17520f8935dbd1341af62
      https://github.com/bluez/bluez/commit/62032321bfe8ad13e1f17520f8935dbd1341af62
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add unespecified bit in audio context to PAC records

This makes sure unespecified bit is properly marked in both audio
contexts since that required by many platforms in order to work properly
and while doing that add proper defines to the defaults values used in
PACS.


  Commit: 2c9ab2d3f4116addf873952c7d90b13b7ddcd347
      https://github.com/bluez/bluez/commit/2c9ab2d3f4116addf873952c7d90b13b7ddcd347
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M client/print.c

  Log Message:
  -----------
  client: Print integers decimal value

This make the code print D-Bus integer iterators also in decimal format
in addition to hexadecimal.


  Commit: 0053bc5472b655153d8b7f38fed4ee9c20cad5d8
      https://github.com/bluez/bluez/commit/0053bc5472b655153d8b7f38fed4ee9c20cad5d8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix auto registration of broadcast endpoint

For broadcast endpoint broadcast must be set properly.


  Commit: 8f525dbccd74f49d1629571eb3d2a0f40555f4e2
      https://github.com/bluez/bluez/commit/8f525dbccd74f49d1629571eb3d2a0f40555f4e2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix transport.acquire for linked transports

Linked (bi-directional) transports can be acquired on single D-Bus
method call which was not being handled properly by the current code
causing unexpected errors.


  Commit: 95d3e66524bf4a5bd313124fb57791dfba0e2ebd
      https://github.com/bluez/bluez/commit/95d3e66524bf4a5bd313124fb57791dfba0e2ebd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Pass bcode as a reference instead of value

This makes bcode field a pointer which makes it simpler to detect when
it is set and also fixes the usage of util_iov_free which expects it to
be allocated.


Compare: https://github.com/bluez/bluez/compare/ddd09531e936...95d3e66524bf
