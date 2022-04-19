Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54152C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352527AbiDSSem (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357381AbiDSScy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 14:32:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712D41F91
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:22:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h5so24859566pgc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6+RIPaUGtTZuyDXwJAZIdaPkQNyTNnASeRBzfJz7OLQ=;
        b=p1Z++Y1a2UuzqOpRJqsJ1JiqaVB4Ss2ARrV1NsSSSteMUP1JKBJG+QkMlynK8PhjlO
         mN5r56Ihe4MCKIOemxcmGWj+OIuN05Vs/ncRXytE1AUHQMFTEU3pv/IFymLDX9AUV+xj
         EJ5+UkYbcacEE4iGwUK2ApJ8wDVJTgFU/9ZrMpxo54rd5yEeilGtVUlQBY9xiMkUlwIP
         YNDptKSmCKaM6cIOboRzId5hgVqagV0XSIRKg29rBgSfc0vkenAv2OGpEaWaycTKoVgb
         OdA7v+u5S0C+YneQfYaSnX0uZmDKr97rWsQTh6CaWNQyxPaerW4D5KexzGLQshxjuA9H
         TmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+RIPaUGtTZuyDXwJAZIdaPkQNyTNnASeRBzfJz7OLQ=;
        b=rZ1nF1gR/jZwiTz+H/cIOcNm/bRuIz7KrUE598gIdHKBcbMGGvjEXpbSnRJx81mPpB
         eYUUqUbQYwzRFjEd86yNFwaDWZTdIaqRh5Nh6LV9ZnG0UGFAkVEEznvr/UlOqg29SRwM
         CtGSRBG5PpMAW6nWXa+MG1X76LDX4HqeL1/je1vi3vy63EKGiBKoknTeS83PjTkLIFfO
         ZFp/okFGRf2GJmqpG2m9eAN+F7ydbbBEtE80P+dG099hfOutNKrBrji5QagfJRJxyKVY
         f/SECj4OPJPjOK/q/KX5jS5Bjwxb1BOJGh/esMi/JZ0ot2hkuXpO9XAbOhjkNQvwkaVJ
         2lJw==
X-Gm-Message-State: AOAM532DZM3uMBwi+uQFHhprglGu2m/7aDUOTtyci07VsBtNG3TwmCnx
        ufKDWvKHRzU9cyDgGj9IEcVrISq8x+E=
X-Google-Smtp-Source: ABdhPJxhvyhh83FPWObTpj0hQrzubLmnOpVm5kO8aseCLRzEElxl2CauTAj68qAz7l8WnYOFn20ihg==
X-Received: by 2002:a62:4e90:0:b0:505:fa47:b611 with SMTP id c138-20020a624e90000000b00505fa47b611mr19132521pfb.65.1650392559767;
        Tue, 19 Apr 2022 11:22:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id kx3-20020a17090b228300b001cb7ed57660sm16688613pjb.52.2022.04.19.11.22.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:22:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] bluetooth.service: Set ConfigurationDirectoryMode
Date:   Tue, 19 Apr 2022 11:22:37 -0700
Message-Id: <20220419182237.2531907-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419182237.2531907-1-luiz.dentz@gmail.com>
References: <20220419182237.2531907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets ConfigurationDirectoryMode to 0555 to really enforce the
ConfigurationDirectory to be read-only [1].

[1] https://github.com/bluez/bluez/issues/329#issuecomment-1102459104
---
 src/bluetooth.service.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 4ea98b506..beb98ce0c 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -22,6 +22,7 @@ ProtectControlGroups=true
 StateDirectory=bluetooth
 StateDirectoryMode=0700
 ConfigurationDirectory=bluetooth
+ConfigurationDirectoryMode=0555
 
 # Execute Mappings
 MemoryDenyWriteExecute=true
-- 
2.35.1

