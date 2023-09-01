Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A0CA0FEC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Sep 2023 17:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350416AbjIARJz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350413AbjIARJy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Sep 2023 13:09:54 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357010FE
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Sep 2023 10:09:34 -0700 (PDT)
Received: from github.com (hubbernetes-node-20d75b3.ac4-iad.github.net [10.52.12.44])
        by smtp.github.com (Postfix) with ESMTPA id 69BE11E06B0
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Sep 2023 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1693588173;
        bh=vw5THHqGjue83LAx+rx+cSFPlNywW4C0EoS+2JGUUG8=;
        h=Date:From:To:Subject:From;
        b=W8ErkeHYRP1oX8CvH1+FD+Ad/7H/xcIgbLKNfLYSa1KPFrqAadozfxDa5oi7HULLa
         Gw/ypBNIhvnSmRBTUM7R6IEIrFTeN1B2wjYep/F8JQRgRcbrLViSh6k8RSBzcmvGZ2
         MyxhLML8ylPptvEVteV5ghdH43PO8KeS+cSj2WpY=
Date:   Fri, 01 Sep 2023 10:09:33 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/530afa-d06b91@github.com>
Subject: [bluez/bluez] c7fd93: monitor: Fix runtime error
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
  Commit: c7fd9310b925e2399be4e0e5fa23be5295b02d7e
      https://github.com/bluez/bluez/commit/c7fd9310b925e2399be4e0e5fa23be5295b02d7e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-31 (Thu, 31 Aug 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix runtime error

This fixes the following runtime error:

monitor/packet.c:10476:2: runtime error: division by zero
Floating point exception


  Commit: d06b912df5abbf1cc046389c36726edd28b373d3
      https://github.com/bluez/bluez/commit/d06b912df5abbf1cc046389c36726edd28b373d3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-01 (Fri, 01 Sep 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not always calling bap_io_close on disconnect

bap_io_disconnected was getting registered for all links while
connecting which prevented bap_io_close to be called when ISO socket is
disconnected thus the cig_active flag will remain set preventing the IO
to be recreated.


Compare: https://github.com/bluez/bluez/compare/530afa43ec29...d06b912df5ab
