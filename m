Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA2E8FDCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 06:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjJDGgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 02:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbjJDGgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 02:36:36 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC71A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 23:36:33 -0700 (PDT)
Received: from github.com (hubbernetes-node-ca8bfa0.va3-iad.github.net [10.48.204.54])
        by smtp.github.com (Postfix) with ESMTPA id EEAC68C105E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1696401393;
        bh=3yncM4ew8CH5bIg/qbfwUFPT6eTzwQgUPHvXrIAzuEk=;
        h=Date:From:To:Subject:From;
        b=ev2nDyi3EXfdA0hUypbmGruSUBPrM+4VRXUdxroZ27H71D/+Fh6YWQH/y/8Va6PXC
         J4fH22b+3yOdMB0NsDy66e6dJtZbcHYO0NWk7vy6cEZ83r/H5OcIAHCHMlccD2QBJr
         HDjDRqjkI/YMCguQ31ZJptE3T+Z+n6E4/6Z3dmDE=
Date:   Tue, 03 Oct 2023 23:36:32 -0700
From:   Marcel Holtmann <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9741e4-6ee10e@github.com>
Subject: [bluez/bluez] 5f0297: lib: Add Bluetooth 5.3 and Bluetooth 5.4 into
 the ...
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
  Commit: 5f0297f13177c7d21590c16275ae11355ac5ef94
      https://github.com/bluez/bluez/commit/5f0297f13177c7d21590c16275ae11355ac5ef94
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-10-04 (Wed, 04 Oct 2023)

  Changed paths:
    M lib/hci.c

  Log Message:
  -----------
  lib: Add Bluetooth 5.3 and Bluetooth 5.4 into the version table


  Commit: 6ee10e6df537cb7435d91ff38275306d8a2787f8
      https://github.com/bluez/bluez/commit/6ee10e6df537cb7435d91ff38275306d8a2787f8
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-10-04 (Wed, 04 Oct 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add Bluetooth 5.4 to the version list


Compare: https://github.com/bluez/bluez/compare/9741e47aebcd...6ee10e6df537
