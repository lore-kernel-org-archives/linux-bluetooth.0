Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348048AbiDAXhT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiDAXhR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:37:17 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51345AEE6
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:35:27 -0700 (PDT)
Received: from github.com (hubbernetes-node-b4e9ef3.ac4-iad.github.net [10.52.201.40])
        by smtp.github.com (Postfix) with ESMTPA id 39DBC600955
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1648856127;
        bh=V9zUaLWnfyn43qB29ACXlFJDQYkWszHYNxLDzGzu7F0=;
        h=Date:From:To:Subject:From;
        b=lChv7WY+LtG+ItEHQvjV1GVmhRc2qPYbkohkY4RpPU9RC7TlJYoVXxoAe+J9PgVol
         u3yg2IpyblAwqwI3KfVfi7hXDvggl9XSgIof7HHDskvElrp1KbJh4x/4mc7hvy4B+S
         aGJ20O88l+BClc39oQxTb+4u9tlZzsHJZY2mozX0=
Date:   Fri, 01 Apr 2022 16:35:27 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ff35b1-234d60@github.com>
Subject: [bluez/bluez] 6d1531: btdev: Check parameter for CIG related commands
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
  Commit: 6d15315570a43375ab98fa01841e5d957de1724c
      https://github.com/bluez/bluez/commit/6d15315570a43375ab98fa01841e5d957de1724c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-01 (Fri, 01 Apr 2022)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Check parameter for CIG related commands

This checks if the parameters given to Set CIG Parameters and Remove CIG
are in the valid range.


  Commit: 234d60423c3b8186a27b31028d4c0acb847eedb1
      https://github.com/bluez/bluez/commit/234d60423c3b8186a27b31028d4c0acb847eedb1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-01 (Fri, 01 Apr 2022)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Fix gatt_db_attribute_get_index

gatt_db_attribute_get_index was calculating the index based on
attrib->handle - service->attributes[0]->handle which doesn't work when
there are gaps in between handles.

Fixes: https://github.com/bluez/bluez/issues/326


Compare: https://github.com/bluez/bluez/compare/ff35b1d2e97e...234d60423c3b
