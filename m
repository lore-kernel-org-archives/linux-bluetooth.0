Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3BEEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 23:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjGLXCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLXCI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 19:02:08 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250011D
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:02:07 -0700 (PDT)
Received: from github.com (hubbernetes-node-9f428fa.ash1-iad.github.net [10.56.131.58])
        by smtp.github.com (Postfix) with ESMTPA id 6D8E5340D1C
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1689202926;
        bh=vDEG0HBZVuu6PfLgJr5fffJGyaOLb88uzTa4zmD9BHg=;
        h=Date:From:To:Subject:From;
        b=e9ZS4JbRRovVzRIQK2BvUDdgIdpiU/QlaYpD3ulGg6N1tobVd3134m9s8uAEvm/V2
         zFcGkylq8kU9YGuTtUjamg/9bKnfnbHruiKbDhQ2bMeUHEsZIKSf4aAyyxOLLFPO93
         Q/JNtj84x+BITDl0L0OzhgU95LyqhiDW+KktdX5U=
Date:   Wed, 12 Jul 2023 16:02:06 -0700
From:   Rudi Heitbaum <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/838e15-c62a4c@github.com>
Subject: [bluez/bluez] c48468: shared/ad: Use util_iov_push_* helpers to
 generate...
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
  Commit: c48468328f28f3c2aad488fdd917db0b517da451
      https://github.com/bluez/bluez/commit/c48468328f28f3c2aad488fdd917db0b517da451
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Use util_iov_push_* helpers to generate data

This makes use of util_iov_push_* helpers to generate the data.


  Commit: 9b0087bc3d2513d32630d84c2bb499a51c155d35
      https://github.com/bluez/bluez/commit/9b0087bc3d2513d32630d84c2bb499a51c155d35
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-10 (Mon, 10 Jul 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Remove DEFAULT_SIRK

DEFAULT_SIRK is currently not used.


  Commit: d1b33eb8bf0f502761844d09dc64803ed5c9e687
      https://github.com/bluez/bluez/commit/d1b33eb8bf0f502761844d09dc64803ed5c9e687
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-11 (Tue, 11 Jul 2023)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Introduce strisutf8

This introduces strisutf8 which can be used to verify if a string is
encoded using UTF-8 format.


  Commit: bc2ab4ba3c6103540b902802a3b156f769791fca
      https://github.com/bluez/bluez/commit/bc2ab4ba3c6103540b902802a3b156f769791fca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-12 (Wed, 12 Jul 2023)

  Changed paths:
    M src/shared/ad.c
    M src/shared/ad.h

  Log Message:
  -----------
  shared/ad: Make use of util_iov_pull_* to parse data

This makes use of util_iov_pull_* helpers to parse data.


  Commit: b8f916b7ee6eb99cee47cd65a5b52e4ece18c17e
      https://github.com/bluez/bluez/commit/b8f916b7ee6eb99cee47cd65a5b52e4ece18c17e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-12 (Wed, 12 Jul 2023)

  Changed paths:
    M unit/test-eir.c

  Log Message:
  -----------
  test-eir: Run tests using bt_ad

This enables the same tests done with eir_data using bt_ad.


  Commit: c62a4cb55183a38ac84ed312214a4671c994ca0b
      https://github.com/bluez/bluez/commit/c62a4cb55183a38ac84ed312214a4671c994ca0b
  Author: Rudi Heitbaum <rudi@heitbaum.com>
  Date:   2023-07-12 (Wed, 12 Jul 2023)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure: Fix check ell path for cross compiling

Use of AC_CHECK_FILE prevents cross compilation.
Instead use test to support cross compiling.


Compare: https://github.com/bluez/bluez/compare/838e15780729...c62a4cb55183
