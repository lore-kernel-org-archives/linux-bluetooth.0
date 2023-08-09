Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9636C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 17:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjHIRes (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHIReq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 13:34:46 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D52AE71
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 10:34:46 -0700 (PDT)
Received: from github.com (hubbernetes-node-562a3cf.ash1-iad.github.net [10.56.131.35])
        by smtp.github.com (Postfix) with ESMTPA id 68B3F1000E1
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1691602485;
        bh=OS8kGPLxx8Sbw7vggstABMmUpzaXz2kQehPZAVBW3qg=;
        h=Date:From:To:Subject:From;
        b=UCBH9Z1tThDuVA0dK4Y0oDLR8QLLkzWpsWUqZdzejyus98FcsMJWwQao2eNMTvdQa
         +qeu7R56idKirgLg2nhEDmrUEhn64nDy1ekW9V+krsMACANWNVwVKRXqyIzD/CJZY5
         lWGDGK6jiyugVz7t/QzJ9sYxf5ZIu+GLF8lb4FLM=
Date:   Wed, 09 Aug 2023 10:34:45 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/96de1c-67a26a@github.com>
Subject: [bluez/bluez] 4352a4: client/player: Add broadcast sink endpoint
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
  Commit: 4352a42ec1e20f509c8584b1a918e620c80fbd98
      https://github.com/bluez/bluez/commit/4352a42ec1e20f509c8584b1a918e620c80fbd98
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-08 (Tue, 08 Aug 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add broadcast sink endpoint

Added support for broadcast sink registration using the 0x1851 UUID.
Added support for remote endpoint creation when a broadcast source
is discovered.
Added support for creating a local endpoint when the broadcast sink
endpoint was registered from an external application (Pipewire).
To test this feature use the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1


  Commit: 7b3aa05323f29de5325a0f2fa52f44d3e85b3637
      https://github.com/bluez/bluez/commit/7b3aa05323f29de5325a0f2fa52f44d3e85b3637
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-08 (Tue, 08 Aug 2023)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Add support for getsockopt(BT_ISO_BASE)

This adds the posibility for a broadcast sink to retrieve the
BASE information received from a source afeter a PA synchronization,
using the getsockopt(BT_ISO_BASE) function.
This needs the patch from bluetooth-next:
Bluetooth: ISO: Add support for periodic adv reports processing


  Commit: 58aa93f3cc4656dfcacd326667015be051c5bd14
      https://github.com/bluez/bluez/commit/58aa93f3cc4656dfcacd326667015be051c5bd14
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-09 (Wed, 09 Aug 2023)

  Changed paths:
    M src/eir.c
    M src/eir.h

  Log Message:
  -----------
  eir: Add eir_get_service_data

This adds eir_get_service_data function which can be used to get a
specific service data.


  Commit: 3370c462552b0dfcae33757bbfe1b843e7cff84f
      https://github.com/bluez/bluez/commit/3370c462552b0dfcae33757bbfe1b843e7cff84f
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-08-09 (Wed, 09 Aug 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Do not filter out broadcast advertiser

This allows a broadcast advertiser to be passed up to application,
if the adapter has the capability of being a Synchronized Receiver.


  Commit: 67a26abe53bf33422c17a3f63866e76864b92bc2
      https://github.com/bluez/bluez/commit/67a26abe53bf33422c17a3f63866e76864b92bc2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-09 (Wed, 09 Aug 2023)

  Changed paths:
    M src/device.c
    M src/profile.h

  Log Message:
  -----------
  profile: Add probe_on_discover flag

This adds probe_on_discover flag which indicates if profile needs to be
probed when the remote_uuid is discovered and changes device logic to
attempt to probe driver when a new UUID is discovered and
probe_on_discover is set.


Compare: https://github.com/bluez/bluez/compare/96de1c6eb9ff...67a26abe53bf
