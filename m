Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB4EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 18:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbiDSSeX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357249AbiDSScg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 14:32:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121B419BD
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:22:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5so16233356pjr.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpC8I70JYwdChRMXQiLRFRC8lTmz301Myr+X3NnTpdo=;
        b=phLrvlF7lA7CktGbW+PgPgvg4zhvWemxRl3koRwmJ2ZpsbDglPRuelLo6pFtpsx/++
         gKN24P0AJlSQr3acMAb5ajP/P1XK8awwBc5nmN7KcW9+Osgw3SYDWH1WScMlTDl3XUKS
         5K6HnS+HKqw+81SgqXNP3XYG7KTOlLWib2DW3S6Jnks4w2QAWeCMntl4c4KLd3tC5aw2
         tb4Q8FZYlB3PvDIqOM6OFcRSLazWwJmeknIfVAqg+8aZ7jTfVdyPfcR0cy7xSsOS9TiJ
         O6xH1RtUu4JzayUlMxVXodzRvKvQsWiW4hhQ/SbqGZbDk3+FWELOwpPsmN8Wuaqkr7Es
         UFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpC8I70JYwdChRMXQiLRFRC8lTmz301Myr+X3NnTpdo=;
        b=WwpPxTpjEygAbK0p19q+ewtnfOEA2NYEJT58MnBWYUbxvj6pMAYCz/VJ0Ylb+TzvFX
         ksCd9ju33qtVodbaBVf3IG826uJDl6wi0THPpphhwOILqzwzqN1lhgZpOPOK0rm68PMl
         JrtwdVfedf7rwCxZkhiHorte4m73phcVmSW8Rvn5O1XLZ2IcUgGTYke4ExRVuCykanQv
         1OGT3f48zReBYHpfCZW+/uwegxO7OTv3RjGSIL8EZe67y3cK1ZhdyaoxgHJ60Bqcn5hZ
         TfKn+vPIZQTLIGUMkXUbhwtJc+kDYvG00lLn27YhSrHYRbucl7WfO9Y6PmsUJXH6Usg7
         gQcw==
X-Gm-Message-State: AOAM532jEPBkfX9Z7jo4znfcz3H9PVbc2+TBkdC2dxmF79GXrdv4qKeR
        Ru3OrN4/WxzObVg5CGZyAz7WOFVc7x8=
X-Google-Smtp-Source: ABdhPJwmvoCuirZyNjS0hSc01sgIMBQSHSO6z6OgQOqORVWH4PVbnZJyhbD4nLIxS1F5eSr4D+l4aQ==
X-Received: by 2002:a17:90b:1a87:b0:1c7:3d66:8cb with SMTP id ng7-20020a17090b1a8700b001c73d6608cbmr25778294pjb.142.1650392558779;
        Tue, 19 Apr 2022 11:22:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id kx3-20020a17090b228300b001cb7ed57660sm16688613pjb.52.2022.04.19.11.22.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:22:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bluetooth.service: Set StateDirectoryMode
Date:   Tue, 19 Apr 2022 11:22:36 -0700
Message-Id: <20220419182237.2531907-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets StateDirectoryMode to 0700 as it is the current mode used for
creating files inside the storage and it is different than the default
systemd uses which is 0755:

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#RuntimeDirectoryMode=
---
 src/bluetooth.service.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 4d39ad49d..4ea98b506 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -20,6 +20,7 @@ PrivateTmp=true
 ProtectKernelTunables=true
 ProtectControlGroups=true
 StateDirectory=bluetooth
+StateDirectoryMode=0700
 ConfigurationDirectory=bluetooth
 
 # Execute Mappings
-- 
2.35.1

