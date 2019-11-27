Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB0EC43215
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74302070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bcCrlgw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfK0JnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:43:04 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:46786 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfK0JnE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 04:43:04 -0500
Received: by mail-lf1-f51.google.com with SMTP id a17so16568011lfi.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRXIoVLDgouGcya7Ui4noKCVeoOcPTVESwhzDR9Gqpo=;
        b=bcCrlgw2dcfjJZepmbnaDNTQlYFXXbQAySBivWya39w8gwZ6fQL8DVDN7TcbtcdjxO
         ybqQAusRGVL7YGx6AUdUZKD41XoAaTszfzKaGN7mPYNAnN2TNTJGZ4ZBCv9QBHHy8OI8
         /zrt+8azq5xdZWtKUTOoQscNtSz8SKNOdGg3oLt0ctCEoiD57MFjds1+thbmXl6ufGRj
         dEgiWj5zXDxhkenlOaYNG/NudwvR3Xj8uHATbAO73uyGrEbWG2FHgsC68FtxwIa0J/lH
         SwDHzxxZdXBsCqjRP3KAQaBYXIguyfuRBnOItpamRenQ1kyXLBVojZM23eb5GuLOrt/q
         3gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRXIoVLDgouGcya7Ui4noKCVeoOcPTVESwhzDR9Gqpo=;
        b=UTeb3OOKbnGlmcoc8zuoabQ6jYj/IbtHYtW/roZ7JUU7KWiQPEk1xTrQmWXo4OaP4D
         72yXAEA1pv8YElLvtimW5U5QthxqvO1pzrcLt/KyXNQ+HYVDgsjtktXj6V2HTlqWAZsM
         C7lKd14i5VE+IuOr0qRfzv+GjiBnWDLADkBIV1FIFD1Ai1dV3TFcqoVh+0XftVDBPpbt
         FPYiM+Vz26C59/JTn0+cuyDpXpNFFVAfUOB1mQ0s2gKrddC1KaJnWubgcMUGEJ91sGDR
         FTJxIj9vJz5P9pxtqHIRMSihhW3j7Uto2b0olt5DU7wHDbMNXiSBoyD6ZoDz6sGpmhOg
         idhw==
X-Gm-Message-State: APjAAAV1z929cojULxWEhYyTCqEMm0HHueADGx/sg9oxo/Meemvv/Eti
        Km9wxBUQz4iVU9xDyVURHxKWIC29XYQ=
X-Google-Smtp-Source: APXvYqyREs7Iuhidp36ou/y704f5Nh0H8AVOHa6z4cy/gCiDqFi0dh+KvWF3a/3NNAuSFiibkJI5mQ==
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr20912745lfn.95.1574847780457;
        Wed, 27 Nov 2019 01:43:00 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t143sm2220860lff.2.2019.11.27.01.42.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 01:42:59 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] Update AUTHORS
Date:   Wed, 27 Nov 2019 10:42:52 +0100
Message-Id: <20191127094254.4037-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just for bookkeeping ;)

Michał Lowas-Rzechonek (2):
  AUTHORS: Fix typo in Inga's surname
  AUTHORS: Mention Silvair's contributions

 AUTHORS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.19.1

