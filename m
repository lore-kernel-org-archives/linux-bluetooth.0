Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93545CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 21:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJKViR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJKViQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 17:38:16 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7599E
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 14:38:15 -0700 (PDT)
Received: from github.com (hubbernetes-node-47d6e02.va3-iad.github.net [10.48.143.20])
        by smtp.github.com (Postfix) with ESMTPA id EB7A0406EA
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1697060295;
        bh=V/GULQbwGU6pXKS9NWKERyOhF6GfXOqoWuvCt5RDnos=;
        h=Date:From:To:Subject:From;
        b=P1bgFCIXvya4UYtvXLorXj6xz6UGArcXvZV31XWGDDvxQtIBSQEG6STqye6sELtfJ
         xolidVaxyNVUVNnT/33/Id/EKwnQaFNGGi6jZoNs6aeUqv7optCGZVflUoVvxyNmbU
         hypYLauPr0SoP2rsNhxhxryy2l+wUDCxC5ALZPxU=
Date:   Wed, 11 Oct 2023 14:38:14 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/04f40b-afb47b@github.com>
Subject: [bluez/bluez] 3a9c63: input: Fix .device_probe failing if SDP record
 is ...
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
  Commit: 3a9c637010f8dc1ba3e8382abe01065761d4f5bb
      https://github.com/bluez/bluez/commit/3a9c637010f8dc1ba3e8382abe01065761d4f5bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-10 (Tue, 10 Oct 2023)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Fix .device_probe failing if SDP record is not found

Due to changes introduced by 67a26abe53bf
("profile: Add probe_on_discover flag") profiles may get probed when
their profile UUID are discovered, rather than resolved, which means
the SDP record may not be available.

Fixes: https://github.com/bluez/bluez/issues/614


  Commit: 25a471a83e02e1effb15d5a488b3f0085eaeb675
      https://github.com/bluez/bluez/commit/25a471a83e02e1effb15d5a488b3f0085eaeb675
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-10 (Tue, 10 Oct 2023)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/input.conf

  Log Message:
  -----------
  input.conf: Change default of ClassicBondedOnly

This changes the default of ClassicBondedOnly since defaulting to false
is not inline with HID specification which mandates the of Security Mode
4:

BLUETOOTH SPECIFICATION Page 84 of 123
Human Interface Device (HID) Profile:

  5.4.3.4.2 Security Modes
  Bluetooth HID Hosts shall use Security Mode 4 when interoperating with
  Bluetooth HID devices that are compliant to the Bluetooth Core
  Specification v2.1+EDR[6].


  Commit: afb47b13c600b0c5e01b4fe3f2e670e89faa6ec2
      https://github.com/bluez/bluez/commit/afb47b13c600b0c5e01b4fe3f2e670e89faa6ec2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-10 (Tue, 10 Oct 2023)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Fix smatch warning

This fixes the following warning:

profiles/input/device.c:165:26: warning: Variable length array is used.


Compare: https://github.com/bluez/bluez/compare/04f40b747fe2...afb47b13c600
