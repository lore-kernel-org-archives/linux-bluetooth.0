Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC67C4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B222076C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4sQ4Ar/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCTBt7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:49:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42196 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCTBt6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 21:49:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so2408646pfn.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 18:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETiO7XhZXke6GDuUI6KgWzLWxeC6pDtcPaOKYiXplXI=;
        b=m4sQ4Ar/8AeFnghpsJxl9gzWUZo4dkOoUwggHTi6im5WlyMNlukpG8VR0Q2/aUzlme
         02l5QGH1Xrq+7tg/kjZPFQHGm7wKWT3JWEVQlGcCjcWqtMDhhJahpUJPnJ5E0aDmdeuK
         swdqraUeWGR9It54oI3HvYrX+c4TDyHbXzs9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETiO7XhZXke6GDuUI6KgWzLWxeC6pDtcPaOKYiXplXI=;
        b=uOjAk4gHZP63zVWUmpHJ3/6aJwEvzmugvvjdDuU938e6o5u4eaqkgQE7u6HsYzABBl
         c2tsQ9HSAVjhHg1QwnXHKtT5ZVhZPnxgsb8eFhFagXWAIty0GgDxP7/qXoVoJB4s9oKp
         BF+Y3pk8eaoEcBxYaLOf0/USdewEyJnk28L5C538v8f44jGFGUXOtlp/29DhXJMkMCEv
         GHyiQbHhSvwctOkD5Rfx5Zge5/dif/vqXPM/HKV0mTIyAnSG8Zwy8kcq/mWZj9t9pf0c
         m6NRnn/o0HxnWDIxEMk8jToMR7yJDtRKVGhSiE1o+Fsy3d7QTodWhbaYlWT9YKJDoexz
         +ecg==
X-Gm-Message-State: ANhLgQ2aVnovP5nnHTcSC/+XbLXkOQONURf8qRu8DIqDBkXBpmEsf1iQ
        PDbHZLW9LGTB9paPmNj5W0z0nw==
X-Google-Smtp-Source: ADFU+vvuzGeaFQfV3LmVCl2fYFHJkCPG3vQj22hjOiMNGRgRkQ8YWCLc+24CB5sgyp+JeL/7tHgiqQ==
X-Received: by 2002:a62:1946:: with SMTP id 67mr7337219pfz.0.1584668997488;
        Thu, 19 Mar 2020 18:49:57 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y9sm3450235pgo.80.2020.03.19.18.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:49:57 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH 0/1] Bluetooth: Set wakeable flag via add_device
Date:   Thu, 19 Mar 2020 18:49:48 -0700
Message-Id: <20200320014950.85018-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel and Luiz,

As suggested, I've updated the add_device mgmt op to accept flags on the
device and added support for the wakeable flag. I've prototyped an
implementation in Bluez as well that will send the mask + value on any
add_device and then clear it on the add_device completion.

This seems to work fairly well and allows updating flags during runtime
as well (for example, via dbus property setting).

Please take a look. I will also send up the Bluez changes so you can
look at how userspace would use this.

Thanks
Abhishek



Abhishek Pandit-Subedi (1):
  Bluetooth: Update add_device to accept flags

 include/net/bluetooth/mgmt.h |  5 ++++-
 net/bluetooth/mgmt.c         | 42 +++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

