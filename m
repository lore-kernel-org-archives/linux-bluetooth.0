Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6670FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 22:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378342AbiEEWvN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352168AbiEEWvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 18:51:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436755DA3C
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 15:47:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v11so4796348pff.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=YvEvfflN4H+g4Koz1knNPtZ3ry+BkfawxTixm5ux4/caQSECP4HyDrOBioahKp1AQI
         0YRn6lZaUS23iNQA7ih09qoGBlNEBJx58A55FHCOSN0zvC5A5sILH9bpIAFtFh3sbus6
         jIC5dnqZyKIrw/dWWuWZIOmK+kiyyWPiQpAmOWibc2BoePXmVYUI3NeLHs0ukQ9WNfw6
         8kEIKTXuK3vyDbhk5RgMtpsy9Lsah6wmgFu7WgTKDcaJyG0XmrdyoaeC+3TfHYPqL27D
         si4DxBY8iAysXz1hTOK/S2ota5YDnq5qrcFRlrkwehEURwoFj4oMBn94aHNsrm+VJde9
         fnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=MLqogXAm9PR5RkO72ujiPS14RmJmn1SoGaf0FlpOEDOZePU1KRDTWAI1gJUr/RqrGw
         Ra7k7eMI3TyfqvYeUnrLfizofPwz8mnZ8TNren1kmc/jbW+wN36Id6mruPhkhuWeRwNG
         pvnk2kjHzmjWNBrqWXCZaMByZ5e73XaNqJ2hZY0i34Ge+cWiZaYDGt6V5GUk7FpCcV23
         0PcLd01V+YczqUL+ReJl2inpEzlszjOCuHFZpJPjZe+FFdWH7/BZnW9YLAsrZdFfXKjP
         mcQtSfGUCa1KFZp+MySc5grDxTlEjaRBN/T4CwQbDDc3bcy1pQ3+M4knJoF4tfDjo7S3
         pupQ==
X-Gm-Message-State: AOAM5338OgXkC0ejPaAO9OfiwFGGmUumRqjbGikEU0YBodECzxXTqAxw
        nrzEyyayyCML5CbfU6/ANpV/dFrPrP0=
X-Google-Smtp-Source: ABdhPJwQEpaKZpMe1VlSkLiPkxtiFnmZcOyWbe9YX9uEUc0fobRt4NyhXWnXLN40m6hu3DR9STk5iw==
X-Received: by 2002:aa7:8888:0:b0:50f:2e7a:76b7 with SMTP id z8-20020aa78888000000b0050f2e7a76b7mr563924pfe.48.1651790850460;
        Thu, 05 May 2022 15:47:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0015e8d4eb2aesm129651pld.248.2022.05.05.15.47.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:47:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Thu,  5 May 2022 15:47:22 -0700
Message-Id: <20220505224727.3369989-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505224727.3369989-1-luiz.dentz@gmail.com>
References: <20220505224727.3369989-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.1

