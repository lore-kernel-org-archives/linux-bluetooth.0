Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A1EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjF3WdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjF3WdF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:33:05 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9D3C24
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:33:02 -0700 (PDT)
Received: from github.com (hubbernetes-node-c199cc0.va3-iad.github.net [10.48.135.34])
        by smtp.github.com (Postfix) with ESMTPA id 2517E941063
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1688164382;
        bh=g2/LbJhl4aSRefhAmQKaQpJXbb9vpCGn8YSMe4+7JU0=;
        h=Date:From:To:Subject:From;
        b=k1HYEjfY6ROFz4KzJr9lCBlAdX5Y+7gEsd1zMI7zZ4B8XzEmDXNpErsd9mR2vfaD8
         uHMqk1C3byT+T4HKOEe8vIxSB6ViuUZ+Q+sJ2/5IzUtrmTCE14LZtW94xNkzWNk6PI
         SSlpeBgKNie2mECa6gjdcd43EuA3gprsBT7fC4Bc=
Date:   Fri, 30 Jun 2023 15:33:02 -0700
From:   Marcel Holtmann <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/19319b-d764f7@github.com>
Subject: [bluez/bluez] d764f7: Release 5.68
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
  Commit: d764f78f27653bc1df71c462e9aca7a18bc75f9f
      https://github.com/bluez/bluez/commit/d764f78f27653bc1df71c462e9aca7a18bc75f9f
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-06-30 (Fri, 30 Jun 2023)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.68


