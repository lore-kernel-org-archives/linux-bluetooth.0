Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A280DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 21:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354203AbiCXVie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354198AbiCXVid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 17:38:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FC0B6E57
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 14:37:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so6397716pjp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uYQh7WxNCqAkXQNsmkZgOU7hKezvfCg9EEVrQ6lw5r0=;
        b=O2R7hmxzDJWmeevA78Xvd6dWHYga6RNvJrxYOiWmzCaazSLFJXk2wnz//Sj9vx8yEv
         RbrrESF592/urtkrPPx5Vro2Tf0lguQa2yodZzRVMxLIE7OHJPXgSgVyqAp/Jkh6l7Zy
         grvoeQxC9Asg8nlAci7tjTxyrfkkxQEh1xiQou2ghMDlREamW/cCq/dKEIus1GFQEQgA
         VOewJjMAd9aoTA5p6wH+ED5m10SvzGRTPPNjZW9cRDvCOHYVK8W4czxkm1eX7lGjDjcZ
         46SQVwZRXdo7uzOL/goTcd+eIkj1x5RIv6XMeWAcx8SjWWyRrjgxw2O2Hr3sNIL4TUfq
         coXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYQh7WxNCqAkXQNsmkZgOU7hKezvfCg9EEVrQ6lw5r0=;
        b=j0nFFtb7Rr78fr2Ne3i/L3d1btNc8WSsF5tTXtMLPOPT2g7+88DOq2AHhHA7LspwDR
         vSLgHveaY1sm5eG2IfSYsb9M9ONjNEYvRfXLXijtMsTxMFk5XP4PBcXLUIbHDSmsYRSh
         2P1NWOIr2VR5Gm8dfpfKr79b7ZmnIV0uutQRmm9rU8uu42RrJLCOluhT+xHK4HuPbeIm
         AI2KoQKe0Ucw+80jcZImjGWz0kTWpIrQJj4JGxgwebybyTnsRD822ZmiciUQ13CmPdIj
         fJNY/a+Bk7fDaxSBhMgRZCUWDvCwDZPJcSmL4NRgQdkbSioq85x/cyn5QfPCubqqEXQ7
         ckpQ==
X-Gm-Message-State: AOAM531xNF9fQp1ytw88KQzRFlHYWrS87LUKftWLk/ak28B0S38aBbFf
        tWw4v0k3m9ifX6rg+WelLzA22i+HBQM=
X-Google-Smtp-Source: ABdhPJx/VPfDuDCKuUc0ESZeKLIjHNWzdT1Mi4xcj8pwYEwvzy92dJ40Rm9lncF5NALKulO5S69rXA==
X-Received: by 2002:a17:90a:528b:b0:1bc:c5f9:82a with SMTP id w11-20020a17090a528b00b001bcc5f9082amr20770488pjh.210.1648157820563;
        Thu, 24 Mar 2022 14:37:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b004fae15ab86dsm4696489pfc.52.2022.03.24.14.37.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:37:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] a2dp: Don't initialize a2dp_sep->destroy until properly registered
Date:   Thu, 24 Mar 2022 14:36:58 -0700
Message-Id: <20220324213658.59479-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324213658.59479-1-luiz.dentz@gmail.com>
References: <20220324213658.59479-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On a2dp_add_sep if the record cannot be properly registred
a2dp_unregister_sep would be called which would attempt to destroy the
user_data causing the following backtrace:

Invalid write of size 8
   at 0x2F41EB: endpoint_init_a2dp_source (media.c:687)
   by 0x2F41EB: media_endpoint_create (media.c:1030)
   by 0x2F6713: register_endpoint (media.c:1155)
   by 0x46983F: process_message (object.c:246)
   by 0x4A574A8: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.14)
   by 0x45F0BF: message_dispatch (mainloop.c:59)
   by 0x495239A: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x495605E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x49AB2A7: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x4955772: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x4CA924: mainloop_run (mainloop-glib.c:66)
   by 0x4CAE1B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2AE791: main (main.c:1258)
 Address 0x6e47a30 is 0 bytes inside a block of size 112 free'd
   at 0x48470E4: free (vg_replace_malloc.c:872)
   by 0x4957CDC: g_free (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x2C2D57: a2dp_unregister_sep (a2dp.c:2588)
   by 0x2D124C: a2dp_add_sep (a2dp.c:2697)
   by 0x2F41D5: endpoint_init_a2dp_source (media.c:687)
   by 0x2F41D5: media_endpoint_create (media.c:1030)
   by 0x2F6713: register_endpoint (media.c:1155)
   by 0x46983F: process_message (object.c:246)
   by 0x4A574A8: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.14)
   by 0x45F0BF: message_dispatch (mainloop.c:59)
   by 0x495239A: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x495605E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x49AB2A7: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
---
 profiles/audio/a2dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f761dbe54..d66c22b2b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2668,8 +2668,6 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	sep->codec = codec;
 	sep->type = type;
 	sep->delay_reporting = delay_reporting;
-	sep->user_data = user_data;
-	sep->destroy = destroy;
 
 	if (type == AVDTP_SEP_TYPE_SOURCE) {
 		l = &server->sources;
@@ -2713,6 +2711,9 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 add:
 	*l = g_slist_append(*l, sep);
 
+	sep->user_data = user_data;
+	sep->destroy = destroy;
+
 	if (err)
 		*err = 0;
 	return sep;
-- 
2.35.1

