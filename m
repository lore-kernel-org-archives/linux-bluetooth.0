Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0111E743D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 00:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjI2ArU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2ArU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 20:47:20 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C3B4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 17:47:17 -0700 (PDT)
Received: from github.com (hubbernetes-node-eb3946a.va3-iad.github.net [10.48.135.45])
        by smtp.github.com (Postfix) with ESMTPA id 64CA640BC1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1695948436;
        bh=M50bgphonRsdvpW1/L3LQmrK415OiUSbXgquXE5gQGw=;
        h=Date:From:To:Subject:From;
        b=jcDB2Ly63jYEp3xc3UsWaAHh4lA2hWWO3T+m3/FgNpBllNF2nuk7Ixf54dIAi/5qV
         laBOWpts3BPONUQQnMxom6gEGuoae+iJjyExS6V3zi1GbM2dcVUNs/doAES7GFP1bf
         K4GqiWfPA8yMBLmBmaB6+R5lLoDkbwhSYQSYvEXY=
Date:   Thu, 28 Sep 2023 17:47:16 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b05c3f-ae9bf5@github.com>
Subject: [bluez/bluez] 676e8b: media-api: Update to reflect the last code
 changes
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
  Commit: 676e8b0cf1740daaec851ca2c2cc8fb3a4e6d64a
      https://github.com/bluez/bluez/commit/676e8b0cf1740daaec851ca2c2cc8fb3a4e6d64a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M doc/media-api.rst

  Log Message:
  -----------
  media-api: Update to reflect the last code changes

This reflect the last code changes adding the missing Broadcast
properties.


  Commit: 771b19e1966ac58e34b17d9fed116ec5635019ee
      https://github.com/bluez/bluez/commit/771b19e1966ac58e34b17d9fed116ec5635019ee
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M client/player.c
    M lib/bluetooth.h
    M profiles/audio/bap.c
    M profiles/audio/transport.c
    M src/shared/bap.h
    M src/shared/bass.c
    M tools/iso-tester.c
    M tools/isotest.c

  Log Message:
  -----------
  transport: Implement QoS property

This implements Transport.QoS as a dict instead of listing each field as
a individual property.


  Commit: d1bb05e3edbce3f474fff4ff592aa39b4a2f667d
      https://github.com/bluez/bluez/commit/d1bb05e3edbce3f474fff4ff592aa39b4a2f667d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Make transport.show to print QoS configuration

This makes transport.show to print QoS configuration since it is now a
single property:

