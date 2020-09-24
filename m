Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C29C4346E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 23:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7123899
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 23:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hq/CgtnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIXXUD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXUC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 19:20:02 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D0C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 16:20:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y53so572821qth.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=CtNAdJymCzf7XlDy5wdKVNQNGbifZpqsFxJiW1M5VxQ=;
        b=hq/CgtnCB0wG8Y12Hw9IfV/RmhGJnpDSjFoMTP///heap8Y/nGrQ52wcXu4Ry9/moC
         fp4Um2Q4LWgwZVQuWr5uKQAo44nRnpVJcpBiK+jrKc5VByqZYE9PJUdDyJeeteS/PhZI
         ftfcVJIBS5NoIT3RgwH4sAcdDQgFeS6JsDvtQpQlprdb2bnWIhmbaCqnU+sXZXkD6Awb
         BFyzbAkoO6V52sgsAnFqNIpOKn4RNtc1YxX4cVcz5QV8hJLfXvANBJdipSU1r3qp+w2G
         KYLDgauC5iLGc4TIZrhV5gZh5PUcHwNmpdK+NSj7U79J1XLmNarYNc4Q79ABHudI2hLf
         YFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=CtNAdJymCzf7XlDy5wdKVNQNGbifZpqsFxJiW1M5VxQ=;
        b=skoc+MOLsaZkobPZ4THtPP7yTRSYNqsNaBHz5phXINlh1u+GTcD7CUmJvjpJQfuidM
         CyfgdFwHn9EOGMqN8/tfYk3KyVp/jvj5SXEbaUTkrdJEyx2hAYCJ8XBUNqbiXbsi7AgS
         kuLxRHXNGpKB/13W2vdwq55TnN/iq5ABq0v7+DXmiofgmHmNV+n42Vg8VALzz1Uj/tBw
         o/uLq8n7RvETOooMMaITtQ0jhKK36pFhw1EHyjMkXh4LIkSya48jwWGVAw9zF5bDkLjD
         EyLpolCL8oPSAKqvQsod2FalcuRbg7ZvXdNQAoBdhFqdQ23vnQGCZTUE1YIpMXI8dald
         QV0Q==
X-Gm-Message-State: AOAM530mwo9B9k3CG+HYdufpKcSgGb9NEwNMOFf6XUgtxdrYSpwFFh6/
        m6lAewqf/a2xI1W5uwWLoarP7J1ijwp5zS8KKlaZbEpaPOyy4q7xeIwBojKsLx+mb67TdQnOagC
        cNRKEsKHD21FYYUR6CUA+mR6E7GdWtyNDtYwzw6DNe6gFADzHZBV+/Cfy68m9DMjPT2Iovm3arW
        NH
X-Google-Smtp-Source: ABdhPJw+iTCjPS2478D8FtSTOdxcw0qAhWUHYkKMjHTCVQgNcWX9nbQGUmKe3wdzP2tayE2N4Le5AzfOnIdl
Sender: "yudiliu via sendgmr" <yudiliu@yudiliu.mtv.corp.google.com>
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:a05:6214:d6b:: with SMTP id
 11mr1772084qvs.30.1600989601782; Thu, 24 Sep 2020 16:20:01 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:19:58 -0700
Message-Id: <20200924161949.Bluez.v2.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2] device: Disable auto connect for temporary devices
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When connecting a LE keyboard, if the user input the wrong passkey, the
stack would keep auto connect and thus allow the user to retry the
passkey indefinitely which is a security concern. This fix would
disallow the auto connect if the authentication failed.

---

Changes in v2:
- Move the logic into btd_device_set_temporary

Changes in v1:
- Initial change

 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index a4b5968d4..a5ef46730 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5684,6 +5684,10 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 		if (device->bredr)
 			adapter_whitelist_remove(device->adapter, device);
 		adapter_connect_list_remove(device->adapter, device);
+		if (device->auto_connect) {
+			device->disable_auto_connect = TRUE;
+			device_set_auto_connect(device, FALSE);
+		}
 		device->temporary_timer = g_timeout_add_seconds(main_opts.tmpto,
 							device_disappeared,
 							device);
-- 
2.28.0.681.g6f77f65b4e-goog

