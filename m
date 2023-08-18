Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB9EE4997
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 21:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjHRVJS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbjHRVIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 17:08:46 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6772421B
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 14:08:45 -0700 (PDT)
Received: from github.com (hubbernetes-node-05fbcf7.ac4-iad.github.net [10.52.135.36])
        by smtp.github.com (Postfix) with ESMTPA id 2585C700817
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692392925;
        bh=AnbxVy3+S3YYtkcDW9WszoOPlwhsKqkQRB2JeK8C88A=;
        h=Date:From:To:Subject:From;
        b=O2w2VqClgokuNUZIcAPehrxVlMRLodNz3aVUU+PBWA/s1SWmvRM8hXI3EmrEDFScC
         6A++v5y+YSWt+mB+Puy1mZw8p5z0Uw+SCYAlTqob1tdX0vGyWJuW58y2PN6PTAB+xh
         Zjd/HoT99iFnlu+GY67gtLrwbNmQT4dumhT92jR4=
Date:   Fri, 18 Aug 2023 14:08:45 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/60731c-0004eb@github.com>
Subject: [bluez/bluez] fb642e: bap: Set auto_connect
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
  Commit: fb642eced45f2048d4812a8cb86db487395b5694
      https://github.com/bluez/bluez/commit/fb642eced45f2048d4812a8cb86db487395b5694
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-17 (Thu, 17 Aug 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Set auto_connect

Patch 2a4cf63f2152 has reset the flag back to false when it shouldn't
so this revert it to its original behavior.


  Commit: 507ba12483c3b6504d7fc0abfbbe1b4a0c8fa006
      https://github.com/bluez/bluez/commit/507ba12483c3b6504d7fc0abfbbe1b4a0c8fa006
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-17 (Thu, 17 Aug 2023)

  Changed paths:
    M src/device.c
    M src/profile.h

  Log Message:
  -----------
  profile: Remove probe_on_discover

The concept of probing not connected devices is already supported when
loading devices from storage, so drivers shall already be capabable of
handling such a thing as there are dedicated callbacks to indicate when
there is a new connection in the form of .accept callback.


  Commit: cc7dbadb7236e5e9a7da5567f838b962a524df13
      https://github.com/bluez/bluez/commit/cc7dbadb7236e5e9a7da5567f838b962a524df13
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-18 (Fri, 18 Aug 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Don't attempt to set auto_connect for devices using RPAs

Device using private address cannot be programmed into the auto_connect
list without them being paired and its IRK being distributed otherwise
there is no way to resolve it address and the command will fail.


  Commit: 0004eb06d5d9a2f27521d9ce3b206d6f3f82c61e
      https://github.com/bluez/bluez/commit/0004eb06d5d9a2f27521d9ce3b206d6f3f82c61e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-18 (Fri, 18 Aug 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Restart temporary timer while connecting

If the device is temporary restart its timer when attempt to connect to
it since it can interrupt the connection attempt prematurely while it
still scanning, etc.


Compare: https://github.com/bluez/bluez/compare/60731cab5891...0004eb06d5d9
