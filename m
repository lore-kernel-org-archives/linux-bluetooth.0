Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4EBC3A59C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9205E20644
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="uEWyXYSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfHPHpI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:45:08 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42110 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfHPHpI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 03:45:08 -0400
Received: by mail-lf1-f44.google.com with SMTP id s19so3415092lfb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RJCpoefp64znxKNxqrXv+x014kSMNfsvU3dlcRL/Vo=;
        b=uEWyXYSqpt9wkazrZ9FWA2M3vknN8oqPJQZxKVN3kfdndVk9IlAL1+ae7sDesIqcyT
         ZriS9Y/W0rpnYGq6W7jEgGlR3SzkDeu5zg2g8eUW1K2Ucqvv99oPb8B53/EZrz4XUvnp
         xPOEliF50JKA65anK9ala0IfUNzDKvFYEVgI4YdJWTNLTerzmKjjnL5Pqq7YFGNACHad
         0GiMFzwaDo1qgruyNhG8cYBM/aOZ9vE6YQLdVOnLeA4I5uYtL0mSZYe0s4e5Bx63SH2G
         gfMQ8485qvDWlGE6XgIkFWTHNmnNFje2+i5WY8qgiYSVeDIQdld2SaEYgmDBZV+C/7+b
         +Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RJCpoefp64znxKNxqrXv+x014kSMNfsvU3dlcRL/Vo=;
        b=t4+hlM+WaYQewK6VurrjLU/y7AGUJIY/9sEqv58d9vC2GvH29WMIbfyK/MD1RUyCM0
         0GbzR5hLMZYyllrzDUPHU3MrhUEu9BA0Rppp3GuTRVIqFcTrUrq5up01sMxXILfu3DYC
         cj7tvkgS669be//YjGeiFaaD72G7qrygV9edU6YpJCk/2VStsOLJgZuhCeWuhNNBsVoo
         93PClfvoS0siKGvYjBcMnEhigSbDjhPZmYVsTo7w05F58W9Ulc2Vl3cLNrZkkK9bDDJt
         8RoVvZzhD2hOOOJ6DoG8Bqi/5Up2i3elbQszdbxhnvdzp3S0CI1o9v9GgHfPCekBfIAY
         1YhQ==
X-Gm-Message-State: APjAAAUgdi0SalJrWiRtLJeyxP98EtCDZFz3kub4LNx3YxBqKpyB3dKj
        K0PwnYeWlyyD9xBIwl5QBjgzj50gtQc=
X-Google-Smtp-Source: APXvYqwKzYIE+JUUtPLq+X3n0RoTgZ6Gt5BdTO8lWN5siwrVvZ9UNHJ1y4c0La0kOPnwva3wpXPgbw==
X-Received: by 2002:ac2:5219:: with SMTP id a25mr4542750lfl.154.1565941505751;
        Fri, 16 Aug 2019 00:45:05 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id i9sm804297lfl.10.2019.08.16.00.45.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 00:45:05 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gitignore: Ignore mesh service file
Date:   Fri, 16 Aug 2019 09:45:00 +0200
Message-Id: <20190816074500.21342-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 68bbbf780..52c0d6994 100644
--- a/.gitignore
+++ b/.gitignore
@@ -133,6 +133,7 @@ mesh/bluetooth-meshd
 
 src/bluetoothd.8
 src/bluetooth.service
+mesh/bluetooth-mesh.service
 
 obexd/src/builtin.h
 obexd/src/obexd
-- 
2.19.1

