Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEFDC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Sep 2022 19:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiIYTEf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Sep 2022 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiIYTEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Sep 2022 15:04:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFA139
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 12:04:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s6so7751488lfo.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=E3DYIryf2otx8rcu6iuitEbGBekz3dZ6/Igq0C14n7s=;
        b=bqoa+IHbkQfAMm5jfbYOOwUESiqRB8+DjzK+6esP7ACBq+1gZ+8owNBBTKmwCOWzXM
         on3niIof+Mrk/lqmsJLL3/XemfM2ec5Tc5zsz+l0nqQjvLL78FQRsdGf+WEIYkbMThmD
         i/4GUaeCZL9VKb7vhZxLcX2IRGMZZMOE+cLuEV4NEUoS3tTT3n0r9jxV7+vrQzqfuaZN
         9GFv6ztJAySUJm/1A3K3ROnD13JGyT7HH6RyTY94GKfUou/wMegAu5QzYcXIwn6gFN1t
         K6G8jrK3+UaU/bZg5Zd3/rZidARx3XguKvgd5VBn7C1F6XaNcUaL+95OZlJ4l7Bn9jBw
         /0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=E3DYIryf2otx8rcu6iuitEbGBekz3dZ6/Igq0C14n7s=;
        b=UfeLW7mTudOf6SfLaNtUetfEQL4+eTWtvqUWgWccWxWRb8sUEvHccK7qxzkpOmgpCQ
         hl1putq594rgd1bicZMFSUkSCYmm0gzp0SfxosKGnnqVYsO1q09DHCEdTJjEt3sOMu+u
         u/JDNfrn5eE/d3F4pNDyPwUHe7eZmA+SHro3qAmRjnswtYKoHWvVIXVZ9SgaD/umZxPn
         aUyyBPnEPwXKGTV8Qbap5hoRXslROH6/gKmbrSdcLxy6WmrB3DZ+F0R2fTKyozsG+pab
         2vBg6ryl+lEf/V+UtZPmgKJFSkUO9SGv8ROYzsSoKq8kK6A61A/0inO98cV21DoO38bH
         76IA==
X-Gm-Message-State: ACrzQf1S7Df9yJpCrcSPIG5QM0DKJy4qSu5E5iY6Q09X4+EJtn5NOJB0
        lI0CZbOMul1osyA3zz0aM9MSz3Noq8x6iqy1GI/dBgIbz70=
X-Google-Smtp-Source: AMsMyM6U2CqSs8EmP6NwAU2/9wRL7ZWqj9zuQTOBwdTn+P0zEHin7WnKt3HAAfCe6is+mLNTF46L5qWFgeVis2pdsq4=
X-Received: by 2002:a05:6512:68a:b0:49f:4c31:e9f with SMTP id
 t10-20020a056512068a00b0049f4c310e9fmr7763876lfe.136.1664132668956; Sun, 25
 Sep 2022 12:04:28 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?QW5kcsOpIFc=?= <beppe85@gmail.com>
Date:   Sun, 25 Sep 2022 16:04:17 -0300
Message-ID: <CAP96LmN8mMd5e=ddoUHt2w3HvcUF=8EahqGr6OhOJcjd3QwD0w@mail.gmail.com>
Subject: [PATCH BlueZ v2] obexd: point DBUS service to obex.service directly
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

dbus-org.bluez.obex.service user service is not available until
obex.service is enabled in systemd. By pointing DBUS service directly
to obex.service, this step can be avoided. The [Alias] section in
systemd services then becomes unnecessary.
---
 obexd/src/obex.service.in        | 3 ---
 obexd/src/org.bluez.obex.service | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index fc0dce993..c3f822f55 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -5,6 +5,3 @@ Description=Bluetooth OBEX service
 Type=dbus
 BusName=org.bluez.obex
 ExecStart=@pkglibexecdir@/obexd
-
-[Install]
-Alias=dbus-org.bluez.obex.service
diff --git a/obexd/src/org.bluez.obex.service b/obexd/src/org.bluez.obex.service
index a53808884..c3917e415 100644
--- a/obexd/src/org.bluez.obex.service
+++ b/obexd/src/org.bluez.obex.service
@@ -1,4 +1,4 @@
 [D-BUS Service]
 Name=org.bluez.obex
 Exec=/bin/false
-SystemdService=dbus-org.bluez.obex.service
+SystemdService=obex.service
-- 
2.37.3
