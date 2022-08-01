Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50054C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 22:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiHAWW3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiHAWW1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 18:22:27 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F2B43325
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 15:22:25 -0700 (PDT)
Received: from github.com (hubbernetes-node-0be5730.ac4-iad.github.net [10.52.223.13])
        by smtp.github.com (Postfix) with ESMTPA id BEA6F600577
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1659392544;
        bh=RtVToo0MN1vRFK2X3wwVeuWcRPamvwImsJdkd5HYSfg=;
        h=Date:From:To:Subject:From;
        b=E1Tiu5vX6Na1NIa3/23v/Q4pNwxXiJ0VhHMNh+BBsuT1Hy0EeaAonMhKBM2qVv8sz
         0Uf0FLu6cR6P7dg6JIQbyqqId3b7DZHxUB7Ayau7yG54KE85ZqWb1r6ZIOZDLf7hYp
         k+jN3IWHBFINfGUT2AdBXh2Fwfvi9NU2Q8YP/6vk=
Date:   Mon, 01 Aug 2022 15:22:24 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9d7530-cb4237@github.com>
Subject: [bluez/bluez] cb4237: iso-test: Add ISO 48_2_1 Defer Send
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
  Commit: cb42377ae002c52ea436718aa99007bb8659f83a
      https://github.com/bluez/bluez/commit/cb42377ae002c52ea436718aa99007bb8659f83a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-28 (Thu, 28 Jul 2022)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-test: Add ISO 48_2_1 Defer Send

This adds ISO 48_2_1 Defer Send test which enables just output instead
of both.


