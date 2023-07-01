Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA0EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jul 2023 05:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGAFVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jul 2023 01:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGAFVC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jul 2023 01:21:02 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99544E65
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 22:21:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76547539775so204537185a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688188860; x=1690780860;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kuPiPeTzXWoH+a1sMtr2Bw2xJgATFRYJwaqwlaIOufQ=;
        b=hMxv250H48FOCOC8SXKw9zTpQbksStuTRiXkmssF2yxijSS60/2HwvQaWpgXA6TeDQ
         Yxgtv1WbADoAd3IvuilzajBF8i3N+yNiRBTX6Q0w2LMaU8FwkhC57J+YTRM9Tu2cWeH6
         x87IhS8soWAs6d/11hhJAVfPs1rOCszQeKpVfru7f4QwYG5+TD1B8sZpoBNoHbFmfpi0
         P7TRk1HB2cEcJ9gFkA1MlPhO/JLkb4wRq6z2gkVZ0z7FFWKGB2tMjcqDlc3zs4foB5Sd
         Hxc1I1zGJqPhVPwy0waW62skQYV185YHbMVqf7GyRey9NHT6GQPlSpjN8nfrMUrU9Ud+
         WLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688188860; x=1690780860;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuPiPeTzXWoH+a1sMtr2Bw2xJgATFRYJwaqwlaIOufQ=;
        b=Mf9NBiZ3djF6Q3Ggp1OsaNHPcuCaGgYwyyevfRWDffisp0ZU6qAZ2D3bhBKRqotGqE
         BDiJIhypGUrrIch4t5xYiAe5E0pvv1wJTr1DLPusLRPJNN99IxR46RG3E78N9AOG9VpJ
         SMCpXphOSHyBUCqnWOZ3HNdNA6mmIp8DA7mRzDVdMBXVXthkodUBvQSgkTOdd/S8dXMX
         FETCoFnqdw68GQP/Lo5uhe6xnQkokGvqAHblLmvfffthI2xXFlyYbtkieAbDTTO2XtCh
         1n42OkeBJkj5K6pmaczfcfljItynO0INKjR2wUBr6aY2T0IC7vCSVo3IgMls2MxjioLc
         ayfQ==
X-Gm-Message-State: AC+VfDxI0WoB+LX/S5JqBuOj0V83FiDAEqhrQzPCzWI4alHxEsRhVcyb
        RCBl7UMjS/QV/hQ7U1+PSo/N0E+oSrs=
X-Google-Smtp-Source: ACHHUZ55iL3sDbiPE/f8DId5pHOFzWvtlYIKTO0IL9DunLDUqfPbtUd7t9bG1ZnVOBnaVe2w1MGzxw==
X-Received: by 2002:a05:620a:2447:b0:765:a723:655c with SMTP id h7-20020a05620a244700b00765a723655cmr5286216qkn.5.1688188860515;
        Fri, 30 Jun 2023 22:21:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.74.47])
        by smtp.gmail.com with ESMTPSA id m4-20020ae9f204000000b007628f6e0833sm7718489qkg.100.2023.06.30.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 22:21:00 -0700 (PDT)
Message-ID: <649fb7bc.e90a0220.277e4.2d75@mx.google.com>
Date:   Fri, 30 Jun 2023 22:21:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4807811211639795892=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rudi@heitbaum.com
Subject: RE: configure: Fix check ell path for cross compiling
In-Reply-To: <20230701041252.139338-1-rudi@heitbaum.com>
References: <20230701041252.139338-1-rudi@heitbaum.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4807811211639795892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761714

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.33 seconds
BluezMake                     PASS      981.12 seconds
MakeCheck                     PASS      12.33 seconds
MakeDistcheck                 PASS      156.72 seconds
CheckValgrind                 PASS      257.33 seconds
CheckSmatch                   PASS      341.43 seconds
bluezmakeextell               PASS      103.52 seconds
IncrementalBuild              PASS      851.66 seconds
ScanBuild                     PASS      1060.78 seconds



---
Regards,
Linux Bluetooth


--===============4807811211639795892==--
