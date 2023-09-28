Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2389E743C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 20:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjI1UfN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UfM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 16:35:12 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490719C
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:35:08 -0700 (PDT)
Received: from github.com (hubbernetes-node-8a429ee.ash1-iad.github.net [10.56.15.72])
        by smtp.github.com (Postfix) with ESMTPA id 307983408BE
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1695933308;
        bh=9RyVQASBCbPrpivEnzk+lzEhbLhqHK4ssUCLtYyz17Y=;
        h=Date:From:To:Subject:From;
        b=Tiuqr5Fucednw89QuwC2os68ickahJ6lWhf18PdHNlpBHS0ZGKwpP5FR31Sg9wiqT
         nTe+of5NvlwzmWItmPLPdFBtNkekLl+7LAVruO6MKx/a+s9Jiu7jzO2mx+TVh4+aLy
         wdfe6HsHNR2WUys4c+6ZOddXYWUJdUIpgh6+tiSE=
Date:   Thu, 28 Sep 2023 13:35:08 -0700
From:   Marcel Holtmann <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5ab535-b05c3f@github.com>
Subject: [bluez/bluez] b05c3f: Release 5.70
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
  Commit: b05c3fbfd764a33dbaefbfb18680fa3296d4a31b
      https://github.com/bluez/bluez/commit/b05c3fbfd764a33dbaefbfb18680fa3296d4a31b
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-09-28 (Thu, 28 Sep 2023)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.70


