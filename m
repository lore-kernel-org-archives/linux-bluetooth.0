Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559C6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiEIUly (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiEIUls (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 16:41:48 -0400
Received: from smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66DE7D
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 13:37:53 -0700 (PDT)
Received: from github.com (hubbernetes-node-f5c4a9b.va3-iad.github.net [10.48.125.73])
        by smtp.github.com (Postfix) with ESMTPA id 28AE33403D2
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1652128673;
        bh=GmmtVN7sy4Dj4qn/cRwOhjwv6PNLeC/APtT43jkGtRg=;
        h=Date:From:To:Subject:From;
        b=nIvIJba1/vHl7ckDaU3/kEKg0OIuBIqlHac1EFEpfwAjG5FYSeYHtio5+Hmn8KjMi
         WDJ/lgtMF+uma19hAbopGocY3YM8PVENlfj6FPR+C+re1KqTgPjM2bV5hJT9WOJwhc
         qEcA/2An4rZ8IwkjJca9IiJCIO9i5qHiRLxQokHE=
Date:   Mon, 09 May 2022 13:37:53 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f0106d-42e9b8@github.com>
Subject: [bluez/bluez] efa900: tools: Fix memory leak in hciconfig
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
  Commit: efa90050937c5eabc6c70a466bd886f164388484
      https://github.com/bluez/bluez/commit/efa90050937c5eabc6c70a466bd886f164388484
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
  Date:   2022-05-09 (Mon, 09 May 2022)

  Changed paths:
    M tools/hciconfig.c

  Log Message:
  -----------
  tools: Fix memory leak in hciconfig

printf() was using function that return dynamic allocated memory as
a parameter.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


  Commit: a4741ef4bf6c6fb262b38a897312e929c2161cf9
      https://github.com/bluez/bluez/commit/a4741ef4bf6c6fb262b38a897312e929c2161cf9
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
  Date:   2022-05-09 (Mon, 09 May 2022)

  Changed paths:
    M tools/btgatt-client.c
    M tools/btgatt-server.c

  Log Message:
  -----------
  tools: Fix memory leaks in btgatt-server/client

According to man buffer allocated by getline() should be freed by
the user program even if getline() failed.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


  Commit: e9ec1cf8715d72195a94d748777a19b8e2ba4db5
      https://github.com/bluez/bluez/commit/e9ec1cf8715d72195a94d748777a19b8e2ba4db5
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
  Date:   2022-05-09 (Mon, 09 May 2022)

  Changed paths:
    M tools/rfcomm.c

  Log Message:
  -----------
  tools: Fix handle leak in rfcomm

Some branches of execution can make handle (socket) leakage.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


  Commit: 42e9b8db92d5d8725e9a1bfd93a5c6a257186776
      https://github.com/bluez/bluez/commit/42e9b8db92d5d8725e9a1bfd93a5c6a257186776
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
  Date:   2022-05-09 (Mon, 09 May 2022)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix uninitialized value usage

Definitely `dbus_bool_t b;` must be initialized before comparing it
with current value.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


Compare: https://github.com/bluez/bluez/compare/f0106d92a1e0...42e9b8db92d5
