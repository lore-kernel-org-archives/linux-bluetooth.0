Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDDFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 03:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357385AbiD0DKm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 23:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiD0DKj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 23:10:39 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5B3584A
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 20:07:28 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k12so281127qvc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 20:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ra2uUasnVTA+wUupbvuUfSkHZLRfLe9I9SUqPjwCkcM=;
        b=jX8RftbOJXar/AQpBotmAgi7Rb5Op1RAUODGb/vi3g2vGHIdaJDRSm4DW0ZgwF5bLb
         nIp5Qt8M0uec9skCSO3y/Q5flbIVU+YSXdWYFsJrGtxLkS3XfoEswBOJgdE7P0X4VNLk
         O3NmPPXZb0X+jgjglosasoTFUcAAF+NJf+dpBcScj8Zzi51rqdbGeU9U+o1FAMePVmut
         qHWXp1SPouJzmVhUX6cSwmVpqkFEzxnK14gVQmn5sLg9fUvWU+Mmk9WGb3Fwa/CmwwDj
         CA3rqvzicTUv0nUmAPj3Z080/Mp3NkJB8aaRG3K6KeL+7bJAj8FsaRofUVm2A4JOm3B5
         3drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ra2uUasnVTA+wUupbvuUfSkHZLRfLe9I9SUqPjwCkcM=;
        b=w/HiUtCDTeZX+6q5I525MmL5AH6THJPWtquQO36VUWIZjyj90V4FJo/kQvRBq9IkTW
         L+Lv5EXDsVVj3m5QM77rGfuN1hq3b1r/et8AZ+fd8E13Ft5j67ut2iIqf58/rWOjPyrp
         T52Zp6BTVZJmnUM46dyqcddf8zY96gBFv4kGVqPoQ5Z1fniS71n75A8iqpyOPLW1GURO
         ssFM96MXz1TRAookQWHptbc0NMT4fhlYd1AGlJd7jvocaOUAoMyv3DG0IABZ2kmKXAkg
         YDh6GP9+31s+OnE8pKy18ji9vZrXPr1ZfVhmLYqzh3arhO79iM8smHC9XgK2DRqT3yOB
         T8lA==
X-Gm-Message-State: AOAM532V1rgHmzuf1y3D69GD8QmqZGW571TGCIch9YM1nyJeUgBMuKbQ
        KvtFrCuYWF8Lod1i9tESLjtHXD/v1TA=
X-Google-Smtp-Source: ABdhPJwPpseM2igyV22QcvIVYYuru5yvSFSLdhy59xR5JVvGYqRwnsJb1wvHLs3wUARXbY+58lbAzQ==
X-Received: by 2002:a05:6214:c82:b0:44e:1569:f21c with SMTP id r2-20020a0562140c8200b0044e1569f21cmr18736024qvr.98.1651028848047;
        Tue, 26 Apr 2022 20:07:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.18.177])
        by smtp.gmail.com with ESMTPSA id a190-20020a3766c7000000b0069e770524adsm7540443qkc.114.2022.04.26.20.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 20:07:27 -0700 (PDT)
Message-ID: <6268b36f.1c69fb81.7d33b.a744@mx.google.com>
Date:   Tue, 26 Apr 2022 20:07:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6183287864821536995=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1651025811-10680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1651025811-10680-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6183287864821536995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=635984

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      0.97 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      31.33 seconds
BuildKernel32                 PASS      27.46 seconds
Incremental Build with patchesPASS      37.87 seconds
TestRunner: Setup             PASS      469.15 seconds
TestRunner: l2cap-tester      PASS      17.39 seconds
TestRunner: bnep-tester       PASS      6.14 seconds
TestRunner: mgmt-tester       PASS      101.33 seconds
TestRunner: rfcomm-tester     PASS      9.61 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: smp-tester        PASS      9.47 seconds
TestRunner: userchan-tester   PASS      6.36 seconds



---
Regards,
Linux Bluetooth


--===============6183287864821536995==--
