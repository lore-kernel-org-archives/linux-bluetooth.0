Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 22:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384797AbiEMWFc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiEMWFa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 18:05:30 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6278606E3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 15:05:27 -0700 (PDT)
Received: from github.com (hubbernetes-node-7711da9.ac4-iad.github.net [10.52.206.112])
        by smtp.github.com (Postfix) with ESMTPA id 0E4D3600207
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1652479527;
        bh=m55qYCT5Wt0uRNbIEpHpaNgYNd97gr0LOmYtZ3X1WbY=;
        h=Date:From:To:Subject:From;
        b=qjLq1vQqwVzug6suxW7s6gqlerWyw5T4CC09WHl0HIbw2+tGFz2VJsw/w4GpzqhkI
         2VIyOCLIVo8N1Y5mj7zEFAeF2hSyNVAX8BDwKfhVE0aAjpy9cLU3a1EvNmcQtbAorA
         3SdtSG+Rz6OAP1tvk5ZE/ly+svd7hPAlgLz2zyJ4=
Date:   Fri, 13 May 2022 15:05:27 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/83497b-c7955b@github.com>
Subject: [bluez/bluez] 7a4b67: device: Fix enabling wake support without RPA
 Reso...
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
  Commit: 7a4b67f9caa6bdc004c910f3a52108744a8cab74
      https://github.com/bluez/bluez/commit/7a4b67f9caa6bdc004c910f3a52108744a8cab74
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-12 (Thu, 12 May 2022)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix enabling wake support without RPA Resolution

If device uses RPA it shall only enable wakeup if RPA Resolution has
been enabled otherwise it cannot be programmed in the acceptlist which
can cause suspend to fail.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768


  Commit: c7955b2099dc6be46e977229d852612c4817f78f
      https://github.com/bluez/bluez/commit/c7955b2099dc6be46e977229d852612c4817f78f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-12 (Thu, 12 May 2022)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Fix not reading report_map of instances

If there is multiple instances the gatt_db of the instances was not
initialized causing the report_map_attr to be NULL which prevents the
report_map to be read and uhid device to be created.

Fixes: https://github.com/bluez/bluez/issues/298


Compare: https://github.com/bluez/bluez/compare/83497bbb307f...c7955b2099dc
