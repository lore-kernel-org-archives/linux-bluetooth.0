Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Nov 2022 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKETkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Nov 2022 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKETkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Nov 2022 15:40:17 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059EEE2C
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Nov 2022 12:40:15 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e15so5618543qvo.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Nov 2022 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tzkLwBmWvTyTV4ADumu30R+f9n/XZlXTlV5Mq39F2YA=;
        b=Cum6Qo3m/VE3U4xxlY7+NiZCFtrVKW8s3c1zl2IQWFNf3LmRpSEfrQd80gzExxDBuj
         LyISzkeXdHDDZUUsGMIoPcMIR0i3NkooPVz4HfycYMSKlFwud/JI9tu0T4wuIZ+0vj79
         dPEGKDPVayVWm5HUpifgrbfAJqGW+bOUdRLsZORbhqsMVpoABwa0KPztTku1j2Z2EsKD
         fVo0L11U+bflMQH53MZDz3yu095VSvgG1DflB0bbRqGIzYCFjOm6wEKN093/cXNZlSxy
         P1OvHX6CfyGqG+8/cek+WnhTbGl45BOzkvHG0Y+WIeFlBvUfvB/55XImZB5y61MuDqKH
         f+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzkLwBmWvTyTV4ADumu30R+f9n/XZlXTlV5Mq39F2YA=;
        b=hHgJWBeRvP7HZmIrfNgdNSe/gimgW1razaqtxAoVKJTcT7jOCJX//0WQzx6kcUwpov
         qC6z4ePKaFHJlzqgSfYIcBEEeslPftJxw0sCtQ/xSCFsmL2oa464C7PY9aRuVzZDQchv
         G54WNeBDCAvJEu5r4R0ya5YqtVKV2/rwSKYEEqT0qrdbjsg1dPu1ggNMrjMGP+lXDFwc
         V0W+cYfDL5gu0rD0N16KgFMq7udIL5EuQybwhMvTaWRLBjF1wJEkCm3s6Xw34sldnOTv
         wkA3ALvaNomo3oryxpobYzUx9fQTkqCFCVTmTtCf5TbyddWWzl9nDs7L/WI+redlQCFq
         mvcQ==
X-Gm-Message-State: ACrzQf37IhPN3iStjKxDW+j+z4D+1aKdrwuOiMNF6xOCcng+iLYH406D
        eirv6idrEwmH25hFRgapY7z/HU3IX8GAgg==
X-Google-Smtp-Source: AMsMyM6iSTTZXca8J5qObYuJ/sW/LDHdzyKkYIbjqdT288kxxInh61f5dsfGmvEEEcq1LYNhV841MQ==
X-Received: by 2002:a05:6214:e45:b0:4bb:7e1a:9dee with SMTP id o5-20020a0562140e4500b004bb7e1a9deemr38465397qvc.96.1667677214272;
        Sat, 05 Nov 2022 12:40:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.171.121])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a269800b006e2d087fd63sm2508819qkp.63.2022.11.05.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 12:40:13 -0700 (PDT)
Message-ID: <6366bc1d.050a0220.b0ddb.40b0@mx.google.com>
Date:   Sat, 05 Nov 2022 12:40:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4098164622224801643=="
MIME-Version: 1.0
Subject: RE: Bluetooth: Fix use-after-free read in hci_cmd_timeout()
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, syoshida@redhat.com
In-Reply-To: <20221105190446.1324053-1-syoshida@redhat.com>
References: <20221105190446.1324053-1-syoshida@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4098164622224801643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_sync.c:4696
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4098164622224801643==--
