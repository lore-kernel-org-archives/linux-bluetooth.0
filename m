Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46602C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Sep 2022 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIYSdB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Sep 2022 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiIYSdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Sep 2022 14:33:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203422B61F
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 11:32:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h3so5315222lja.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=fwB9rJgpzs0FysFkb7synWzQE2DvvXwsCuF+cTsihPc=;
        b=C3uy83CMNaExvq3mzAGJ0Xie3Xaw5TJMMYKYj61XjNHSubqZzp3Sc4VMcTFm6akS69
         DUz91kAH6G822bhxEcsx3uu+NrXss3MsS3BHVNx/UqWK3qurNX/gmtfCUIOrE/V0QnyI
         oAUUwFk0pWvVK+70buvldISNx+Ss8nbCJxX6b9msIb+ZIpjFiQvgGVWclC4HHdhoxqRw
         FRKI/huAMYMlKunUbFEFNa4xO3jCv5FdqWfG/0NSKLkQqcEzc15leXW67X//M6xZyOb2
         /PWu+6LzjVxLuX57udYdparNrbGE0pLUKqlr4WST4vREnnFm6wK9Zu/9FDoq238sbVvr
         Wjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=fwB9rJgpzs0FysFkb7synWzQE2DvvXwsCuF+cTsihPc=;
        b=YaQhN1UNgOyxUzSxx8vUBB9Ji+sutCaiZT7e1g45ajDeLkcLJwAaE6rD6e+yJ/D9b9
         1j1xyaQlH2T5qqSdkDWMRZSD9UZimadnfSe1LcdIa2ZeMUxXEA4A+do6aMtnlGoLYdOT
         Ma4XXfA7/OGKorRPydJmWpuikELL/XBtziFKCFkwLjneiXa+WYpbouk4vOiV2cEvFqhj
         qopNdFse+VVkv71EWsc8qaSxyp72RAK1T0gVhz2MhLnmL8g7ocPv5NDGrxqH2lD+wxvK
         Fb5xCjwrDvuea/yp2ypVJDwSNX5V/fVTy4RkXycVmkMTvZVBM1q6zPzaCPUS+44y8JhY
         UNKg==
X-Gm-Message-State: ACrzQf0kaSy0iLiR+JNxQ5JvhKCwQzt89yJKU6/94Sl7BXFEDCm+UhrU
        p39zo8/Ol4yicmOq8s5XgsZXs3fOxruiedejXdE8aTC7Gvg=
X-Google-Smtp-Source: AMsMyM7Z55CjFZx2+L0QndMxskw/fBG2MR3DYg7nnv3hDqbte6esq8RH4QBhOMxCZ53/CGOFj4ZbhkARk9Fa5xt8xB4=
X-Received: by 2002:a2e:8ec6:0:b0:26c:7fc5:2d47 with SMTP id
 e6-20020a2e8ec6000000b0026c7fc52d47mr3844096ljl.507.1664130776988; Sun, 25
 Sep 2022 11:32:56 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?QW5kcsOpIFc=?= <beppe85@gmail.com>
Date:   Sun, 25 Sep 2022 15:32:45 -0300
Message-ID: <CAP96LmPVajLT8P_SBzJBnW1vJqDhU9-XRdVdpyReuwB=utNFLQ@mail.gmail.com>
Subject: [PATCH BlueZ] obexd: point DBUS service to obex.service directly
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From 4e5914a69c5e9d16287052dcccba25dd43cddc29 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9=20Werlang?= <beppe85@gmail.com>
Date: Sun, 25 Sep 2022 14:38:45 -0300
Subject: [PATCH BlueZ] obexd: point DBUS service to obex.service directly

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
