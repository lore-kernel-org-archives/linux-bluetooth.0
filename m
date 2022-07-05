Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiGERq0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGERqY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 13:46:24 -0400
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE91BEAB
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 10:46:23 -0700 (PDT)
Received: from github.com (hubbernetes-node-559464a.ash1-iad.github.net [10.56.224.28])
        by smtp.github.com (Postfix) with ESMTPA id EE3575E0AAB
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1657043182;
        bh=Iu9pdYep8Du9Of8DrthTzK5btpY68DKjkOQy6Y6FrUA=;
        h=Date:From:To:Subject:From;
        b=dBBx4Z2NCdktmveWw9gtoBfZoMfu3E4Uc5HmlDJsK6YJSbqKoQ/CfzQew42DGBx7Y
         M1DvpSM8oZLtMpqdJEjKL4LeUTE3To6zjjQ2Lc3VW2ro3/f2WkoYjS4Hx83pmG7cn0
         pgsTmY1MIQ+fqJk4hw3oT5Q3pfmPEULlY8933h2M=
Date:   Tue, 05 Jul 2022 10:46:22 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/575778-e681fa@github.com>
Subject: [bluez/bluez] 6270ad: client: Fix build warning
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
  Commit: 6270ad35b2f7b71dbc0a76b825f2f3ca07f936d2=0D
      https://github.com/bluez/bluez/commit/6270ad35b2f7b71dbc0a76b825f2f=
3ca07f936d2=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-07-05 (Tue, 05 Jul 2022)=0D
=0D
  Changed paths:=0D
    M client/player.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client: Fix build warning=0D
=0D
This fixes the following build warning:=0D
=0D
      warning: =E2=80=98g_memdup=E2=80=99 is deprecated: Use 'g_memdup2' =
instead=0D
      [-Wdeprecated-declarations]=0D
=0D
=0D
  Commit: e681fae6bcceb73ebab16e6f8c4eabd6265dd40f=0D
      https://github.com/bluez/bluez/commit/e681fae6bcceb73ebab16e6f8c4ea=
bd6265dd40f=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-07-05 (Tue, 05 Jul 2022)=0D
=0D
  Changed paths:=0D
    M monitor/att.c=0D
=0D
  Log Message:=0D
  -----------=0D
  monitor: Fix build error in some targets=0D
=0D
This fixes the following error:=0D
=0D
monitor/att.c: In function 'print_attribute':=0D
monitor/att.c:1850:35: error: lvalue required as unary '&' operand=0D
                 print_uuid(label, &cpu_to_le16(uuid->value.u16), 2);=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/575778a45f84...e681fae6bc=
ce=0D
