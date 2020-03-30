Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B366FC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FE820774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdWBaJio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgC3HFr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:05:47 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:56055 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgC3HFr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:05:47 -0400
Received: by mail-pj1-f74.google.com with SMTP id y21so14392679pjn.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t2dXNqO1VZ6ka+XgAqt99Zn3WvCFoWXIyyD5CoC/I3k=;
        b=bdWBaJioddkC0e6GqJpMkiP1FnbfOMijF3RKhULLxMXsCxRtVKz0wu/UHiDQpp4460
         B+1c2vA+zBWzLe5r3bwWcxECC1U07vJVv1P74yJps0TEQMc2QHzIEKEx8or99g81Zx4l
         Ab7JcRhGo+inTJch9awX+nuA7K7EM+Pc8hz8ZkcDe+dmK+OYUJd2DUZZ83WNmVf6B+sF
         IRWn56TZU7GKUgEAuLcUsX0Br1VZ5iZg4514x2PA8bFOAwpZfgzqEmVbyMunkqihal97
         J+BgXzkG1J0bTl38nq1K3Zp8fspeVVd5BDr2WIjaiAT7oUaV+ec4K2NrXHxylBM9I5kY
         CkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t2dXNqO1VZ6ka+XgAqt99Zn3WvCFoWXIyyD5CoC/I3k=;
        b=Lec07HtO4nhq3WWunk1P00Rhd48Dawl6KXCuyYaDvBmOGv5Pocdk83xlvZ9UWHG2Vs
         q/6kImVhOBQaDoKo3hmxB5SCZ0uYsyfU+9ykh7ZKSDA6w7/OwzujVLezUMaN7ctWkuGp
         GaujQWiOAPzFSoiCcCsz7k6ec/Ifm/SZVqRbt0T8jYQrFhwTcecNCtm1bAexDJEJUCZd
         vwcP+fS7elsps2IE9zrXWb6gA74njo/Mb92WswvH9gPelHBfbHVe3d4c2bJCxdhdyNsw
         Nd2jdcrbg1UktGRIr20Uf1MDYoZ1/V5gxBiK1fMS5H/QPAzJbvo1evIhEc8KeejAAWNW
         iuIQ==
X-Gm-Message-State: ANhLgQ3PtUkM4duQUekGcKgh6R6Jgrxfsmrmgfu7Bl6+EGgdKTtl8Bq9
        bvzabCgKnlE22GxpvwnsoWQEUIaWKPjetwXVaXwoc9PXotjLbDaIRY4kjpIqw8X91tonoaBtJZX
        OIWf/p/toix1KaJQ2+o1wnmHgh4pdecTyyIq6ZoZot+f8ThSg7/LF+SJokTkBGpH5fB3EPlexLO
        lc+2NUbbevBsM=
X-Google-Smtp-Source: ADFU+vsgtzPJHVcTKwL7O9LfHycSyDDyP9EOlEumDrQcEaUxPf8qQg6G6MWscyFhNYvvpPehuy/MQ0PkugL0uHVp1A==
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr14735596pjs.150.1585551945709;
 Mon, 30 Mar 2020 00:05:45 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:04:38 +0800
In-Reply-To: <20200330070438.37316-1-howardchung@google.com>
Message-Id: <20200330150424.Bluez.v1.6.I469418408aadd72a98d675c7d8835cb79741835b@changeid>
Mime-Version: 1.0
References: <20200330070438.37316-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1 6/6] tools/btmgmt: Add setting string for LE Set
 Advertising Interval
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

$ btmgmt info
    current settings: powered bondable ... advertising-intervals

Signed-off-by: Howard Chung <howardchung@google.com>
---

 tools/btmgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b1820b41c..91e9c0b40 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -355,6 +355,7 @@ static const char *settings_str[] = {
 				"static-addr",
 				"phy-configuration",
 				"wide-band-speech",
+				"advertising-intervals",
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.26.0.rc2.310.g2932bb562d-goog

