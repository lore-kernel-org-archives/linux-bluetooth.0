Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1906BC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 10:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB43D2080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 10:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="a8aw8xTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfD3KaJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:30:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46134 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3KaJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 06:30:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so12224148ljk.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvDfH04UqCTz4k85+OXxY0UiEq9xfrn3D1VbDTW93vI=;
        b=a8aw8xTVwnt5dJZo8dC9En5w/GfqrEYKytdlo3vWbXS+y6aepuUgl2ernAsqaFCbdV
         jvZtiWRjhWK5rng7c26M6qQbKc4Ze8AMErTCdQIqDuPv7xtvJ3kKGFB1UWUGjFxyRdJY
         F1S2UbBap3DaHDzG1jm0JrYtV36IlbUYmIQXvIi/hFPj3PUcpbwCxERMnKJUnpihkWp3
         ZjZ7TDuD13i7oZhsDV19sF06NyZOMp2THrAWktooVk4e9EX+ScScqgQzKm1vb8FG4Xuq
         MbyhQNgn/D0adQcMVPr9DbU8ID/Bz75+fKPuudhKwAGwx12PitcW91m1rXhbny157CX8
         sswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvDfH04UqCTz4k85+OXxY0UiEq9xfrn3D1VbDTW93vI=;
        b=YxVB/k4a3a+FdOYogShJhIC5qYNzxmjD2+bbndFqoJzybZQi78GWdRroBbgjSIc3c2
         cwkqP+2V+JOT5bbqmdeHEEJLtFbQwzNwApaezzGoo1HCLMapdJCtSe0JYecGYIOxrsLz
         eJKiKE4M6LJ9mWSV1Eg0NpjoyHVYsET2YPrn1yMUncjEEU7D9OAQ62Wk+XPAc3/uCB0V
         4MZMY5irRoFMIOr1LxjsJVdJaWAsjeQJV8shs20ZtN8oajhf0lEPblgROcRxWYs4RD30
         eh3zq2y2goYQIIaF41bmXTFgnqQts4JiivX1ZqFWC9hu6B7G7p0JXVOGUIWHsdSvslNY
         84Qw==
X-Gm-Message-State: APjAAAVV+fj7yR++0acKI4NF5Kucpch11yNw0WY+6AIwUOdy1s0FfDmf
        9++4T7K96iC5rNjHLn+ySEVOtMwptso=
X-Google-Smtp-Source: APXvYqzBnxt9JYb9Fj5E991HumfUNFcEIHDLKi3ScWm096CL+srXVURlvOUrRi8hAx5DyNkMrbJtzA==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr13300164ljk.5.1556620207103;
        Tue, 30 Apr 2019 03:30:07 -0700 (PDT)
Received: from scytale.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z2sm3733277lji.77.2019.04.30.03.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 03:30:06 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v2] a2dp: Fixed warn_unused_result warning
Date:   Tue, 30 Apr 2019 12:30:00 +0200
Message-Id: <20190430103001.30661-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This used to break builds when using maintainer mode via
./bootstrap-configure:

profiles/audio/a2dp.c:1775:2: error: ignoring return value of
    ‘asprintf’, declared with attribute warn_unused_result
    [-Werror=unused-result]
  asprintf(&sep->path, "%s/sep%d",
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 profiles/audio/a2dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8f141739c..5f5ad508d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1772,8 +1772,15 @@ static void register_remote_sep(void *data, void *user_data)
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		goto done;
 
-	asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
-							avdtp_get_seid(rsep));
+	if (asprintf(&sep->path, "%s/sep%d",
+				device_get_path(chan->device),
+				avdtp_get_seid(rsep)) < 0) {
+		error("Could not allocate path for remote sep %s/sep%d",
+				device_get_path(chan->device),
+				avdtp_get_seid(rsep));
+		sep->path = NULL;
+		goto done;
+	}
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				sep->path, MEDIA_ENDPOINT_INTERFACE,
-- 
2.19.1

