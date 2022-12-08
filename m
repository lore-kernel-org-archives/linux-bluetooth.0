Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158DC4708E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Dec 2022 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLHA2X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLHA2P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Dec 2022 19:28:15 -0500
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F25326D2
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 16:28:14 -0800 (PST)
Received: from github.com (hubbernetes-node-cc91d20.ac4-iad.github.net [10.52.211.57])
        by smtp.github.com (Postfix) with ESMTPA id AB9875204FF
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1670459293;
        bh=op0gpDovE6jIraw1FE3boXvythGpDDmG3ERcFcp9E0k=;
        h=Date:From:To:Subject:From;
        b=hC3ev2u2yCnC2vptjjj5stYPZ1Q2CvkfS2Q7ynt7+HLdDXxiLjo3CswwSui7f2+Zd
         ScsqMG+BNMRQmT1XB38a6gKzjNIk071ShGe4vuF200QU+k5rz97XU6NiKWE3RtAm2y
         vR6BoQDA8FInxf8OOSaV8yiEFPMtYh6mykhxlxpI=
Date:   Wed, 07 Dec 2022 16:28:13 -0800
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/35947e-758161@github.com>
Subject: [bluez/bluez] 9a550d: client: Allow gatt.select-attribute to work
 with l...
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
  Commit: 9a550d43b84ed808ff2a678b0117a8e14355d80c
      https://github.com/bluez/bluez/commit/9a550d43b84ed808ff2a678b0117a8e14355d80c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-06 (Tue, 06 Dec 2022)

  Changed paths:
    M client/gatt.c
    M client/gatt.h
    M client/main.c

  Log Message:
  -----------
  client: Allow gatt.select-attribute to work with local attributes

This allows gatt.select-attribute local to select from the registered
attributes:

[bluetooth]# gatt.select-attribute local /org/bluez/app/service0/chrc0
[/org/bluez/app/service0/chrc0]# gatt.write 0x01
[CHG] Attribute /org/bluez/app/service0/chrc0 (%UUID) written
[/org/bluez/app/service0/chrc0]# gatt.read
01                                               .
[/org/bluez/app/service0/chrc0]# gatt.select-attribute local
 /org/bluez/app/service0/chrc1
[/org/bluez/app/service0/chrc1]# gatt.write 0x01
[CHG] Attribute /org/bluez/app/service0/chrc1 (%UUID) written
[/org/bluez/app/service0/chrc1]# gatt.read
01                                               .
[/org/bluez/app/service0/chrc1]#


  Commit: 33b84917ee9645a1fbef9173ee6e1df47cc8ff2c
      https://github.com/bluez/bluez/commit/33b84917ee9645a1fbef9173ee6e1df47cc8ff2c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-06 (Tue, 06 Dec 2022)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c

  Log Message:
  -----------
  bthost: Add callback to accept ISO connections

This enables setting an accept callback which can return reject
reason if the connection shall not be accepted.


  Commit: 758161c422e694d2d76e69a71ddd2ecbafa9bde8
      https://github.com/bluez/bluez/commit/758161c422e694d2d76e69a71ddd2ecbafa9bde8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-07 (Wed, 07 Dec 2022)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test when peer rejects CIS

This adds the following test for testing when remote stack rejects the
CIS:

ISO Connect - Reject                                 Passed


Compare: https://github.com/bluez/bluez/compare/35947e26771c...758161c422e6
