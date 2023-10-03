Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2228E8FDC0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 23:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjJCXfT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjJCXfS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 19:35:18 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB06AF
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:35:14 -0700 (PDT)
Received: from github.com (hubbernetes-node-ca9b8e1.ash1-iad.github.net [10.56.148.19])
        by smtp.github.com (Postfix) with ESMTPA id 77D83600168
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1696376113;
        bh=ebYe5btKOSbyUI8F1mkOACAiebXyyYxHhq89UhNWFHE=;
        h=Date:From:To:Subject:From;
        b=eTZola0P/DAkVOF0uF6r1S/Ke1/mAYrxqPv+RCa/+j2g/SfAKP3fZkc/OfiNOng7W
         Jmn9+coK5eL8zNLnlsLa56Ai3wxjUxHrLv5gDHWyOLikzlZoATZnJs6uUQnkmLOEA0
         L/GRhw0u3Nm9HEenZh/KBZ7HXXCmEkPnFxMq64Y8=
Date:   Tue, 03 Oct 2023 16:35:13 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7a79ff-9741e4@github.com>
Subject: [bluez/bluez] 32b6d7: doc/set-api: Rename to org.bluez.DeviceSet
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
  Commit: 32b6d7394e9466d1769ad6a9b9fc65c6943a9b1d
      https://github.com/bluez/bluez/commit/32b6d7394e9466d1769ad6a9b9fc65c6943a9b1d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.DeviceSet.rst
    R doc/set-api.rst

  Log Message:
  -----------
  doc/set-api: Rename to org.bluez.DeviceSet

This renames set-api.rst to org.bluez.DeviceSet.rst and generate a
manpage org.bluez.DeviceSet.5.


  Commit: b938b05559d345306486b6badc245b18d88f0ccf
      https://github.com/bluez/bluez/commit/b938b05559d345306486b6badc245b18d88f0ccf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: Fix returning invalid data to attribute Size reads

The attribute Size value is stored in the size_val not on size member
which represents the attribute object.


  Commit: a1920af6f81fba7917784c2ca09159b0cef4e779
      https://github.com/bluez/bluez/commit/a1920af6f81fba7917784c2ca09159b0cef4e779
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: Fix not requiring encryption

According to CSIS spec all attributes shall require encryption:

  'Table 5.1: Coordinated Set Identification Service characteristics'


  Commit: 65b53b0d3a8836eee6cff23518ef62c9409a301d
      https://github.com/bluez/bluez/commit/65b53b0d3a8836eee6cff23518ef62c9409a301d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: Fix not always reading SIRK value

This makes sure the SIRK value is always read otherwise its value can
be outdated or not even read if the connection was interrupted before
read procedure was completed.


  Commit: c35304f32c42125ec92fbae1b5f18223c4cde86a
      https://github.com/bluez/bluez/commit/c35304f32c42125ec92fbae1b5f18223c4cde86a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_get_ltk

This adds btd_device_get_ltk function which can be used by plugins to
access the LTK key.


  Commit: 267bf36d844bd8813acba74434dfa2dc4d81a37b
      https://github.com/bluez/bluez/commit/267bf36d844bd8813acba74434dfa2dc4d81a37b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M profiles/audio/csip.c
    M src/shared/csip.c
    M src/shared/csip.h

  Log Message:
  -----------
  csip: Add support for SIRK encryption

This implements SIRK value encryption using the LTK which is accessed
using btd_device_get_ltk.


  Commit: 954b8e5324fdecbabd2da3ce2f1e884ac847d80d
      https://github.com/bluez/bluez/commit/954b8e5324fdecbabd2da3ce2f1e884ac847d80d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main.conf: Fix default of CSIS.encrypt

CSIS.encrypt setting shall default to true, not false.


  Commit: 7ff68ce57fb4475f259cf5a7453cbd3cb9b8a5bd
      https://github.com/bluez/bluez/commit/7ff68ce57fb4475f259cf5a7453cbd3cb9b8a5bd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Don't keep retrying the same operation

If an operation has been retried already don't attempt to change the
security again.


  Commit: 5e582e34e39210ffdf5bc2a4695e884c00e7116f
      https://github.com/bluez/bluez/commit/5e582e34e39210ffdf5bc2a4695e884c00e7116f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  bap: use MediaEndpoint related properties consistently

Use the documented name "MaximumLatency" for the MediaEndpoint QoS
Max_Transport_Latency field, in SelectProperties input parameters and
expected client MediaEndpoint properties.

Put QoS fields to a "QoS" dict in SelectProperties input.

Fix typoed ppd_min -> ppd_max in SelectProperties input.

Use the name "Locations" for SelectProperties supported locations input
parameter, to match the MediaEndpoint property name which indicates the
same thing.


  Commit: 6683305d827a2f5626a2ae11cf0c8dae2e832899
      https://github.com/bluez/bluez/commit/6683305d827a2f5626a2ae11cf0c8dae2e832899
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: clarify org.bluez.MediaEndpoint documentation

Document the actual input and output parameter values used in
SelectProperties. These differ from SetConfiguration.

Mention SelectProperties is used for unicast only.

Document SetConfiguration input parameters.


  Commit: 232f6f68531bbe8be44c45a1094b26ee20a56c19
      https://github.com/bluez/bluez/commit/232f6f68531bbe8be44c45a1094b26ee20a56c19
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for bcast AC 13 BIS unset

This adds a new test for the ISO Broadcast AC 13, when the BIG handle
is set but the advertising handle is unset:

ISO Broadcaster AC 13 BIG 0x01 - Success


  Commit: d9445f6d0f087ecfc99cc94b558f1d8c5cf3272d
      https://github.com/bluez/bluez/commit/d9445f6d0f087ecfc99cc94b558f1d8c5cf3272d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Test bcast receiver with PA sync, no BIS

This tests that a broadcast receiver is able to successfully sync to the
PA transmitted by a source, without performing BIS sync also:

ISO Broadcaster Receiver Defer No BIS - Success


  Commit: 9741e47aebcdcff343dd2ca7dadc3ec41b66744f
      https://github.com/bluez/bluez/commit/9741e47aebcdcff343dd2ca7dadc3ec41b66744f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-03 (Tue, 03 Oct 2023)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Fix registering pairing callbacks

Don't register pairing callbacks until mgmt.pair is called otherwise it
may take over the role of pairing agent when bluetoothctl agent is in
use.


Compare: https://github.com/bluez/bluez/compare/7a79ff88fd95...9741e47aebcd
