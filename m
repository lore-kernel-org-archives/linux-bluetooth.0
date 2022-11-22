Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB327C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 02:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKVCli (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 21:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKVClh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 21:41:37 -0500
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557C21276
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 18:41:36 -0800 (PST)
Received: from github.com (hubbernetes-node-b9ce309.ac4-iad.github.net [10.52.200.84])
        by smtp.github.com (Postfix) with ESMTPA id E329F600196
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 18:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1669084895;
        bh=Nh1ojPuvziMH3/MKN3LZg35C49BnvmgtUiPJ6Nwy1Pg=;
        h=Date:From:To:Subject:From;
        b=MS+MLACHpY9Q+hk9Tsy47n/qJoxJIu3e2Z2Vo1pBuD+QdWgkoif/VTbDclDwEM7e4
         WPZt4DdNKx8H56e9FsZGLeGZicedFZLKTmgtympfT6shvSjNjfkP4r24I0rhjKGpWu
         YY4tC2iBjRJXkq/QBf1jGhHBEX7rM7mMt7bzqJ8c=
Date:   Mon, 21 Nov 2022 18:41:35 -0800
From:   =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/818adf-9f5036@github.com>
Subject: [bluez/bluez] 5a872a: client/player: Fix scan-build warning
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
  Commit: 5a872af406ca2d432e79d978f23a85771c7ce6ea
      https://github.com/bluez/bluez/commit/5a872af406ca2d432e79d978f23a85771c7ce6ea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-21 (Mon, 21 Nov 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix scan-build warning

This fixes the following warning:

client/player.c:1775:25: warning: Dereference of null pointer
[core.NullDereference]
iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                        ^~~~~~~~~~~~~~~~~~~~~


  Commit: 9f5036834ba20226456acc0c430642ce36d4eecc
      https://github.com/bluez/bluez/commit/9f5036834ba20226456acc0c430642ce36d4eecc
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2022-11-21 (Mon, 21 Nov 2022)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add SecureConnections option

This introduces SecureConnections option to main.conf that can be used to
configure this on adapter initialization.

This is useful for:
- disable for adapters that have a problems with SecureConnections enabled
- if you want to disable CTKD (cross transport key derivation)
- add option to enable only SecureConnections


Compare: https://github.com/bluez/bluez/compare/818adf28e518...9f5036834ba2
