Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86909C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 22:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJSWvK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJSWvJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:09 -0400
Received: from smtp.github.com (out-22.smtp.github.com [192.30.252.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EE8183E1B
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 15:51:06 -0700 (PDT)
Received: from github.com (hubbernetes-node-30ea504.ac4-iad.github.net [10.52.201.36])
        by smtp.github.com (Postfix) with ESMTPA id 7B9007207C2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1666219865;
        bh=mEXLeFvlaW4Co9QtpbIdw2+zunS55Rrci8xL+6s3x/U=;
        h=Date:From:To:Subject:From;
        b=B/w3TidpWO1AhUWtiqMGtgs6ausYRMwWBrpznz/2JT7djKHgTNPogP5gXPLxfTFBY
         RHNxe9IiKfvrna1hfwd27JSI3Rug/K4FYlqmR9t5FqjPfGPRV6mbMlSzxokx30n8KC
         NWxk/OOSxBxpLQ/Mxp5v6DDH0F6Lv5rcs+olxags=
Date:   Wed, 19 Oct 2022 15:51:05 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/68155e-3153b0@github.com>
Subject: [bluez/bluez] 3153b0: shared/util: Increase debug trace buffer size
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master=0D
  Home:   https://github.com/bluez/bluez=0D
  Commit: 3153b0ecfe16a885994a30463a498bfeff5ca650=0D
      https://github.com/bluez/bluez/commit/3153b0ecfe16a885994a30463a498=
bfeff5ca650=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-10-19 (Wed, 19 Oct 2022)=0D
=0D
  Changed paths:=0D
    M src/shared/util.c=0D
=0D
  Log Message:=0D
  -----------=0D
  shared/util: Increase debug trace buffer size=0D
=0D
Most of the debug traces are longer than 78 characters, increase the buff=
er=0D
to not lost trace's end=0D
=0D
=0D
