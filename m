Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJEVSq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJEVSp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 17:18:45 -0400
Received: from smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140282608
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 14:18:45 -0700 (PDT)
Received: from github.com (hubbernetes-node-29e6b1e.va3-iad.github.net [10.48.205.50])
        by smtp.github.com (Postfix) with ESMTPA id A213D3407A5
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1665004724;
        bh=CBYTHgAuckW0i6SqtiXKaYgHaUh8kSmEOxl9itnsOe4=;
        h=Date:From:To:Subject:From;
        b=fqjRh73hVRawnoH0P3YsKHEjs6psM3jD1xYkiP829P0J98r/4yQfB1p8ii03MvqWC
         zv4HWYm/GRDYM0zCkOBDu1uh+JiidWFH/yPmDm+0w3S9P2yocX5hxj5zoSZoU3Wgym
         0usizjQziCjQDADwiQ6coEDdKuZxcIiESoi577h0=
Date:   Wed, 05 Oct 2022 14:18:44 -0700
From:   inga-s <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/fe9427-e71e11@github.com>
Subject: [bluez/bluez] e71e11: mesh: Fix mesh to work with
 MESH_IO_TYPE_UNIT_TEST
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
  Commit: e71e1103abc63df5ba445897036eabfda4de2a2d
      https://github.com/bluez/bluez/commit/e71e1103abc63df5ba445897036eabfda4de2a2d
  Author: Inga Stotland <inga.stotland@intel.com>
  Date:   2022-10-05 (Wed, 05 Oct 2022)

  Changed paths:
    M mesh/main.c
    M mesh/mesh-io.c

  Log Message:
  -----------
  mesh: Fix mesh to work with MESH_IO_TYPE_UNIT_TEST

This fixes mesh io flow for MESH_IO_TYPE_UNIT_TEST which
got broken after:
commit 9966cb8b6999a5f54fc13acbd7e1526512a84342
("mesh: Add new kernel MGMT based IO transport")


