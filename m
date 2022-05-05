Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 03:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiEEDlm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 23:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEEDll (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 23:41:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2834993B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 20:38:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x52so2639082pfu.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rT4H5WQ3A9wnK9fcW2eEWSSP4pDwFptJX7ZiVbyKx0s=;
        b=fz9xMV0ProQgmzXa77pMWM/iiitMdTLOYWGTVBFf/ApmEffa3TVkOEabscox0ahiDN
         p7dRnDqfWZPp6nMjZBkyQ2pe6vtWXfmCPpcuEhhIPGF4V3uIGfOvaIipca0qz+ibTUxz
         8OnlXTClHfSB93VhHmIQl5R9WKufxufIDEOTW7129+UOLX92bPjS3BDOxvbhR/QSCNVb
         64aF9KtOY/Kgnbd6HPjGVOTRPG6L0wJQc/ExJg2BAYA0iyW14fFu8QpL5jBjAo5F/Iu3
         iDKJ/zkwX73QEPyotz7ySYia2XhNapUsBuPMq/q2nuSEaFu06joj9Sr22rPFW3xIUaJm
         9bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rT4H5WQ3A9wnK9fcW2eEWSSP4pDwFptJX7ZiVbyKx0s=;
        b=3MsB6l704rD3lcoRPKyGw6TR/ROGZjp0KL+nhJ8X2IqYJKuJT0HyfZZdqQs6xDmycP
         2UKNbL6BIWVuacoDkrQqw79Or6eICFQDL2l4w5RhCK0/rLPmZVizXK646QJoXdn5kzyl
         n0HpMaVuj2ba35JDTm/URWJ21Spx9z4v7t5nffSMYspQfqLI9iRirWw6YB5lAor8WSFd
         eUkzMsiwi8XKygOvrKTSc/ne4V/YkEJfnxKjrolFyaSRfEQUeboubKD9o8bLK7HO05ni
         9qiGHW2W/GQ4fndRUyHpONNX7LF7wy0bU8hdz+UFk5PGTTyA714v1knVHc1u/a0FE3nx
         scIA==
X-Gm-Message-State: AOAM532bEbM5M3pW2AuPfZMggpDLSvJbTldAPCH0p9IgtGstvHmwyu1n
        vvCP9jrK9MpMXk65h02NcI7i1C5gVII=
X-Google-Smtp-Source: ABdhPJzgQnCyWokMfeMM1Y55VpI5nxB47zsL73mDKohhp6Fhph17O0zkk6Wa4DlV9nqKfkGjmmSGQQ==
X-Received: by 2002:a63:834a:0:b0:3c6:505:4d29 with SMTP id h71-20020a63834a000000b003c605054d29mr3127871pge.259.1651721882571;
        Wed, 04 May 2022 20:38:02 -0700 (PDT)
Received: from fedora.. (104.128.94.217.16clouds.com. [104.128.94.217])
        by smtp.gmail.com with ESMTPSA id k22-20020a056a00169600b0050dc7628149sm186918pfc.35.2022.05.04.20.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 20:38:02 -0700 (PDT)
From:   LuoZhongYao <luozhongyao@gmail.com>
X-Google-Original-From: LuoZhongYao <LuoZhongYao@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     LuoZhongYao <LuoZhongYao@gmail.com>
Subject: [PATCH BlueZ 0/1] btmon: discard corrupt data
Date:   Thu,  5 May 2022 11:37:44 +0800
Message-Id: <20220505033745.3242729-1-LuoZhongYao@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

   When damaged data is received, the data is not discarded and the offset
is not set correctly, which may cause data->offset == sizeof(data->buf),
resulting in the inability to continue to receive more data

LuoZhongYao (1):
  btmon: discard corrupt data

 monitor/control.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.35.1

