Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE9EC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjFHAbm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjFHAbk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 20:31:40 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA27213C
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 17:31:39 -0700 (PDT)
Received: from github.com (hubbernetes-node-24fed23.ac4-iad.github.net [10.52.131.37])
        by smtp.github.com (Postfix) with ESMTPA id 2EB48520474
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1686184299;
        bh=bkHKBWdilBeQUfuOYJF79M4GpcadywvA6Yod+7ZEzuE=;
        h=Date:From:To:Subject:From;
        b=C8Pt+kWMzW4A7lZMoDsjHw+/czvqtsQJ5JuKugI0X/3Yed+CZBmRUX4nidXEhLiOu
         gDmceuTVMzu7sI3oGEmlvSORF+y6lIp7gjzM5rvaQIDLH/1vcN4iH8YcI2pF3jCZUv
         GHS41cGqUaL/1p8wFxX+ZWoTyi8maToXEbSib4zY=
Date:   Wed, 07 Jun 2023 17:31:39 -0700
From:   silviubarbulescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/08d627-303088@github.com>
Subject: [bluez/bluez] eeb349: shared/bap: Split unicast and broadcast
 structures
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
  Commit: eeb349bbab8662d78fa49ce439af632dd313ff50
      https://github.com/bluez/bluez/commit/eeb349bbab8662d78fa49ce439af632dd313ff50
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-06-07 (Wed, 07 Jun 2023)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M profiles/audio/transport.c
    M src/shared/bap.c
    M src/shared/bap.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Split unicast and broadcast structures

This splits bt_bap_qos structure into unicast and broadcast structures.


  Commit: eb821743f9bfd142a3b5c8b9c5a6e9b308709fce
      https://github.com/bluez/bluez/commit/eb821743f9bfd142a3b5c8b9c5a6e9b308709fce
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-06-07 (Wed, 07 Jun 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for broadcast source

This adds bluetoothctl support for broadcast source.
To test the current implementation use bluetoothctl with the commands:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config <created endpoint> <local endpoint> 16_2_1
transport.acquire <created transport>
transport.send <created transport> <file.wav>


  Commit: d15d9669ce4483023e75f272faab21ba8c9991d1
      https://github.com/bluez/bluez/commit/d15d9669ce4483023e75f272faab21ba8c9991d1
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-06-07 (Wed, 07 Jun 2023)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add initial code for BAP broadcast source

This adds initial support for BAP broadcast source.


  Commit: 3030883005c02c77766e1a27a8d5c4d579daa9b5
      https://github.com/bluez/bluez/commit/3030883005c02c77766e1a27a8d5c4d579daa9b5
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-06-07 (Wed, 07 Jun 2023)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: Add broadcast source support

This updates BAP plugin with broadcast source support.


Compare: https://github.com/bluez/bluez/compare/08d62744ce17...3030883005c0
