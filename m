Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63671C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjAZUMq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjAZUMp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 15:12:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C0628D2B
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o13so2601563pjg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOP5sc6GAk/5mEPeE8p07kGXaiP2fSMYAITGHTtqSyg=;
        b=CAJefpuWN7ZPtn7NtNPgIDWQM7QDQOvpSLFNZvyNErRQkhr1bviYZ8Qt9z2ioIX1JL
         hz3puOdko8N4HTqPY+Rb4XptMNAbce5ZzZuHVtIBN1kpl/2/Phh6qYKPTeA2myWFUg91
         QKfNgzAj4QVi4obXyEJDzisuejffHQuVR5y4Fg6MHdN2FWpAPSr0w0+xzYjbDJqC8GVc
         PwTDxvHSpojhDzlQLSnAzo1k3lCgtXh2YZtSvav4CP+0WOlep4WF0ox1Vi0flnMXLRDu
         46eoLOiom1lNjIq0tm0bucm/s72fKcUNinWH8OaaShp1M8+rbY7lMWCtYn4OanJcfTZE
         7CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOP5sc6GAk/5mEPeE8p07kGXaiP2fSMYAITGHTtqSyg=;
        b=Otwbmkq5eQn0+/2ynMIK8AAkTfO9oxe06WE8iiZqPa+xKkIGr6Fy4NEAjMzIphg2JF
         KcVhcsEiS9qfC1BvpJcookOt0cN6LEJJw0kmNsD/lGpjWfmfYAERUqVSreeWM+b16xWQ
         e0Yk4S6oCwNDPcsQCMKbkfrYXy30MNxQvxcEatFcljN/c9dNqdoMDZaIDS2efhr+XTlU
         boI0EADZFdqZXvKUeN+VdXKk5DYJWbFxtlSkVrEd1xYDor1akRkAOzHeDBf3HIq/tjJl
         iahqgXb9Xf8jtYA8RDPIxcqT2dUjEermbRW7uRzB+x+FlFdwUUP0aQJ1VCLegFlHSCBO
         21mQ==
X-Gm-Message-State: AFqh2kqJCebaZQuVK4yNBMh1ZNwEiLDyiRP2+Dlzx5cUswVPMjgWzqxk
        /pm6zq0g5H7CsSQ3M3hTdnxlmV4psQ0=
X-Google-Smtp-Source: AMrXdXvuEJvpkpQCWhOb01D1yKmXRcdnxF2n0GD0x2eIFuyakWjSpS1JaxH3pGZwCtgZom0rtk/o9Q==
X-Received: by 2002:a17:902:da8d:b0:194:7a42:2d33 with SMTP id j13-20020a170902da8d00b001947a422d33mr46784859plx.28.1674763964066;
        Thu, 26 Jan 2023 12:12:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902c78100b00194955b7898sm1341045pla.237.2023.01.26.12.12.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:12:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/5] shared/bap: Fix not detaching streams when PAC is removed
Date:   Thu, 26 Jan 2023 12:12:38 -0800
Message-Id: <20230126201242.4110305-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When local PAC is removed we attempt to release the streams but we left
it still attached to the endpoint, so this makes sure the stream is
properly detached by setting its state to idle.

Fixes: https://github.com/bluez/bluez/issues/457
---
 src/shared/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index db7def7999b7..4ba65cbaa8f9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2478,8 +2478,10 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	if (stream) {
 		bt_bap_stream_release(stream, NULL, NULL);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+	}
 }
 
 bool bt_bap_remove_pac(struct bt_bap_pac *pac)
-- 
2.37.3

