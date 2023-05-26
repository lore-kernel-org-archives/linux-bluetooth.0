Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C9CC77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 23:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjEZXBU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 19:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEZXBT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 19:01:19 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D46AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 16:01:17 -0700 (PDT)
Received: from github.com (hubbernetes-node-f2ec2b3.va3-iad.github.net [10.48.220.39])
        by smtp.github.com (Postfix) with ESMTPA id D46085C05C6
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1685142076;
        bh=gkd3PNxWH3FoJxthaibRXs/SbbwzGv//xclptFFGmrY=;
        h=Date:From:To:Subject:From;
        b=gpe4+CA/SyQkyVqshis+sg8fBsI7c4Hp88bU0Yq4BVcqtv8NMZUn0GPE5ksZvKOeK
         bbosJjA67llMJsmbPrwf0DkhdJYkFSr/U6nqMeq8qINUyszyl1CgN3vA8PdH40UQFN
         uMt5pBg8K4OISynVZcCzU1DhSf/g6rOPrnJ9X1tc=
Date:   Fri, 26 May 2023 16:01:16 -0700
From:   silviubarbulescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/97f338-7002ec@github.com>
Subject: [bluez/bluez] 07c6d9: lib: Add macro definitions for BAP broadcast
 sourc...
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
  Commit: 07c6d9b1106545afb2dcbdd7c5ab067fd15310f0
      https://github.com/bluez/bluez/commit/07c6d9b1106545afb2dcbdd7c5ab067fd15310f0
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-05-26 (Fri, 26 May 2023)

  Changed paths:
    M lib/bluetooth.h
    M lib/mgmt.h
    M lib/uuid.h

  Log Message:
  -----------
  lib: Add macro definitions for BAP broadcast source support

This adds macro definitions for BAP broadcast source support.


  Commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
      https://github.com/bluez/bluez/commit/7002ecc8914ab1f22e36bd98c4d46eb760edf767
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-05-26 (Fri, 26 May 2023)

  Changed paths:
    M btio/btio.c
    M btio/btio.h

  Log Message:
  -----------
  btio: Add support for setsockopt (BT_IO_OPT_BASE)

This adds btio support for setting the BT_IO_OPT_BASE socket option.


Compare: https://github.com/bluez/bluez/compare/97f3386268fa...7002ecc8914a
