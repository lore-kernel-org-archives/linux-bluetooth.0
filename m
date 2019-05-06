Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D7C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FE62087F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNuHIJps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFMnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:43:20 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33915 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEFMnU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:43:20 -0400
Received: by mail-ed1-f47.google.com with SMTP id p27so265906eda.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pL5g8Gdn7icw2A088OSOwjbavt26vgDag0C+pOR1O5I=;
        b=LNuHIJps8vUSUDKph6CTvVTZ8T0baN0h39pWf8t5Y1hQae5VUo7QkiFG9h9M6Rih0W
         h898kYPL11EFsjMFjk3LEpl5rN71apXPP4EY7LPpfvMnODAWx76obd4uCanDtc+YYrX/
         QQS9wF2+4wWKVL2QR+oqrbHnB1JIqb3GJOXD1FoIjapf+Wv8yVUJLyfT8t/fy1tCA3wA
         WRtNxbHEFSwZ8qRgcmszFBVU/CiL1C9U6j/144dRNwm2U6kh1L4p2oCf9ODZQI5itEeU
         Kg6YlUHIRW8iH+8oL01WOphg0zzsW5yiUQx9fj6MHJdpEZBu6Tj4ABe7AxLlC7rzpeRr
         tYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL5g8Gdn7icw2A088OSOwjbavt26vgDag0C+pOR1O5I=;
        b=Iv54ut2phNJD0bFQnnN9a0ZIQtThjMC7X12imn8LsrMpQIT5ktBLlBTVB20UDvUUHQ
         SqdjICbfENMX2vLtZcbk5cD73WnXcRn/g32fPIkTe4Km+wa+iT0ijSp2sqgxidPAPvxa
         2o3S5clCnVWNiHyASLqEqkj2emnUJnTrhdiCxzvi6XE2viz8CdhFWnTQUQRLE/b3BwWY
         FB/mrPHwmutl7R/xPWqEP6yIS3sUVsAucaNs8jwVjNfHcwS+ov8oSCqnX+XhQfr2XHLv
         ImjegAn8xlqeHvJnJUX0QGkIl7tCmrqmTT+CM0BJrhUFrTiKMaH0k1LH0Z0sbRQlKHHj
         YB6Q==
X-Gm-Message-State: APjAAAVE1tMvO+5xGn/mqjp/nLsj80Y0o3T6/hKRfPeq0W6qw8wGf38U
        4Pv9FhmWQuHpXjCcsBEBIB35JLlFCwU=
X-Google-Smtp-Source: APXvYqzuIBNvtVe9S6fwt018IQGjKdtILXRG6srUt/MtK1HetnflawhKjFbHHpEGlg3UWoTPFnfJXQ==
X-Received: by 2002:a50:cdd4:: with SMTP id h20mr26013730edj.114.1557146597821;
        Mon, 06 May 2019 05:43:17 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h27sm1025816edb.66.2019.05.06.05.43.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 05:43:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] a2dp: Fix reconfiguring when there multiple devices connected
Date:   Mon,  6 May 2019 15:43:08 +0300
Message-Id: <20190506124310.19151-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506124310.19151-1-luiz.dentz@gmail.com>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When there are multiple devices connected streams need to be matched
with the sessions they belong.
---
 profiles/audio/a2dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2ce7c06cb..f89105a8d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1648,6 +1648,10 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 							tmp->user_data)))
 				return -EPERM;
 
+			/* Check if stream is for the channel */
+			if (!avdtp_has_stream(chan->session, tmp->stream))
+				continue;
+
 			err = avdtp_close(chan->session, tmp->stream, FALSE);
 			if (err < 0) {
 				err = avdtp_abort(chan->session, tmp->stream);
-- 
2.20.1

