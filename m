Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0397ECAA27
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 20:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiHYUIF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiHYUIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 16:08:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C797BFC43
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:08:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x15so19948793pfp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=FjTGAAUprYz5An1oPjFJTl3OQSaKp8GhLv9KVGzta5Y=;
        b=DsBGUPS/sxK1qzzsfLKfTxS9/bqdbNtW406fQzicHsWGTHH8iXWfLmHmWzHxfDkzGz
         SRhw06TdcUBYKysViMxosNUZiA07qiPhQHoJyyTtV17ZqCqyRFBVFXSftFdm8E7gUuEr
         OoTfvSLpqd7xg0ewzKpcaySiqKGt0DTjRpvijD8wDcla13scg5e7AgKY4Xk4oBo01HGc
         JOG9bkjyTPVYOy3yS1XAhPbzmQuZxL6vcXxT/ZeEasD+oulxqs0RTAII+InzcunCGNL2
         89g0/a2YPntarQgWHIj9XQX/HTnle0zssHs8jaXZ7tKith+zS+cT7FUqdV/oBJ2++x5l
         B9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=FjTGAAUprYz5An1oPjFJTl3OQSaKp8GhLv9KVGzta5Y=;
        b=yq78ViQybhotJzdvOwQjfDCU9z7u46Txv0WaSNingOiqulM1EYnucYcf2fV7X6dJB/
         Hzs6z5Wz42iDaSHrJDVUejehU8LNPdKm991I44id601Ai6ZP0r5DOta/3ga15SXOVRYd
         pv7cEw0lXW3KhuNV2JqRVo6JRxo4MIsp25x6vWa4LAt/QiBZKPlediPTCgd0qVCbo8g2
         dWJLqFBCwanhha3sw/PHpxgQD4US7R8oKI3DOXii1NLDxt1/qyRfbqLIBUyAV7ul6m4z
         0iBzCsiL5YlflrI1HssU6QDtTx6ueLjQM1zXU4zCnCfXFPgT/JsNT8qyO9meX+3lOA3F
         40Dg==
X-Gm-Message-State: ACgBeo352wmcd2EG85LMplp49dh6jnGuUzH7n1hboCKfAbz8ez6Lw382
        PKv90dybPhC5AkXN0xC8GP8JcEu9qUA=
X-Google-Smtp-Source: AA6agR6vVz3VDQgviawkMpO8UIZL1hpKqp4G0gymUpXaYybw43pwQFJitc/dpaSwD3/Eel2KCEz1TQ==
X-Received: by 2002:a62:b614:0:b0:537:6d2:85e0 with SMTP id j20-20020a62b614000000b0053706d285e0mr618817pff.40.1661458080501;
        Thu, 25 Aug 2022 13:08:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902e38b00b001726ea1b716sm1779043ple.237.2022.08.25.13.07.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:07:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gatt-api: Add error code ReadValue/WriteValue
Date:   Thu, 25 Aug 2022 13:07:57 -0700
Message-Id: <20220825200758.1645136-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allows application to return error codes in the range allowed by
the spec:

 'GATT - Section 4.9.5:

  Application Error 0x80 – 0x9F Application error code defined by a
  higher layer specification.'
---
 doc/gatt-api.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index af0aa761d0a2..5042c54704e4 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -79,13 +79,15 @@ Methods		array{byte} ReadValue(dict options)
 					  "mtu": Exchanged MTU (Server only)
 					  "device": Object Device (Server only)
 
-			Possible Errors: org.bluez.Error.Failed
+			Possible Errors: org.bluez.Error.Failed(string ecode)
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.InvalidOffset
 					 org.bluez.Error.NotSupported
 
+			Possible Error Code: string 0x80 - 0x9f
+
 		void WriteValue(array{byte} value, dict options)
 
 			Issues a request to write the value of the
@@ -105,13 +107,15 @@ Methods		array{byte} ReadValue(dict options)
 							       authorization
 							       request
 
-			Possible Errors: org.bluez.Error.Failed
+			Possible Errors: org.bluez.Error.Failed(string ecode)
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.InvalidValueLength
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
+			Possible Error Code: string 0x80 - 0x9f
+
 		fd, uint16 AcquireWrite(dict options) [optional]
 
 			Acquire file descriptor and MTU for writing. Only
-- 
2.37.2

