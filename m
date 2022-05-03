Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 May 2022 01:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiECBSW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 21:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiECBRw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 21:17:52 -0400
Received: from o10.sgmail.github.com (o10.sgmail.github.com [167.89.101.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67524D5F
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to;
        s=smtpapi; bh=SG7tvEA6khBbiVlGaMzPBKJ3Lt2tgRdZiT/8VbqYl0w=;
        b=zUClZhl2ipH3pZd9sKez/jWf37f7uPJUn09Zzl3CsYM2zK4kQLb724VJoybgFzs4EE5H
        C8O02G9nb8rEK+ZYgCVy5z70T5zPr11kelVvYAP1XpMv7QlMjLY7QeIUwYdAzcfZvnkZ+o
        wBq8fjbo6QlktGtuPxfb7mTS0FvWwb660=
Received: by filterdrecv-644fcdb6d6-q2rrs with SMTP id filterdrecv-644fcdb6d6-q2rrs-1-627077F1-10B
        2022-05-03 00:31:45.973278606 +0000 UTC m=+2255969.519603733
Received: from out-24.smtp.github.com (unknown)
        by geopod-ismtpd-5-2 (SG)
        with ESMTP id UKtoE4l2QNCoCi-tBd9dxw
        for <linux-bluetooth@vger.kernel.org>;
        Tue, 03 May 2022 00:31:45.885 +0000 (UTC)
Received: from github.com (hubbernetes-node-fbf9b16.ac4-iad.github.net [10.52.211.83])
        by smtp.github.com (Postfix) with ESMTPA id BC9F66001BA
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 17:31:40 -0700 (PDT)
Date:   Tue, 03 May 2022 00:31:46 +0000 (UTC)
From:   Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/fa7828-b7ca43@github.com>
Subject: [bluez/bluez] c75ff3: btdev: Fix not removing connection and
 advertising...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?NCuo=2Faci8=2Fvc654FLG8ZqCi=2Ftd5PhuN55Q9iF5tvb2ErGMYgqEnmC5+VcxN1HW?=
 =?us-ascii?Q?HZEMO+yd+6Y5QOUrvrilW=2F0p8rOL4=2F9GtDaLwlV?=
 =?us-ascii?Q?kQBZzDHaQOztHwuOd0UCNt1uAudw4gsyzl6b50T?=
 =?us-ascii?Q?=2F7rQcZUmauuqyMWvn45Ad8XMH7pdYsKh8jErvVb?=
 =?us-ascii?Q?0C0SFAggNEboLY6K8yUrDJaYGgE0vsTJv9WuAUX?=
 =?us-ascii?Q?SeQoY6h31BBcf1IxDuB3TdPRO837nQnZ8Hmkx+j?=
 =?us-ascii?Q?ysmPo1WkawaWih1L7M4YQ=3D=3D?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: c75ff36b77f88821beffabe4d3e60317c243d9b1
      https://github.com/bluez/bluez/commit/c75ff36b77f88821beffabe4d3e60317c243d9b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-02 (Mon, 02 May 2022)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not removing connection and advertising set on reset

This makes sure that all connections and advertising sets are cleanup
on reset.


  Commit: 6bf9d1775cf4ccd7374a6a88f353ddefaa123d52
      https://github.com/bluez/bluez/commit/6bf9d1775cf4ccd7374a6a88f353ddefaa123d52
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-02 (Mon, 02 May 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode LTV fields of Basic Audio Announcements

This decodes the LTV fields of Basic Audio Announcements:

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 41
        Handle: 0
        Operation: Complete ext advertising data (0x03)
        Data length: 0x26
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration #0: len 0x02 type 0x01
            Codec Specific Configuration: 03
            Codec Specific Configuration #1: len 0x02 type 0x02
            Codec Specific Configuration: 01
            Codec Specific Configuration #2: len 0x05 type 0x03
            Codec Specific Configuration: 01000000
            Codec Specific Configuration #3: len 0x03 type 0x04
            Codec Specific Configuration: 2800
            Metadata #0: len 0x03 type 0x02
            Metadata: 0200
              BIS #0:
              Index: 1
              Codec Specific Configuration:


  Commit: b7ca43eedfd5a028909a410287ad915ec026e24d
      https://github.com/bluez/bluez/commit/b7ca43eedfd5a028909a410287ad915ec026e24d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-02 (Mon, 02 May 2022)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Fix parsing of LE Terminate BIG Complete event

LE Terminate BIG Complete event format Subevent_Code, BIG_Handle and
Reason but the last two were swapped.


Compare: https://github.com/bluez/bluez/compare/fa7828bddd21...b7ca43eedfd5
