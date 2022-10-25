Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EEECDFA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 23:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiJYXqS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiJYXqQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 19:46:16 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F6DA23C8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 16:46:13 -0700 (PDT)
Received: from github.com (hubbernetes-node-51c8952.ac4-iad.github.net [10.52.200.82])
        by smtp.github.com (Postfix) with ESMTPA id 59CFA52089D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1666741573;
        bh=Bp1Ku4ngKgXEtvt7Dkx4JkSNUNvK2yYp11VCAce8MKM=;
        h=Date:From:To:Subject:From;
        b=VzwZcAms2ge1LEaNZtzwEhy7YTALBQrQZepgrqDN3bVcjjIezAc1k7iuNwQ2BZBTy
         5ezc3UnDGSSfbv4PXSlj9+55ZHedQy0nk64JkTs1XSZFiXn0a/HsRuNHZ3LDL394Y6
         NcQJJdr/rLZ581Zq2YFbSDlIh7Ahys0J4Bz9RngE=
Date:   Tue, 25 Oct 2022 16:46:13 -0700
From:   Tedd Ho-Jeong An <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/689932-f65b4d@github.com>
Subject: [bluez/bluez] f65b4d: doc/ci.config: Add configuration for CI test
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
  Commit: f65b4d5fc77f6ed23f79eebe37a3db6ef9f6cc7a
      https://github.com/bluez/bluez/commit/f65b4d5fc77f6ed23f79eebe37a3db6ef9f6cc7a
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-10-25 (Tue, 25 Oct 2022)

  Changed paths:
    A doc/ci.config

  Log Message:
  -----------
  doc/ci.config: Add configuration for CI test

This patch adds the bluetooth kernel config file used by CI test, which
enables all bluetooth features.


