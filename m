Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0668C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jul 2022 21:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiGXVSN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jul 2022 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiGXVSM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jul 2022 17:18:12 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5E10FDA
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 14:18:08 -0700 (PDT)
Received: from github.com (hubbernetes-node-9ba6275.ac4-iad.github.net [10.52.125.45])
        by smtp.github.com (Postfix) with ESMTPA id B991A520500
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1658697487;
        bh=WknYNOR3IQoGZgHWWB/nrE7brvVUC9Cg4jOmooZT/u8=;
        h=Date:From:To:Subject:From;
        b=AVkgx8mL7izCFfnaiC/4LqP9Xigjc1T/T7k8R2rrbDozi+NFaUbwdgO10SFKnVZCY
         BiLM9/BdFMljcdkYLs/7/0oHok+vYgBX/YhDoIoqy3sGNaAGRqWQa3+Y6s2570wOFR
         2q88g9uS0xdibDFdeDqj4yL9lpfZRc5v48cVtSTE=
Date:   Sun, 24 Jul 2022 14:18:07 -0700
From:   Marcel Holtmann <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4314f7-9d7530@github.com>
Subject: [bluez/bluez] 5061ec: build: Update library version
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
  Commit: 5061ec4178dd5c5340fd097b967b9f70f6d44d67
      https://github.com/bluez/bluez/commit/5061ec4178dd5c5340fd097b967b9f70f6d44d67
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2022-07-24 (Sun, 24 Jul 2022)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: 9d753065494edaddf436484de3377bf7c3d64263
      https://github.com/bluez/bluez/commit/9d753065494edaddf436484de3377bf7c3d64263
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2022-07-24 (Sun, 24 Jul 2022)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.65


Compare: https://github.com/bluez/bluez/compare/4314f7066721...9d753065494e
