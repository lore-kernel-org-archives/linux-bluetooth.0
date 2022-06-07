Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC6C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 16:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiFGQIO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbiFGQIM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 12:08:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49D2C642
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 09:08:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 2so12984681qtw.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Imp8zSdFyTuumRDbNdzzEX10InYOARhy/orbLdGWCCQ=;
        b=Sz9j3RN8wAPMYCGEGbKVuxaZx42TNp5C9vF6AHrgXXChepTvRFmR751LVekMwarfWy
         H7WHApbr8xiz0hl7Q9X2tMSifWcKJj3IuoJlehPoWzMvvhRN/ics1me5A8aHDFppzHr1
         xfAIOiXgEYYaQOPFM9AKYMdpMTqpW1hAZyobwG3stcalEaODsG8CXWkcReRKzZngoT/I
         bOyH4ioU+q1ql/B3IyUcUdKJXOJXYMztZAMq4XD1kg5A8gEeq03JR3WKT8Zr/0gGCgJS
         GTnhYNyyblmc9kcxiCRRJQ+H0O1xkU73M8+KCuXPXoludr3NMNzdW9Ux13otTKdMo4vH
         EmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Imp8zSdFyTuumRDbNdzzEX10InYOARhy/orbLdGWCCQ=;
        b=2bNf1BBZG4QLE9+gXEpqXRy0sgDXAqi8+2hvIzQ5E7q2LDbfjtG3zyo7xue/7EPUeL
         gOED+bbV52Aw2NQvbMALf3lH/KGPaT00FetDm0Z9llYykOGZK8m+u+YDDRcWqtcEh39G
         WYtZevYDduropxrOkiOjUUnRRelco6GhiYG64J+ztmzphg4QSBduYbTExUQ08fayw1CR
         BZV93lez4TH766q3dCfp7Shpx0bdF+7V3JEwBecua+bsknWr2qvTwbVdWxv6IAmVFk2J
         mTlteMAViaIku410HzaSFQNoXaLh0v/4fja65Bmqt6JOQUT0GAI2OmlIjbDglb20zoPC
         Vp7g==
X-Gm-Message-State: AOAM530k0W0PUvMY5+Z94coZWAgPekqpNeu3u7e5+TBXy+VaO0CX0Kqp
        bPUyJ5aA9LZjTmZ0Ri2x6efIlso3aJ4X7g==
X-Google-Smtp-Source: ABdhPJyRXuc5ZtuUfen4AWWEyST/adViH6mDzAPfwIxtZwajJuVgj4O3EeKtVFfCh+JQJn5Kw6z08w==
X-Received: by 2002:a05:622a:508:b0:2f9:1cc0:2d50 with SMTP id l8-20020a05622a050800b002f91cc02d50mr23615281qtx.66.1654618090197;
        Tue, 07 Jun 2022 09:08:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.43.67])
        by smtp.gmail.com with ESMTPSA id w26-20020ac843da000000b00304fa21762csm1270811qtn.53.2022.06.07.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:08:09 -0700 (PDT)
Message-ID: <629f77e9.1c69fb81.2a3d5.3bce@mx.google.com>
Date:   Tue, 07 Jun 2022 09:08:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2276775071105603952=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ruc_zhangxiaohui@163.com
Subject: RE: [1/1] Bluetooth: use memset avoid memory leaks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220607153020.29430-1-ruc_zhangxiaohui@163.com>
References: <20220607153020.29430-1-ruc_zhangxiaohui@163.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2276775071105603952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648077

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.96 seconds
BuildKernel                   PASS      37.83 seconds
BuildKernel32                 PASS      33.95 seconds
Incremental Build with patchesPASS      47.39 seconds
TestRunner: Setup             PASS      565.52 seconds
TestRunner: l2cap-tester      PASS      19.79 seconds
TestRunner: bnep-tester       PASS      7.36 seconds
TestRunner: mgmt-tester       PASS      114.34 seconds
TestRunner: rfcomm-tester     PASS      10.98 seconds
TestRunner: sco-tester        PASS      10.72 seconds
TestRunner: smp-tester        PASS      10.86 seconds
TestRunner: userchan-tester   PASS      7.54 seconds



---
Regards,
Linux Bluetooth


--===============2276775071105603952==--
