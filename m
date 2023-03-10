Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D49AC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCJBNR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 20:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCJBNP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 20:13:15 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2D2211F
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 17:13:14 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c18so4229118qte.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 17:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678410793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8gifrjivOz1kauind9PJPbcNtjivpnyteOhFE6A060o=;
        b=fHc78ZL0qPcce+/jZ1ickWxidrvx/NFQ/w1252HZTt1pqskBAZypWfXT1cqTLagu30
         LmBdtfBN2+sMYMYOZK/F1DFVx8VUKHxHnu2uEA7NpOVHCFDJQEr1WDd99Z5MtMrimtTp
         scByIxKG8GwpVsVI8Jvzq4z+dbHupFBdDDeUkee/gu+YB4coQMLw1CTqbaFps27T4vET
         doZyJ5tuKdRBlQPamBfYLBlt/JwwoVsfYDPK7k4/9PLhtSRC16xWNRpdQLoyk0KH4rLc
         ynfDNG16A6IYIGDlnQirJCmwsCwfLeXfADghYK5wg0C6REULMy0TuGcMfuoPvUWZbsN6
         aDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678410793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gifrjivOz1kauind9PJPbcNtjivpnyteOhFE6A060o=;
        b=3i4z6NLC2KgDLDgBcwz/74czprI5iqUAB3U0cfFbKFzB8Z9xB0DPVPpyDiRsyK3LAZ
         HTNh4NmkGICS2CnGL4Vr8xdjgaXUlpsr6bmK57EJ6q8uA45skVgkrEyyQJBlL01D5ZiJ
         x7S5+gQPu9SRLQ5HQ4LxAAchWR9rkAnRCAiGveFpxMxFW2t2zlIr/4Tu5X99cCtg/4ZF
         CLyYPBqKHiyR4mViWLxjOpllHMFB5t4orGRDjWSPmG9oNaNzvTlLKJkJWbZX+JaUp/HF
         d80xRzszQWRJ4ls52T34pbx5fWaR23BLVWsaOeaRhpscEzvW8IOGPVS8y353w2mNo7mS
         RVyw==
X-Gm-Message-State: AO0yUKX3dGcP1smqY2NulSVnXCCYVWOVsl6w29YPJIkrBXnCWspgTp3/
        4t7goaNncgK6fN3ZMH8Fa312w5mJ/mU=
X-Google-Smtp-Source: AK7set/BkJhlaSz/bnjdiEgfhgMV26RybTxjp+CVOY01Tc67QXoaE/IMAhFkEX9IqCoHeEWWTIqSJw==
X-Received: by 2002:a05:622a:24a:b0:3bf:d00e:9908 with SMTP id c10-20020a05622a024a00b003bfd00e9908mr42741051qtx.44.1678410793615;
        Thu, 09 Mar 2023 17:13:13 -0800 (PST)
Received: from [172.17.0.2] ([172.177.213.89])
        by smtp.gmail.com with ESMTPSA id o22-20020ac85556000000b003bfbf3afe51sm372560qtr.93.2023.03.09.17.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:13:13 -0800 (PST)
Message-ID: <640a8429.c80a0220.66b0b.1748@mx.google.com>
Date:   Thu, 09 Mar 2023 17:13:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5130612191388546692=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] main: Disable EATT by default
In-Reply-To: <20230310000354.3404030-1-luiz.dentz@gmail.com>
References: <20230310000354.3404030-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5130612191388546692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/main.conf:255
error: src/main.conf: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5130612191388546692==--
