Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 07:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814DC20738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 07:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MSsojPnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgHaHpO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHpN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 03:45:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F3C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 00:45:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so8425020ybf.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8jQ86AYXJT4P7OxYuESa4anzbwdw7z7p9lbkOmXOBgw=;
        b=MSsojPncwWM2riolVB2ghhaUHF7oMREgxcKYBAeiGU4hj9aUxKyY9xNatNbT/oaZtv
         /aRNM4g4Dn1ocPnZKAgp7PG4GLs58VlO0ZGXBr+KD9kOhmPlaJznvbOLOP1yELcoPwEe
         WRWu9CphDVAX1XNS0u9I1QA4YOJIQYPd1csqt90wOCUsi+6vEETw0WTihEXA56RUj7zP
         f12CP6kYiQNqzpFSmfOpiW9wO/jYIcANv7trzZB/QbhKUTG1Q5WNzVn/29tHf7ZrF05l
         Gz7wdYg/Ao9dIB10+zXCBhNSe3IVGMLylun6iCZs64bI4JPoJFt10WNVBVk2Pi2E0YM/
         Rd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8jQ86AYXJT4P7OxYuESa4anzbwdw7z7p9lbkOmXOBgw=;
        b=oaxdPhY/CuHr98VSY55Whr/QcnkTJAeJD7Q7xSGz/0fkQQgyASAkBJ3sePDUWJjvyD
         6SSlhxtvi9tpQQoZCXaPP6TfWb8qIyQh9GDiJqPgq28QqAK5J1htK5sudFq2FLG/l+zz
         xhDukDucbvos4s4FfvPgw8DhSz2rQ5zytKIEWVFxA4XJKGrEyB9ewViSnc1p3M68wbJ+
         rgEpc/0kDq9LV3rPVzjaqBrKaFwrUA3MEy5C/hnGEqkgciO51RmrxKfdIsL+YAGMTlvz
         ydnRcLouPPPwhvV4bfGFcoPJyR4Zz84xYhE5STXU/Pz3XFUzdhZ7YI3aTTuCPzEk8sjy
         JevQ==
X-Gm-Message-State: AOAM532FBDeAt29CT4fVJfx2s29pQ+y+QteqeV3cGrHJNycLPZ+Yqbzy
        JIq1YJjG1hZoqQEpeZTGbteeQkfr9jX5cnpfCLPsCNbQjZyiaLYGfOzr05MZmb2Onn/hYy7U3M4
        XL85OAo3OXOqq6Vh78KYyJcf2F+l8a0tUrs4pip1oguVRIVkKbtfhrbjDbcRQLwwtcFrky5H2cR
        Pf
X-Google-Smtp-Source: ABdhPJyrovg27oEejz0lJquVQVUKznegi41tqVrcl9tX1JUKBaF6IfkqzaqKMbqldkvnNAiYbwFHO4DMlgQs
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:7a42:: with SMTP id
 v63mr581587ybc.4.1598859912365; Mon, 31 Aug 2020 00:45:12 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:44:52 +0800
Message-Id: <20200831154443.Bluez.v1.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v1] media: Don't set initial volume if it's invalid
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When initializing media transport, we try to initialize the volume
of the player. However, the assigned initial volume could be invalid
due to the session has not been initialized, or when we assume the
role of audio sink. In this case, we should not assign the initial
volume.

Reviewed-by: Michael Sun <michaelfsun@google.com>
Reviewed-by: Yu Liu <yudiliu@google.com>
---

 profiles/audio/media.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 02bf82a49..acb4a8ee9 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -494,7 +494,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 		return FALSE;
 
 	init_volume = media_player_get_device_volume(device);
-	media_transport_update_volume(transport, init_volume);
+	if (init_volume >= 0)
+		media_transport_update_volume(transport, init_volume);
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
-- 
2.28.0.402.g5ffc5be6b7-goog

