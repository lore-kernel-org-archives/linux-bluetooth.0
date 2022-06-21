Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F646C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354275AbiFUUVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUVN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 16:21:13 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E6A1CFCD
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:21:12 -0700 (PDT)
Received: from github.com (hubbernetes-node-9dc8368.ac4-iad.github.net [10.52.125.51])
        by smtp.github.com (Postfix) with ESMTPA id 8A7EC600AA0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1655842871;
        bh=0qgJU0dmcXXGoemT3ivZmcFvNYPN6geKzOEF3qM+dQo=;
        h=Date:From:To:Subject:From;
        b=yDp/ZkK0INCKX9yGY9QMIddGzwhhs4NIhuJM+leniMkm7pwIjk0fuy4pluIM0qDl/
         6+JBgvAqfvnN+4OOjVOzR2B096U8XEjSQOfX8Y1rYVHLAQiZ6hFbbgWpXlvRlFUD6t
         4OdtDN/m5SfBf5+0rCe9jB+NoouC6UtmDtzxH954=
Date:   Tue, 21 Jun 2022 13:21:11 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/19ad43-71560e@github.com>
Subject: [bluez/bluez] 949898: avdtp: Free discover when send_request returns
 error
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
  Commit: 949898cc5e7f0657dff91f799718e54dc4cde723
      https://github.com/bluez/bluez/commit/949898cc5e7f0657dff91f799718e54dc4cde723
  Author: Chengyi <zhaochengyi@uniontech.com>
  Date:   2022-06-21 (Tue, 21 Jun 2022)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Free discover when send_request returns error

When send_request returns an error, session->discover should
be released here, so that the next time the program enters
avdtp_discover, the -EBUSY error will not be returned.


  Commit: 71560e12863ff1b133e421ef7dd25d20c8d83acc
      https://github.com/bluez/bluez/commit/71560e12863ff1b133e421ef7dd25d20c8d83acc
  Author: Jonas Maes <jonas@dptechnics.com>
  Date:   2022-06-21 (Tue, 21 Jun 2022)

  Changed paths:
    M mesh/mesh-io-generic.c

  Log Message:
  -----------
  mesh: Fix bug where bluetooth-meshd stops sending

When there is a backlog of mesh packets to be sent, the packet sender
Fix bug where bluetooth-meshd stops sending

When there is a backlog of mesh packets to be sent, the packet sender
incorrectly infers that the tx worker thread is already running
and therefore needn't be invoked. As a result, the mesh daemon will
sometimes stop broadcasting while there are still packets in the queue.
It will not resume broadcasting.

This patch will invoke the tx worker thread correctly in that case.

The logic to send packets at least twice when the transmitter is idle
was slightly modified accordingly, and should behave the same way as
before.


Compare: https://github.com/bluez/bluez/compare/19ad4310c9b4...71560e12863f
