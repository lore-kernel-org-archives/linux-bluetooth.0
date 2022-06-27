Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4867C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jun 2022 08:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiF0I1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiF0I1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jun 2022 04:27:48 -0400
Received: from smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C6624C
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 01:27:43 -0700 (PDT)
Received: from github.com (hubbernetes-node-6d2abdf.va3-iad.github.net [10.48.14.15])
        by smtp.github.com (Postfix) with ESMTPA id A9ED45C0AEA
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1656318462;
        bh=Nyh574iC6mkr87LFi1tHN4DX6syVig5wroP24MlinrQ=;
        h=Date:From:To:Subject:From;
        b=bDeC6XCzFCR8p2YVVxHzgnbqLhFfFtTnThpPS6oM6pZTxDXy4xEsrga6OhDQTRAff
         Zq/gCMN9/z5sadUZpi1OMJgHYecQIfLxzhSTldyo6g+dSVLG5LqQ70vuQeWgPnZaG6
         /iOE97pB8IOUOKaGhQYjYoGHRY340EajvMFW4L0M=
Date:   Mon, 27 Jun 2022 01:27:42 -0700
From:   Szymon Janc <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/65f7fa-1d6cfb@github.com>
Subject: [bluez/bluez] 1d6cfb: monitor: Fix crash when using RTT backend
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
  Commit: 1d6cfb8e625a944010956714c1802bc1e1fc6c4f
      https://github.com/bluez/bluez/commit/1d6cfb8e625a944010956714c1802bc1e1fc6c4f
  Author: Szymon Janc <szymon.janc@codecoup.pl>
  Date:   2022-06-27 (Mon, 27 Jun 2022)

  Changed paths:
    M monitor/jlink.c

  Log Message:
  -----------
  monitor: Fix crash when using RTT backend

This fix regression introduced by "monitor: Fix memory leaks".
J-Link shared library is in use if jlink_init() returns 0 and thus
handle shall not be closed.


