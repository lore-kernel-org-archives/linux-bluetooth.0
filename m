Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31659C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiAYRXy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588103AbiAYRVr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 12:21:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638FC061777
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 09:21:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d5so18184305pjk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MSpy/w/gxL50f2LIGcKawBsd13QbAMbgz88hgpZr8is=;
        b=IDLStkPmbN6bZgmjyZs6qD1C3NKZ5h8/MjIjBXDN6hZmOM56NO4BuE438LikPoYfJU
         VjHDUr+UVdMQsxIrHIn1BBuoaKIQ1x6c1QhNSC6ATftfR0DeR5CXnwZwqOWJmjGAQUp9
         B44zC5lkKn1+DqRtIGh9JjvHI/pvZrYqSotuvmqxGGTUy0UURhw+NFGGBQ++eJNmj939
         m7brVdCfwOCxBsNGvrp2BQtW5/n2U25HT8AF6JGA5AATgCma5JJ/rUlsZ4EUhFBgluag
         48l9eunFLUH2IGPsaqmJHPEJoHniq4Hxosfc5n0ninHR6WOFUbeghmu9iPwdPIl2Rx/f
         gqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MSpy/w/gxL50f2LIGcKawBsd13QbAMbgz88hgpZr8is=;
        b=N92j726PHowecmX4rjoVtsbU7+XIty3eHe/aEqETJrY1nfxfHnywtP0O2ejYEMID4/
         T/Kij/WpQbz5aSFmv/OGLUqwnm1utfOSOWyrnI6fRm9rjXQvekV2LEyKb+3JJqL+zrlk
         SuaF4pAKWVGERjnOcMi3NVJzIlHPdLjpLHJGF9QMxDusBswM7DGYURMt5156cMDiIh4X
         XK4JMRWwshFun8XnISzvIJ1SaBMNu8VhrDHVni5m69ohhVgUkiay8/S2MBKa71QLzK1x
         UUQUlQTzyUztW5rL+nxKGSr2XXsvL6O91coXizDikjYx58bs/t3v1G6YTs7bLJslCkrd
         EJvg==
X-Gm-Message-State: AOAM530CphGtnTO8szYa9T+FUMcoXoQ+0L6+ubH5W4OFXfJEKS7QUOT6
        zGsXx8z2sQoVMy3A5flO8/jyL6sgHn8=
X-Google-Smtp-Source: ABdhPJzuZhI9zc3OSi9txGYVE5TsyX2lE+BwEIzz/VSujsZM1sxxBhzXZ6tOUhiRsFxp5p44L8/OaQ==
X-Received: by 2002:a17:902:aa8f:b0:149:7898:af96 with SMTP id d15-20020a170902aa8f00b001497898af96mr19520298plr.161.1643131305444;
        Tue, 25 Jan 2022 09:21:45 -0800 (PST)
Received: from [172.17.0.2] ([52.137.79.163])
        by smtp.gmail.com with ESMTPSA id h2sm10443706pfc.96.2022.01.25.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:21:45 -0800 (PST)
Message-ID: <61f031a9.1c69fb81.91d93.a01f@mx.google.com>
Date:   Tue, 25 Jan 2022 09:21:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5470562107716166411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, adeep@lexina.in
Subject: RE: Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220125161401.729179-2-adeep@lexina.in>
References: <20220125161401.729179-2-adeep@lexina.in>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5470562107716166411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608329

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      0.82 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      35.41 seconds
BuildKernel32                 PASS      32.24 seconds
Incremental Build with patchesPASS      49.51 seconds
TestRunner: Setup             PASS      576.74 seconds
TestRunner: l2cap-tester      PASS      15.58 seconds
TestRunner: bnep-tester       PASS      6.73 seconds
TestRunner: mgmt-tester       PASS      120.53 seconds
TestRunner: rfcomm-tester     PASS      8.32 seconds
TestRunner: sco-tester        PASS      8.89 seconds
TestRunner: smp-tester        PASS      9.25 seconds
TestRunner: userchan-tester   PASS      7.55 seconds



---
Regards,
Linux Bluetooth


--===============5470562107716166411==--
