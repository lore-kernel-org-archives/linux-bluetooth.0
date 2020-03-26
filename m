Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A5CC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B90E206E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRbhYx3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZFmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:42:07 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:37576 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZFmG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 01:42:06 -0400
Received: by mail-pf1-f176.google.com with SMTP id h72so2242520pfe.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQM7DSJnjHZf4CMiJhUAhGzDJ0zvjdD0E3QxycNBJNs=;
        b=VRbhYx3wn1q4GGFQogVkUwG4QnAC0MybJ2vCo4QhLTY0RNDmCqTYLDB84jt+Nl3Vp/
         HGmu+TY/Wha5H9OLdR+9c9B6rXl3vHM99CWvFpbY4afVFknD8F8NV1JWIIbOMTDwur2i
         xWns3IVB3PkSCEYbXEv/to+XkiGcA3C+LZBDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQM7DSJnjHZf4CMiJhUAhGzDJ0zvjdD0E3QxycNBJNs=;
        b=IQFctl31gBcj/cLzRWE1KhQpUatIF92W16waqg6UAc1P1TwTOKWUJLnGjEytsFu9zD
         6VDZsgcuxeFdcMnYSA4n1Dk/QaIfrG7EA2IQTy02AFZpR2vdWPg4U2tbaVS6BvBauaLo
         tro4hzNPaajBqNEnDZCeMDXFYV8/hb/VnndZRVS/PaVNautRdYyWlWHiytf+QIfvQuRQ
         BDXwgqlYvMtuGDFL8vVWnfEH8HFL/005vx25OfWZjvOSz+ahM2S1UDryjfe3doZcmIwp
         cY/1SAqApPyHjaQRj/P732e3ZWVYpX62EX1+yJbRBQxVMZnP09D7X/HEYfNGCYv2hRjN
         JMmw==
X-Gm-Message-State: ANhLgQ3Hp3fjFFT/b+P1HFqw3av40PTrbfpZ6uQRTnPzmxV2u81fvteW
        qZ+li9uA6XxlStlbKd3oveTqjQ==
X-Google-Smtp-Source: ADFU+vs/AaE6aqlQY1TAZZCQG2Z+KY0trXhgyyzVOdBbs+3c2BgHS7P5zclsKKY9+PHHw4Fb+FfirA==
X-Received: by 2002:a62:7950:: with SMTP id u77mr7533442pfc.34.1585201325384;
        Wed, 25 Mar 2020 22:42:05 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b3sm710855pgs.69.2020.03.25.22.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:42:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/1] Bluetooth: Add actions to set wakeable in add device
Date:   Wed, 25 Mar 2020 22:39:16 -0700
Message-Id: <20200326053917.65024-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel,

As suggested, I've updated add device to accept action 0x3 and 0x4 to
set and remove the wakeable property.

Thanks
Abhishek



Abhishek Pandit-Subedi (1):
  Bluetooth: Update add_device with wakeable actions

 net/bluetooth/mgmt.c | 56 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

