Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40AEC00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 08:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbiHHI0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiHHI0e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 04:26:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10D13DE5
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 01:26:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y13so15143993ejp.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=71mE66J3ERxXp8+TtlLuDBbmzDbTaroriWxGGsN8hYE=;
        b=INS3MiKDrbPz14WoyXOKCHCdpV1/IpWj/EfFGXJC+ExfL+ONIy2hGIk7jiAHWCaB22
         3FR/z3elLrBtLde/BDHmvYu85f44/BrJVQKd1TtXr+8CtEQo3RjeUyXP3JvSYyo035dR
         8A0QplhdvJzRJYhGht351+6R4NgEijL5suY8eVDNCovwhoHcpLwLLjg/zCWLZ8YlE3yu
         abTWBgaBEb9Yz+vhJtxs1EoICN9zi3JbMxWwMsOlq4a969WlRmw7AsAu6SifgPzgOE/P
         FBfHWITTyyOrdQcgiHQuN1k0w5FbZ8m93iZbXcVvq7JpO7dD7k+ZNQ9dJxPgPI2sDBt0
         uPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=71mE66J3ERxXp8+TtlLuDBbmzDbTaroriWxGGsN8hYE=;
        b=vd4HV384biE5CX/I2q4tFh8bF8g8Amuv3IbeAjY9JQk8YncpZWExc80hm2Jrj+AmON
         /WZL3XEQZLCWgKZ5K6GxwqV4c/8pDeWrLxIhyrhvXT1x/WFcqa775oA9SlLq869cu9Dm
         9Z4pWdISaCYNAL3++tAOmzWAp1tc53uDk7bYFpHSY3Vf3FG/hfUSf01+XYtWXABtSYQ9
         EnPVi7EXRJgsaN+R9nA2omTjLnij9Qw1jAeHN1biVX3qvaJp4ZtjloB+G88s1+inT5yD
         s5YqusJ1uX8OBKHSsoHjQn6PYRGndOE1c4h4MjjUTYGLjdk3BFw9VI46ZQEvc6zzNw3F
         lRwA==
X-Gm-Message-State: ACgBeo0lSEdPP7xTzEPPiKcTuft5rJg1Z2EDU50XrxRyL+AU1T1ETLmD
        ywzhMIjwmHyMXZIioqCf3vt/AOxg3lMm0036
X-Google-Smtp-Source: AA6agR5eSwL1fnSDiFAUPT+q52oQpApYpLiO7KAmnFxlvOeFeaLlaI8kSF+eKogWC1IO3lbSwfr58Q==
X-Received: by 2002:a17:907:2c78:b0:730:e952:4104 with SMTP id ib24-20020a1709072c7800b00730e9524104mr11196115ejc.33.1659947189989;
        Mon, 08 Aug 2022 01:26:29 -0700 (PDT)
Received: from cati.. (5.186.100.144.dhcp.fibianet.dk. [5.186.100.144])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b007307d099ed7sm4716228ejc.121.2022.08.08.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 01:26:29 -0700 (PDT)
From:   Alicia Boya Garcia <ntrrgc@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alicia Boya Garcia <ntrrgc@gmail.com>
Subject: [PATCH BlueZ 0/1] client: Fix uninitialized read in attribute handle
Date:   Mon,  8 Aug 2022 10:26:23 +0200
Message-Id: <20220808082624.146995-1-ntrrgc@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With the previous submission the patch failed to apply, let's retry...

Alicia Boya Garcia (1):
  client: Fix uninitialized read in attribute handle

 client/gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.37.1

