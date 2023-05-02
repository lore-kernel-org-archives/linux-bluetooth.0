Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43474C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 16:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjEBQkg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjEBQke (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 12:40:34 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D59E78
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 09:40:29 -0700 (PDT)
Received: from github.com (hubbernetes-node-5b0aef3.va3-iad.github.net [10.48.142.39])
        by smtp.github.com (Postfix) with ESMTPA id 7F4E0340508
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1683045628;
        bh=Imwx2DCcPZ2UfFB+Hbzq9H6g877leoa5yDIWm7sDuuo=;
        h=Date:From:To:Subject:From;
        b=ll7eZP7rOCVjk2Fo9lWapIRzBKQ3Tob6wnTAn0Z2V+Vlec6CtzizchNXbksBWV3c4
         hXyldz+06lMb5fjjQLsIEEEq42rzGGa5PhPtepG1G3LvLwlAYt5AxC+aYdyGQebWWR
         tpT2CGQdJmdAXrEhu7VhEU5mlfoVJTFsYflSP5jU=
Date:   Tue, 02 May 2023 09:40:28 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/083e66-3818b9@github.com>
Subject: [bluez/bluez] f9376b: client/player: Add support for Metadata in BAP
 Pro...
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
  Commit: f9376b13b3fe67430239037fbfc28ad2828bd3b3
      https://github.com/bluez/bluez/commit/f9376b13b3fe67430239037fbfc28ad2828bd3b3
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2023-04-28 (Fri, 28 Apr 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for Metadata in BAP Profile

This adds support for Metadata in BAP profile.
In order to register zero Metadata, 0 shall be
entered when prompted.

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Enter Metadata (value/no): n
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep0 registered


  Commit: 416b8375ffde990c1ec443be0961b9ada38da75b
      https://github.com/bluez/bluez/commit/416b8375ffde990c1ec443be0961b9ada38da75b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-01 (Mon, 01 May 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix crash when RegisterEndpoint fails

If RegisterEndpoint fails when there are multiple adapters it would
attempt to free the same endpoint multiple times.


  Commit: 0b88ee29ff1d174fa54d3e462fb0ebc890da3bf4
      https://github.com/bluez/bluez/commit/0b88ee29ff1d174fa54d3e462fb0ebc890da3bf4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-01 (Mon, 01 May 2023)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not releasing prompt

This fixes not releasing prompt when queueing a line to be executed
since it can be considered as user input if the init script is
attempting to enter it as response to prompt input.


  Commit: 3818b99c764efe84cd3455081f6392c256564085
      https://github.com/bluez/bluez/commit/3818b99c764efe84cd3455081f6392c256564085
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-01 (Mon, 01 May 2023)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix smatch warning

This fixes the following warning:

src/shared/shell.c:615:21: warning: non-ANSI function declaration of
function 'bt_shell_usage'


Compare: https://github.com/bluez/bluez/compare/083e66d3ac2d...3818b99c764e
