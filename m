Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF69CDB474
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 22:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442986AbjJLWP6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 18:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442960AbjJLWP6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 18:15:58 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12DB8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 15:15:56 -0700 (PDT)
Received: from github.com (hubbernetes-node-4d7919d.ac4-iad.github.net [10.52.206.76])
        by smtp.github.com (Postfix) with ESMTPA id 43E0270091B
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1697148956;
        bh=W5Kg+GOWS7vfoIOBV6nd38Y1w5v62AqrxBjWsmfxOh0=;
        h=Date:From:To:Subject:From;
        b=lKFXajlsvqOkTA+KhNmsYF3b/pMl8awfQASfisyV5y0TFdiLs9QYE6xFGWW87rCyz
         9ulkpFPHJikGYFnD4Fjy0QNCerAwNEYtF9hgxZF+mYKDkh+vLTEfgiGDKTeX9bM4gl
         vINr9zZS8WA8vGp7F5pNfvJKLTZ74zIZFeHKFGsY=
Date:   Thu, 12 Oct 2023 15:15:56 -0700
From:   silviubarbulescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/afb47b-e34779@github.com>
Subject: [bluez/bluez] 345ad5: doc/obex-*-api: Rename to org.bluez.obex.*.rst
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
  Commit: 345ad5e352b1b77c18ceecb06523a0d1352dee38
      https://github.com/bluez/bluez/commit/345ad5e352b1b77c18ceecb06523a0d1352dee38
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-12 (Thu, 12 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/obex-agent-api.txt
    R doc/obex-api.txt
    A doc/org.bluez.obex.Agent.rst
    A doc/org.bluez.obex.AgentManager.rst
    A doc/org.bluez.obex.Client.rst
    A doc/org.bluez.obex.FileTransfer.rst
    A doc/org.bluez.obex.Message.rst
    A doc/org.bluez.obex.MessageAccess.rst
    A doc/org.bluez.obex.ObjectPush.rst
    A doc/org.bluez.obex.PhonebookAccess.rst
    A doc/org.bluez.obex.Session.rst
    A doc/org.bluez.obex.Synchronization.rst
    A doc/org.bluez.obex.Transfer.rst

  Log Message:
  -----------
  doc/obex-*-api: Rename to org.bluez.obex.*.rst

This renames obex-*-api.txt to org.bluez.obex.*.rst and generate
manpages org.bluez.obex.*.5.


  Commit: 052534ae07b89bb947daadfa7eb11704db599bcb
      https://github.com/bluez/bluez/commit/052534ae07b89bb947daadfa7eb11704db599bcb
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-10-12 (Thu, 12 Oct 2023)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Update transport release flow for bcast src

Update transport release flow for broadcast source


  Commit: e347792f41a8ab2cf4f789b6544a4f8ec8464a53
      https://github.com/bluez/bluez/commit/e347792f41a8ab2cf4f789b6544a4f8ec8464a53
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-10-12 (Thu, 12 Oct 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Update transport acquire/release flow for bcast src

Update transport acquire/release flow for BAP bcast source


Compare: https://github.com/bluez/bluez/compare/afb47b13c600...e347792f41a8
