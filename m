Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC71C4321E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Dec 2022 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiLCA1L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Dec 2022 19:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiLCA1C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Dec 2022 19:27:02 -0500
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CCCF4643
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 16:26:58 -0800 (PST)
Received: from github.com (hubbernetes-node-4109849.ash1-iad.github.net [10.56.15.43])
        by smtp.github.com (Postfix) with ESMTPA id 2A19E8405D3
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 16:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1670027218;
        bh=2ld0VwJyfLAn1ByN8xLOW5r6YHDVrUcHUeTIz46Ex+U=;
        h=Date:From:To:Subject:From;
        b=UE5VdCjm23nkdgUtxNvobsnqcuACBW2kpMcpKY8DR9Tulto+J3/IeiSfWF6iUo/Dq
         I7krW11EXXVSiV9rDW6dTRhhro9WkIou518+TTVCOm/iuMS7nk4zSGgdl1ZGORVjlE
         3zvdaoCfrhfx3lJ9mPH2c/xm57kFa9zGCIUzvWZE=
Date:   Fri, 02 Dec 2022 16:26:58 -0800
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d84ce7-35947e@github.com>
Subject: [bluez/bluez] 35947e: monitor/att: Fix crash when accessing
 packet_conn
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
  Commit: 35947e26771c89d965aec5ad059267bb8c15298e
      https://github.com/bluez/bluez/commit/35947e26771c89d965aec5ad059267bb8c15298e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix crash when accessing packet_conn

This fixes the following crash:

:monitor/att.c:2697:11: runtime error: member access within null
pointer of type 'struct att_conn_data'


