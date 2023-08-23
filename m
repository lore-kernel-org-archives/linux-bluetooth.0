Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B58C3DA66
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 23:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjHWXKo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjHWXKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 19:10:13 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3717FE7D
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:10:11 -0700 (PDT)
Received: from github.com (hubbernetes-node-61de8af.va3-iad.github.net [10.48.144.43])
        by smtp.github.com (Postfix) with ESMTPA id 7966B8C06AB
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692832210;
        bh=ETv5XKwtMyG1HipSr5e5PUVq/vOSZNKqUfyWtirc+is=;
        h=Date:From:To:Subject:From;
        b=TDI3xoVbTGeVz14a7I4mDc84IP2EoOwp94HUt0lG2rGUVi6fF3BOT7E29ZSeL/Cc/
         xOaqkpu7/LG8TmCZ8Hp83rVcZQIeNW6NX0EMUdX08Cpd0lfQAXhoM2u+oI4yEBgvZh
         LPFTzbIaOs/5U+cvvQSKzeIfFBYIiD1xsig0jrfs=
Date:   Wed, 23 Aug 2023 16:10:10 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c01cf4-8b2f00@github.com>
Subject: [bluez/bluez] 35c706: client: Add agent auto argument support
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
  Commit: 35c706f3986d3813e9ce55bc214858be6ac419e3
      https://github.com/bluez/bluez/commit/35c706f3986d3813e9ce55bc214858be6ac419e3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M client/agent.c
    M client/main.c

  Log Message:
  -----------
  client: Add agent auto argument support

This adds "auto" capability which behaves like "on" but instead of
asking user to confirm/autorize it automatically accepts, which is
not secure to be used thus a warning is printed when user selects it.

Usage:

  [bluetoothctl]# agent auto
  Warning: setting auto response is not secure, it bypass user
  confirmation/authorization, it shall only be used for test automation.

  or

  client/bluetoothctl -a auto


  Commit: d49ea14f70dac31365e2bbf84d065a7ed7222cad
      https://github.com/bluez/bluez/commit/d49ea14f70dac31365e2bbf84d065a7ed7222cad
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add support for BAP broadcast sink

This adds support for BAP broadcast sink, creates a remote endpoint when a
broadcast source is discovered and synchronizes with the source upon
endpoint configuration.
This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1


  Commit: c7850975b0d01e2ed646bee759bbf0499de6c70c
      https://github.com/bluez/bluez/commit/c7850975b0d01e2ed646bee759bbf0499de6c70c
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add support for BAP broadcast sink

This adds support for BAP broadcast sink, creates a remote endpoint when a
broadcast source is discovered and synchronizes with the source upon
endpoint configuration.
This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1


  Commit: 9966e0f8f6d8a04373ed832e8d2b40f491949539
      https://github.com/bluez/bluez/commit/9966e0f8f6d8a04373ed832e8d2b40f491949539
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  media: Add broadcast sink media endpoint

This patch adds the possibility to register a broadcast
media endpoint if the controller has support for ISO Sync Receiver.


  Commit: 34d546038ab17a0a7caa6aa9e181c6f8b0ebcc7a
      https://github.com/bluez/bluez/commit/34d546038ab17a0a7caa6aa9e181c6f8b0ebcc7a
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Update transport properties for a broadcast stream

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.


  Commit: 0a824ce8f6f695963aaeb525b1b55dca72d9cd82
      https://github.com/bluez/bluez/commit/0a824ce8f6f695963aaeb525b1b55dca72d9cd82
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Remove Broadcast parameter

Remove unused gdbus parameter.
Fix length for Codec Specific Configuration.


  Commit: 8d0d62659c06cb421b39b7928b4d56f052a874e5
      https://github.com/bluez/bluez/commit/8d0d62659c06cb421b39b7928b4d56f052a874e5
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix UUID name advertised for bcast source

Fix UUID name typo.


  Commit: 8b2f002edeb3c06dfc64dc2a913d112bb4124579
      https://github.com/bluez/bluez/commit/8b2f002edeb3c06dfc64dc2a913d112bb4124579
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-08-23 (Wed, 23 Aug 2023)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Add defer setup support for Broadcast Receiver

This adds defer setup support for the Broadcast Receiver scenario.

In order to create a Broadcast Receiver with the defer setup option,
the -W command line parameter should be used, as described in
isotest.rst.


Compare: https://github.com/bluez/bluez/compare/c01cf4552c12...8b2f002edeb3
