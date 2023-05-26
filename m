Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D4EC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 22:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjEZWbR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 18:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZWbQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 18:31:16 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6C2A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:31:15 -0700 (PDT)
Received: from github.com (hubbernetes-node-5b0aef3.va3-iad.github.net [10.48.142.39])
        by smtp.github.com (Postfix) with ESMTPA id 644D8E0205
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1685140274;
        bh=/2UtiWqmboYagBVha8HbJ3gYaLYpz/IrTe8eQ/SkgzA=;
        h=Date:From:To:Subject:From;
        b=Z6iDx9c4R0Xqsk+gME7JWPw7z3G9ATKm92XAxSHVfVtE/qyRIKNyo9zPLpJS7oQ0r
         PQSoyr7ErquEf/owLZY7PrVZ8wdtOfe1zvd0oAmPLLxsnDgDyemYPH3rmpnxVpE/oy
         rejfL9nXuCIeMllsLOoU5KxsXtpfqT5Zac0tcnbg=
Date:   Fri, 26 May 2023 15:31:14 -0700
From:   silviubarbulescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/718f27-97f338@github.com>
Subject: [bluez/bluez] ec8535: monitor: Print process information
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
  Commit: ec85350c4803b2966249537ea696031304260b91
      https://github.com/bluez/bluez/commit/ec85350c4803b2966249537ea696031304260b91
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-25 (Thu, 25 May 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print process information

This prints the process information when available:

bluetoothd[35]: @ MGMT Command: Rea.. (0x0001) plen 0  {0x0001}
@ MGMT Event: Command Complete (0x0001) plen 6         {0x0001}
    Read Management Version Information (0x0001) plen 3


  Commit: f808fa065396ff31e7f7a73f5cb855142dad475b
      https://github.com/bluez/bluez/commit/f808fa065396ff31e7f7a73f5cb855142dad475b
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-05-26 (Fri, 26 May 2023)

  Changed paths:
    M doc/media-api.txt
    M doc/mgmt-api.txt

  Log Message:
  -----------
  doc: Update Docs for BAP broadcast source

This adds broadcast properties to the SetConfiguration method and
bits for Broadcast support to the Supported_Settings bitmask.


  Commit: 97f3386268faec3c748765f4fcbb4fb80978407f
      https://github.com/bluez/bluez/commit/97f3386268faec3c748765f4fcbb4fb80978407f
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-05-26 (Fri, 26 May 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode broadcast bits of MGMT settings

This adds bits for broadcast support to mgmt_settings_table.


Compare: https://github.com/bluez/bluez/compare/718f27d09fc1...97f3386268fa
