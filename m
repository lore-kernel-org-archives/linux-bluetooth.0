Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B762C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Mar 2021 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D926264E6C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Mar 2021 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhCAUKO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbhCAUHJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Mar 2021 15:07:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EA3C061788
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Mar 2021 12:06:15 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k22so10599535pll.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Mar 2021 12:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K7jUgE2LmNGDoZDwBfA1B86gHJCehExJZSP0d0xq6Q=;
        b=LfZC7e1Abwp4SFyTkNDTrMGwigimuUz+CkvxeONBp6YcvvYKk5IafZZapAjzhjHXy4
         Daru8urkNWAzXTMszOXYN7pVJ4s5C5wUFPHsqYjzDxpxaODlYrOk2IHTzqORnjAZsJze
         juDHxwCbLQ0PwF/nso4Ctzc2zOdm2f5Z5Qgfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K7jUgE2LmNGDoZDwBfA1B86gHJCehExJZSP0d0xq6Q=;
        b=gbWcUuwqf1z2//7tswSIkVylBLNU9m6ZzrS0WbBUD1Cm/82+EmDprPVOh5uSrujCM1
         VPIYonUnnVuEFrlmBm4YjqcC3/yr7DnLTBBqMUtNI7qsV6IE7Rz2Onx+zcyPryCo1NPi
         ZEp2Qs0Qm3Js7iCGwDF6bGT8T2jwA2eKN3egFTHoJsLXI+Td6+qwGt9WhAefDmihBxPd
         5DMe1fZIVLcNtsOv/oCdKdvvMHGnVHC/AfwnPSdg9XmrqHZs+CbKP52ukez9QR+79pbT
         EdbX0CR0alAeDxKyQxj9lkaNvbt7O04m+YS7uGa8ruyz5QTcmFvNqU65S/Rw00eALyUE
         s9rA==
X-Gm-Message-State: AOAM531sp+J+25c6njtW+MPNO+miZWRYN0xVboEZGlURWzW/4nb3lqrl
        3Fg3foGcbB2xnoJQvEMXdBkdEg==
X-Google-Smtp-Source: ABdhPJyOUFWHpB2eBwfNpAVcdon+IACxVbRZiRQFJuCOcZG4gMOgaxKCxuY+GU5MYhsnxmXQZgkU2Q==
X-Received: by 2002:a17:902:f1c2:b029:e4:6c23:489f with SMTP id e2-20020a170902f1c2b02900e46c23489fmr369260plc.62.1614629174679;
        Mon, 01 Mar 2021 12:06:14 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:d800:e660:6ed:356a])
        by smtp.gmail.com with ESMTPSA id t4sm238256pjs.12.2021.03.01.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 12:06:14 -0800 (PST)
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
Subject: [PATCH 0/2] Bluetooth: Suspend improvements
Date:   Mon,  1 Mar 2021 12:06:03 -0800
Message-Id: <20210301200605.106607-1-abhishekpandit@chromium.org>
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



Abhishek Pandit-Subedi (2):
  Bluetooth: Notify suspend on le conn failed
  Bluetooth: Remove unneeded commands for suspend

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_conn.c    | 10 +++++++++
 net/bluetooth/hci_event.c   | 31 ++++++++++++++++++++++++++
 net/bluetooth/hci_request.c | 44 +++++++++++++++++++++++--------------
 4 files changed, 69 insertions(+), 17 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

