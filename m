Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91958C2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A1320776
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Chufib3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgC3HCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:02:16 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:38169 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgC3HCP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:02:15 -0400
Received: by mail-ua1-f74.google.com with SMTP id t10so7338064uaj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GdYWbWFlv53UTK+JR9SjzdWX32BHmnSxKAdSkwsVD+4=;
        b=Chufib3LlEIVtBvpGQ6OH+yWuI31WOCVYCLBNV6sa18vQ3a2npxSDe7gGOtiGnNjFq
         yclYhJe6ECn/XQsKHdnbspt/Ek2kVUhfOnNDKGQRU0OUKiMLsI0U6hQwYQNxkVwmf9cA
         r3dvfivvnESV/xwzi+jZP+0UXwJ58TSR+Q3FBHW3A+Y+EGXgCTcfmjMnAXhBimzsi1+r
         Rfjv2VvH3Dt1t1bklCRB0LLU32adPO+fz2d0MJ2X7LmyRo4We+ISQSWFj+zzQgNu6A9q
         DTjZkY5MjR5imCfCVjUJPlvbN3pOLTiq3L8FfHmjqUYkyxzAnLtlvChY6egfmltJxtwF
         L2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GdYWbWFlv53UTK+JR9SjzdWX32BHmnSxKAdSkwsVD+4=;
        b=W//rM5tfrMr4SvB3p3tTHr3XNo8U00zkWe7rDD9AaT8nzpnd4xI8Ys3Xrkj9bobBh1
         gNu/kfPr7yLFKLYJN5W+51URImkF7sG/8FxmF4EwYjXjjSq5LswdAxM4+WKGz820BGSe
         0b56tHKUg5jIX781YfI4DBLspyUedVdR7ixejVHNlB7zsb+1k/WYJUxnnT5dZmDZsIMC
         /X1fa4k/MtXsmoaxZug/S59V8auofID6AsoRttoWulN9O2XhkP0M+OfPpjSIbDXHe6eo
         iqC7MvXwd/8j3v2dznLvmGn2587mlZCTRNso+j4L59PWpiG+TSxJ9SIkZmjfZ0oswyH5
         D/xw==
X-Gm-Message-State: AGi0Puak7W/u/sTqTzKjKBfSHLWKR2Hokq4xnp2AfCbSKi/9EMbUeApA
        N8Nkgo14PVEA9VZ3l9pqZvHOXuuF2PSIubo7rOtD+lmIzxyC1IYg/RzNgSzg6hpOwFUKCZxy7j3
        J+G+b3fa05/yHEAIhOnNhWeF8VgsuyaxbWAUD6x0lTTdO/PrZFZvBbz1I2sw+2M8t+VddOBbEdj
        25pHf+HzZVI0g=
X-Google-Smtp-Source: APiQypJaKYQ1/cjtxsADVOjlXK4KNDi8epi0DX8T8rj7Ces7Fj6EoTyzP+pFq5qzLEqoL1uwTZZ1ZdvuDB8e4wFp3Q==
X-Received: by 2002:ab0:72c6:: with SMTP id g6mr6904193uap.24.1585551732369;
 Mon, 30 Mar 2020 00:02:12 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:02:06 +0800
Message-Id: <20200330150145.Bluez.v1.1.I0238396807efb194dc5b61945b2c738d8dd8b64a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1] lib/mgmt: Fix missing mgmt op string
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

MGMT_OP_SET_WIDEBAND_SPEECH (0x0047) is missing in mgmt op.
---

 lib/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 7682537fe..7520c7ae9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -897,6 +897,7 @@ static const char *mgmt_op[] = {
 	"Get PHY Configuration",
 	"Set PHY Configuration",
 	"Set Blocked Keys",
+	"Set Wideband Speech",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.26.0.rc2.310.g2932bb562d-goog

