Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D97BC001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 22:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjHHWKQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjHHWJ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 18:09:56 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CEE10F0
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 15:09:55 -0700 (PDT)
Received: from github.com (hubbernetes-node-7e783b0.va3-iad.github.net [10.48.12.46])
        by smtp.github.com (Postfix) with ESMTPA id BAC9E8C0C32
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1691532594;
        bh=zjjW1xz1KaMoUrbxFbCU9azJqX2uSBdETF73WmxMeVs=;
        h=Date:From:To:Subject:From;
        b=OIX62B7Tw/I3DP70+4EZi9b2g/4453i8q/qJur5WH3Eueuxxj/WlPJED1XUPIkkPh
         QGlOgfQKX6GJzXGrnUGcscmLcKl9mZbc4+lMt6pBa4Ot4Ays3408+jloolua3bOk9D
         y1GqGLHNeYzUdhhZYOL7eW34OLqC+36kZBTpnUaI=
Date:   Tue, 08 Aug 2023 15:09:54 -0700
From:   Pauli Virtanen <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/59569c-96de1c@github.com>
Subject: [bluez/bluez] 459b09: btdev: fix CIG ID on Set CIG Parameters error
 resp...
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
  Commit: 459b095c663c5fd7dfdd00bcefe178bbf21c38f5
      https://github.com/bluez/bluez/commit/459b095c663c5fd7dfdd00bcefe178bbf21c38f5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-07 (Mon, 07 Aug 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: fix CIG ID on Set CIG Parameters error response

Set CIG Parameters shall return correct CIG ID in Command_Complete also
when it errors.


  Commit: 96de1c6eb9ff1a0b8ec6f4785f3fd3fe47145ecf
      https://github.com/bluez/bluez/commit/96de1c6eb9ff1a0b8ec6f4785f3fd3fe47145ecf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-07 (Mon, 07 Aug 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: test busy CIG error does not drop existing connections

A second connection made with same CIG while the CIG is busy, shall not
disconnect the first already existing connection.

Add test for this:

ISO Connect2 Busy CIG 0x01 - Success/Invalid

This was the original intent of "ISO Connect2 CIG 0x01 -
Success/Invalid", but the busy check should not be made synchronously in
connect() (to maintain ordering with Remove CIG etc), but must be done
in hci_sync. So the test needs to check the error async and explictly
that the first conn is not dropped.


Compare: https://github.com/bluez/bluez/compare/59569c1f947d...96de1c6eb9ff
