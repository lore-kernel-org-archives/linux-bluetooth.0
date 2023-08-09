Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4AAC0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 18:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHISNt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHISNs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 14:13:48 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0721736
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 11:13:47 -0700 (PDT)
Received: from github.com (hubbernetes-node-04cd247.ash1-iad.github.net [10.56.151.29])
        by smtp.github.com (Postfix) with ESMTPA id 32F183410C8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1691604827;
        bh=Xoc+4nAINeL51/u2OFR+JXzMVf800xkMoNryXwApsEk=;
        h=Date:From:To:Subject:From;
        b=Hny1WEcffd2ccyFd1weJc6K1N8BJzzClnikqWksKCs8XhZcFiSdnhmWOo/SodXLcZ
         7uRR6PqPw9flD42W/XOqzHjGey3CMbtnsHrtWyeDbx60Br10blQ5mkHBO92bv0u7AO
         rxqWM5YnltIR9IqgRzdcSybdAu4cSdOuq5p0ovco=
Date:   Wed, 09 Aug 2023 11:13:47 -0700
From:   Gioele <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/67a26a-fc6f58@github.com>
Subject: [bluez/bluez] 8b6432: configure.ac: Bump minimum D-Bus version to
 1.10
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
  Commit: 8b6432a8728f87aa328bd67f07a35a1e755d75e6
      https://github.com/bluez/bluez/commit/8b6432a8728f87aa328bd67f07a35a1e755d75e6
  Author: Gioele Barabucci <gioele@svario.it>
  Date:   2023-08-09 (Wed, 09 Aug 2023)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: Bump minimum D-Bus version to 1.10

D-Bus 1.10, released in 2015, is the first version that supports reading
policy files from `/usr/share/dbus-1` in addition to `/etc/dbus-1`.

The previous minimum version, 1.6, was released in 2012.


  Commit: fc6f5856d1775b39712b35049307afdd65df3d27
      https://github.com/bluez/bluez/commit/fc6f5856d1775b39712b35049307afdd65df3d27
  Author: Gioele Barabucci <gioele@svario.it>
  Date:   2023-08-09 (Wed, 09 Aug 2023)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: Install D-Bus policy in /usr/share, not /etc

From https://bugs.debian.org/1006631:

> dbus supports policy files in both `/usr/share/dbus-1/system.d` and
> `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
> deprecates installing packages' default policies into
> `/etc/dbus-1/systemd`, instead reserving it for the sysadmin.
> This is the same idea as the difference between `/usr/lib/udev/rules.d`
> and `/etc/udev/rules.d`.


Compare: https://github.com/bluez/bluez/compare/67a26abe53bf...fc6f5856d177