transport.show <transport>
Transport /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0/fd1
	UUID: 00002bcb-0000-1000-8000-00805f9b34fb
	Codec: 0x06 (6)
	Configuration:
  02 01 03 02 02 01 03 04 28 00                    ........(.
	Device: /org/bluez/hci0/dev_00_AA_01_01_00_03
	State: idle
	Endpoint: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0
	QoS Key: CIG
	QoS Value: 0x00 (0)
	QoS Key: CIS
	QoS Value: 0x00 (0)
	QoS Key: Framing
	QoS Value: 0x00 (0)
	QoS Key: PresentationDelay
	QoS Value: 0x00009c40 (40000)
	QoS Key: Interval
	QoS Value: 0x00002710 (10000)
	QoS Key: Latency
	QoS Value: 0x000a (10)
	QoS Key: SDU
	QoS Value: 0x0028 (40)
	QoS Key: PHY
	QoS Value: 0x02 (2)
	QoS Key: Retransmissions
	QoS Value: 0x02 (2)
	Location: 0x00000003 (3)
	Links: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0


  Commit: df75d2f37ca34f4ac5850688c40d376a9b295ae4
      https://github.com/bluez/bluez/commit/df75d2f37ca34f4ac5850688c40d376a9b295ae4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  media: Implement QoS property

This implements QoS as a dict instead of listing each field as
a individual property.


  Commit: 1c79a45667e7f1bef40b2ac131d85024d73ea643
      https://github.com/bluez/bluez/commit/1c79a45667e7f1bef40b2ac131d85024d73ea643
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M client/player.c
    M client/print.c

  Log Message:
  -----------
  client: Make Endpoint.SelectProperties reply properly

This makes Endpoint.SelectProperties reply with QoS property since it
is now a single property.


  Commit: 3ca45476faa40e761cbeacc7268ea694a789c90d
      https://github.com/bluez/bluez/commit/3ca45476faa40e761cbeacc7268ea694a789c90d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M Makefile.am
    R doc/media-api.rst
    A doc/org.bluez.Media.rst
    A doc/org.bluez.MediaControl.rst
    A doc/org.bluez.MediaEndpoint.rst
    A doc/org.bluez.MediaFolder.rst
    A doc/org.bluez.MediaItem.rst
    A doc/org.bluez.MediaPlayer.rst
    A doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/media: Convert media-api.rst into manpages

This splits media-api.rst into org.bluez.Media<interface>.rst and
generate manpages for them.


  Commit: a6aac75b410e52cab01d118c2a2646cde89bf94f
      https://github.com/bluez/bluez/commit/a6aac75b410e52cab01d118c2a2646cde89bf94f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add support content and contexts to bt_bap_pac_qos

This adds support for setting supported content and contexts on a per
PAC record basis which then is carried over to their respective PACS
attribute and notified properly when changed (added/removed).


  Commit: 32afb9df424c27d47955c0c7c5596d809b9641c1
      https://github.com/bluez/bluez/commit/32afb9df424c27d47955c0c7c5596d809b9641c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc/MediaEndpoint: Move QoS capabilities to its own dict property

This moves QoS capabilities to its own dict property just as it was done
for MediaTransport QoS configuration.


  Commit: bcd7a6b697aa882c2aacdfb9e2812e0df07b7508
      https://github.com/bluez/bluez/commit/bcd7a6b697aa882c2aacdfb9e2812e0df07b7508
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add support for location and contexts to bt_bap_pac_qos

This adds support for location and contexts to bt_bap_pac_qos and
function to read them.


  Commit: e932ff330fd04ec7c3fccd2a021b00f39df4ee3d
      https://github.com/bluez/bluez/commit/e932ff330fd04ec7c3fccd2a021b00f39df4ee3d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add support for missing MediaEndpoint properties

This adds support for Location, SupportedContext, Context and QoS
properties.


  Commit: 8e5142a1fad5182c4b2ace826a077966f24b3848
      https://github.com/bluez/bluez/commit/8e5142a1fad5182c4b2ace826a077966f24b3848
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Make endpoint.show print ISO specific capabilities

This makes endpoint.show print Locations, SupportedContext, Context and
Qos capabilities.


  Commit: 2a61791d16797b2ac0a8d68e07f7bfaebd825a47
      https://github.com/bluez/bluez/commit/2a61791d16797b2ac0a8d68e07f7bfaebd825a47
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix freeing value of dbus_message_iter_get_fixed_array

The value returned by dbus_message_iter_get_fixed_array is a reference
and shall not be freed:

 'The returned value is by reference and should not be freed.'


  Commit: c488783cb55e59fbc1891c66870be41c370cd482
      https://github.com/bluez/bluez/commit/c488783cb55e59fbc1891c66870be41c370cd482
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M profiles/audio/csip.c

  Log Message:
  -----------
  csip: Fix not registering CSIS service

adapter_probe callback shall register service the plugin wants to
expose which was not the case for csip since it depended on a device to
register the bt_csip instance which is then responsible to register its
attributes, so this change it so there is a dedicated driver for CSIS
which takes care of creating the necessary attributes and associate it
with the adapter so it can be cleanup properly.


  Commit: ae9bf50a27922f2f62a465b62800e90f0fba7831
      https://github.com/bluez/bluez/commit/ae9bf50a27922f2f62a465b62800e90f0fba7831
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M src/shared/csip.c
    M src/shared/csip.h

  Log Message:
  -----------
  shared/csip: Remove bt_csip_add_db

bt_csip_add_db is unused since csip plugin does use bt_csip_new to
properly create the attributes for CSIS.


Compare: https://github.com/bluez/bluez/compare/b05c3fbfd764...ae9bf50a2792
