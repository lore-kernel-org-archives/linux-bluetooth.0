Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3ADC64ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 05:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCAFEC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 00:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCAFEB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 00:04:01 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F64F772
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 21:03:56 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id cc12-20020a05683061cc00b00693daa9016fso6924360otb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 21:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJNeOZCERsN5NNJ+U8zY5CxH3rWUUai7cSgECreMIrw=;
        b=k6HH1KC6G3fYJBHuTvNAtlj+61OU2dl2yjViZJkjcV5xmP/pBvHEYzsxRJnS87B1b9
         sQaTTIIGkZuRcoKVTKNH67dWj2Y4c8FaWBnCyTBQpRbAZzyXkjZW6qOjv/uQiHJtoajk
         aWLOIi/egT7uJ2zsQBmYKLZNdbhOU9qsl8Bi/yGBFDYHJ0PTFgfv8NvnOqB49iz6Ip2Z
         92Ae8+CPa/SJNw0Didl7xUkCLbcmOK3gWUMdUt3G0fuWg4alIkMiueYbKPWhFEQMW8Z6
         PbZmnGcyei0sbx2TrEN5vFTkTZWVGwbOv7Ztfku24NxibUfruopR4if6lI2Ej2HgbcOK
         eN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJNeOZCERsN5NNJ+U8zY5CxH3rWUUai7cSgECreMIrw=;
        b=GPKbnCqTzz3nAaqdVgnm3Ebk3BuYzl+FtOl1PfGhHv4uFpbs/baSHvIIQoLhun2nx0
         suG6CoRff+eTjdC3ubUMSlbJQ9yiKqUSwjkkI4fDOMWKJWieGQ9TFAumiYlxHFe9Njxk
         qreCsoMYfAD/99kbT7hUCesjIaeHMTZPWOzwTiBwE8ibL5t6sSUXCJ36RcTLZdGF5T33
         F3GM9nO6Qqs1psdb41PpXiFBpyqe3dPzehSXX3GR4/QktEJMAHcd6yJ40fCg+V3MEJtb
         qAbikSkFOwzCcQcagoDHL0pnImkRfwYWHlc1bi27GdtWgYZTuTu7eIfLwgVpw+opvrH1
         lV0w==
X-Gm-Message-State: AO0yUKW+vNcsgXWV1Kf+EwNH4bqOW/4lBPQeW3xwsy/TwU4HoDLovyad
        wDmaffLWQkiozw0ZLZZF5jEx2MlIalvIlA==
X-Google-Smtp-Source: AK7set/wST1q0V1Fd1FB/+xJRgZFvStBOuObWAZ17oohuBQVFJTXeMm83I5ZFuzDULUdy5mLQ1oAIQ==
X-Received: by 2002:a05:6830:4122:b0:693:daa8:ea82 with SMTP id w34-20020a056830412200b00693daa8ea82mr3444519ott.13.1677647035928;
        Tue, 28 Feb 2023 21:03:55 -0800 (PST)
Received: from localhost.localdomain (69-223-86-197.lightspeed.hstntx.sbcglobal.net. [69.223.86.197])
        by smtp.gmail.com with ESMTPSA id x31-20020a056830409f00b0068be372babfsm4607266ott.47.2023.02.28.21.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 21:03:31 -0800 (PST)
From:   Erfaun Atabakhsh <eatabakhsh04@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Erfaun Atabakhsh <eatabakhsh04@gmail.com>
Subject: [PATCH] obexd: launch obexd directly from dbus service
Date:   Tue, 28 Feb 2023 23:02:42 -0600
Message-Id: <20230301050242.47225-1-eatabakhsh04@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Whenver obexd is summoned via dbus with the systemdservice file, the
daemon exits with the following error: Failed to start org.bluez.obex service: Process org.bluez.obex exite.
Irregardless of obex.service is enabled and running in the background,
whenver an app calls for obexd via dbus, it seems like it forces to use
the systemdservice, and that for whatever reason doesn't work.

Therefore, I propose instead of having systemd launch obexd, obexd
should be launched directly from the dbus service. Using this patch has
fixed all of my woes described in https://bugs.kde.org/show_bug.cgi?id=464929#c3
, and has worked both on KDE and GNOME. This is my first email patch, so
I look forward to you all's feedback and critical response!
---
 obexd/src/org.bluez.obex.service | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/obexd/src/org.bluez.obex.service b/obexd/src/org.bluez.obex.service
index a53808884..efbd8f1d9 100644
--- a/obexd/src/org.bluez.obex.service
+++ b/obexd/src/org.bluez.obex.service
@@ -1,4 +1,3 @@
 [D-BUS Service]
 Name=org.bluez.obex
-Exec=/bin/false
-SystemdService=dbus-org.bluez.obex.service
+Exec=/usr/lib/bluetooth/obexd
-- 
2.39.2

