Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB2C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 23:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjAMXDV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjAMXDT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 18:03:19 -0500
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98B7F47A
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 15:03:18 -0800 (PST)
Received: from github.com (hubbernetes-node-485aeca.ash1-iad.github.net [10.56.226.33])
        by smtp.github.com (Postfix) with ESMTPA id AF21F9006F1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1673650997;
        bh=4HbJIM8DPycE7wTStwSBU4cw0YQARaprFC5VRQr+ugQ=;
        h=Date:From:To:Subject:From;
        b=C79O93a8JxjtaToGCT/WZ08r86/oqSLdqTB9lNJsL0XdqkFtxNSdqAiHaYzTMVLNJ
         v7BeD7ux5VfBYIgc3eTv1x0cLrBcE802uXQ+6wEzGoxirF4GXGUNPmEUg+a5uB04HS
         rG6p91fDZBvTzX41ZDFKu055wFiGQQAOxvmNVXG0=
Date:   Fri, 13 Jan 2023 15:03:17 -0800
From:   Abhay <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c18e3b-fd893f@github.com>
Subject: [bluez/bluez] 6f8b35: shared/bap: Fix scan-build warning
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
  Commit: 6f8b3544b95e21c46521ba071d16fb4ac10ae5d8
      https://github.com/bluez/bluez/commit/6f8b3544b95e21c46521ba071d16fb4ac10ae5d8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-13 (Fri, 13 Jan 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix scan-build warning

This fixes the following warning:

src/shared/bap.c:2268:26: warning: Access to field 'iov_len' results in
a dereference of a null pointer (loaded from variable 'cont')
        return iov_append(data, cont->iov_len, cont->iov_base);
	                                ^~~~~~~~~~~~~


  Commit: fd893fdd814e36119a3d71a2103bd7dc359a9f75
      https://github.com/bluez/bluez/commit/fd893fdd814e36119a3d71a2103bd7dc359a9f75
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2023-01-13 (Fri, 13 Jan 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fixing Company ID, Vendor ID and Metadata handling

This fixes Company ID, Vendor Codec ID and metadata storing
PAC record.


Compare: https://github.com/bluez/bluez/compare/c18e3bf92e04...fd893fdd814e
