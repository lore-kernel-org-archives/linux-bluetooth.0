Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F65EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 21:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjFMVBx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMVBw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 17:01:52 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159B1713
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 14:01:49 -0700 (PDT)
Received: from github.com (hubbernetes-node-04c349b.va3-iad.github.net [10.48.125.73])
        by smtp.github.com (Postfix) with ESMTPA id 6007AE00A5
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1686690108;
        bh=auOiP+Bp9Oiq45eecgtZm+0Il4+kzH0wQM380AO4ByY=;
        h=Date:From:To:Subject:From;
        b=fNWJv48d2n6qEJY7GG0oH/qeGJy8ppTVzVBd43pfMfvoyaQfNXteqWJJw0wCVC8Xn
         44lT4Q7yNkGTICAeAHh2tTC165+iSl7IYVg7Muj288ZwZV9ZQqB+tVT4YhmIUeqF2r
         4dwmuRLEq9/y12wP1bS2IENKGkIOhf+2S3lupr1Q=
Date:   Tue, 13 Jun 2023 14:01:48 -0700
From:   NJNXP <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/303088-d2d2d1@github.com>
Subject: [bluez/bluez] 2f52af: btdev: Fix build error
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2f52afa21a26354a540c1a288480511e90567c6f
      https://github.com/bluez/bluez/commit/2f52afa21a26354a540c1a2884805=
11e90567c6f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix build error

This fixes the following build error:

emulator/btdev.c: In function =E2=80=98le_cis_estabilished=E2=80=99:
emulator/btdev.c:5947:22: error: =E2=80=98cis_idx=E2=80=99 may be used
uninitialized [-Werror=3Dmaybe-uninitialized]
 5947 |         int cig_idx, cis_idx;
      |                      ^~~~~~~


  Commit: 0599a7fa9fce1bbd4a543c6f5bb63f911a676872
      https://github.com/bluez/bluez/commit/0599a7fa9fce1bbd4a543c6f5bb63=
f911a676872
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Fix build error

This fixes the following error:

In function =E2=80=98get_composition=E2=80=99,
    inlined from =E2=80=98cfg_srv_pkt=E2=80=99 at mesh/cfgmod-server.c:80=
1:8:
mesh/cfgmod-server.c:758:9: error: =E2=80=98comp=E2=80=99 may be used
uninitialized [-Werror=3Dmaybe-uninitialized]
  758 |         memcpy(buf, comp, len);
      |         ^~~~~~~~~~~~~~~~~~~~~~
mesh/cfgmod-server.c: In function =E2=80=98cfg_srv_pkt=E2=80=99:
mesh/cfgmod-server.c:739:24: note: =E2=80=98comp=E2=80=99 was declared he=
re
  739 |         const uint8_t *comp;
      |                        ^~~~


  Commit: 0735ca179fdf127b60c4b4ed502d869b6d10899d
      https://github.com/bluez/bluez/commit/0735ca179fdf127b60c4b4ed502d8=
69b6d10899d
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid.h: Add VOCS characteristic uuid(s)


  Commit: 52a4d79f22c3f71abe5a17e0ce307547094569f1
      https://github.com/bluez/bluez/commit/52a4d79f22c3f71abe5a17e0ce307=
547094569f1
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Add initial code for handling VOCS

Summary:
- This adds implementation for VOCS service and characteristics
- Implementation based on VOCS_v1.0.pdf specification
- Tested using PTS with reference to VOCS.TS.p1.pdf


  Commit: d2d2d12f59d65002c4a671a5af1837f295181142
      https://github.com/bluez/bluez/commit/d2d2d12f59d65002c4a671a5af183=
7f295181142
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-06-13 (Tue, 13 Jun 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp.c: Make VOCS as an included service of VCS

Fixed the following issue observed during PTS testing
- Specified Upper and Lower Limit for Volume offset
- Corrected the number of handles for VOCS
- VOCS is made as included service of VCS
  (VOCS is secondary service and VSC is primary service)


Compare: https://github.com/bluez/bluez/compare/3030883005c0...d2d2d12f59=
d6
