Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1031EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHIGwW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIGwV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:52:21 -0400
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E04910CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:52:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-093-131-108-051.93.131.pool.telefonica.de [93.131.108.51])
        by mail.svario.it (Postfix) with ESMTPSA id DF1F7DA0C6;
        Wed,  9 Aug 2023 08:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691563940; bh=5/dhfnbUuwYJXoSTje41LLlaDNr2sZr2EUy/+5yIyjc=;
        h=From:To:Cc:Subject:Date:From;
        b=jVHGdZBAArff8m4d3UWe06XFdZMuV95pKXmlNsHJvKqQP+fM8gEw0g5WJvG1AGDiW
         PmR3Rv40HvF6afr+EalKM/jRbQb2uGT/bwGcB8fgpVKyfwUe1Gujpv3yHOnbrSwy8q
         q05JDGjxRrsDb6cMiPigA09TvDNpBr/Ua7jg309OMW0FCIHZM6EFV4Fo5l7rHXZlYC
         y+kn8+nKhQ72hPe4q3LZV6GLovmmmS4WTaRyHlDCYA7Dp68wVE/mcPILyEKCghAUMf
         K5cQOy44qeqMva86yRM1sm7OQdKGCiZPXPUdtKXwaPeAXH4zxaSeK/e0YMCJMqdFmO
         iwnqG3LFQeRag==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ v4 0/2] configure.ac: Install D-Bus policy in /usr/share, not /etc
Date:   Wed,  9 Aug 2023 08:51:41 +0200
Message-Id: <20230809065143.2002324-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Sending again, this time with the right commit titles. Sorry for the noise.]

This patch changes configure.am to install the bluez D-Bus policy in
`/usr/share/dbus-1/system.d` instead of `/etc/dbus-1/system.d`.

From https://bugs.debian.org/1006631:

> dbus supports policy files in both /usr/share/dbus-1/system.d and
> /etc/dbus-1/systemd. [The] recently released dbus 1.14.0, officially
> deprecates installing packages' default policies into /etc/dbus-1/systemd,
> instead reserving it for the sysadmin. This is the same idea as the
> difference between /usr/lib/udev/rules.d and /etc/udev/rules.d.

D-Bus supports reading policies from /usr since version 1.10,
released in 2015:
https://sources.debian.org/src/dbus/1.10.32-0%2Bdeb9u1/NEWS/#L483-L499

Regards,

v1 -> v2:
- bump D-Bus min version
- derive DBUS_CONFDIR from datadir

v2 -> v3:
- split in two commits

v3 -> v4:
- reorder commits and fix titles

Gioele Barabucci (2):
  configure.ac: Bump minimum D-Bus version to 1.10
  configure.ac: Install D-Bus policy in /usr/share, not /etc

 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.2

