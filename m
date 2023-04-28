Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFAC77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbjD1Sqv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346036AbjD1Squ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E3268D
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso395832b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707606; x=1685299606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/6BjiB3CztTfLUdP27sBZNVOKuIvJqXf2EZ0PwMXGE=;
        b=nf54Jp9isPKtHSFJCQs2Bt1sklZhnhDM+kfr3Dikc2BsnL0ctCkYq475ANBhY3Ep4b
         wOU/+/4gcc5X9KaS0Oeoye9hl3idZv/p+4IQK+NwXbd8DhA8T6bkZzBsxeo+F6IlhtZH
         Z7kSkxCj56cpVw0K28nZ9WLghMtnriGloDSl94iPonWcEtiA+kEQzkQlBsbRX4aoxgQt
         PSqTp1scZfWxubDQFIvm51RDPkunD6oQcW9SincrlT0LQZ5ziHyB7/prFZ4m8Vz3TZ0y
         eU+Wtg0WnPFSe6F8b+yPV5v5g8J6nmaPsCNcCypFi2Q/cbQh5OfsWgeiIQmSIIj1145v
         R06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707606; x=1685299606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/6BjiB3CztTfLUdP27sBZNVOKuIvJqXf2EZ0PwMXGE=;
        b=Wyt0rS4Fk/Bdc6qZAhzsQDmp90e/s/6ScZ4pvatIPH0fCYt+Sa5xL+CVIRBNASi9Wv
         wn07BCM29wUSK1pZemr9vnM+PaWbuVgMQbTK/iCk3/pzGoEw9AOKZhYGEzGtOM4/7rUb
         U+/ys+t5oD2SaSSJWYdX/N5cp7tfTqhWa+jPMJ2yWxcQd1LcmE1oocynUqbRmcNIN729
         XU6gKWFFfOqidCtxZQMPUBeErLXExC2D30PLr3o1FrZpXgM52HLxoPh7hK5PfGLVAmbD
         RChBZCWSZV4QLwcd7XlnOjlf9r6Qyi0KT5Rpt3j7cJelSkKmO3mdPFQhAJ4kHSigaBtc
         1wfg==
X-Gm-Message-State: AC+VfDysFVVHtSoziQjcnbIvKtr/VfPS7BSiOc6MUXPUkXaXdI8oDIBD
        65esmofb5ZlxIuyNqAovIuamQpaecfY=
X-Google-Smtp-Source: ACHHUZ62k9Dg25FtLalPM7VJfisiTXCefHa5L166CnLky774iv53WDwkY4Vp2W7+69vw0HqhVF2r0g==
X-Received: by 2002:a17:902:ec92:b0:1a9:b8c3:c2c2 with SMTP id x18-20020a170902ec9200b001a9b8c3c2c2mr7133114plg.37.1682707605959;
        Fri, 28 Apr 2023 11:46:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 3/9] share/bap: Fix not removing timeout on bap_free
Date:   Fri, 28 Apr 2023 11:46:34 -0700
Message-Id: <20230428184640.849066-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
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

