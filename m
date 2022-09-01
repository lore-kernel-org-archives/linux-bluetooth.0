Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD477ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 18:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiIAStl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiIAStk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 14:49:40 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CD89919
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:49:38 -0700 (PDT)
Received: from github.com (hubbernetes-node-547a474.ash1-iad.github.net [10.56.200.63])
        by smtp.github.com (Postfix) with ESMTPA id 1A23D900BB1
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1662058178;
        bh=K83HKZF+SiXTzS655GVCnkUw+mT8Ke1LLUpgumYtwHY=;
        h=Date:From:To:Subject:From;
        b=OG33P1sc5wMKMVUfYsdM85X12kXh9cH+A0KKHtr1RvEs0LZoIhJVNLLdbpJL80KXp
         hW3DBx1z9scr+lY28veW5VOsp+6kjJPfLgJH1t9/G0gQAgcA3SiXmjyR1TIZDfUT6D
         GXRdKNlVXS3BYmV4Ml5US+Z9XOWJsfIzqIGt2EQc=
Date:   Thu, 01 Sep 2022 11:49:38 -0700
From:   hadess <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/49b8c5-61f4f2@github.com>
Subject: [bluez/bluez] abf5ba: adapter: Keep track of whether the adapter is
 rfki...
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
  Commit: abf5ba6b80add53a4617ffdd06ac2102095347c2
      https://github.com/bluez/bluez/commit/abf5ba6b80add53a4617ffdd06ac2102095347c2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-09-01 (Thu, 01 Sep 2022)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/btd.h
    M src/rfkill.c

  Log Message:
  -----------
  adapter: Keep track of whether the adapter is rfkill'ed

Instead of only replying to D-Bus requests with an error saying the
adapter is blocked, keep track of the rfkill being enabled or disabled
so we know the rfkill state of the adapter at all times.


  Commit: 58021a665b7f608e20096328bb28e24d3fe8bf0d
      https://github.com/bluez/bluez/commit/58021a665b7f608e20096328bb28e24d3fe8bf0d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-09-01 (Thu, 01 Sep 2022)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Implement PowerState property

This property should allow any program to show whether an adapter is in
the process of being turned on.

As turning on an adapter isn't instantaneous, it's important that the UI
reflects the transitional state of the adapter's power, and doesn't
assume the device is already turned on but not yet working, or still off
despite having requested for it to be turned on, in both cases making
the UI feel unresponsive.

This can also not be implemented in front-ends directly as, then,
the status of an adapter wouldn't be reflected correctly in the Settings
window if it's turned on in the system menu. Implementing it in the
front-ends would also preclude from having feedback about the state of
the adapter when bluetoothd is the one powering up the adapter after the
rfkill was unblocked.

See https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/121
and the original https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/5773


  Commit: 48992da64f52a4ca73221689e9e116ae93e0ba03
      https://github.com/bluez/bluez/commit/48992da64f52a4ca73221689e9e116ae93e0ba03
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-09-01 (Thu, 01 Sep 2022)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print the PowerState property


  Commit: 6e49216ad47dc8ffd9cbf2066d13fd7b59613c98
      https://github.com/bluez/bluez/commit/6e49216ad47dc8ffd9cbf2066d13fd7b59613c98
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-09-01 (Thu, 01 Sep 2022)

  Changed paths:
    M doc/adapter-api.txt

  Log Message:
  -----------
  adapter-api: Add PowerState property documentation


  Commit: 61f4f2895882a19c402e93ef4ba7bb6b802015a4
      https://github.com/bluez/bluez/commit/61f4f2895882a19c402e93ef4ba7bb6b802015a4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-09-01 (Thu, 01 Sep 2022)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix typo in function name


Compare: https://github.com/bluez/bluez/compare/49b8c5901584...61f4f2895882
