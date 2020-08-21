Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F2820724
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oToy7o0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHUScm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgHUScl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 14:32:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F798C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:32:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id j13so1176831pjd.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4fJEJrOfNYX+h8qqGsLJy1ms3/GXFmWCekSgzQoR7w=;
        b=oToy7o0EiYf15FrNFGitmk6Mhd74HVw1h8gYsaccxRF2dDBd3w2wvgu6fzevyurXSS
         SRG9Mz3uXluala7EciP9FnlMBGs/uEarwqtGkzF7cZm6zp9K0npcu2xTZMkewlXzBsAD
         Bpw6Zo0Qw3s7ffdalDtPi9i0xUzUVMTFuRugI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4fJEJrOfNYX+h8qqGsLJy1ms3/GXFmWCekSgzQoR7w=;
        b=EyYs4MExV4anD8aA4ubzsdUZw1f6O2DySlSVzd1i6EZNoXK19KsucJMf5kkKMaKuCb
         mCuhvdUNgiicM+FJkr027EZ8XzpH5yCkCca+JadmdPiGvNGhI88efcEGocVQ18CzdM51
         ip1Op2e8lUMo1tZUO4P8aC+NjmT4POyCqW5iUjRpKvtWI55suPsPVlOn4QY9g6jior9a
         MjEfGdAH4rLtMjP2C6pjy/PRhm0sB1Ch4N2lsLK+uEweD5bhfLJiPHZfOeey1fxTDo7e
         NwJgKZ9JEk4YrdXL3GeSe4CHsyinCmKUBC1iXErCAbPRJq7SybUKglHqpzp/l03+CqET
         njew==
X-Gm-Message-State: AOAM530WrchtPkNEi1s35Go8mbXQs2zyshfznSOppWxCkY83YXc2zqnY
        O5EsZUDOvFYN30P81iSbKXsLBd1LwYB+XQ==
X-Google-Smtp-Source: ABdhPJxUFG3aGCGXY7Eddoy2oBtCflcTmDrpTmAYmr7hw5i+UelIhEqT64BDARiCtiGTwNWicskrVw==
X-Received: by 2002:a17:902:c404:: with SMTP id k4mr3409459plk.234.1598034760309;
        Fri, 21 Aug 2020 11:32:40 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id j8sm3344145pfh.90.2020.08.21.11.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 11:32:39 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Shyh-In Hwang <josephsih@chromium.org>
Subject: [PATCH BlueZ] device: Disconnect att before creating a new one
Date:   Fri, 21 Aug 2020 11:32:36 -0700
Message-Id: <20200821183236.21963-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When device_attach_att is invoked, it may be that the old att is still
connected (the disconnection hasn't been detected).

This patch calls the disconnection callback before creating the new att
since the disconnection callback will never be invoked after the new att
is created. The disconnection callback also cleans up the att of the
device object before assigning a new one. This way the old att will not
at later time fire disconnect event which would operate on the already
freed device pointer.

When there is a HCI LE Disconnection Complete event followed by HCI LE
Connection Complete event and they are very close together, this
sequence could happen because the kernel doesn't guarantee that the
closing of the l2cap socket (due to LE Disconnection Complete event)
always happens earlier than the creation of the new l2cap socket (due to
LE Connection Complete event).

Tested by repeatedly connecting/disconnecting to a device until the
situation happens and checking that bluetoothd doesn't crash.

Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>

---
 src/device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b7808405..bed8f38b5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5304,6 +5304,15 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
+	/* This may be reached when the device already has att attached to it.
+	 * In this case disconnect the att first before assigning the new one,
+	 * otherwise the old att may fire a disconnect event at later time
+	 * and will invoke operations on the already freed device pointer.
+	 * The error code (ECONNRESET) is chosen arbitrarily since the
+	 * disconnection event (with an error code) is not yet detected.
+	 */
+	if (dev->attrib || dev->att)
+		att_disconnected_cb(ECONNRESET, dev);
 	dev->attrib = attrib;
 	dev->att = g_attrib_get_att(attrib);
 
-- 
2.26.2

