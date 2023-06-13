Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645B7EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 21:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjFMVbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMVbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 17:31:04 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E483173C
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 14:31:01 -0700 (PDT)
Received: from github.com (hubbernetes-node-da265f8.ash1-iad.github.net [10.56.148.25])
        by smtp.github.com (Postfix) with ESMTPA id 927149005D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1686691860;
        bh=YBV1u1y571LslYzJ+Ew1125A/OevT4DtERLH66d2mFw=;
        h=Date:From:To:Subject:From;
        b=L2Wh1KkVh5sVaGDjx1cmIObxFRWZxYvqvTIBeNDus18Rl7Amw2tV6RQfYP17opN85
         DtPOwZKJbnULytJ0WM9ZJzd+1iOLSEnafSOsZeBHMv0/P7ATJKrel9t3NVUWnIohmW
         GV9pAoLK7ibXKxvhaa1frR9Ti43usj4vtq1TPs8Y=
Date:   Tue, 13 Jun 2023 14:31:00 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d2d2d1-ddd095@github.com>
Subject: [bluez/bluez] c0156e: gatt-server: Check pointer before memcpy
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
  Commit: c0156edd198eef10c847b3540098cb4b9d18d142
      https://github.com/bluez/bluez/commit/c0156edd198eef10c847b3540098cb4b9d18d142
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Check pointer before memcpy

This adds a check before calling memcpy inside
bt_gatt_server_send_notification, to avoid getting
the following error in case the user wants to send
an empty notification for an attribute:

src/shared/gatt-server.c:1789:3: runtime error:
null pointer passed as argument 2, which is declared to never be null


  Commit: ddd09531e936508ba9ea620f9caaf3402c54496f
      https://github.com/bluez/bluez/commit/ddd09531e936508ba9ea620f9caaf3402c54496f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Implement CP opcode handlers

This adds handlers for the following BASS Broadcast Audio Scan
Control Point opcodes:
   Remote Scan Stopped
   Remote Scan Started
   Remove Source


Compare: https://github.com/bluez/bluez/compare/d2d2d12f59d6...ddd09531e936
