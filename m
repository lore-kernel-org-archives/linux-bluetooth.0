Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D1C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 05:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCPFhf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 01:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPFhe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 01:37:34 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A83A858
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 22:37:32 -0700 (PDT)
Received: from github.com (hubbernetes-node-84ff6e5.va3-iad.github.net [10.48.138.19])
        by smtp.github.com (Postfix) with ESMTPA id CBB595C0388
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 22:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1678945051;
        bh=08SWhqkT72E/b0EJchuH3s87CixFYu1pN4At3MjZ3Xc=;
        h=Date:From:To:Subject:From;
        b=OKJbisQpAm9BqWbe1cldZRt0ZjbhtmR8x+QXomZA4v/kSgp7eS6960PiReQX9vitU
         1W5+ARJaKoO+IDJ0c5/Fpb+ah1M4uXk1Tv727UT0YgRPPEFlhgwzPRHr8KqPokAhgu
         ZIn0n4f8W37MVUk89QQub6/x0yukD66mkYTLmPk4=
Date:   Wed, 15 Mar 2023 22:37:31 -0700
From:   Brian Gix <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7c0fb2-806230@github.com>
Subject: [bluez/bluez] a5998b: mesh: Filter originated Provisioning Data
 packets
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
  Commit: a5998b588c8646fb7709bbacad1cf872a94cc032
      https://github.com/bluez/bluez/commit/a5998b588c8646fb7709bbacad1cf872a94cc032
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-03-15 (Wed, 15 Mar 2023)

  Changed paths:
    M mesh/mesh-io-mgmt.c

  Log Message:
  -----------
  mesh: Filter originated Provisioning Data packets

The mesh daemon can process incoming mesh packets on more than one
controller, but if a Provisioning data packet that originated from the
local daemon is received by a different controller, it must be filtered
and disregarded, or it will break the provisioning protocol.


  Commit: c1f7aed635f39578cdb4a1870413278d29a081c5
      https://github.com/bluez/bluez/commit/c1f7aed635f39578cdb4a1870413278d29a081c5
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-03-15 (Wed, 15 Mar 2023)

  Changed paths:
    M mesh/mesh-io-mgmt.c

  Log Message:
  -----------
  mesh: Make MGMT mesh-io less noisy

Remove excessive logging traffic


  Commit: 806230e4fda7a2fafeb7f1da3d2f17a1bafb25f8
      https://github.com/bluez/bluez/commit/806230e4fda7a2fafeb7f1da3d2f17a1bafb25f8
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-03-15 (Wed, 15 Mar 2023)

  Changed paths:
    M mesh/remprv-server.c

  Log Message:
  -----------
  mesh: Don't send Prov Failed on non-existant links

If remote device does not respond to a Prov Link Open request, then the
callbacks do not get established, and attempting to send Failure
messages on the non-existent link rersult in seg fault.


Compare: https://github.com/bluez/bluez/compare/7c0fb2fefb6a...806230e4fda7
