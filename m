Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99220C001B1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 08:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjF3IfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjF3Iev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 04:34:51 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E2EF5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 01:34:50 -0700 (PDT)
Received: from github.com (hubbernetes-node-b317c54.va3-iad.github.net [10.48.130.35])
        by smtp.github.com (Postfix) with ESMTPA id B721041172
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1688114089;
        bh=tSyNaR8pUmPWQMoo4VE/cSHcSMQPhXFVMhRkONxqtuM=;
        h=Date:From:To:Subject:From;
        b=TnObMQVaCg+APH5/9a69yKUKFzE6C07VAQ6IZWy40c+KH+1b8v5+Hazkt+6CZCWB3
         J/XOXHuPWvoZ5pQ1vlVNhCUUe6VJVtuSe9imW07hMKwxRJr2lXoG44Ye2+bFIVY0So
         Wdxtfr9M3SJ8IIYX6nYkAI/61MHXMR/NCqbAB2FU=
Date:   Fri, 30 Jun 2023 01:34:49 -0700
From:   Marcel Holtmann <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/58c08e-d4b9d8@github.com>
Subject: [bluez/bluez] d4b9d8: Release 5.67
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
  Commit: d4b9d89f449128fe6d7571a7ba901c7c9df37b2e
      https://github.com/bluez/bluez/commit/d4b9d89f449128fe6d7571a7ba901c7c9df37b2e
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-06-30 (Fri, 30 Jun 2023)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.67


