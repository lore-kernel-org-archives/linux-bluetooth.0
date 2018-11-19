Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA0AC43610
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3070E20851
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKgNKPa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3070E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKTCHQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:07:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34321 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbeKTCHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 21:07:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so3068022ede.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hVWDEZTwAs0KIDLaSYrjFiNHLZVKxKQh8wu3PgMIOl8=;
        b=hKgNKPa74rBghE/Wkb8KVKDSx9R1tWmV2x7X0SSOEBhv9+ZQtbWn47eYRdq2zo8poE
         V2+Z8eh8GzzDDYtrDgPPL3labvhnuhr+5iMLkaUkh7uqJ3JRwYfpmieOE86olmEg3zCh
         dDXVornxUHkggfKEPTcFPTw7i7AjZjQI6mSMR6W2UraC+JSydG2RQL2QeZgRJz13lY3A
         2oONdeRBhkMFASCyfmkOg6jfU+pLDj7Ujeprbg5HXNpwj0jFf4N8S/hjuy5BAMbT9ZhI
         h7WxVx8gkNw1C8K+zcl5gRTCUuNoc9Gzw1x2SE5CPfaxYs6bvkBN/sRGoe7E+z+4B6Kx
         /qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hVWDEZTwAs0KIDLaSYrjFiNHLZVKxKQh8wu3PgMIOl8=;
        b=tNj8tnzCuuZcKDhUFyPfVwx73ZlBYweVUM4RQuuAzrz3jpQuGtBthrEJUdlMaCPuEw
         NVsUDcDeV9r1UHmfURZD+4ofxPSGgbkuNHDQ1EmYlBKxD+IEZyS+/V3CBjw2ssbZaNey
         z1ThnoQcRuokqhToVuri1b1V2Ei6WXUakRp7wc1RlcsF5hYw+WsUoGoAFlUGNPno4Bj6
         J61blqv2d+pn7OkKmyIK3LdUfPmQDxAekcwbLqHKMUTgNe4Kq8/3aos+5wBkybG6ckIP
         jWdn1okL05fcVuSWiXiVVryu8zuHGgq3L0h/hjCbkzXZSRPQcfa+7IyyVxLKDE7ApXq0
         6dBw==
X-Gm-Message-State: AGRZ1gIaDqRF5qbrkXAijQ0W+6/IdwTL4Q1/dCxEdXfkKd5bDLknQpId
        6BqRBtKe2g6oWvt6+WwhIpC9Zpz+
X-Google-Smtp-Source: AJdET5f44Uu+SpMLcgv7V7IJA89G35zOo8odInv7E9HoK8DTnS4p4k9mOaCn85UEa2p/rtiRux/tIQ==
X-Received: by 2002:a50:94f4:: with SMTP id t49mr20711840eda.24.1542642196494;
        Mon, 19 Nov 2018 07:43:16 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s3sm684448eda.69.2018.11.19.07.43.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:43:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] doc/gatt-api: Restrict supported file descriptors
Date:   Mon, 19 Nov 2018 17:43:08 +0200
Message-Id: <20181119154311.27826-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181119154311.27826-1-luiz.dentz@gmail.com>
References: <20181119154311.27826-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only support sockets with AcquireWrite/AcquireNotify since pipe don't
work with sendmsg therefore MSG_NOSIGNAL cannot be used.
---
 doc/gatt-api.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index be4c60c6f..8dda60b8a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -100,9 +100,9 @@ Methods		array{byte} ReadValue(dict options)
 
 		fd, uint16 AcquireWrite(dict options) [optional]
 
-			Acquire file descriptor and MTU for writing. Usage of
-			WriteValue will be locked causing it to return
-			NotPermitted error.
+			Acquire file descriptor and MTU for writing. Only
+			sockets are supported. Usage of WriteValue will be
+			locked causing it to return NotPermitted error.
 
 			For server the MTU returned shall be equal or smaller
 			than the negotiated MTU.
@@ -130,9 +130,9 @@ Methods		array{byte} ReadValue(dict options)
 
 		fd, uint16 AcquireNotify(dict options) [optional]
 
-			Acquire file descriptor and MTU for notify. Usage of
-			StartNotify will be locked causing it to return
-			NotPermitted error.
+			Acquire file descriptor and MTU for notify. Only
+			sockets are support. Usage of StartNotify will be locked
+			causing it to return NotPermitted error.
 
 			For server the MTU returned shall be equal or smaller
 			than the negotiated MTU.
-- 
2.17.2

