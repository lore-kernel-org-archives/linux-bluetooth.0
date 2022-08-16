Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD926C32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 06:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiHPGoq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiHPGoU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 02:44:20 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DB2643AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 20:19:26 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id b7so7047836qvq.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=MzyaWEwiic8Xb0oi7vkqbfnlJP7SFgYVScMDaWJdY9A=;
        b=g1HsPnI1coJGE43+JQA3WzWikYOy0xmpAP97DuKez5wP/n7Dk4IcWE5ggAhJ9mm11L
         vjvw4rZtkzOfTg7pFceSAxyrtfyqM4/ONHo3G0ofC2BfxAvyInwx7HscNCFKw+MgoRIn
         +HjYUApyB7j4vQ17fFqOghryIrZ3kJMpL1WgIhFUBvw7yFjI0+IaPxGq0KK4+IfulGex
         92QAoU7C2ohIOpZinLXAJTMoAQJT/xFmRda9U3kB0un7yojkbdFdub1ChrglFI26G7RQ
         b3t2etx2EWHao2SEb22nEDkyShD3Ao7CVYCFzHSvwsy4B5fZlOiV/BUKYYokTiDyaC42
         +6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=MzyaWEwiic8Xb0oi7vkqbfnlJP7SFgYVScMDaWJdY9A=;
        b=h459TumyailSpB3vYbOBpBlKVdBCQDOAKhcIwCmE3X72ujjB/wA4gPJPNhIjrp+zpp
         1fGMb+YmigSfKkxkrpDyzLcGoP23AGk2E35q9gA8UmhfsODoQNsY7dVxCuN619ERd8k0
         nDjj+RH83MyzEZlCTZh3NBjfzQ2xvJSrCL4DwIwqXbL/nL+kkCdg02z0cW+gPHTZdkLq
         jnYJH8L59oeaoJlIzZTJJJ27JcxsWxhr50JhpiMAJ6WWiXw21RkZxbv4JZVp1RcMb6nH
         xmp6ILil2TXPTIfDGliQ+8pvNMQT4Wyonp86lkU5IOneB2fZ/mbDql88BR2PObP/cbeg
         /sRQ==
X-Gm-Message-State: ACgBeo1CEJHRHNe8bh7JVXsCWWQDGD0IvQr3lhlB+kDizawSLUEeWdER
        LiJWq0zXL5VlvY0YXOqkOPkjH9WCZDA=
X-Google-Smtp-Source: AA6agR4bDKNw6KpSM6E52d4/WLsxMnJpx5gBwmfCFoaDJlU6hbxogNgkWFiX+lcSZhUyQhlJ1ZoCXg==
X-Received: by 2002:a05:6214:d6c:b0:476:94f5:aa7b with SMTP id 12-20020a0562140d6c00b0047694f5aa7bmr16501205qvs.92.1660619963887;
        Mon, 15 Aug 2022 20:19:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.10.13.106])
        by smtp.gmail.com with ESMTPSA id c11-20020ac853cb000000b0034455ff76ddsm5508623qtq.34.2022.08.15.20.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 20:19:23 -0700 (PDT)
Message-ID: <62fb0cbb.c80a0220.71b13.9613@mx.google.com>
Date:   Mon, 15 Aug 2022 20:19:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7704419531808919724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: MGMT: Fix Get Device Flags
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220815231848.1252347-1-luiz.dentz@gmail.com>
References: <20220815231848.1252347-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7704419531808919724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667828

---Test result---

Test Summary:
CheckPatch                    PASS      1.77 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      42.76 seconds
BuildKernel32                 PASS      36.14 seconds
Incremental Build with patchesPASS      51.00 seconds
TestRunner: Setup             PASS      597.67 seconds
TestRunner: l2cap-tester      PASS      20.85 seconds
TestRunner: bnep-tester       PASS      8.15 seconds
TestRunner: mgmt-tester       PASS      121.94 seconds
TestRunner: rfcomm-tester     PASS      11.83 seconds
TestRunner: sco-tester        PASS      11.84 seconds
TestRunner: smp-tester        PASS      11.49 seconds
TestRunner: userchan-tester   PASS      8.24 seconds



---
Regards,
Linux Bluetooth


--===============7704419531808919724==--
