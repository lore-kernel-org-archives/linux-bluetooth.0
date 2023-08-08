Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D598C001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjHHSAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjHHSAH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 14:00:07 -0400
X-Greylist: delayed 1481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 09:27:30 PDT
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941792C987
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 09:27:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-078-048-063-071.78.48.pool.telefonica.de [78.48.63.71])
        by mail.svario.it (Postfix) with ESMTPSA id C0254D9FE6;
        Tue,  8 Aug 2023 08:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691477897; bh=daMyFmCfid7nDZBXLArk4TcOOF/YxTVYtASNs7nwb04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vV2GVFG0dBIduhIKPJWmO1fDCzzKPP+qKjcYSzh+PVA8IkVMF/Q7sy4LnUDwZ6myM
         WFk9gOCex1inQqO2jCYmiQ4vuMhEFMGWHpwn+v1IGmmR+awJvEBAKB/y01ZMEjk594
         7qJSJWI7YupJEBmAu4O9a7fizEA3hkERELNhpOHZAfJaoiur4IRRuAbpVyAe0h2I1w
         zJeFUU8seM6p+b7yKkzPJy41QoYnTy0JINxIEFSGWOY1Bz0krbZpKXIoVFQr2xNYcC
         EApXcUi5z9A0km6VzCdixfky8qFufvy0ePV4pjjDrqRAjP/+G1ssZPjzlGb3AWcsE3
         sTfmRGqTzCV5A==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PREFIX BlueZ 1/1] Makefile.am: Install D-Bus policy in /usr/share, not /etc
Date:   Tue,  8 Aug 2023 08:57:34 +0200
Message-Id: <20230808065734.1475152-2-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808065734.1475152-1-gioele@svario.it>
References: <20230808065734.1475152-1-gioele@svario.it>
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

