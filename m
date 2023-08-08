Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1663C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjHHSJL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjHHSIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 14:08:40 -0400
X-Greylist: delayed 2649 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 10:11:36 PDT
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A268BCE
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 10:11:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.48.63.71])
        by mail.svario.it (Postfix) with ESMTPSA id 63A5FD7637;
        Tue,  8 Aug 2023 10:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691484969; bh=Jyi25HsR8F9yJc4ku0ZKBf72iwYg112ebAsFzjSuzPo=;
        h=From:To:Cc:Subject:Date:From;
        b=cT8UBs4vHo18NEaN6P0khqT4KulqbLf41L1nvBLhhQF7q+n4nIOd0ca/uf5KyvHDj
         0O0Bi9X3MYYF7HV0I+rp7gm/Wff0AsBkLmWTYOuspAK9O/RvVEpwihQtMN+6olvXp/
         0d/koC0zDk+Bpqpvb7URu8bejbUNmeuJMFLxuHIE/TFHwE0skYbUI3R3KTrB4oRa1e
         13r9iXPKfoi6N0wH7nTP+nreRZRQbAAXY14RSE1gQQHaTA0Pxr1yvzTjf9mWY5Wz7b
         B+uqgbqsGVkRKi/JzOmorUUgDHnK4Dm0N+URp1iA109N1YhWwAI8K4DkE8FucQxqQ3
         u+tt4AmY+1csw==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ 0/1] Makefile.am: Install D-Bus policy in /usr/share, not /etc
Date:   Tue,  8 Aug 2023 10:55:39 +0200
Message-Id: <20230808085540.1475435-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

(Resent with right subject tag.)

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

