Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60835C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 20:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiEIUYl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEIUYG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 16:24:06 -0400
Received: from smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACE224A4B
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 13:07:08 -0700 (PDT)
Received: from github.com (hubbernetes-node-1591364.va3-iad.github.net [10.48.209.51])
        by smtp.github.com (Postfix) with ESMTPA id 3E479340155
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1652126828;
        bh=M/+GpVNVp9Lo71ezC6tQH31uw+e25GCTEmP7pVS46ic=;
        h=Date:From:To:Subject:From;
        b=qaNLA2r2eFSTPnMSAGe/YS89KOSXwd449EPD73t4hGIoFq3Fgb3ngpwQ9114FRCdp
         qAF5u3x0Vymd5wbmffgTAJPeEQpBAByxnA5DG+Ew+pEQXjrKITM2EJy/AjFRacE0fI
         QWg3y6xFydt6lyfeXyEFIG4+wcojGmUsxTUp9q0A=
Date:   Mon, 09 May 2022 13:07:08 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7ce093-f0106d@github.com>
Subject: [bluez/bluez] f0106d: advertising: Treat empty LocalName the same as
 omi...
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
  Commit: f0106d92a1e04950a1ddd28fbcdb480cbd050d43
      https://github.com/bluez/bluez/commit/f0106d92a1e04950a1ddd28fbcdb480cbd050d43
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-06 (Fri, 06 May 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Treat empty LocalName the same as omitting it

This treats empty LocalName ("") the same as omitting it so not name is
set in the advertising data since some D-Bus binding seems to have
problems to omit properties at runtime.

Fixes: https://github.com/bluez/bluez/issues/337


