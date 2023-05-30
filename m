Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB15C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 13:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjE3NQk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjE3NQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 09:16:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8EBEA
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 06:16:30 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6af6f633de8so3033404a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685452589; x=1688044589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9hfXxhYjtGD5WAGjocGUvFFP3zpGfXHDYbuEE7yCp4Q=;
        b=kW7fPpxARVGPubWeI4K64T1mY1muu3cnyKGctUM+bLGK2zUhkxe1OxQEN5dhuJykbs
         Ct0/1+A7m0AtB1PaG7IJh9eWZdHHrvyKWXtnEy/ZGI5BTWJMe/oluIKICeCibN9YOv2C
         WQCIvz23uuLIpOKYhnvK8kpg6qMmOMisv8D7+0PKsmuvaPg+s00O3sJ8dykcDO4IGtHg
         ADm3qiMud+iPEWKPb8H2xJBL/XLAeWP7/wUCilWmIrW+mRH7pfqxNqcrPDJ3NtpUm/Rd
         bw830G8sL63k4lxM5NR2IWH+8/Am/gqQDSqhISq5e4Ye34eDaBtXvIk40hYnk9QSNZ+g
         JO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452590; x=1688044590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hfXxhYjtGD5WAGjocGUvFFP3zpGfXHDYbuEE7yCp4Q=;
        b=AikwNPev7Z6NA1U30DediShqm0l2Wg3o8VxcsZyx00eoPhmeRNVXn/le81yyPy0xk3
         anq3lDW//d5OlWsYb2syqTTNppxO1+bNOd06HVc1JbocyV3EtJ+9Y21MFcEUHDFoV3Vp
         ohqJ+SsIHEHNal3yVbqw3/7e3fZG/RHKDaSBREIJXIsCUOhQOZ6LyYZWzZrol8t6DNzR
         f4artxEbaPtE8EYpUspoZpZU2qKNN2O/uuxVrYUUNM4ySL2tW4Vocyt4A5iBsydmG90O
         o6Tf4A3uDMcnIbI7KZSHQVYf6M0rmp7uAZvc77K+o6zJQybMzLFxFH/HflS2a4Wv+Eop
         Tkuw==
X-Gm-Message-State: AC+VfDydhpYFVUROWfw9CkQUtUbZnOShL2eqATk2SQiU1VDmSGAlXuzx
        hTcQQXrklknCnABv1A7FgsODbBZ397s=
X-Google-Smtp-Source: ACHHUZ48aF4auO3XMyXyztzU6PKTvtGmP4z0eepqT5yba7mQbB0ZqlYQI+3BJqhbCQ1dhDbWXlE1Kw==
X-Received: by 2002:a05:6830:6582:b0:6af:700d:25c0 with SMTP id cn2-20020a056830658200b006af700d25c0mr5032274otb.9.1685452589739;
        Tue, 30 May 2023 06:16:29 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.35.25])
        by smtp.gmail.com with ESMTPSA id e21-20020a056830201500b006aafe381a12sm5669415otp.48.2023.05.30.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:16:29 -0700 (PDT)
Message-ID: <6475f72d.050a0220.6d67d.a223@mx.google.com>
Date:   Tue, 30 May 2023 06:16:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8209996672738153979=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530125731.253442-2-dragos.panait@windriver.com>
References: <20230530125731.253442-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8209996672738153979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:973
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8209996672738153979==--
