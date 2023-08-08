Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD3FC001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjHHSJL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjHHSIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 14:08:40 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E068BD0
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 10:11:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.48.63.71])
        by mail.svario.it (Postfix) with ESMTPSA id 9EF39D9FEF;
        Tue,  8 Aug 2023 10:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691484971; bh=daMyFmCfid7nDZBXLArk4TcOOF/YxTVYtASNs7nwb04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhfhWLEFlSUK0h/Mp9r+c2OF23HPMXLF36y/p9usTn2TNcm2kHsGir85xPzZUocQD
         lIIOJYFxRsQKS+vl+VOYL0Ct+JNuLC+VpbT92b9FJuADQ/8KF+f2WxL40NRop3y9sC
         fmzvI2cdWlaKV+PALXq2658GHw/Bd7fLdrXoTD53P7CBviLYwA8DNvRpEiPMY1wfZa
         iWV2kWe5jBVlJ6fCElWo4mfpcybI3LLwuWExVEf+Kj8aaVhL6/PUFVY5nXumvy0EUi
         8EP5t4/VHuy8p8HFKNtMj6Tau0RzFamltRt4omiuOLg8qiexudy1rOu7Ne7oaeohuc
         ezww6uJu44DBQ==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ 1/1] Makefile.am: Install D-Bus policy in /usr/share, not /etc
Date:   Tue,  8 Aug 2023 10:55:40 +0200
Message-Id: <20230808085540.1475435-2-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808085540.1475435-1-gioele@svario.it>
References: <20230808085540.1475435-1-gioele@svario.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From https://bugs.debian.org/1006631:

> dbus supports policy files in both `/usr/share/dbus-1/system.d` and
> `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
> deprecates installing packages' default policies into `/etc/dbus-1/systemd`,
> instead reserving it for the sysadmin. This is the same idea as the
> difference between `/usr/lib/udev/rules.d` and `/etc/udev/rules.d`.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 4b9b7e5cd..f23c39d20 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -32,7 +32,7 @@ confdir = $(sysconfdir)/bluetooth
 statedir = $(localstatedir)/lib/bluetooth
 
 if DATAFILES
-dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
+dbusdir = $(datadir)/dbus-1/system.d
 dbus_DATA = src/bluetooth.conf
 
 conf_DATA =
-- 
2.39.2

