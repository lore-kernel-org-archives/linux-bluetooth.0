Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36013C11D3D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D520726
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QecIEsPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgB0S3t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:29:49 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35524 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgB0S3t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 13:29:49 -0500
Received: by mail-vs1-f68.google.com with SMTP id u26so293301vsg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2020 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfQMAoqcyNCeWMpJPYuHXDwVURKqY58rPDSyHiJoy74=;
        b=QecIEsPmWSEaIk0e8hUrg+gRM9YJbAj/+uioSLfkLGw6pUyKxfHJjIIu1at77MRyMT
         hBd0hFdZv34yNyVD4xRmcwXa1zRpynEjixuP7Qdih+dVgIuY+EBTCyTeztO/8Jl2ZIsz
         5Iusy2/7yDrYmnXINGKWRB9H/YzTFsFX7y+3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfQMAoqcyNCeWMpJPYuHXDwVURKqY58rPDSyHiJoy74=;
        b=kPrady3zExfmyhkbOVvPiIAkGIRYfp+aR6pb/7oXH1+AGGCQQJIV4Lpa9TpbWMGKgb
         16XUng9J8j7l3tlTtE2Sb16+1A0mM+LC8PuAkXzENiH7Esp5W7ZvERexSQG0PNJXsKLO
         hixpjFUFP8IAdlQAVbIKkTzGGJwM7V7P8SGTMhbPqd7v1DUNTW46YP2JWnJY5vZWdmbX
         C2CptL1smwz6agPFHNDbe/OLVl/tIp2QmqyTSiIDwnWyEQs3EZ+gwWy/eX6KrEneiZmW
         SZNV11zqxWAeyubOGOQNkhvLiv18vWkssnSL8jWJfMzQl9js8KFiB3nDvvdF8UTZ4ztR
         tRXw==
X-Gm-Message-State: ANhLgQ25py3TTZ6MxSR4naGVUh+cypbohdWUhhqkZ7xNr5r01g8zlcuP
        Og23kniUzYShZTlY8UkmQ9UHzIYPgX8=
X-Google-Smtp-Source: ADFU+vsWtOTGMjmED6/GTLsnoCE+HcbFCaVVEvtTGKyxWm2pPa/ev1OZzbHpW5tkgxrtvnzvLFop0Q==
X-Received: by 2002:a67:cf46:: with SMTP id f6mr380085vsm.143.1582828186381;
        Thu, 27 Feb 2020 10:29:46 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id v21sm2274464vkd.54.2020.02.27.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:29:45 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1 0/3] This series allows a higher level HFP implementation to enable wbs.
Date:   Thu, 27 Feb 2020 18:29:35 +0000
Message-Id: <20200227182938.110670-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


In particular this series :

1. It allows the driver to indicate support for wide band speech.
2. Use a quirk tied to a MGMT local controller settings allowing a
higherlevel HFP implementation to check if the local controller supports
wide band speech.
3. When the controller reports support for wide band speech, enable
erroneous data reporting to allow a higher level PLC to deal with
erroneous or missing packets.


Alain Michaud (3):
  bluetooth: Add flag to define wideband speech capability
  bluetooth: Support querying for WBS support through MGMT
  bluetooth: Enable erroneous data reporting if wbs is supported

 drivers/bluetooth/btusb.c    | 22 ++++++++++++++++------
 include/net/bluetooth/hci.h  | 16 ++++++++++++++++
 include/net/bluetooth/mgmt.h |  1 +
 net/bluetooth/hci_core.c     | 33 +++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c         |  4 ++++
 5 files changed, 70 insertions(+), 6 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

