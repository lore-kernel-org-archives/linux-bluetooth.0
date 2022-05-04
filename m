Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E324C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 23:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380228AbiEDXVI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385413AbiEDXIo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 19:08:44 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01AD8D
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 16:04:30 -0700 (PDT)
Received: from github.com (hubbernetes-node-3b1ab92.ash1-iad.github.net [10.56.131.45])
        by smtp.github.com (Postfix) with ESMTPA id A18E1840701
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1651705469;
        bh=vu4KXDp1O9KqmGcsGl07ynySlm9/X7wHVVnyejLzFC0=;
        h=Date:From:To:Subject:From;
        b=p0aDjmGac0F3xiMZwck7iAlgRH0DvBJOrzPdx9trUO+ZozkxUbVw4V0g2IXgoJke1
         9u6LsHzRNpzRtAV8C5RjBqTmZCoGeuNev83CvJm5/UXUVURRnkXoNBgKSgTgZAc3bz
         sANJ8rpLOd1WT3iOoG8ZohRM0jmo6k3fYE5V+W2k=
Date:   Wed, 04 May 2022 16:04:29 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b7ca43-bda2a9@github.com>
Subject: [bluez/bluez] 5c05df: doc: add "Bonded" flag to dbus property
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
  Commit: 5c05df7c7607d18aa1dc115eca1ea6c08668c85e
      https://github.com/bluez/bluez/commit/5c05df7c7607d18aa1dc115eca1ea6c08668c85e
  Author: Zhengping Jiang <jiangzp@google.com>
  Date:   2022-05-04 (Wed, 04 May 2022)

  Changed paths:
    M doc/device-api.txt

  Log Message:
  -----------
  doc: add "Bonded" flag to dbus property

Bonded flag is used to indicate the link key or ltk of the remote
device has been stored.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>


  Commit: 0e2e52d0c16a36c1a414d327f26660f72223b97f
      https://github.com/bluez/bluez/commit/0e2e52d0c16a36c1a414d327f26660f72223b97f
  Author: Zhengping Jiang <jiangzp@google.com>
  Date:   2022-05-04 (Wed, 04 May 2022)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add "Bonded" flag to dbus property

Add "Bonded" to dbus device property table. When setting the "Bonded
flag, check the status of the Bonded property first. If the Bonded
property is changed, send property changed signal.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>


  Commit: bda2a9e6f90295f295bd14ec8596bdd263eb0671
      https://github.com/bluez/bluez/commit/bda2a9e6f90295f295bd14ec8596bdd263eb0671
  Author: Zhengping Jiang <jiangzp@google.com>
  Date:   2022-05-04 (Wed, 04 May 2022)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add filter to devices and show Bonded in info

Use the property name as optional filters to the command "devices" and
show the "Bonded" property for the command "info".

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>


Compare: https://github.com/bluez/bluez/compare/b7ca43eedfd5...bda2a9e6f902
