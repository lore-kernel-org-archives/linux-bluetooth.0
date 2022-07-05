Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6AC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 17:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiGER1C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGER1B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 13:27:01 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD120187
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 10:27:00 -0700 (PDT)
Received: from github.com (hubbernetes-node-7b40740.ac4-iad.github.net [10.52.207.48])
        by smtp.github.com (Postfix) with ESMTPA id 4812A6009F1
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1657042020;
        bh=Cv9KFzXnYCZzIutr8L1mbCzjAQgQOPg+1aTFEJEm57I=;
        h=Date:From:To:Subject:From;
        b=cP+SWl7nU/lmpDlF52e5iCr9evrm09/CTzwocP8VXV04EYVBQpcPMtcBj35KK2XC2
         VqWMR2zWtezT3TYv/y9dvlhhSSjQrDqJccx+Kj7o6hFyGiDW9uJLmtt7CR6OV7GDT6
         dg7tUTLRTPzioMSrnjbBcXI/1tonJd8WSsDdY4rM=
Date:   Tue, 05 Jul 2022 10:27:00 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dd12ff-575778@github.com>
Subject: [bluez/bluez] 575778: obexd: Fix the code style
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
  Commit: 575778a45f84a665e66074ef1e86926e5380f42e
      https://github.com/bluez/bluez/commit/575778a45f84a665e66074ef1e86926e5380f42e
  Author: Youwan Wang <wangyouwan@uniontech.com>
  Date:   2022-07-05 (Tue, 05 Jul 2022)

  Changed paths:
    M obexd/client/session.c

  Log Message:
  -----------
  obexd: Fix the code style


