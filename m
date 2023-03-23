Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E5C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCWVOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCWVOR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:14:17 -0400
Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445992596B
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:14:17 -0700 (PDT)
Received: from github.com (hubbernetes-node-19b9775.ac4-iad.github.net [10.52.205.67])
        by smtp.github.com (Postfix) with ESMTPA id 9C4B5722056
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1679606056;
        bh=egSP8L15WPxl0AphyN4MECF5mQlaZdWCd4VEOMG+sTs=;
        h=Date:From:To:Subject:From;
        b=UMAD42WSbPmLrNYN3fVpsZsJSMvb+XekbtmCWk3J5lgbSyqKVzV6gI0aHykCSnsdq
         c6ASSonQaSWe7QX+smi7NOQfukStbZsJnyWr6tG9mvwgT0iDlUbZsoUJu7fqhgpHHQ
         JmNHAoPV8aeSruRcnzbqlGfu3dRPPVZfGN2DWUnU=
Date:   Thu, 23 Mar 2023 14:14:16 -0700
From:   =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/338ba4-648b43@github.com>
Subject: [bluez/bluez] 446e13: monitor: Fix crash when there is no write
 handler
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
  Commit: 446e13360dbaa95fd3912ebb9ca734ccb17d7a32
      https://github.com/bluez/bluez/commit/446e13360dbaa95fd3912ebb9ca734ccb17d7a32
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-03-23 (Thu, 23 Mar 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix crash when there is no write handler


  Commit: 648b4362521bcd9146b88d03e51e05454269e27f
      https://github.com/bluez/bluez/commit/648b4362521bcd9146b88d03e51e05454269e27f
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-03-23 (Thu, 23 Mar 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix printing Signed Write Command

Data field were print twice (1 time incorrectly):
> ACL Data RX: Handle 64 flags 0x02 dlen 19
      ATT: Signed Write Command (0xd2) len 14
        Handle: 0x006f Type: Vendor specific (f7debc9a-7856-3412-7856-341278563412)
          Data: 0800000087f303c224516133
          Data:
          Signature: 0800000087f303c224516133


Compare: https://github.com/bluez/bluez/compare/338ba4352b6c...648b4362521b
