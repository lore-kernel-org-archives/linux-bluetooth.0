Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F06C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 04:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E9F615FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 04:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKE2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 00:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhEKE2M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 00:28:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B3DC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 21:27:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so1390127pjj.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQYXfIxHN+kc0x/loh0bCrm5wf8jqmlsr4a4ea5xGpo=;
        b=G8JXmaioIblcnyftXTnT2hOWc0QXfe7u/VmPcDQO8Wu8TiM9FC4GP+iXxbLvSXhGjx
         jpfPC6NuXhnt4e6F5LUNsZhpJwIjcf8xkLvRtgMxZqfrebxRpgO/PXc0taSDzMUVRpFq
         ccI1674g2Lck5ZXBE64ORgwvXQ2swNTdOPbEczt83FGQgVB54ewUMRgvL5pddRj9tfvt
         MTn9dyfQdyeIYpDq5OwsayM4ZGKNIUoRn+TCmq3OvTJQu/0lj7NOQqTrA6nzDWGPaPgq
         DMDsgbrFiCVBlFEmhtudXhIIxqyBsAeCvydUF9m7UqsNCSjzSYUl3uVIwy0jblipBW6b
         +8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQYXfIxHN+kc0x/loh0bCrm5wf8jqmlsr4a4ea5xGpo=;
        b=iAXGszrA1epJQWTmQFqauACfpNSj3itSghSn3oz2TIVET6c98+axoSHwXEZn3w2bV9
         g4PVYrF7mvGd+snxnFORg+ODCH3gePdOF/hrRN4BLd8s33J9/RujRCEfpqDdLYJdcDVb
         L2tppCwuZ4Eb2pTsHZt1aPhGylYnXZqorr6AEMFcKR7zTRxzOGr8VHa5dtHmTeSyzeQg
         VQa+kSUBZBxZGvDWdd7yBwFR2fOPwqGI2BIVThdBZZUPt3iayktU4+hheYr4xSLQaGXT
         cdOu/vKU205tYiP3/JT2ORCtWKvs3NOqFwNgYo4vdqKguHrlEGwDBZUcrfx0rOg8aInx
         qn9Q==
X-Gm-Message-State: AOAM530HpgnArEnmPEU5JY8w4Rq0ayg2BXOW9HhSUGcHpvVMHqQnDt6P
        RwIEyDLnQWD2aNJhBi3i6ceyrCgmyEDv/qoqQiw=
X-Google-Smtp-Source: ABdhPJzSr2sMdGLwRsSAg3ZO98g4V+HR0uk8YgLaWu+LHEshtFX0THdlBl8rzoSGqsSOEhQR81Z7Lg==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr3005648pjr.179.1620707225278;
        Mon, 10 May 2021 21:27:05 -0700 (PDT)
Received: from localhost.localdomain ([66.115.182.68])
        by smtp.gmail.com with ESMTPSA id d8sm11717091pfl.156.2021.05.10.21.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:27:04 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Fix failing to init controllers with operation firmware
Date:   Tue, 11 May 2021 12:26:54 +0800
Message-Id: <20210511042654.8549-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430230501.603111-1-luiz.dentz@gmail.com>
References: <20210430230501.603111-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I test this patch no help. rmmod btusb, modprobe btusb.


[    7.661739] Bluetooth: Core ver 2.22
[    7.661762] NET: Registered protocol family 31
[    7.661763] Bluetooth: HCI device and connection manager initialized
[    7.661767] Bluetooth: HCI socket layer initialized
[    7.661768] Bluetooth: L2CAP socket layer initialized
[    7.661772] Bluetooth: SCO socket layer initialized
[    7.686106] usbcore: registered new interface driver btusb
[    7.689317] iwlwifi 0000:07:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
[    7.689789] Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
[    7.694911] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2

[  230.746397] usbcore: registered new interface driver btusb
[  230.750827] Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
[  230.756450] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2
