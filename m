Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12207C76195
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Mar 2023 01:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCYBTC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjCYBSv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 21:18:51 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB41ACE3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 18:18:49 -0700 (PDT)
Received: from github.com (hubbernetes-node-841cb74.ash1-iad.github.net [10.56.144.39])
        by smtp.github.com (Postfix) with ESMTPA id 507339004FF
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1679707129;
        bh=tf2aaCyFUy1jfzJFrPEogyY304tKC8NH9A5NM2qz/Bg=;
        h=Date:From:To:Subject:From;
        b=mDZ7AZtlw2yDdEoTdYlUgcA72FLBryqVZEeVhD9mmLvDpYPVoxKYmI+tSlcpClm7f
         iKqML/6GBi4EmJ+CLbg83VvJs8w5I2EC8E125Nytka+kqQJ2CZbcbmQDbJUDlDfk0v
         o9J7fCx+jZzZnbpkA4LSafOefa8RZjxS3ml8k9UE=
Date:   Fri, 24 Mar 2023 18:18:49 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/648b43-fb1c69@github.com>
Subject: [bluez/bluez] 1ee1fc: bap: Fix not continue selecting if endpoint
 respon...
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
  Commit: 1ee1fc8e387c074c474bfdae15707f1afa76e1b9
      https://github.com/bluez/bluez/commit/1ee1fc8e387c074c474bfdae15707f1afa76e1b9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-24 (Fri, 24 Mar 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not continue selecting if endpoint respond with an error

If the endpoint respond with an error we shall decrement selecting
counter and proceed to check if there is any stream that can be
configured.


  Commit: f2f7c742ad0b3b6f99e91889a7297cec21084015
      https://github.com/bluez/bluez/commit/f2f7c742ad0b3b6f99e91889a7297cec21084015
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-24 (Fri, 24 Mar 2023)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add support for -i/--init-script

This adds support for -i/--init-script which can be used to provide a
file with commands to be initialized, the commands are then run in
sequence after completing:

client/bluetoothctl -i client/power-on-off.bt
Agent registered
Changing power on succeeded
[CHG] Controller A8:7E:EA:56:87:D5 Pairable: yes
[CHG] Controller 98:8D:46:EE:6D:16 Pairable: yes
[CHG] Controller 98:8D:46:EE:6D:16 PowerState: on-disabling
AdvertisementMonitor path registered


  Commit: fb1c694100b2aff6ee1ad69d2a07c0f122e2e929
      https://github.com/bluez/bluez/commit/fb1c694100b2aff6ee1ad69d2a07c0f122e2e929
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-24 (Fri, 24 Mar 2023)

  Changed paths:
    A client/scripts/advertise-broadcast.bt
    A client/scripts/advertise-on.bt
    A client/scripts/advertise-peripheral.bt
    A client/scripts/gatt-batt.bt
    A client/scripts/power-on-off.bt
    A client/scripts/power-on.bt
    A client/scripts/preset-custom.bt
    A client/scripts/scan-bredr.bt
    A client/scripts/scan-le.bt
    A client/scripts/scan-on-off.bt
    A client/scripts/scan-on.bt

  Log Message:
  -----------
  client: Add samples init scripts

This adds sample init scripts that can be passed to bluetoothctl for
testing.


Compare: https://github.com/bluez/bluez/compare/648b4362521b...fb1c694100b2
