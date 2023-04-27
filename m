Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6FC77B61
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 23:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjD0XOB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344399AbjD0XOA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 19:14:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A8F272E
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:13:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a516fb6523so92930795ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682637238; x=1685229238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/6BjiB3CztTfLUdP27sBZNVOKuIvJqXf2EZ0PwMXGE=;
        b=UKOCOv/CBXUfnQVbEq4cO4b+YoohtaUpo8Hcr3T4Xoajzxy/LxRrRIawdCqrjxCz4R
         ezj58lUMhqLjM4l3JxNjlkARzG31rTN8gbSppYGiz+M7ZHy+IwQQvAKdNLUzMFOeOc3w
         psWB7OSaV4C7TI2yx+ijHkgvGS/GMpWFXb98xaPCwAUH+CNKOYfoE05kMtgZKug2FkZq
         B0D13SSDdMEIsIQKZzkIdCExcmwwvWvW+MbcBhcmLNAgK8vWtR/M10vYcb9dUrYcfTBu
         LBs/pJBiOjQz4zrhLfCINmFazVyLabsunGlWe0SNQB4M+tAR08qVCpTID/ZBX9XCABIb
         QAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637238; x=1685229238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/6BjiB3CztTfLUdP27sBZNVOKuIvJqXf2EZ0PwMXGE=;
        b=J+y7xpCPUbnqPlvWv86E9UQZvYOb4HHina7AYW+/gqtPiYmUwxopHad2IEfwrQA7ia
         b3jTYGV7SDO5p18s380frN4YHHpK0fiS4Xl/owucE1i4pc9VFJ/TluAQqQSqv+EMkfky
         uyOr2Idd5iZQ2K8CBs0FjxoRMXXhTdzG0xcbBmb39TZvnLQpqm6P3LOGxHE45OnIhEn+
         GjciGSM+m/nB3eG+pA6eVL6v0P+p7vPETyHnh4WJKlLcR3Gb/+8zPvOG+IVM3MkeNmRO
         H3w+SVXYSjM+JM1x2TvVo5Bb/v+CDEp7YnYjJGPmihdg2KLbM+MI3n5O8A/cX8vl9Ijq
         3G8g==
X-Gm-Message-State: AC+VfDyEc6wTAApL6mHjxkksa0gFU4m4M5eOgDCIGv1mKIE4LcfVgGJg
        6fvrPPFvLcqBZURSgjAPlEhVEETZRFU=
X-Google-Smtp-Source: ACHHUZ7E8f6CwatxLsugqTHSL0M8oAVZzcsTpUdiGWvSK/6sTRZaKJAlYpsf6EIB4UmFcplwx2r89Q==
X-Received: by 2002:a17:903:32ce:b0:1a6:3d8e:face with SMTP id i14-20020a17090332ce00b001a63d8efacemr3906178plr.0.1682637238095;
        Thu, 27 Apr 2023 16:13:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902aa4500b001a24cded097sm12112369plr.236.2023.04.27.16.13.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:13:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 3/9] share/bap: Fix not removing timeout on bap_free
Date:   Thu, 27 Apr 2023 16:13:46 -0700
Message-Id: <20230427231352.576337-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427231352.576337-1-luiz.dentz@gmail.com>
References: <20230427231352.576337-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not removing the process_id timeout when freeing the session
which can cause the following crash:

Invalid read of size 8
  at 0x18EB39: bap_debug (bap.c:553)
  by 0x1913A8: bap_process_queue (bap.c:3542)
  by 0x1A8630: timeout_callback (timeout-glib.c:25)
Address 0x55e0650 is 128 bytes inside a block of size 160 free'd
  at 0x48480E4: free (vg_replace_malloc.c:872)
---
 src/shared/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index bc6177a5ba90..6131c312865a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2600,6 +2600,8 @@ static void bap_free(void *data)
 {
 	struct bt_bap *bap = data;
 
+	timeout_remove(bap->process_id);
+
 	bt_bap_detach(bap);
 
 	bap_db_free(bap->rdb);
-- 
2.40.0

