Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34449C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiF3VTB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiF3VTA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:00 -0400
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B4545784
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:18:59 -0700 (PDT)
Received: from github.com (hubbernetes-node-a107d45.ash1-iad.github.net [10.56.202.78])
        by smtp.github.com (Postfix) with ESMTPA id E46D15E0295
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1656623938;
        bh=ic5h3jueMJ7HhY1414cYt/SqEldgxXfgh7eqXh+49XQ=;
        h=Date:From:To:Subject:From;
        b=LS6buzE3sDY2NaabjoiomFEUsJoA5jRdZ8wo6lwylykDSkELrjqtGPhxTSps7IRYr
         fgepcmXol3ZXSZzxlW5qeIWarGQNlAXGmMcMOQpu7WyPy+o7mTsLkUbUziljVtnXrH
         xK18egBsbipe6bZ3mcscYHaiaCIqz64UPVgiuzIE=
Date:   Thu, 30 Jun 2022 14:18:58 -0700
From:   Brian Gix <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5351d4-433a9f@github.com>
Subject: [bluez/bluez] 433a9f: monitor: Fix usage of %z formater for uint64_t
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
  Commit: 433a9fd13d46298706a752d86756a02a8d91bdf2
      https://github.com/bluez/bluez/commit/433a9fd13d46298706a752d86756a02a8d91bdf2
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-06-30 (Thu, 30 Jun 2022)

  Changed paths:
    M monitor/l2cap.h

  Log Message:
  -----------
  monitor: Fix usage of %z formater for uint64_t

%z expect a size_t as argument not uint64_t, so passing
an argument of type uint64_t shall use PRIx64 instead.


