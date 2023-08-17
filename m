Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D8C5ACA0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 20:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353975AbjHQULA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354813AbjHQUKv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 16:10:51 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953D30DF
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 13:10:50 -0700 (PDT)
Received: from github.com (hubbernetes-node-0ebcb78.ash1-iad.github.net [10.56.224.59])
        by smtp.github.com (Postfix) with ESMTPA id 7393C1011BF
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692303049;
        bh=ZgduPuoqM2NXWUKV/nnPSSKhDY/WnmUgY1FPQzMfRJI=;
        h=Date:From:To:Subject:From;
        b=bddauKiDJYet4iBOEtv7yhm4DLyO+3QiXwukl6jdCHxpsStrkEv/o/2EKSPHN2VPY
         FCNNBCY0V0+EazNgpKM9WioMuVn1nMd92nm1kTQPIvbWZJ0siDdtscCCSIlGq5FoYc
         Io6hGG/rDZT3a5zbNBdUtyE+j8yfg8juoyyu61tQ=
Date:   Thu, 17 Aug 2023 13:10:49 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f4aea3-60731c@github.com>
Subject: [bluez/bluez] 31941f: monitor: Fix not printing latency information
 with -r
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
  Commit: 31941ff3977c4764d7fcc6df20971f4ab601e38f
      https://github.com/bluez/bluez/commit/31941ff3977c4764d7fcc6df20971f4ab601e38f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-16 (Wed, 16 Aug 2023)

  Changed paths:
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Fix not printing latency information with -r

When reading a log from file hci_devba may not work, also store link
information so assign_handle can use use the parent (ACL) destination.


  Commit: aed756136b7f87b3dda2ba99d8272734615e73a4
      https://github.com/bluez/bluez/commit/aed756136b7f87b3dda2ba99d8272734615e73a4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-16 (Wed, 16 Aug 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Detect LE-ACL connections

This enables LE-ACL connections to be detected by processing its events
otherwise they would be assumed to be BR-ACL. Also make sure that LE-ISO
address is set based on its ACL link.


  Commit: 60731cab5891ad2be01f5fcdbf5908aff7df4fd1
      https://github.com/bluez/bluez/commit/60731cab5891ad2be01f5fcdbf5908aff7df4fd1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-08-17 (Thu, 17 Aug 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for bcast receiver defer setup

This adds the following test to validate defer setup support for the
Broadcast Receiver scenario:

ISO Broadcaster Receiver Defer - Success


Compare: https://github.com/bluez/bluez/compare/f4aea37ee6cf...60731cab5891
