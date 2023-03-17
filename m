Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B4BC7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 20:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCQUiB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQUiB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 16:38:01 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F4B8617
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:37:58 -0700 (PDT)
Received: from github.com (hubbernetes-node-abc436b.va3-iad.github.net [10.48.145.22])
        by smtp.github.com (Postfix) with ESMTPA id 5788DE003D
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1679085478;
        bh=eUIJEmlMrLeK7zN4DWhuLbddygCewAEjGk0jOqwIddA=;
        h=Date:From:To:Subject:From;
        b=AQrrqenAicwifchxcqEyyjQyJD0p/94ctN5BUn0KGozfeZy+Nhm1wDosvhTKnuEay
         6Fx7sEYMYiamPUUaz/ghYTMgA075oXgRqp5+x4c+dBRF63+w18RB8VQJy+oTjJiwdX
         3JcSzpVMm83iYa37l3qy2P+0VzfC3x7gny3ig4Yo=
Date:   Fri, 17 Mar 2023 13:37:58 -0700
From:   inga-s <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/39260c-551a0c@github.com>
Subject: [bluez/bluez] bc9619: tools/mesh-cfgclient: Prevent storing duplicate
 mo...
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
  Commit: bc961998a842529a12d5fcb590d4435022c9fcbe
      https://github.com/bluez/bluez/commit/bc961998a842529a12d5fcb590d4435022c9fcbe
  Author: Inga Stotland <inga.stotland@gmail.com>
  Date:   2023-03-17 (Fri, 17 Mar 2023)

  Changed paths:
    M tools/mesh/mesh-db.c
    M tools/mesh/remote.c

  Log Message:
  -----------
  tools/mesh-cfgclient: Prevent storing duplicate models

This fixes the situation when subsequent requests to get a node
composition result in appending element's model list with duplicate models.
This adds a check for a presence of a model on an element when attempting
to add a new model ID to a model list on this element.


  Commit: 551a0c80ab33332920b966dbd7e6761a1b640ed6
      https://github.com/bluez/bluez/commit/551a0c80ab33332920b966dbd7e6761a1b640ed6
  Author: Inga Stotland <inga.stotland@gmail.com>
  Date:   2023-03-17 (Fri, 17 Mar 2023)

  Changed paths:
    M tools/mesh-cfgclient.c
    M tools/mesh/cfgcli.c
    M tools/mesh/cfgcli.h
    M tools/mesh/util.c

  Log Message:
  -----------
  tools/mesh-cfgclient: Auto request own composition data

When attaching a local provisioner node, always request own
composition data to accommodate functional consolidation of
regular and remote provisioning mechanisms.
The knowledge of the own node composition is necessary for
provisioning initiation and self configuration.


Compare: https://github.com/bluez/bluez/compare/39260c3cfa05...551a0c80ab33
