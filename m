Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113FFC10F25
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 02:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D486020728
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 02:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mr8h0B/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgCJCfZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:35:25 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37019 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCJCfZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Mar 2020 22:35:25 -0400
Received: by mail-vk1-f196.google.com with SMTP id o124so1038353vkc.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2020 19:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFmpkmWVOfYNHFZngp7S6p8wZvHubM+kgPuBRtA3vO4=;
        b=Mr8h0B/J+69ezJKfsdeEu8c3BJbsd+x2rsZn0OU5eqpXg6ffqlFHbxEg7RJ5BOY87h
         NMknIlZd1sG5EMr7Oo/pFtEa+ZSQi3PSi0y+UU3MviDTXuGiwo39OPFaLM0+KLX7wVHe
         yFuB9Z06xdfR/9BjzAIfnT6X48V19oRlaOknY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFmpkmWVOfYNHFZngp7S6p8wZvHubM+kgPuBRtA3vO4=;
        b=WVluhooVIqDYDGoRyURtwahkboFkceaKc4wBd5fJMVlpEuDf0P9LPg20CitOBpSSd4
         BWIuCtgJrOZFoYhKIVNAnNZVo+luIFJwsTonezLt4Pk2XftW+bRj0nb3G0jGh2MYNBBQ
         E1x8GwtbFMIzPAf+r0eRJNkTjOcIoy9gUjRGv7BSNXmeNW6qfwbg5qKt1b0W32+IpUvU
         Ve/Mj2RpmvKNTLX9gHc89cqUncBK2dQ2YTkKDKuIx4EP0JDqBPWlwKvB+MWeot93Bmwn
         fRQpfHqMR5tf01o5j+qkUZ+xtGJKyRBAVqf37yGB0xCnfI0xsLI1Z3Z0hKS/IuvO3II7
         85EA==
X-Gm-Message-State: ANhLgQ1K6jqjrXcs+gOOn20KJdLVfCVYuDZTol8y4xl58Y0PekxOYg5g
        X0i/x43gOe1oA77out073ZxNd9KiWC0=
X-Google-Smtp-Source: ADFU+vtLLFnN6ye27+CjyI9FEnW7KxbFEdCEQR9xJwNTFPcJuXr3GKE9tZ5JPOQUWT27ndg8ozad8w==
X-Received: by 2002:a1f:c686:: with SMTP id w128mr10022483vkf.34.1583807723773;
        Mon, 09 Mar 2020 19:35:23 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id p24sm2767024uao.4.2020.03.09.19.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:35:23 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 0/2] HID and HOGP connections from non-bonded devices.
Date:   Tue, 10 Mar 2020 02:35:14 +0000
Message-Id: <20200310023516.209146-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It was discovered that BlueZ's HID and HOGP profiles implementations
don't specifically require bonding between the device and the host.

This creates an opportunity for an malicious device to connect to a
target host to either impersonate an existing HID device without
security or to cause an SDP or GATT service discovery to take place
which would allow HID reports to be injected to the input subsystem from
a non-bonded source.

This patch series addresses the issue by ensuring that only connections
from devices that are bonded are accepted by the HID and HOGP profile
implementation.

More information about the vulnerability is available here:
https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.html

Alain Michaud (2):
  HOGP must only accept data from bonded devices.
  HID accepts bonded device connections only.

 profiles/input/device.c   | 23 ++++++++++++++++++++++-
 profiles/input/device.h   |  1 +
 profiles/input/hog.c      |  4 ++++
 profiles/input/input.conf |  8 ++++++++
 profiles/input/manager.c  | 13 ++++++++++++-
 5 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

