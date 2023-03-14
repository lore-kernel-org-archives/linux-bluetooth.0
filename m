Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F08C7618B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 21:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCNViA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCNVh7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 17:37:59 -0400
Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743BA55060
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 14:37:53 -0700 (PDT)
Received: from github.com (hubbernetes-node-d1109c9.ash1-iad.github.net [10.56.206.57])
        by smtp.github.com (Postfix) with ESMTPA id CFA125E0383
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1678829872;
        bh=w1rVoSN1TMdN+l7FwKqBzz68vzSe6uVM5imDCzx1xRk=;
        h=Date:From:To:Subject:From;
        b=vg6QJrIbueeED5ehzpoNhh0FmUxCQ8p4ZDT22gydvDuMhPbuEz/KcmZFH0GeKO2kl
         dO6y5VtOjD4a8v63ZwO608oqbLdIMexhKnn4zTNx5FIvFnO+MjjyHZNs4h3nEPWSo7
         J0CX/OQZg/yP0C0j0gV7XkeWwlZY0QbgaskZJ9pc=
Date:   Tue, 14 Mar 2023 14:37:52 -0700
From:   Brian Gix <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/857d9b-7c0fb2@github.com>
Subject: [bluez/bluez] 5934f1: mesh: Fix uninitialized memory usage
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
  Commit: 5934f133d44aeda4e682bd15daf2dc93bb7d355f
      https://github.com/bluez/bluez/commit/5934f133d44aeda4e682bd15daf2dc93bb7d355f
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M mesh/manager.c

  Log Message:
  -----------
  mesh: Fix uninitialized memory usage

When attempting to cancel an unknown Scan request structure must be
NULL initialized.


  Commit: 7c0fb2fefb6a121f1ac56e39212ce4d64307eeff
      https://github.com/bluez/bluez/commit/7c0fb2fefb6a121f1ac56e39212ce4d64307eeff
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M mesh/mesh-io.c
    M mesh/remprv-server.c

  Log Message:
  -----------
  mesh: Loopback unprovisioned beacons

Because the daemon explicitly supports multiple nodes, we need
local Config Clients to be able to see local unprovisioned devices.

This loops the unprovisioned beacon, so that local Provisioning servers
can see it.

Fixes Issue: https://github.com/bluez/bluez/issues/341


Compare: https://github.com/bluez/bluez/compare/857d9b96b384...7c0fb2fefb6a
