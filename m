Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E43AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 23:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiI2Xk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI2Xk0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 19:40:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6CE46620
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:40:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2743859pjh.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=JEnvm0DYYOkDwf5lVIhNElABu8wPCInJYjWh2mvAGEE=;
        b=GD0ur60QFUfNnTUPZZ5YnaqhjtMLIeWjfh2Ejei32Z5s3wbWgLNv3rQ8sY9aLdY3CK
         NQVIsm4A5AKiGPxxMf3tv4M1Y2UM9YbSEf3OXXRldGDnZHOKOPgZB1cvN78x4CKzx2ga
         1OSckDLayK7dpQ34IuH+jIO6ruKStMT5ApbUzf/NqfyVZ7zZZ0Zy7CyuShYNHoc6QcxU
         09NjjMc6aC/bKI8DckJDw069BnKzNiXXM+z1+PLXbLHNA3gCUdRL8h0+mkXc+lyw6jtA
         RrAis7r/rsinxPghohDIR8cJlnal+BqNyeFg6wG7+Qs/hgvbwVdQQQTKwtMUPCPou3dA
         7l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=JEnvm0DYYOkDwf5lVIhNElABu8wPCInJYjWh2mvAGEE=;
        b=O0DsLm0Pi3oJoy0PBBJ1PTgSrMyQ0yvHig4wUSXNvC7tIqPc7bd+EO7vrCq8yy2RFX
         HPXIoLxMQqAWpD5ad5fMLzzd18eIUnwpJwO3x6xdc58xN3zReJP064u92SGVX7fFBRP9
         gYug3anrqMzRBtKR4HuwtlQ20KevYctK6LPXGpz3IQQoF2h+Ap5FqsSXOvmB9gVYC6mj
         aZ/7KX5OdelNfvaVVA7NJJ9tS6M+uI09ZNXDTiQRc5tBc47VLmMWPOPL5buUgtC31g4F
         GREclnIbH03MFoZqosGBO69pnTZdRwAkHIhSOVw+hThRL64Df5ISPm/hxhRQN8JAt3pg
         1yAw==
X-Gm-Message-State: ACrzQf2ieCd3/qe6WIPPA7yGvfpAGbz1zuQesjfqq2Z/XMuJfjnU2mKh
        LI4ZN+1asEpnCN5+s8tjNdcw/kcd/XkGKQ==
X-Google-Smtp-Source: AMsMyM61N5xuSdSaNhjd0YoLoDhl7xbyzxjMYdd/ZnMa4Ltyiq1KdnPpwDs03Xeu7OewYkt6bRItVA==
X-Received: by 2002:a17:902:7482:b0:17b:fdf9:6c92 with SMTP id h2-20020a170902748200b0017bfdf96c92mr2073183pll.91.1664494825017;
        Thu, 29 Sep 2022 16:40:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.213.49])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0017a018221e2sm460769plk.70.2022.09.29.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:40:24 -0700 (PDT)
Message-ID: <63362ce8.170a0220.277ca.139b@mx.google.com>
Date:   Thu, 29 Sep 2022 16:40:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7280691784218632381=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7280691784218632381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7280691784218632381==--
