Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A3AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiERWiG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiERWiF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:38:05 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909A8720D
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:38:02 -0700 (PDT)
Received: from github.com (hubbernetes-node-3c312f5.ac4-iad.github.net [10.52.207.59])
        by smtp.github.com (Postfix) with ESMTPA id 0884F6000AB
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1652913482;
        bh=usPw4tElOmX+3oP9i1V2pFpmfcljyUGT8jqGsmJ0nMU=;
        h=Date:From:To:Subject:From;
        b=TYoApvVIyzZJX+Ly+uf1vsItm5skhlNHL6/GmPi8JSveYJhxXKqPDyP3Q8n3fa6VH
         W6bNYpyjs8TJQO6+hLinblOMdjASRT4iBAlh/g62JfNi8eg0s7fy+hgyY+jQwfdsoN
         V5j9wmRBlHFipV3obNGURI5eO7hNuNnPjCOWmhi0=
Date:   Wed, 18 May 2022 15:38:02 -0700
From:   apusaka <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c7955b-c159d7@github.com>
Subject: [bluez/bluez] c159d7: input/device: Notify failure if ctrl disconnect
 wh...
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
  Commit: c159d790e8786581cfa5e5a9e7bd71458a343e44
      https://github.com/bluez/bluez/commit/c159d790e8786581cfa5e5a9e7bd71458a343e44
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Notify failure if ctrl disconnect when waiting intr

On some rare occasions, the peer HID device might disconnect the ctrl
channel when we are trying to connect the intr channel. If this
happens, interrupt_connect_cb() will not be called by btio, and we
will be stuck in "connecting" state. Any future connection attempt to
the peer device will fail because of "busy".

This patch prevents that by checking if we need to report connection
failure when the ctrl channel is disconnected.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>


