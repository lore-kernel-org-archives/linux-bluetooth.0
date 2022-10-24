Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F38C67871
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 00:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJYAuE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiJYAt3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Oct 2022 20:49:29 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 16:27:32 PDT
Received: from o11.sgmail.github.com (o11.sgmail.github.com [167.89.101.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536384C2E6
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to:
        cc;
        s=smtpapi; bh=dVqQ3r1IjEx/AMxYPdfsEiG8FuRr29Obx3akB6q3FiY=;
        b=SWfZ4zmT+m99vYLt8eSZ3bn6PxUVArWTlqfi8ktcWWV0NAY7dyn0uG3H8Ts1R6/GnbM0
        dOQZbbScVqUfEUeqLeVpSNDBtqv0D6YGokUBPKn5HnsBybMQdqgYSqPi4/QgHZQh3wsfP6
        NEVSuDXPeUZS58pHY1XGuEJIm3nbdAyNU=
Received: by filterdrecv-5c575ccb78-wllxt with SMTP id filterdrecv-5c575ccb78-wllxt-1-6356F467-E
        2022-10-24 20:24:07.123017064 +0000 UTC m=+2327738.891758829
Received: from out-24.smtp.github.com (unknown)
        by geopod-ismtpd-2-0 (SG)
        with ESMTP id wjn7QN9sRKChSkmkh8QZSA
        for <linux-bluetooth@vger.kernel.org>;
        Mon, 24 Oct 2022 20:24:07.009 +0000 (UTC)
Received: from github.com (hubbernetes-node-34c0388.ac4-iad.github.net [10.52.208.15])
        by smtp.github.com (Postfix) with ESMTPA id DC26A600201
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 13:24:01 -0700 (PDT)
Date:   Mon, 24 Oct 2022 20:24:07 +0000 (UTC)
From:   xiaoyao <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/c88367-689932@github.com>
Subject: [bluez/bluez] 689932: monitor: Ellisys: Add iso packet support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?cDJdhjFqQejEwX1KKzz6HoJpQW986V1xIZKQquWmvULJM0PO32gHaltG1v4qMu?=
 =?us-ascii?Q?Adc1H7629mrwQq6v7Sgc4HhTvZ0y5ZSUxOzZNeL?=
 =?us-ascii?Q?taxK5hfteMAxoxHeaA1pFAUeRRcmLMByCA+TUNi?=
 =?us-ascii?Q?OVb65lsXkbWYGsn8F9zsN5nRR=2FNsQQpXhnhoKyU?=
 =?us-ascii?Q?kw0OKvKOZmmoMFBjG+vyjeazt1L24RIKgHdRE16?=
 =?us-ascii?Q?uCIl7ToZDoL7gWHC=2FbVefmVmmvmsi3EaCtJQFr?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 6899322b68e546b545ce3f6db1c569c64a90fdd7
      https://github.com/bluez/bluez/commit/6899322b68e546b545ce3f6db1c569c64a90fdd7
  Author: Yao Xiao <xiaoyao@rock-chips.com>
  Date:   2022-10-24 (Mon, 24 Oct 2022)

  Changed paths:
    M monitor/ellisys.c

  Log Message:
  -----------
  monitor: Ellisys: Add iso packet support

Ellisys Bluetooth Analyzer Injection API Services.pdf

HCI Packet Type Object
Value   HCI Packet Type
0x05    HCI ISO Data (host to controller)
0x85    HCI ISO Data (controller to host)


