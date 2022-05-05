Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B22C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 00:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiEEAeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 20:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiEEAdw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 20:33:52 -0400
Received: from smtp.github.com (out-22.smtp.github.com [192.30.252.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A3AD76
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 17:30:14 -0700 (PDT)
Received: from github.com (hubbernetes-node-bea49b0.ac4-iad.github.net [10.52.207.42])
        by smtp.github.com (Postfix) with ESMTPA id 7766C7205EF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1651710613;
        bh=LuZbFKjm0qRqfQB6y39ImPxMhVjvLFtwYjRGplYa+38=;
        h=Date:From:To:Subject:From;
        b=vOaP/Vr+1I9vnLtK49hV6BPhdLnJcoWaiyntYZCW0Nh24YvpLiYmNNO0UBwIDFzoe
         8In1gkZMcyh0VM171bjIFAv6Z6r8OsKp/qSCh7nMIZzVOl9CNHegQxIFP5cnsZhd6D
         r+1pzjLS21iSIBg9AiH5ztu4ubO0Kxj7HLpFWMY8=
Date:   Wed, 04 May 2022 17:30:13 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bda2a9-7ce093@github.com>
Subject: [bluez/bluez] 7ce093: device-api: Clarify Paired/Bonded documentation
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
  Commit: 7ce093041a19b7195ddab6940e62587edc7b99ea
      https://github.com/bluez/bluez/commit/7ce093041a19b7195ddab6940e62587edc7b99ea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-04 (Wed, 04 May 2022)

  Changed paths:
    M doc/device-api.txt

  Log Message:
  -----------
  device-api: Clarify Paired/Bonded documentation

This attempt to clarify the distinction of Paired and Bonded
properties.


