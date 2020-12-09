Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8BCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E282239FD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 01:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgLIBBf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgLIBBb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 20:01:31 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 17:00:45 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 4so49511plk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 17:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3YSqH1FiIVrSIBPKfpTCG/uhni00GyHzVDOAjTchBw=;
        b=TCd+sqLJKgzH3YdAR1aQQlQDSFRyteDmiTBk9ZwNV5Au9xV70009L6+vyhTL5TKsep
         oBOesgxlRQ2JmCEkoFgqUMtHfK8/O82z+PTfJD8FkXwhIkUJrVaEZR71pl4Ap9oU15fs
         insmoGzWDlfD5CBzSYvgoqFM8gNm+ddxAz8hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3YSqH1FiIVrSIBPKfpTCG/uhni00GyHzVDOAjTchBw=;
        b=NWlbIEqW2xLoapc1b/5OIlwFUi4ddISbnmCh0UKRPn41+JAgDRhmGx1+/MGcBeGBAm
         vGCm6j3qKs944EOsCX/ayGxJA0++nksW8rvteSaGgT0LnpH0J7Z9kNEAiNL/CsPiVEUz
         sGK2739ci6QH0yNrJnfU5YhfxRE1agcGjkTNzfmsx629lCwVB82P064axMGOX+OW3yhU
         nfQ875sCW26TsWmLCYOy2IxkGiX/+Rm73o9SP2GHoRCY/BykizDIUopEmlCm1tQEKTXh
         6Ah8v4kfRUNGWXhMO9+uFgmGb3zLNok4uhDeGwGTCvJwAPfG5zVIumWntjulIFA8rus1
         JYbw==
X-Gm-Message-State: AOAM533ayAqPG0fQZ1oRTfivRXcsp458b/K0IuJ3KKnn5fVSsAQwhdc6
        lg9fguYI8TFOflRxU1oFaxRwmc352csAcA==
X-Google-Smtp-Source: ABdhPJz0VfUJacp7OyGnCc7QalZUUur0ld+EM8Ce8MGFILdLYVJ0kMH5BGCRoCBqg1qUYotvUrVNAw==
X-Received: by 2002:a17:902:82c8:b029:da:eead:94a0 with SMTP id u8-20020a17090282c8b02900daeead94a0mr83955plz.42.1607475644911;
        Tue, 08 Dec 2020 17:00:44 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 5sm28052pfw.12.2020.12.08.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 17:00:44 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ 1/2] Revert "input/hog: Remove HID device after HoG device disconnects"
Date:   Tue,  8 Dec 2020 17:00:29 -0800
Message-Id: <20201209010030.342632-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reverts commit d6cafa1f0c3ea1989f8a580e52f418b0998a3552.

In commit d6cafa1f0c3e ("input/hog: Remove HID device after HoG device
disconnects"), the bt_hog structure is destroyed in order to fix a bug
where the UHID connection is not destroyed. This fix has the cost of
increasing reconnection time because every reconnection would need to
re-read the report map again. An improvement to this fix is, instead of
removing the bt_hog structure, we can just destroy the UHID with
UHID_DESTROY event and use the existing bt_hog structure to keep the
cache of the report map to avoid re-reading the report map at
reconnection.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/input/hog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 91de4c70f..d50b82321 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -207,8 +207,6 @@ static int hog_disconnect(struct btd_service *service)
 	struct hog_device *dev = btd_service_get_user_data(service);
 
 	bt_hog_detach(dev->hog);
-	bt_hog_unref(dev->hog);
-	dev->hog = NULL;
 
 	btd_service_disconnecting_complete(service, 0);
 
-- 
2.26.2

