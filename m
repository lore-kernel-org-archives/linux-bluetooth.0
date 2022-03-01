Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA14C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 06:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiCAGPn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiCAGPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 01:15:41 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8410566200
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 22:15:01 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a1so4603974qta.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 22:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qzvDkeXrnzJfoZnnJMWHyXWm9jAHgdi71UEpmec65A=;
        b=CsBZITIfhiY/AtoIUkvzH48KLEvgOObopKtjZ9TnUn3Zlga1Po7DekTlhFpG8hmmyJ
         TCzB0oCrjW3cj8WgGdjKN4CThDDRVXTb4NJ8ct+ENhYboMPqGcr9q2DsRMa4OsEFNAXQ
         XEDvBHEd/eVzYZD/834W4UqEhfVrW4cle598I2Mng8sSO7PTYkEIrG1Y7M4c1ju5lPmU
         ZcRYasZhV/4WlGzBxuH6lbyhbkFiq1wnIpDNCqf423v93gwMCgqu/T5hBtRHmh3EzfES
         yqf0i7YOWVcqqSEUPanEGK9FpxAQgNZDa4f8hTBpk+Oi3WT6oAqD+9/9Gnd9+UG3yqBu
         ArxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qzvDkeXrnzJfoZnnJMWHyXWm9jAHgdi71UEpmec65A=;
        b=s9zaV6U6QM59P3JD7eQp8Vbp+9PMcVxfk9kqbVUqgVJYOcSadLc8j3I8qXd7JUCZpw
         TTlA7y5+SYoL4HhuxSDLJJj/Fx2WQo7FgxwHvimouylQOcUpAJ/nvdfLZvqEPs7tKbGk
         5M2/ye3SAbS9Y6grXKjCTlwvlxcnyTvuCd7LDnKp5YWXFKtG2ny6KWYstDy89AlHXJU/
         ANOm8rs1f1cQOBRvQn246xAfk2AT+p0Cz36AVtBROwRicRw52XrbaiL45pGlPOcPkUBs
         Ck1lvVfQTHW1UlNSoiwsnhk5iJyBUYaKqz21DhZDX0+IkuozMTP+XX63DihOU8Z5pdnR
         gLSA==
X-Gm-Message-State: AOAM530x/7OldPcLJ+krJw3DvfBaCOr64VQm1nk0kM8bTQRXsOgfLMwO
        g1ZmvRLvPoaeQmfHpeH4g/w207Dm4lQ=
X-Google-Smtp-Source: ABdhPJz9ixzLNa9zX/d8gj427pyDO+wMDTaXH13/N8GycaC9zxzcMDPS/VQZqYARLMQUcGqchnBlmA==
X-Received: by 2002:a05:622a:2c8:b0:2de:8904:e42 with SMTP id a8-20020a05622a02c800b002de89040e42mr18575444qtx.631.1646115300502;
        Mon, 28 Feb 2022 22:15:00 -0800 (PST)
Received: from fv-az193-672.ibjetn2pge3ujnh3vtdq41oyjh.bx.internal.cloudapp.net ([52.188.209.207])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a12f300b0050871994f63sm5950916qkl.120.2022.02.28.22.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:15:00 -0800 (PST)
From:   ihsinme <ihsinme@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ihsinme <ihsinme@gmail.com>
Subject: [PATCH BlueZ 0/1] fix writing out of bounds array
Date:   Tue,  1 Mar 2022 06:14:44 +0000
Message-Id: <20220301061445.7626-1-ihsinme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

see https://github.com/bluez/bluez/pull/303

ihsinme (1):
  fix writing out of bounds array

 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.35.1

