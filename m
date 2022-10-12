Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC09AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Oct 2022 21:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJLVp5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJLVpz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Oct 2022 17:45:55 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CACA28714
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 14:45:55 -0700 (PDT)
Received: from github.com (hubbernetes-node-34d90a0.ac4-iad.github.net [10.52.222.34])
        by smtp.github.com (Postfix) with ESMTPA id 88B1E520139
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1665611154;
        bh=ycSc89XejB1AqdaIw09rJwaxketvqQ6F9obTdaCTSFw=;
        h=Date:From:To:Subject:From;
        b=0OgxUS+bOLDWM1umCbx69Y3fIzqvfPC9rYuCA/Tc4ERJ6nwZDYVG4En4ciEXUbiI4
         DE0LxuMqtcuWbR/LRyUdEProIjsxpxAlTaj3LdBdyxH0Qz8vZLLIfr4CUqlZCmkxE0
         AfbLonpOoSo1pFhP8rWCsB6vmXMCwP/RGIfKPuSs=
Date:   Wed, 12 Oct 2022 14:45:54 -0700
From:   Isak Westin <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/906585-5f0647@github.com>
Subject: [bluez/bluez] 5f0647: mesh: Keep cancelled SAR data for at least 10
 sec
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
  Commit: 5f06473908d9e477574c59cb0854eacc38cfcf68
      https://github.com/bluez/bluez/commit/5f06473908d9e477574c59cb0854eacc38cfcf68
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-12 (Wed, 12 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Keep cancelled SAR data for at least 10 sec

When a SAR transmission has been completed or cancelled, the recipent
should store the block authentication values for at least 10 seconds
and ignore new segments with the same values during this period. See
MshPRFv1.0.1 section 3.5.3.4.


