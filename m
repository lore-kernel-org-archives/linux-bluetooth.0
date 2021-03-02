Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D00364F2B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838013AbhCBXCr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581338AbhCBSug (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 13:50:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7803C061D7C
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Mar 2021 10:49:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b15so2534999pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Mar 2021 10:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICT+rzXe6Uf7SYTOFwtfIOL39YlZQ7S1ZDWq8wbgKdw=;
        b=ls2q8gqX0V96FwSbFWk52WiMJyp+XvHetFkLhAkPpRym9jxonqOVaO8b+u2RFcpKE9
         dyggFIiZhdRX+hkFHWZkyj4ZqSqiR3/MrFOTvvJYeVF/RcWC39tC9ccobE9Ml+IBloZl
         Xa046p7c7N/sJt4/YyAwknUjv0hf2k1I+iBFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICT+rzXe6Uf7SYTOFwtfIOL39YlZQ7S1ZDWq8wbgKdw=;
        b=s/vgHziVtNdYnVEuCh/28VcsHAcQgyyd4Ueq23Mp8FuatYtGb18B1j4yiWTaC0fiqR
         EVBt14rg72ZrnYu4UQj3cK714u5RcuOjzzRRm0YwaQ3aaHHN5qlguW3RgdAIQli8urd6
         uMMAvnndtTTUmSLxt7cIBxwKpw0LpyuBAeCxij04NBtgQ8Qh0lErfPK0i5OXZbGNbarf
         lht9NsShLH/ZbgM5/WwiFSzvrn8S1BPuwC5ibnGM5Tz8OTw5OAXJaLqg7kms1/JOQSTo
         NgWkaH7UaYuqcz+oeJpWnu3paH1m37hyODQr/DDxUl40rFbDY1h7ukZ/S+cYi/eBl6WC
         avCQ==
X-Gm-Message-State: AOAM532NCUvBp9SJFhb0ggCK+BNTCfew2hjmF1uwEa8E8hc78wkGrsJs
        VvS6YIqcS2+RYnV3FTwd8Z0r2g==
X-Google-Smtp-Source: ABdhPJyUbr688nxLCQmvjUglkPWkLxdMy+8VrCxK/FGD23O7xIN2l+BsuOGpwYr0DvUCTB9bk7sDfg==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr5618286pjb.29.1614710983315;
        Tue, 02 Mar 2021 10:49:43 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:9c83:cccc:4c1:7b17])
        by smtp.gmail.com with ESMTPSA id 140sm21800839pfv.83.2021.03.02.10.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:49:42 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 0/1] Bluetooth: Suspend improvements
Date:   Tue,  2 Mar 2021 10:49:35 -0800
Message-Id: <20210302184936.619740-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel (and linux bluetooth),

Here are a few suspend improvements based on user reports we saw on
ChromeOS and feedback from Hans de Goede on the mailing list.

I have tested this using our ChromeOS suspend/resume automated tests
(full SRHealth test coverage and some suspend resume stress tests).

Thanks
Abhishek


Changes in v2:
* Removed hci_dev_lock from hci_cc_set_event_filter since flags are
  set/cleared atomically

Abhishek Pandit-Subedi (1):
  Bluetooth: Remove unneeded commands for suspend

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 24 ++++++++++++++++++++
 net/bluetooth/hci_request.c | 44 +++++++++++++++++++++++--------------
 3 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

