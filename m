Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2017AC83F3E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjIET2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjIET2n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 15:28:43 -0400
X-Greylist: delayed 1089 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 12:28:23 PDT
Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C31BE
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to:
        cc:content-type:from:subject:to;
        s=smtpapi; bh=K98/9Aing/43Dq25KUJ6EJGTomO2Qmz2tej1VtEmlGw=;
        b=CEBeg8JQdRIvspXD/Hpt3iv72RJWBefRFDVJLMg41asbIyhkgGxvH3EMsW4H+kRiGzfX
        ysJZjpbBcv5ODcnIQQSgCOiVVUjfQHIcj5V51ixZND7xffjxTZIqsER2SatUnybmii/yZT
        mOh9wQNGy7rCWbilLCbMc3oPmQb1DkYhY=
Received: by filterdrecv-85c4c97bf5-8crrp with SMTP id filterdrecv-85c4c97bf5-8crrp-1-64F77CDE-52
        2023-09-05 19:09:18.506707532 +0000 UTC m=+10179200.476901941
Received: from out-20.smtp.github.com (unknown)
        by geopod-ismtpd-2 (SG)
        with ESMTP id Tg5qNHyfQKqWCz6o-S2DEA
        for <linux-bluetooth@vger.kernel.org>;
        Tue, 05 Sep 2023 19:09:18.469 +0000 (UTC)
Received: from github.com (hubbernetes-node-51b2999.va3-iad.github.net [10.48.141.11])
        by smtp.github.com (Postfix) with ESMTPA id 347498C0C00
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 12:08:35 -0700 (PDT)
Date:   Tue, 05 Sep 2023 19:09:18 +0000 (UTC)
From:   Nitin Jadhav <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/d06b91-2e4771@github.com>
Subject: [bluez/bluez] 94ea14: lib/uuid.h: Add UUID(s)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?em4uxDjFTmK6HGA0dkTtYd7uB0ZF8ijVfgh847oM=2FOj6U4EIpgG4=2FynbSB75Yp?=
 =?us-ascii?Q?QW5EfiCKp7+AJ2dOAOrRaLthV37GwP757MJGYvS?=
 =?us-ascii?Q?=2FXB=2FBfQGkJXxyy9VDtLL6Xw=2FzkSRGjXrnMD2PCs?=
 =?us-ascii?Q?mRo+Jku6QYG3XqeRC22NECbbt8mXHddPgz+f0B7?=
 =?us-ascii?Q?iGUbZ+5KEv5d7wb9AkeUdJtFN7xei42hauB8cx7?=
 =?us-ascii?Q?7iyHKzZU4=2FfMBCaO7H4wVOmdWLuzUL9RKJdKmQl?=
 =?us-ascii?Q?ZSO8QQEJMwf9ndlwWTiAg=3D=3D?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 94ea14917ff99cffb2fb23b6a3867fc4b16b1b8d
      https://github.com/bluez/bluez/commit/94ea14917ff99cffb2fb23b6a3867fc4b16b1b8d
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-09-05 (Tue, 05 Sep 2023)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid.h: Add UUID(s)

Add MICS characteristic uuid(s)


  Commit: 5c788b73b8a5819ca2e7c6b5374807f6af1c5576
      https://github.com/bluez/bluez/commit/5c788b73b8a5819ca2e7c6b5374807f6af1c5576
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-09-05 (Tue, 05 Sep 2023)

  Changed paths:
    M Makefile.am
    A src/shared/micp.c
    A src/shared/micp.h

  Log Message:
  -----------
  src/shared/micp.c: To implement MICP profile MICS service

- Implementation of functions related profile and service for MICS and MICP
- Specifications referred for implementation:
MICS - MICS_v1.0.pdf
MICP - MICP_v1.0.pdf


  Commit: 2e47711d4d81d2a86751dc0403895b1d1554182c
      https://github.com/bluez/bluez/commit/2e47711d4d81d2a86751dc0403895b1d1554182c
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-09-05 (Tue, 05 Sep 2023)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/micp.c

  Log Message:
  -----------
  micp: Add MICP plugin

MICP profile level interface function have been implemented
This adds initial code for MICP plugin.


Compare: https://github.com/bluez/bluez/compare/d06b912df5ab...2e47711d4d81
