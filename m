Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F528C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 23:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiFWXkr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFWXkr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 19:40:47 -0400
Received: from smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CEC3B545
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 16:40:46 -0700 (PDT)
Received: from github.com (hubbernetes-node-df45605.va3-iad.github.net [10.48.13.50])
        by smtp.github.com (Postfix) with ESMTPA id E6E70340AEB
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1656027645;
        bh=qUjHkzLHhKmqQ7/WVSs6+pyzfNipwEo9epj/YBH7FeM=;
        h=Date:From:To:Subject:From;
        b=0OaBr8p/AvwwGdRbh7mms0a+Qc74oUic+mON0GImZSXnM9u8M6F5c4isDpi9S67wy
         dkCmjaWeGCIZ092OkaMWloPfdHNDUzWUW+s7QKgAKojdG92gNsbaOaRR3pl9Jm2DqD
         AGp7hw23x909AxXBxqk14Olg6OGwdnSx7Jnv1kkI=
Date:   Thu, 23 Jun 2022 16:40:45 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7f92f7-65f7fa@github.com>
Subject: [bluez/bluez] e3c92f: mgmt-tester: Fix null dereference issue
 reported b...
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
  Commit: e3c92f1f786f0b55440bd908b55894d0c792cf0e
      https://github.com/bluez/bluez/commit/e3c92f1f786f0b55440bd908b55894d0c792cf0e
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-06-23 (Thu, 23 Jun 2022)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix null dereference issue reported by scan-build

This patch fixes the null dereference reported by the scan-build.

tools/mgmt-tester.c:12025:28: warning: Access to field 'cap_len' results
in a dereference of a null pointer (loaded from variable 'rp')
[core.NullDereference]

        if (sizeof(rp->cap_len) + rp->cap_len != length) {
                                  ^~~~~~~~~~~


  Commit: 65f7faf5a3d0dcd63c14467a3a2bda317287e330
      https://github.com/bluez/bluez/commit/65f7faf5a3d0dcd63c14467a3a2bda317287e330
  Author: Youwan Wang <wangyouwan@uniontech.com>
  Date:   2022-06-23 (Thu, 23 Jun 2022)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix not removing connected device

[bluetooth]# connect 40:EF:4C:0C:11:F0
Attempting to connect to 40:EF:4C:0C:11:F0
[CHG] Device 40:EF:4C:0C:11:F0 Connected: yes
Connection successful
[CHG] Device 40:EF:4C:0C:11:F0 ServicesResolved: yes
[UFO]# remove 40:EF:4C:0C:11:F0
[CHG] Device 40:EF:4C:0C:11:F0 ServicesResolved: no
Device has been removed
[CHG] Device 40:EF:4C:0C:11:F0 Connected: no
[bluetooth]# info 40:EF:4C:0C:11:F0
Device 40:EF:4C:0C:11:F0 (public)
        Name: UFO
        Alias: UFO
        Class: 0x00240418
        Icon: audio-headphones
        Paired: yes
        Trusted: no
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: Headset
        UUID: Audio Sink
        UUID: A/V Remote Control Target
        UUID: A/V Remote Control
        UUID: Handsfree
        UUID: Phonebook Access Server


Compare: https://github.com/bluez/bluez/compare/7f92f75e88b6...65f7faf5a3d0
