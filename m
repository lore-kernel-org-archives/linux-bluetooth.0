Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F94E92FC1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJEVJ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjJEVJz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:09:55 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD595
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:09:54 -0700 (PDT)
Received: from github.com (hubbernetes-node-c2b81ad.ac4-iad.github.net [10.52.210.47])
        by smtp.github.com (Postfix) with ESMTPA id 94CCD5E0B89
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1696540193;
        bh=kNp+AsO5iL38XMH7jdYpAgVu6MNJO+YZEtIKjTjs86U=;
        h=Date:From:To:Subject:From;
        b=RzyX03ncon3X1QoXgiBPXkJ1/U8q1djnjSPf3mKfzjv/pG6dE9EUfNmnUtFtvAP3f
         pR6z7vBRXrfw3paGxEDjDZMx6vID1iMKeDeMQKmAaKgR3Y/RM42Eax+j7/oYxG7DC/
         avxJg2BBOUc/JdzrjgFkN+sM6yoriHVD/8kglwDY=
Date:   Thu, 05 Oct 2023 14:09:53 -0700
From:   maheshtalewad <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/90af80-0a7496@github.com>
Subject: [bluez/bluez] 769268: btio: Bind listener to bcaster addr based on
 dst opt
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
  Commit: 769268f4b1f4ae10abdd812f9de774c323e49eac
      https://github.com/bluez/bluez/commit/769268f4b1f4ae10abdd812f9de774c323e49eac
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M btio/btio.c
    M profiles/audio/bap.c

  Log Message:
  -----------
  btio: Bind listener to bcaster addr based on dst opt

This updates the btio module to decide whether to bind a listening socket
to a broadcaster address or not, by looking at the dst address.


  Commit: b94e33f90aa019dd865879d801445f99ca1dca07
      https://github.com/bluez/bluez/commit/b94e33f90aa019dd865879d801445f99ca1dca07
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M emulator/hciemu.c
    M emulator/hciemu.h

  Log Message:
  -----------
  hciemu: Add support for setting emulator bdaddr

This adds support for the user to explicitly set a desired bdaddr to
a client emulator.


  Commit: a56bc5ec376a0ae3b451b22644fd11aecdeb2799
      https://github.com/bluez/bluez/commit/a56bc5ec376a0ae3b451b22644fd11aecdeb2799
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add miscellaneous fixes

This introduces miscellaneous BASS updates and fixes discovered
during PTS testing.


  Commit: 495a582675cf0a4b2fee293cc215504ef24a1c43
      https://github.com/bluez/bluez/commit/495a582675cf0a4b2fee293cc215504ef24a1c43
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M src/adapter.c
    M src/battery.c

  Log Message:
  -----------
  battery: mark all battery DBus APIs non-experimental

Remove experimental marker from BatteryProvider1 and Battery1.Source.

It's common that headsets send battery information via HFP, and often
this is also the only way to get it. Pipewire/pulseaudio manage HFP,
parse the battery commands, and use the BatteryProvider API if present
to forward it. No problems with the API appeared here, and it's been
experimental for a few years, so it's useful to enable it by default
now.


  Commit: 85460c32d1334f5edad021d214eb997e6f462b30
      https://github.com/bluez/bluez/commit/85460c32d1334f5edad021d214eb997e6f462b30
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M doc/battery-api.txt

  Log Message:
  -----------
  doc: mark battery APIs non-experimental

Remove experimental status also from documentation.


  Commit: b88e6602e8f59ab611eaa83f0f5a0e4f1047a950
      https://github.com/bluez/bluez/commit/b88e6602e8f59ab611eaa83f0f5a0e4f1047a950
  Author: maheshtalewad <mahesh.talewad@nxp.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  unit/test-micp.c: MICP-MICS unit test case implementation

-Added MICS and MICP Unit test cases in a single file[test-micp.c].
-Fixed the issue that occurred while running all the
 Unit test cases at a time.
-Tested all Unit test cases and working fine.


  Commit: 0a749634f5972e741137844d0e2174d8ba1444c5
      https://github.com/bluez/bluez/commit/0a749634f5972e741137844d0e2174d8ba1444c5
  Author: Mahesh Talewad <mahesh.talewad@nxp.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M src/shared/micp.c

  Log Message:
  -----------
  shared/micp: Fix memory leaks


Compare: https://github.com/bluez/bluez/compare/90af8029ba8e...0a749634f597
