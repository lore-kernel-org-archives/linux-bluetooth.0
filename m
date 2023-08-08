Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE6C001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjHHSBv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHHSBW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 14:01:22 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F872D1C9
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 09:28:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-078-048-063-071.78.48.pool.telefonica.de [78.48.63.71])
        by mail.svario.it (Postfix) with ESMTPSA id 81C2BD86EC;
        Tue,  8 Aug 2023 08:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691477886; bh=N1gFyDCblnESnweKHz3F7v4xl5qu1zu2eTSZAbC51A0=;
        h=From:To:Cc:Subject:Date:From;
        b=uPCb6rRq3asG5k6ov7Ry5hiaoHgtnbkPmaoypjRZirOTNyPHFCqwTHqeaEeOKA5Gm
         JcCqnpsR5BGbP8Zs2jbwFA6gPAOSFuOPyznhDbvvTusqGPZNXrex3LGFsbYUCNmcV5
         J4sjIlA5mpr4RPM2CKhm81Hbwyf4CgNagy9288TUFaRHfzX9LeVaYU3VWtN8uAuk7p
         Kd4pSNKLGvs8L67sUFROV3nKG1I7AiThIgam1mUnS8cQ/6MyxSXf7Oz4ZxXy1yjyy3
         7LsSkVMyfdRUtGwHJQ7tR/uukg4nUklOt5pdDguia81+7qtZJgkr2TOVJ2EZYUwN+u
         KWCtiD+Y6dWDg==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PREFIX BlueZ 0/1] Makefile.am: Install D-Bus policy in /usr/share, not /etc
Date:   Tue,  8 Aug 2023 08:57:33 +0200
Message-Id: <20230808065734.1475152-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch changes Makefile.am to install the bluez D-Bus policy in
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

Gioele Barabucci (1):
  Makefile.am: Install D-Bus policy in /usr/share, not /etc

 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

