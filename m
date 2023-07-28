Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D7EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 06:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjG1GaF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjG1GaE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 02:30:04 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34A12D
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:30:03 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bb74752ddbso1437799fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690525803; x=1691130603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TDrKLquLiZjTubtE45CdYUFSbEKN2k8lPniiOVc0y60=;
        b=qZpY+5C4Y6vzGCO7Onm4I8gLlL4x0e2k8LOatPpnxYo4I/RjLCVIzSRGorchz37NrW
         Tej/CkMkq8a1SNB0kMufzTNQXe9/f6lNjTNBcON4UfUWcnCVu/boXOpaY927GEDOYp+y
         rRBV18Wib5qLu1fW9TaX1xdo8TEMuBYyFImN/kpVItMkVTswMrssvkS5Yjsc+U0ucXla
         mIy+TvWE8ZbXoSgFZbR4xT7IzmFOj1U/Dyz/+Q1vT7neRzSgtql/89L8Kwq0BhXw5bXZ
         NA0iPuL876SD3P8x348s0plhv1JPPuSaFNKibivc4fcrsLlJBmd/K+vf9xZmbXhO7ws1
         gWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690525803; x=1691130603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDrKLquLiZjTubtE45CdYUFSbEKN2k8lPniiOVc0y60=;
        b=aABnmz4FPYe2+qHD/pOvn6xvH986/5foGpJt+g1IZZyEbPavlC7C/k7B6sGyjwGrEM
         G35nJEAA4wqgTUiiln5uiMXkiPVdd1VXqNG0Zn3bRx5EAtD1ZLip/9BESyXmIjVln1Q9
         Y9fSVDzg/LpSUb2JBSCMQum+W5XGWySg8pW1jCDWj14WiAkGYn9G3qXIUt9YAaog22Wo
         Ye7gGGUUeT/snYD5QUUPgfMGZ81ssB88nQ5Y6qKyWo9j71VWTVsOwrTUAMtAe0IdUrE7
         o5ufXyIM8cG320JS4JAUMOxU+Jdftf3mp/qo7zvEU3VtctfnxisGB9ZfrY90foVcI1pt
         5TYg==
X-Gm-Message-State: ABy/qLauyil91VCjGy3TS/F2HJtzGmCa6jXI8Pk4v0k9qPyoZwTViFpF
        L85ZmElqx5t2SFpNG2IAWEbDtYLStXM=
X-Google-Smtp-Source: APBJJlHCuUfq8bVCtETiwRkOvdaLXhwocIgC3ogVZzde/BUxjsGVmcpksPEpPo7PCZKfM3Ct/A4jKA==
X-Received: by 2002:a05:6870:1717:b0:1a0:85d3:3d70 with SMTP id h23-20020a056870171700b001a085d33d70mr2245318oae.28.1690525802918;
        Thu, 27 Jul 2023 23:30:02 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.138.110])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056870769a00b0019e6b96f909sm1458032oab.22.2023.07.27.23.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:30:02 -0700 (PDT)
Message-ID: <64c3606a.050a0220.c145.939d@mx.google.com>
Date:   Thu, 27 Jul 2023 23:30:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6790040634556462031=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] advertising: Fix setting "BR/EDR not supported" flag
In-Reply-To: <20230728044923.576144-1-simon.mikuda@streamunlimited.com>
References: <20230728044923.576144-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6790040634556462031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770394

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      32.24 seconds
BluezMake                     PASS      1169.96 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      187.52 seconds
CheckValgrind                 PASS      308.22 seconds
CheckSmatch                   PASS      423.85 seconds
bluezmakeextell               PASS      123.95 seconds
IncrementalBuild              PASS      1023.43 seconds
ScanBuild                     PASS      1342.03 seconds



---
Regards,
Linux Bluetooth


--===============6790040634556462031==--
