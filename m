Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D267C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 11:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjA0Lhi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 06:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjA0Lhb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 06:37:31 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56239113D4
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 03:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telink-semi.com;
        s=lgqu2209; t=1674819363;
        bh=LgTTC/TLEhF0BzRQPSAklDMCm7nG2B83icGTGG1K4g0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=blf5U5ano0sXI32g3IpwFLWRyemKMTtQolwULtLsFj+22zMLSMOfBFsNdYyxKzN4s
         gS90+3EOLCS7xpI4ZG46nnc62UjX/GV4thGiXU3wR2iAP04IzNGatbEsI+ztaLvmTy
         HBdtrwdleyPis9p+NQ7vts7cDxGXRigiFjregNZg=
X-QQ-mid: bizesmtp91t1674819361tipmilo2
Received: from fedora.. ( [85.31.249.147])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 27 Jan 2023 19:35:54 +0800 (CST)
X-QQ-SSF: 0140000000200030D000B00A0000000
X-QQ-FEAT: znfcQSa1hKb4Q2TYl9rFjQ/0K5IDkrhtwpvjZzJHc7lBV/sPGlMMTVZzDARZe
        sOLXQs/qnjMQ8og+vtqGNPftX89Omas/uVtIjS5lPdAg0fgfUIp90+yJ4ikMdggPK6j1bOD
        SZ6y17wgh/3N7MziT2eQuRL0RpBK9a5+jW9y6mBIcw2snvFUjoISDdacprbnhCBIvyJWBYp
        BkLAHz+L55aUlq0cVx4GKl5HpvkXMKyikSNvFRM4GdS5DiRVCHEtPnE95CvxdcdlX7p3kki
        57+y4ZWyFnI2EoQRIfGRO4knRlahiYfODQAlfHnuhJ8tNdFQJHQXeGcFh0sVLCjgEsErXan
        WnTHW982AOpt7c09aWr17IdbVPZHWfjJqN6uD+itRpzrhmfXX8inib+DjAJvd6on93owIg1
        Jr2xNZcFDY39NSvzS3G8mA==
X-QQ-GoodBg: 2
From:   Marcin Kraglak <marcin.kraglak@telink-semi.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Subject: [PATCH 2/2] AUTHORS: Update Marcin's email
Date:   Fri, 27 Jan 2023 12:35:03 +0100
Message-Id: <20230127113504.134109-2-marcin.kraglak@telink-semi.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
References: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:telink-semi.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 AUTHORS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/AUTHORS b/AUTHORS
index 291d9b049..5d2d09688 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -84,7 +84,7 @@ Petri Gynther <pgynther@google.com>
 Scott James Remnant <scott@netsplit.com>
 Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
 Grzegorz Kołodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
-Marcin Krąglak <marcin.kraglak@tieto.com>
+Marcin Krąglak <marcin.kraglak@telink-semi.com>
 Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
 Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
 Arman Uguray <armansito@chromium.org>
-- 
2.39.0

