Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiDSA3G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiDSA2s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 20:28:48 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6562237DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 17:26:04 -0700 (PDT)
Received: from github.com (hubbernetes-node-daebbff.ash1-iad.github.net [10.56.14.93])
        by smtp.github.com (Postfix) with ESMTPA id 00766901574
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1650327964;
        bh=24KWCKETl264csMMBX6fZT+Q9d4SwUVNiUidXt5V6Wk=;
        h=Date:From:To:Subject:From;
        b=UqhixoMpjLMRUOwc4nsWMArUIu0rhXwNsOg0WwzlDVd8w8mLdniblW1/gwDSoPI7K
         X0XiQSQlUWWdF03TIhcweee2TKzRKCjwusLkBt3ub9a8z4A+zr2IWXc8sAKViCu1qN
         m1dY6RRzmtvNFkTvN4ylAHOWEYYKLt7pVjJ0FcbI=
Date:   Mon, 18 Apr 2022 17:26:03 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/036024-b2db8f@github.com>
Subject: [bluez/bluez] 46f171: client/player: Add endpoint menu
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
  Commit: 46f171a86c17d7e36ac7f334fd94fe55793def4a
      https://github.com/bluez/bluez/commit/46f171a86c17d7e36ac7f334fd94fe55793def4a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-14 (Thu, 14 Apr 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add endpoint menu

This adds endpoint menu:

[bluetooth]# menu endpoint
Menu endpoint:
Available commands:
-------------------
list [local]                                      List available endpoints
show <endpoint>                                   Endpoint information
register <UUID> <codec> [capabilities...]         Register Endpoint
unregister <UUID/object>                          Register Endpoint
config <endpoint> <local endpoint> [preset]       Configure Endpoint
presets <UUID> [default]                          List available presets


  Commit: 777bc7c3f50c769ef1133e5bd598f300a060d3f5
      https://github.com/bluez/bluez/commit/777bc7c3f50c769ef1133e5bd598f300a060d3f5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-14 (Thu, 14 Apr 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add transport menu

This adds transport menu:

[bluetooth]# menu transport
Menu transport:
Available commands:
-------------------
list                                              List available transports
show <transport>                                  Transport information
acquire <transport>                               Acquire Transport
release <transport>                               Release Transport
send <filename>                                   Send contents of a file


  Commit: 180cf09933b2d8eb03972c8638063429fe5fece5
      https://github.com/bluez/bluez/commit/180cf09933b2d8eb03972c8638063429fe5fece5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-14 (Thu, 14 Apr 2022)

  Changed paths:
    M plugins/policy.c
    M src/main.conf

  Log Message:
  -----------
  policy: Change AutoEnable default to true

This changes the default of AutoEnable to true so controllers are power
up by default.

Fixes: https://github.com/bluez/bluez/issues/328


  Commit: 5fb27418e7decc30000f57f2f7911dd25c24cb59
      https://github.com/bluez/bluez/commit/5fb27418e7decc30000f57f2f7911dd25c24cb59
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-18 (Mon, 18 Apr 2022)

  Changed paths:
    M profiles/audio/a2dp.c
    M src/adapter.c
    M src/device.c
    M src/storage.c
    M src/textfile.c
    M src/textfile.h

  Log Message:
  -----------
  storage: Add support for STATE_DIRECTORY environment variable

When running as a systemd service the STATE_DIRECTORY environment
variable maybe set:

https://www.freedesktop.org/software/systemd/man/systemd.exec.html


  Commit: 385e8d649e062e3b265b0970fa5e15107084cd2e
      https://github.com/bluez/bluez/commit/385e8d649e062e3b265b0970fa5e15107084cd2e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-18 (Mon, 18 Apr 2022)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Add support for CONFIGURATION_DIRECTORY environment variable

When running as a systemd service the CONFIGURATION_DIRECTORY
environment variable maybe set:

https://www.freedesktop.org/software/systemd/man/systemd.exec.html


  Commit: 0905a06410d4a5189f0be81e25eb3c3e8a2199c5
      https://github.com/bluez/bluez/commit/0905a06410d4a5189f0be81e25eb3c3e8a2199c5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-18 (Mon, 18 Apr 2022)

  Changed paths:
    M src/bluetooth.service.in

  Log Message:
  -----------
  build: Make use of StateDirectory and ConfigurationDirectory

This makes use of StateDirectory[1] and ConfigurationDirectory[1] to
inform systemd what those paths are used for instead of using
ReadWritePaths and ReadOnlyPaths which can lead to issues.

Fixes: https://github.com/bluez/bluez/issues/329

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html


  Commit: fb4997fb09fa8fce83ba3b41c7aebec45e789b1f
      https://github.com/bluez/bluez/commit/fb4997fb09fa8fce83ba3b41c7aebec45e789b1f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-18 (Mon, 18 Apr 2022)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add dedicated option to start D-Bus

This adds a dedicated option to start D-Bus alone which can be useful
when testing the bluetoothd with the likes of valgrind.


  Commit: b2db8f0e3a69872c4f10d18d70af260abaebdd57
      https://github.com/bluez/bluez/commit/b2db8f0e3a69872c4f10d18d70af260abaebdd57
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-18 (Mon, 18 Apr 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix use of unsupported config_qos

QoS is not yet supported by bluetoothd so remove them.


Compare: https://github.com/bluez/bluez/compare/03602479bd7b...b2db8f0e3a69
