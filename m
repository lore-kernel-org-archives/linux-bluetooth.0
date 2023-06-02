Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2533C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 20:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjFBUB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjFBUBz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 16:01:55 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE99D
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 13:01:53 -0700 (PDT)
Received: from github.com (hubbernetes-node-442bd11.ash1-iad.github.net [10.56.157.35])
        by smtp.github.com (Postfix) with ESMTPA id CE227840335
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1685736112;
        bh=7OTI3NfllMyPDWsqhyvK2EH3GYbXjHTW8i726MuRzz8=;
        h=Date:From:To:Subject:From;
        b=Vh/IKYsdWLc7SfpkHCA5ZrqxRtVpBk78OR4QBaFObCN66/bxU/l03e9+ALlW8tUJ4
         9LVbi0dnNxawSF7+gZnK4Cbbo4KSubLEZ5xCbaZsJPL9O2zpTTUe+qvR8oPumviD8g
         0VSfO1j9uxFYXGCJeBn53VfdIhHdZdhyaXlBC+pY=
Date:   Fri, 02 Jun 2023 13:01:52 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1248bd-52477e@github.com>
Subject: [bluez/bluez] f84979: monitor: Only print credentials if PID is set
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
  Commit: f84979c1591f8911b1557d454dcfeab56b12a7f1
      https://github.com/bluez/bluez/commit/f84979c1591f8911b1557d454dcfeab56b12a7f1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-01 (Thu, 01 Jun 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Only print credentials if PID is set

If PID is not set don't print anything since this is likely a packet
originated by the kernel itself.


  Commit: 52477e80fc892bdd2ac250e932ceacda59f90b1c
      https://github.com/bluez/bluez/commit/52477e80fc892bdd2ac250e932ceacda59f90b1c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-01 (Thu, 01 Jun 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't overwrite attribute declaration

The attribute declaration (e.g. characteristic properties) shall not be
overwritten as they are part of the information that is part of the
cache beside the same information is already stored as part of the
bt_bap instance.


Compare: https://github.com/bluez/bluez/compare/1248bdd43291...52477e80fc89
