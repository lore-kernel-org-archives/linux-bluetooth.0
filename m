Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D321EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 21:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiDVVix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiDVViu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 17:38:50 -0400
Received: from o6.sgmail.github.com (o6.sgmail.github.com [192.254.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446FA412281
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to;
        s=smtpapi; bh=wH0qAcM2An/FZuJUYRuI3OFSXtmBkqKprM3jBFfw5Lw=;
        b=F/q+FOAiEr7iTWwVzDjPgiA2Jv650xx/b0kAp0KJCctmNFkSPNBiFeyvqWw+Hhssk/7F
        zz1phKUoMc8i47h6CuhS69Ul0FNgVlGU5HLdIahtg1Je3kCn0UZkANs/Kkw5LvcdRiZ9mm
        oeMmDc4OdO5MH51+dX/2XJRkPJDwXEjjY=
Received: by filterdrecv-644fcdb6d6-kjv48 with SMTP id filterdrecv-644fcdb6d6-kjv48-1-62630AEC-FE
        2022-04-22 20:07:08.783284237 +0000 UTC m=+1376095.252406715
Received: from smtp.github.com (unknown)
        by geopod-ismtpd-2-3 (SG)
        with ESMTP id k6KJw6rjRCmQ2S097humfQ
        for <linux-bluetooth@vger.kernel.org>;
        Fri, 22 Apr 2022 20:07:08.691 +0000 (UTC)
Received: from github.com (hubbernetes-node-655f4a4.ash1-iad.github.net [10.56.14.49])
        by smtp.github.com (Postfix) with ESMTPA id 49E9F840E93
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:06:28 -0700 (PDT)
Date:   Fri, 22 Apr 2022 20:07:08 +0000 (UTC)
From:   Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/a1939b-3e2ad5@github.com>
Subject: [bluez/bluez] c53562: hog-lib: Check if Report ID is set before
 prependi...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?NCuo=2Faci8=2Fvc654FLG8ZqCi=2Ftd5PhuN55Q9iF5tvb2ErGMYgqEnmC5+VcxN1HW?=
 =?us-ascii?Q?HZEMO+yd+6Y5QOUrvrilW=2F0hzAy+0q23lKrfbYi?=
 =?us-ascii?Q?bGIdh7J02Fv7HM4JTIyfg6aU2HQ=2F7Osa2zUxfxZ?=
 =?us-ascii?Q?PXq3kUE9jKk115WqLDi7ZD+JKwMl=2FavI4EDmoqL?=
 =?us-ascii?Q?H9aM13uK8pTIa6LHlvdFmv14WGAyJ73AZrR6gbA?=
 =?us-ascii?Q?oUX5AgR=2F+Vv86FxyxSqugZio2Nd9iHryJDqEBI5?=
 =?us-ascii?Q?XO+Lv1NPx35PwWmjpn9Xg=3D=3D?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: c535623a713c340031daf56d0798829644a92532
      https://github.com/bluez/bluez/commit/c535623a713c340031daf56d0798829644a92532
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-22 (Fri, 22 Apr 2022)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Check if Report ID is set before prepending it

Before prepending the Report ID check if it is non-zero:

BLUETOOTH SPECIFICATION Page 16 of 26
HID Service Specification

Report ID shall be nonzero in a Report Reference characteristic
descriptor where there is more than one instance of the Report
characteristic for any given Report Type.

Fixes: https://www.spinics.net/lists/linux-bluetooth/msg97262.html


  Commit: 3e2ad5009c0fb2c8a7b3a04438ad1e449c764dcc
      https://github.com/bluez/bluez/commit/3e2ad5009c0fb2c8a7b3a04438ad1e449c764dcc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-22 (Fri, 22 Apr 2022)

  Changed paths:
    M monitor/l2cap.c

  Log Message:
  -----------
  btmon: Fix decoding of Enhanced Credit Connection Request

This fixes the decoding of Enhanced Credit Connection Request which was
not accounting the fields correctly causing 2 extra Source CID to be
printed.


Compare: https://github.com/bluez/bluez/compare/a1939bd51e0f...3e2ad5009c0f
