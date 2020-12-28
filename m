Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07BEC433E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FA0221F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgL1KF7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgL1KF6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 05:05:58 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98290C061798
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:05:18 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id f7so8914563qvr.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SvJkmW8trmd30n6OPTE0R++9r6zKxsd0lzJkBum7ukc=;
        b=IgzhkxAVYzoA3f8UsY5mMZNNiDfp4nJZaOSsx0ZpwQIhkTeZMDHB3gK7XcyTfm4mPM
         YA4P7yzo/dZEqonv1DQX+49Nx/WJO4gaPh7MkDb7tVkZvq8vjFIXEMGGJiapguncyDgm
         ww4058KxQ/CyAp1bbHYzrNpQgkkt1xg7j1YzCRbE1HrfMy13QKbeQ+IULAOgfyqHYKMM
         JI3Up8T4LQJ4rfCVCda20JVOQtPrpmXsIRPOOiv8Q6MTFD9ORnMG4exnThyQxZNibCG/
         VfivwIxO/Q2ZWsAWoR1fF5cOp87yJhEXCrQQmCeO3BIGca0cTLnJopoe/LsR/VrNu1Gn
         Wbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SvJkmW8trmd30n6OPTE0R++9r6zKxsd0lzJkBum7ukc=;
        b=GT/G6fftVm2uEt813Bk9ZtSDqQ9SszYK+PgtQJ0vqazmvBRVrppROhnLXuOYPJbQ4t
         CDIQwk9j/QkjTpwGfEwdJhSKzlSdMaeRtSkbjOcpJZ2pebLTa6eciCICNDQBmtJ2qf7g
         pwErpVLP7GA25sxf6i+GFFzDzIynrx4ln6Sqt5X24zIV8MAmrB36lS0qcCpndHn2L9G9
         3RTcO/EkGSCuJ/vhH6DQYTjuuKPPghsySZiTrMqtlUF0r2CAvEwKWQ4prvx/ExVmuhXB
         ac2pAs8qAVmuj6NUGMuWiYsIX08tDBNikUHwhzisVZQqdPVuawk9SMpuc8Zgpe0eAvj/
         l+RQ==
X-Gm-Message-State: AOAM533ADt6+N182ISxga4HVYrigBh+wmYbyVY8rOF0qZ328Ilgnww6b
        ADGSUHJlyXNnbJf0lzREUsTolA6IIlePAycYpjzWM/us+yLjftnm4/CaaZg7stZo70d7Hi/f4tM
        E+HkyTBxkMvuZSvzLZ9mcQ9cZrC7ZlilbW4QF0SFBt5eX16wiYQiP7CGeTjVvp7A9bcziVxbSuw
        wLUj3ZzI/TO58=
X-Google-Smtp-Source: ABdhPJzroEoHfBGg7a7H3VLq0N7g56N4FsjLSJYGBKZyJZZT14U3fQiKEyKmbNYWreIanUwSlbOFUFoyrswQ5sywsg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:f283:: with SMTP id
 k3mr46508393qvl.48.1609149917733; Mon, 28 Dec 2020 02:05:17 -0800 (PST)
Date:   Mon, 28 Dec 2020 18:04:58 +0800
In-Reply-To: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228180429.Bluez.v2.4.I43884adadc00a5095dd03d2261a71dc2ba80d986@changeid>
Mime-Version: 1.0
References: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v2 4/4] shared/mgmt: Fix memory leak in mgmt_tlv_list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, mmandlik@chromium.org, apusaka@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch freed the mgmt_tlv properly in mgmt_tlv_list_free.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mcchou@chromium.org
---

Changes in v2:
- Fix incompatible pointer type error of mgmt_tlv_free

 src/shared/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index dc8107846668..0d0c957709d7 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -588,14 +588,15 @@ static struct mgmt_tlv *mgmt_tlv_new(uint16_t type, uint8_t length,
 	return entry;
 }
 
-static void mgmt_tlv_free(struct mgmt_tlv *entry)
+static void mgmt_tlv_free(void *data)
 {
+	struct mgmt_tlv *entry = data;
 	free(entry);
 }
 
 void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
 {
-	queue_destroy(tlv_list->tlv_queue, NULL);
+	queue_destroy(tlv_list->tlv_queue, mgmt_tlv_free);
 	free(tlv_list);
 }
 
-- 
2.29.2.729.g45daf8777d-goog

