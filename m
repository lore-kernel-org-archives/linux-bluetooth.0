Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 22:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349081AbiFCWcr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiFCWcq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 18:32:46 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9D29CBB
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 15:32:45 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h7so819951ila.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CthkhlRxZHKfmVUvwmEZ1uekjvuetDlWmyTRyQCf7Zc=;
        b=SQ7PUshqEhXGPH/5m6qMrxb99LYLyHk7cp0jrCv+HnFeSpOT7SAzo/HDOrdKTd9L10
         6hUKXqYdIjLBN3/f2aWY+U91CS02RuUmc0gFVdnoxgfqo7lIIjlnUMZ37Svht2Smk3hw
         SqdQI73WHaMi3kRspxRYFHiv1kkTkl8uC2v1y+ws8Z1qBT47OtzwjBrIcFx+aveNnx9P
         MrCBRZMiGyHuSgHJgBlp50oie5GGkhHlcBUROtho7SvzplZnixrvbmX8VJrDIszVjuku
         xr2IXgzKQXZ3glWFCypsSCr3ll1rsAnmdvb9t7kvQ6KtFnv+vcuVogC+AmdMeeb9mu3d
         6mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CthkhlRxZHKfmVUvwmEZ1uekjvuetDlWmyTRyQCf7Zc=;
        b=4nk1wLlrQRev/BCaUzuYwPFF+nEeIIZ9CvuPYasnk9JItZ6f6bVQ0ngfUtw296D42I
         +QZDgXSQZ0FELT0cbplh72NB07unZNh5bpB0ZHH/0EqM4RGlDC280jYECnnyb6Qbg7ic
         3ZmMcjXk34lLX9e4Rvp+Zi1t1VRj6zxu/gInhxp2nDAHus45+zj9Mwz0B4F2DW+Y6BjQ
         lK/JWFLxqBIiRj0H4rxEuR5I0XyOBxvJSHhK1ZfVmgCrg7BoNxg+HHdzbrEy8oRMeDQT
         ShDmUTPxj5xdnfqvlvZ6fzW3ne+oUEzU24sDl5zEHJAF2KN8VW7M02eEJmZsEYXzKPma
         urcQ==
X-Gm-Message-State: AOAM532vdO/9/U+Jy2NSOvs96AxNnyypKpd7M85gHlgaib4rmVeKcVEx
        HA3B70mDfRsujbv1rfxiUICSMgOZgfA=
X-Google-Smtp-Source: ABdhPJzgmQsxyyFqgXmLPcAtd2NsSD7yyd3FPmxZEbGk/6DOIcOA8RP6nbdOnO+rmWfp+O8PZjrFAg==
X-Received: by 2002:a05:6e02:16cc:b0:2d1:9a4c:db79 with SMTP id 12-20020a056e0216cc00b002d19a4cdb79mr7184509ilx.175.1654295564699;
        Fri, 03 Jun 2022 15:32:44 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id f2-20020a02b782000000b003315c00e885sm2825352jam.0.2022.06.03.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:32:44 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH 0/3] LE OOB pairing support
Date:   Fri,  3 Jun 2022 17:32:22 -0500
Message-Id: <20220603223225.20296-1-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

This patch series implements userspace support for LE OOB pairing. It was
tested against an nRF52 dev kit with Nordic's NFC pairing example. Support is
only for reading a tag; generating and sending back OOB information was not
implemented.

Overall, LE EIR data is not dissimilar to BREDR, but the OOB blob starts off
slightly differently necessitating a different code path before reaching the
EIR parser.

Michael Brudevold (3):
  eir: parse data types for LE OOB pairing
  Accept LE formatted EIR data with neard plugin
  neard: Update D-Bus path and interface

 plugins/neard.c | 64 +++++++++++++++++++++++++++++++++++++++++++------
 src/adapter.c   |  3 ++-
 src/adapter.h   |  2 +-
 src/eir.c       | 21 ++++++++++++++++
 src/eir.h       |  4 ++++
 5 files changed, 85 insertions(+), 9 deletions(-)

-- 
2.25.1

