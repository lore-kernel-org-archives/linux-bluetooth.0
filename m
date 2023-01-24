Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8ACC54EED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 22:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjAXWEw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjAXWEt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 17:04:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1714FCD6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 14:04:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 5so10821357plo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjDKNnXKI4DZyDT6VREKL9OJAP8DQS9re1UFtOGenYY=;
        b=Triw851jDp5rCcwa38GvZnX9afmN3AdhHiwRYVFQYxUj1eHIJsxU5Bujl9svEcFE1F
         kQH1PEomST7IRMEPz2+AqvyOTX6PtPE2ubRAOHh6q/L5SULqTLaFvU4qrOhC9qectat/
         Fqjiu8CZUTCg4AxAkfvmWAlUpeFvsWo0Qo93BcBIIByaHg0UekeSW9p3y/vvMwMlzYsP
         ZXhnhD3lU3S3awPmru2uU1KQyEsxTxKrxCP2cmxf6g/gO85FnXo9TtZZCYWqC0xt7dtL
         54HF+0pArMYY5/E+RU0GaqQZM068TVuMPeSEuSbbRymyQkR4qk1aP7FSgyrORb0TkJAv
         Ihnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjDKNnXKI4DZyDT6VREKL9OJAP8DQS9re1UFtOGenYY=;
        b=Z3hK1+zNo74VG4toO8LtH8erG9AEG4bbdkVZcsUQWVXAaVcfPYZhA/Hn2Pu5AjJsp5
         ngoOnWRfrRVAbVsyTHNKvk+mXpjaxOHeBArvJVI1/MiZupekGm2sCGJdfKC1W5UXNbgL
         xL5RxTpSrhlTiLq7p7r/vtkMO7jfqjGdiZ5frtd7512F5dZ6VsxTpLjJAVfhOQXGxgKZ
         YJGRGrCiIxNP9qd03OPQe6fSPeqhFm84wMIdTdtPgdGRzcpNPbsn6dPCiXXb41tNoE3C
         QR+GGo9hVbgNCqhmGhTVnkVxRscYgMTWKIbjUImZTnWZZBuUzKa3/zkTDAZsoic98eki
         bmSQ==
X-Gm-Message-State: AFqh2kqWJ+usr74KtAkZDl9YD5+cTmQnmMwQhtnssoXiaOCqLR+xdktB
        FE+EqBHfLAuumq+y2LRj0/GyZeu6F1d9Zw==
X-Google-Smtp-Source: AMrXdXsFCAMv5vfotu7OzYgA7YbG7Kjh0l6nSPgBSjkJdXpdwkUiaXgOFVf1WeyVg3yLPD4naUepVQ==
X-Received: by 2002:a05:6a21:2d88:b0:b8:7b63:252a with SMTP id ty8-20020a056a212d8800b000b87b63252amr27035065pzb.51.1674597865087;
        Tue, 24 Jan 2023 14:04:25 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79572000000b00581d62be96dsm2070958pfq.197.2023.01.24.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:24 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ] AUTHORS: modify email address
Date:   Tue, 24 Jan 2023 14:04:16 -0800
Message-Id: <20230124220416.312697-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 AUTHORS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/AUTHORS b/AUTHORS
index 291d9b049..45572d1db 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -53,7 +53,7 @@ Daniel Orstadius <daniel.orstadius@gmail.com>
 Anderson Briglia <anderson.briglia@openbossa.org>
 Anderson Lizardo <anderson.lizardo@openbossa.org>
 Bruna Moreira <bruna.moreira@openbossa.org>
-Brian Gix <brian.gix@intel.com>
+Brian Gix <brian.gix@gmail.com>
 Andre Guedes <andre.guedes@openbossa.org>
 Sheldon Demario <sheldon.demario@openbossa.org>
 Lucas De Marchi <lucas.demarchi@profusion.mobi>
-- 
2.39.1

