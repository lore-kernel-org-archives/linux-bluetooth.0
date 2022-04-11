Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D13C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiDKSq1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbiDKSq0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 14:46:26 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657C17A93
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 11:44:10 -0700 (PDT)
Received: from github.com (hubbernetes-node-495f34c.ac4-iad.github.net [10.52.125.68])
        by smtp.github.com (Postfix) with ESMTPA id 5519D5204C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1649702650;
        bh=hGjD45T6MrBLXGA3SKuFDxwKWlXcIgDoxivlFTP93c4=;
        h=Date:From:To:Subject:From;
        b=x7sw+ta5PyGfq8SjiO/l/nWH7hI0mt29ooorBved3PeF+V5WGJIAnDa/dTXinFeNQ
         Vhwb2e2X5N+pv+dP2RimJTg32DwiplmA+U9HLeS+737U87m7u0RC0DRo7unt5OIuTf
         mw7pWGRadpqdVzZtYXONlMChSJQnBJJ4C90AwyFw=
Date:   Mon, 11 Apr 2022 11:44:10 -0700
From:   Jakob Hilmer <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d1871f-7903bb@github.com>
Subject: [bluez/bluez] f547db: shell: Fix not being able to auto complete
 submenus
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
  Commit: f547db04fdc61a3fe45f0dc4e014d951ba687b7e
      https://github.com/bluez/bluez/commit/f547db04fdc61a3fe45f0dc4e014d951ba687b7e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-11 (Mon, 11 Apr 2022)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shell: Fix not being able to auto complete submenus

submenus should be part of the list of possible auto completes just as
other commands.


  Commit: 195d9b80e1a94f6bae954022979ea1350c95f7c2
      https://github.com/bluez/bluez/commit/195d9b80e1a94f6bae954022979ea1350c95f7c2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-11 (Mon, 11 Apr 2022)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shell: Fix not able to auto complete commands with submenu prefix

If the command was given with submenu prefix the code wasn't able to
detect the command to be able to generate the auto complete for its
arguments.


  Commit: 7903bbe1005bd05f542f64cf6af251f0f648d3ac
      https://github.com/bluez/bluez/commit/7903bbe1005bd05f542f64cf6af251f0f648d3ac
  Author: Jakob hilmer <jakob@hilmer.dk>
  Date:   2022-04-11 (Mon, 11 Apr 2022)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix check of DISCOVERABLE setting

The test for `DISCOVERABLE` should be done with
`MGMT_SETTING_DISCOVERABLE` instead of `MGMT_OP_SET_DISCOVERABLE`.
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Compare: https://github.com/bluez/bluez/compare/d1871fc93522...7903bbe1005b
