Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB2C7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA71520665
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 17:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzUgo4AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfGORlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:41:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36423 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfGORlB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 13:41:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so18064002wrs.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2019 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=leIP0OAh53+wTgpcOjXWf7ORXKa2TGEslcN5WSiwGog=;
        b=VzUgo4AQMs75lSyRTFyMqkTPSIqUatOrMZ/TrrvNanFKn6b/dc4Sm8rsDVP1yEevZJ
         Bz7za56RURsWKeaFElsqls7EzPm00B69JgBLy0IG5jU6f+0H8bA/gDFEdxNWcodFTtxT
         BGnQCTV9Yy+RepsMjKBsnOVXKJj1BSdfPDcmLa941smQQQlKTmeDS0EapGGbagyTJUCX
         YuILKcVk0f6Nm2Mkz5oWdjJEFsROP1Wrvxs1LIRo4QMsEshRzjZI8QcaPvmq4BW2O5UJ
         pjTPBYFugo4q9URwEhGVag6zNvny9f0oPM/ffJNi2795wVf3ECkMar/OHQEkhpzo7sTo
         Vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=leIP0OAh53+wTgpcOjXWf7ORXKa2TGEslcN5WSiwGog=;
        b=Ooetao+3z57jcTYfdiuZLBtemqmcl87GORMIW0yLup8tmumSPwkou766lNuLnNQ4+j
         YgB6NyQPzz+zOErMKYU9jmUk962CW7CIQd91QJlRfqQDdNJzUU3SOROjEHXBkWQKu3OI
         WBIURaqUWmPLBiouQszK78xxSFguxiBiHLEi4jmp8Y4KtPDMA9qN1jNLoWEIknt/k+Iy
         4PWii7Ycn8hdQcoZoBo4WHhJ/cF/GGZK2AeWJIy5P5tqeoklz1WzHorn4+dyn+pE+AVt
         paXssSuGNldRhz+oybF1ginEZ1zclN8IqvKGDT91smpwVwRCpP2uotqtDzHqaStwVACB
         iymQ==
X-Gm-Message-State: APjAAAVBeZExEbgT7YBDLBVz7691fMZp+oHcch2l8kUXuooN1xqCb2n4
        i7BdWuwzRfzq1E4sRbJ1S/0=
X-Google-Smtp-Source: APXvYqxnO400gb4nBlLb9qe8sxSE82wynOjntDNz3s2dfumcXGzDJkqoJxsdC6iz0BNsyplWigQnMg==
X-Received: by 2002:adf:8183:: with SMTP id 3mr30469034wra.181.1563212458532;
        Mon, 15 Jul 2019 10:40:58 -0700 (PDT)
Received: from [192.168.153.44] (urania.mpim-bonn.mpg.de. [195.37.209.183])
        by smtp.gmail.com with ESMTPSA id v65sm17900477wme.31.2019.07.15.10.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:40:57 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com
From:   Fabian Henneke <fabian.henneke@gmail.com>
Subject: [PATCH] hidp: Let hidp_send_message return number of queued bytes
Message-ID: <f46a923b-caa8-83bb-1b64-44bb0ef25ca6@gmail.com>
Date:   Mon, 15 Jul 2019 19:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Let hidp_send_message return the number of successfully queued bytes
instead of an unconditional 0.

With the return value fixed to 0, other drivers relying on hidp, such as
hidraw, can not return meaningful values from their respective
implementations of write(). In particular, with the current behavior, a
hidraw device's write() will have different return values depending on
whether the device is connected via USB or Bluetooth, which makes it
harder to abstract away the transport layer.

Signed-off-by: Fabian Henneke <fabian.henneke@gmail.com>
---
 net/bluetooth/hidp/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a442e21f3894..69af11f98e4a 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -101,6 +101,7 @@ static int hidp_send_message(struct hidp_session *session, struct socket *sock,
 {
 	struct sk_buff *skb;
 	struct sock *sk = sock->sk;
+	int ret;
 
 	BT_DBG("session %p data %p size %d", session, data, size);
 
@@ -114,13 +115,17 @@ static int hidp_send_message(struct hidp_session *session, struct socket *sock,
 	}
 
 	skb_put_u8(skb, hdr);
-	if (data && size > 0)
+	if (data && size > 0) {
 		skb_put_data(skb, data, size);
+		ret = size;
+	} else {
+		ret = 0;
+	}
 
 	skb_queue_tail(transmit, skb);
 	wake_up_interruptible(sk_sleep(sk));
 
-	return 0;
+	return ret;
 }
 
 static int hidp_send_ctrl_message(struct hidp_session *session,
-- 
2.20.1
