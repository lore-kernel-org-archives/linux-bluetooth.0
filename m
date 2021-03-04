Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E36C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D3964FFD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhCDWYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCDWYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 17:24:53 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64137C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 14:24:53 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h13so130026pjt.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CdO8AQ43B/auHlZn9bQCnluYC/RpMR97gc9Gnd58FtA=;
        b=UsCY8QBiOW9WqlPatdaNXjlilEVNS8KX6Yn/8mnz3ohn/Gsmjif2+XcRbN5sYoTJyU
         60A1AZ/dEGUKCPgatfLcfM/Uxx/3VFfg3CgAjbOwWETkreCW9IAvYmoneSUfvuSe4wi3
         t4MrVAzMJ9paYPWY4mmXJxnP+OpBEM9Ur7h/ooyqI91v82ySTfnp3aaQoLMu2yZkX9lY
         /enw2j9ltMrKk8sGqHeG8oJXSU2G/KlIY7Lru0zGrXHDRdse7Hvfl0ZVJfsRnRFf3ZDv
         OSkL+jbzR3AtjHsxMlxBZd6IfUfIdS1nMIeZRC44W04VeZtzjrNkOFg6fwGdcZww5j4h
         Ifqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdO8AQ43B/auHlZn9bQCnluYC/RpMR97gc9Gnd58FtA=;
        b=hOmhWrqUlkMNtNcObTJbQRrX9q19jSmNcj1ym3rWq3c7hIFHpoi+LZblm4CerXH2lp
         EmNJaPj5YIa2y8SfD+INDs+OGpR0x9EKAQbTjhmXYV+p8sJbxJWbCrSpk48E5n5Gp61W
         NXZ+VL5FZTK44Xdp3buzdEnpxbALRvUdQ3wG/OOtJGxnxTj2DEVYJRBp54+rNx0Bx0p+
         St5O2xVx2MSA7Nslg0KTwXFCY6eE1J5ELV7iOowJ3at0e3gepHbH/XiVt3lpVxEEl70b
         /54eCM1hKAlsz1iXeFFPvphRQPyxKMI78jXeNIdW7KmKZ8HEsXFvvjZt+wH0IRbrONwt
         0bag==
X-Gm-Message-State: AOAM530XSgFvTCCbMoCrzRnKymoOXH553y3ms7080elRW58elNkJsx91
        JvUdEbR9fUozr3RP7tRIsOmQorQ65v9f6A==
X-Google-Smtp-Source: ABdhPJw1ewQ9/CTn+UWB6Oi6FyUMsXmY6xmtL1hnTfDpAsRXo229K/0lQ+I+KSqV/CvwPE5pasV+Ng==
X-Received: by 2002:a17:90a:a10b:: with SMTP id s11mr6935006pjp.3.1614896692635;
        Thu, 04 Mar 2021 14:24:52 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 71sm196691pfu.82.2021.03.04.14.24.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:24:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] adapter: Return Busy error when setting is pending
Date:   Thu,  4 Mar 2021 14:24:48 -0800
Message-Id: <20210304222448.3769100-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304222448.3769100-1-luiz.dentz@gmail.com>
References: <20210304222448.3769100-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This returns an error if application attempts to change a property that
is pending.

Fixes: https://github.com/bluez/bluez/issues/99
---
 src/adapter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index f483cc827..cc0849f99 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2880,12 +2880,18 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 	dbus_message_iter_get_basic(value, &enable);
 
+	if (adapter->pending_settings & setting) {
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Busy",
+						NULL);
+		return;
+	}
+
 	if (adapter->current_settings & setting)
 		current_enable = TRUE;
 	else
 		current_enable = FALSE;
 
-	if (enable == current_enable || adapter->pending_settings & setting) {
+	if (enable == current_enable) {
 		g_dbus_pending_property_success(id);
 		return;
 	}
-- 
2.29.2

