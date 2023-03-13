Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BAC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCMWwp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCMWwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 18:52:24 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FA74DDA
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id bf15so5670146iob.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCv7QOAuRV5FStXHJ5VlNaiHp0TNB/Iir068ELBaIAI=;
        b=dtLcQvgRaZpwdi+WwBYf7mi0YvoaRx4wAWyiY9Juh3t/is80fL0HxRMJ95nhyeNw7+
         rMQquO1pMagOTjl9h9It+WN3sm7f4gx6PfexOSFZbtYeO6YVQhOLhT1u4YmLtz019jBd
         MwFiLrYBai8vCGaGSmU9C8XLAUyspjLpHZaB3GDm70zkiyz4ZedsqufQDJ1TTgmvtx1S
         XS39crKckrfw95TQVwj+otsy5xtx40OVBeSOrk4rDuT0Nffhav0BmXQIkvYkMo/k5Vsk
         Yi19hfQKVo9TEIhILVVrBrDMf9sRHJR9cjmLAvpbaEpgTQhcAkpj45KKgEzWN96Vxxwi
         oSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCv7QOAuRV5FStXHJ5VlNaiHp0TNB/Iir068ELBaIAI=;
        b=IV5fe9PZA5Tyrv+yKuOEf/nOMRIs3NUlx/PANhQjSlM/4WB8NG4TggDP3tfAidTdDR
         ycwTdNYo2PthFL7t5iJeyJ+P/kMRDAcIvc5Xp24CwKtUgfpPETOdeLsYVWAGIs5rTHHS
         Ur0ZOs72mEyd/TQqGy5CMbxvwtMGBOaXkORzYXYHItzHEKANI1/mhE1IC4heyzP3iQho
         YuhWMeu6apBJeIcSGUWA4Ho5aSkoLqEq2jjwxZ+PVHKWNmG9PMIijSogwxBsq8YM01pr
         Pc5rLzzXeu2kbboqYd3DZzXIlK7SmuQiMd5CRp2XrjkvHIeV6omCZjw0Gkky+jUNH3Kv
         Z7fQ==
X-Gm-Message-State: AO0yUKXFIqaNpH25egL9TgYUEuE3MaXp25RPzusXyIMRY5bF+NXaNrM7
        5D9KQnXRAxyIsTryYnyYfPwIg3krCQY=
X-Google-Smtp-Source: AK7set/P5tRaVhhE0yatpm7sGbPBY482NJ7ah/MGpFgawAGYBAavLi5XSsBCPM2VmZRsdujtuI1d+w==
X-Received: by 2002:a6b:600f:0:b0:704:b286:64c3 with SMTP id r15-20020a6b600f000000b00704b28664c3mr20860357iog.16.1678747914061;
        Mon, 13 Mar 2023 15:51:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m17-20020a02cdd1000000b003c4d71489aasm278318jap.6.2023.03.13.15.51.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:51:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/csip: Fix not unregistering idle callback on detach
Date:   Mon, 13 Mar 2023 15:51:48 -0700
Message-Id: <20230313225150.267896-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313225150.267896-1-luiz.dentz@gmail.com>
References: <20230313225150.267896-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make sure idle callback is unregistered before bt_gatt_client is
unref.
---
 src/shared/csip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index ff2047a4ade0..094f448a3532 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -122,6 +122,8 @@ void bt_csip_detach(struct bt_csip *csip)
 	if (!queue_remove(sessions, csip))
 		return;
 
+	bt_gatt_client_idle_unregister(csip->client, csip->idle_id);
+
 	bt_gatt_client_unref(csip->client);
 	csip->client = NULL;
 
-- 
2.39.2

