Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD6DE7C4F1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjJDULf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJDULf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 16:11:35 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAFDA6
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 13:11:31 -0700 (PDT)
Received: from github.com (hubbernetes-node-8a5d584.ash1-iad.github.net [10.56.157.33])
        by smtp.github.com (Postfix) with ESMTPA id 38BE4101005
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1696450291;
        bh=RHOu9/WyXV0Afv7u5ksfq4Q0x8GYb+onjhwxveTvgRw=;
        h=Date:From:To:Subject:From;
        b=IHXU/hRfFPKKn0x18nwBheqAMpIscYAScWTig8wZHGzCmxhqVcpAMci3+m30PI26x
         hCLGnrWAmZkOY3QpJSxcHEkFFaQM16raBO8D6Q/C1JTVjoYoJBjw9sRg9liu0ZT8+f
         sF8nUTWCw+xuL71drjsoWasYi3Kh9ZFNqN+fvm/A=
Date:   Wed, 04 Oct 2023 13:11:31 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6ee10e-f25371@github.com>
Subject: [bluez/bluez] 639301: adapter-api: Add Manufacturer and Version
 properties
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
  Commit: 6393012d4680e976a207a59962d38b88ec24c4fc
      https://github.com/bluez/bluez/commit/6393012d4680e976a207a59962d38b88ec24c4fc
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2023-10-04 (Wed, 04 Oct 2023)

  Changed paths:
    M doc/adapter-api.txt

  Log Message:
  -----------
  adapter-api: Add Manufacturer and Version properties

This adds Manufacturer and Version properties to org.bluez.Adapter1
interface.


  Commit: f2677c0153fda6ec30b615f8b449c95d0339a880
      https://github.com/bluez/bluez/commit/f2677c0153fda6ec30b615f8b449c95d0339a880
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2023-10-04 (Wed, 04 Oct 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Implement Version and Manufacturer properties

This allows DBus clients to find an adapter's version and
manufacturer company code without querying the management API.


  Commit: f253711c0e46cffe68a7c2361580b458520c121e
      https://github.com/bluez/bluez/commit/f253711c0e46cffe68a7c2361580b458520c121e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-04 (Wed, 04 Oct 2023)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print Manufacturer and Version on show command

This enables show to print the Manufaturer and Version information if
available:

bluetoothctl> show
...
	Manufacturer: 0x0002 (2)
	Version: 0x0b (11)


Compare: https://github.com/bluez/bluez/compare/6ee10e6df537...f253711c0e46
