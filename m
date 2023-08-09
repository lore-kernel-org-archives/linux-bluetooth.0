Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A9C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjHIGp5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHIGp4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:45:56 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8B10CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:45:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-093-131-108-051.93.131.pool.telefonica.de [93.131.108.51])
        by mail.svario.it (Postfix) with ESMTPSA id 3D49BDA0C6;
        Wed,  9 Aug 2023 08:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691563554; bh=H4CScWPNyu8VgosjlX6hIOsDiPamx4Td72oLFOTd+2U=;
        h=From:To:Cc:Subject:Date:From;
        b=q7heEuhw5xNDsr1OME7IxTBtz4OefxnhenT2WnuzHrQnp53dE/bzLI6cMCjYFnUIN
         xMP9UvbOKG794MWaErB1YTXNBG5zlECENOnlxHqjTWO6IzRFCuRXLIrpmY9qSeinjM
         OwudWtMtJl0pyWvnrcgz0fBWdSHaQVTUvalOUvTdz9kOJjeVajUl4B4XtuQ1r20BwE
         zKn3lo7Z21ZHlFu+SHZAoUjNLjM/CheHw8Ba2cmePxre5aB5f83/JaOVQiyKqZZr8+
         KC3k8fGV/NBHN+ZI2yh8xPTq1or7GeODTmmTYWoX1sC0YfL0Y1AHqzRnSVFGOsxzkj
         c4Rnv9xMQsslQ==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ v3 0/2] configure.ac: Install D-Bus policy in /usr/share, not /etc
Date:   Wed,  9 Aug 2023 08:44:39 +0200
Message-Id: <20230809064441.2002194-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

Gioele Barabucci (2):
  configure.ac: Bump minimum D-Bus version to 1.10
  configure.ac: Install D-Bus policy in /usr/share, not /etc

 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.2

