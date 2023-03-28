Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8D2C76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 08:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC1IqN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjC1IqH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 04:46:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF35242
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 01:46:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o11so10996223ple.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679993163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gyWFqV/eJJlh6YtYUi3GlFnCYTEUxaEFhQ6OjOWTpRE=;
        b=NE+44sr0tqZSx1xY2mrPUn12BuXB0l7ufpuln68Zx6/QMvYnY/+wC1Mp+O5NKQDvTq
         DhGyIBUIE/Y5YOfO65guG/ErG797tM2ay7wjZfenenSlOxN6HwXLgqakZQoORImxtqGQ
         g722AqQUjLYA2SDs2PpmTg79MD5WSKiq9L/W5ZqFCu2M7xkOYSWVJ1vP/O9k45eG2aFp
         mWdqyg8iiRDuuufRn8/F+iiCxDVkwXi5K7e5qIZ2C0Tx5v29QxPyOMtNRR5GC+gBgY2w
         be6O+MVXsSDlasbuIIrEAnIR4RIhHIrCY2ERpHRj92zrCCWEE/1AXYYEt5NPMcscLiHB
         bYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyWFqV/eJJlh6YtYUi3GlFnCYTEUxaEFhQ6OjOWTpRE=;
        b=B5Wa2dvBryiloEy+ntvYpOfX4q4gkJrm8nnN3vk5x33fiwHxOc6baJpfZJfxUMCL5Y
         GtxGByz+f/O1jEnu61Er5auLGj1b9YZ/kJfg55OHzyFDAsU+zAedXc7Sv7oJtPH6dInd
         CmVcfGsRz3Yl4XkoxMcpRdofnJ3wv7q0SLquig/BaqD75NMOQU4ttdTNfNL/vzbGaHZP
         NOKkMBu1fDsr3qkQmOBxP/kV3kFdhM0EyZLnPr2cUetmGZwxtaxN/UTV+M2hA3sKEYz8
         /piAJg5RIA1FobtKDAvIgjocoWmEP/2OOV2PTF/xOqCkah1QkE/rUqXyN2T1Ba2ASMLR
         qlog==
X-Gm-Message-State: AO0yUKWpE/6Qysb6DrznrXR8nXhL/wRxswkgZ3mK8URP+jWibZ2j4up9
        8U52onPX1uhEDiMvIRS571YH5GNyefM=
X-Google-Smtp-Source: AK7set9ZBU/3hKsM6JCRJscg1PYgRV/1g381DPwz+Yc4Tg2lyEZ1iL9/0p7NEJf+PvSna1+q0Hmb/Q==
X-Received: by 2002:a05:6a20:a891:b0:de:5082:c9ec with SMTP id ca17-20020a056a20a89100b000de5082c9ecmr12172396pzb.2.1679993163117;
        Tue, 28 Mar 2023 01:46:03 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.216])
        by smtp.gmail.com with ESMTPSA id v20-20020aa78094000000b006089fb79f1esm21007195pff.96.2023.03.28.01.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 01:46:02 -0700 (PDT)
Message-ID: <6422a94a.a70a0220.281c2.5cc9@mx.google.com>
Date:   Tue, 28 Mar 2023 01:46:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7412452733680473868=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Split bt_iso_qos into dedicated structures
In-Reply-To: <20230328072622.16896-2-iulia.tanasescu@nxp.com>
References: <20230328072622.16896-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7412452733680473868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734492

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      32.97 seconds
BluezMake                     PASS      1004.38 seconds
MakeCheck                     PASS      12.64 seconds
MakeDistcheck                 PASS      182.43 seconds
CheckValgrind                 PASS      296.33 seconds
CheckSmatch                   WARNING   392.58 seconds
bluezmakeextell               PASS      118.78 seconds
IncrementalBuild              PASS      815.07 seconds
ScanBuild                     PASS      1224.98 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7412452733680473868==--
