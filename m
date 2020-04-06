Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D40CC2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCE4206B8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cn3Ws38V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDFSyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:54:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43956 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgDFSyw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:54:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id s4so420543pgk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3s/azVcAKYn4FoQVJtdOnYETn5jVBnR54PceNuclGDY=;
        b=Cn3Ws38VjU3XKA0YB+NsZVZON02LqxDqX2Joumi9OSkK1/4XEJ9aWWN+dBydJIceHR
         dq1K+tDGrYE8Nzg7abG1ESPx6SrMdR7dqdivll6u/+p1OEWBXY9YszFS/Rt9IlpSnHWC
         SF/c6JPbJcBAtAbCtgI4uWYKnuLBmj6YG09w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3s/azVcAKYn4FoQVJtdOnYETn5jVBnR54PceNuclGDY=;
        b=HCGLm9fPRS0jNG7JcRv+yXrvq73Mr98UkHazm8JiwA3dBzqEDSsyOiG7icyc5MA/As
         agvk/6U6JBKAqZQXcQJdtQu3Z05dBJmdhpnYZmXX2vZwE3yl9+UVgWClEu4TM5o4M5Wq
         yTA0H9TfgayXHkWGQPcCJs9jaFE19+1fvnNZwW9WsS3g9i7vIxxfE99Z1W4/KAJai24g
         ev5g/JHpsSlkDjnfQKVcS1XEbUnDQk4DorjYHM9QoODtgUanMOuwxxAXWDRMLZLsntiZ
         6hPdVHUn55MYMZWMmiJKimINnGvyB4fMleL536caiXrsbTVlfbI/CXKUIOQfUmYBZ8E6
         7NvQ==
X-Gm-Message-State: AGi0Pub9hecYXB3GR6FvM9fRcWwSVUR6gJsqE/3lh4BFL2T71K8OEoJo
        10J28MQTl0nUOVTcsxCiM/zTHmJYMOw=
X-Google-Smtp-Source: APiQypJmXhvs3CN/9nuie+zQm7s1dZL6vWiE0E6gCFFoVIjQwUnnJ1Mj1rfVBuNdLl7VYW69H46Wkw==
X-Received: by 2002:a62:2f01:: with SMTP id v1mr886586pfv.136.1586199290345;
        Mon, 06 Apr 2020 11:54:50 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id y4sm12253649pfo.39.2020.04.06.11.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 11:54:49 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] Bluetooth: Simplify / fix return values from tk_request
Date:   Mon,  6 Apr 2020 11:54:38 -0700
Message-Id: <20200406185438.13576-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406184523.GA49680@roeck-us.net>
References: <20200406184523.GA49680@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Some static checker run by 0day reports a variableScope warning.

net/bluetooth/smp.c:870:6: warning:
	The scope of the variable 'err' can be reduced. [variableScope]

There is no need for two separate variables holding return values.
Stick with the existing variable. While at it, don't pre-initialize
'ret' because it is set in each code path.

tk_request() is supposed to return a negative error code on errors,
not a bluetooth return code. The calling code converts the return
value to SMP_UNSPECIFIED if needed.

Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
Cc: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---
 net/bluetooth/smp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d0b695ee4..30e8626dd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -854,8 +854,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	u32 passkey = 0;
-	int ret = 0;
-	int err;
+	int ret;
 
 	/* Initialize key for JUST WORKS */
 	memset(smp->tk, 0, sizeof(smp->tk));
@@ -887,12 +886,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	/* If Just Works, Continue with Zero TK and ask user-space for
 	 * confirmation */
 	if (smp->method == JUST_WORKS) {
-		err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+		ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
 						hcon->type,
 						hcon->dst_type,
 						passkey, 1);
-		if (err)
-			return SMP_UNSPECIFIED;
+		if (ret)
+			return ret;
 		set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
 		return 0;
 	}
-- 
2.24.1

