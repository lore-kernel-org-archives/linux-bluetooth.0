Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27EC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA520781
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lcIYdbkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgDWOnd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726963AbgDWOnd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 10:43:33 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76AC08E934
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:43:33 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g10so5908815uae.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaRDhlK2NHNeurmMan7RY0AcLjKjzIMg63JaKxpdTg4=;
        b=lcIYdbkg5Exzv+pMyXXFnCDSRCHkQrBLvQ7xZzAYUSilE6XcCZgJhNH9eBGcyCh2IA
         hZ8VzIFRFEV4S/Ge8HenpuokRkwXXax+FFk/7+1wUMWnQtuwrf7dk9jyy3+2RD8Pk74D
         gsaH8E/pnoYEeAb3h2hks3tBwzerrSQNh4A3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaRDhlK2NHNeurmMan7RY0AcLjKjzIMg63JaKxpdTg4=;
        b=Nh3Mzu+3xlOGm2qlA/NUFjfW8+2Em2+/M+LmyPQwbN8Mo05L4nRioRsJ1YESa7Fflg
         EQLAeJst3VCE6zXC7d8JHkv86CtjI15zFgvEnf4VN9Le01bwFLxWkAEGSQmTOwuR5weH
         8v2ageRLAO2w3M5YCfbG5IyHzOX1KcJP0sDbdKAUHM2kFDWsGYZ0IH6c8tJXlF3FCFk+
         AK6dIPzirMJIR8m0eUZHyXi/xIf8rYy+/SE7iI+mlTJE3KSzeIWJXw5YphWfG5095MCx
         86p4pOubuAx4lDZOEZL1NSLBb6MYcIkiWZl9R9onc5o3HwcZTXUbvsp0cSFJ03h7iA1U
         YtFA==
X-Gm-Message-State: AGi0PuZWfBDIVkMt022Io52Bz7znnN/313zXK3J/yBsy3bt46Iko/ReH
        6+FA0V4Cv/mtnKIyIuks1XaLY4XCBjo=
X-Google-Smtp-Source: APiQypKbbk5R1B+XvVyQE7nUuj+URRUx1snUrES8VpBudR2pWzRpvwMPOZqbRhwVySgsJ3/eBxgjBQ==
X-Received: by 2002:ab0:485:: with SMTP id 5mr3280622uaw.5.1587653011929;
        Thu, 23 Apr 2020 07:43:31 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id d83sm762107vka.34.2020.04.23.07.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:43:30 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 0/3] bluetooth:Adding driver and quirk defs for multi-role LE
Date:   Thu, 23 Apr 2020 14:43:25 +0000
Message-Id: <20200423144328.82478-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series adds BTUSB and quirk support for the driver to confirm that
the reported LE_states can be trusted.  The quirk will be used to
gradually roll out the feature to supported controllers without
affecting the stability of other controllers.  If all controllers FWs
are fixed or else validated, we can consider removing the quirk over
time.


Alain Michaud (3):
  bluetooth:Adding driver and quirk defs for multi-role LE
  bluetooth:allow scatternet connections if supported.
  bluetooth:btusb: Adding support for LE scatternet to Jfp and ThP

 drivers/bluetooth/btusb.c   | 11 ++++++++---
 include/net/bluetooth/hci.h |  9 +++++++++
 net/bluetooth/hci_event.c   |  4 +++-
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

