Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0350C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 19:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCTTmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCTTma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 15:42:30 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4AE113EC
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:37:43 -0700 (PDT)
Received: from github.com (hubbernetes-node-bd0fe8f.va3-iad.github.net [10.48.109.80])
        by smtp.github.com (Postfix) with ESMTPA id 976F6E0546
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1679341060;
        bh=wF6TCquJ+JGIoFWBx7e3nnQ3rtaNes5C797mzGgWY6E=;
        h=Date:From:To:Subject:From;
        b=j+QdSYl0bEZANE0vHKu2T2KFSwTcCO97Zwg7aPeFkCqdHCHULl57Ye4TJI60kBZU8
         jS9nTkNW6oKlhe6FRkM5UY04C3mG8BALAD6L/A3js3cRwFLd0xiPBp9itjPawubhEm
         q6LotgfTt0p/amDX6DqH2kWVoP5H1CTSgd8XnXp4=
Date:   Mon, 20 Mar 2023 12:37:40 -0700
From:   inga-s <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/551a0c-4a3f46@github.com>
Subject: [bluez/bluez] 4a3f46: mesh: On exit free timer for filtering
 duplicates
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
  Commit: 4a3f465a55c9e2159d363a5419f3a5dbb965036d
      https://github.com/bluez/bluez/commit/4a3f465a55c9e2159d363a5419f3a5dbb965036d
  Author: Inga Stotland <inga.stotland@gmail.com>
  Date:   2023-03-20 (Mon, 20 Mar 2023)

  Changed paths:
    M mesh/mesh-io-mgmt.c

  Log Message:
  -----------
  mesh: On exit free timer for filtering duplicates

This frees resources associated with duplicate filter timer
when destroying management IO.


