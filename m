Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC69ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIPWWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 18:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIPWWc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 18:22:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877ABBA57
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 15:22:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id ay9so6311510qtb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=0DjbSO9R0UBXcibY5EOq5QJbtEgCdx8GrkUt6poIkuQ=;
        b=c/RQm/IbJAMe3EWVCjNj/w1+2wuDZqmQkGVT6a0ULSVXHIzYcWa30aY4arQkB0NoTE
         m2mk+uOkZl9xhBI8o32SP+ZKPrgDyb8mQQJeqFl8DggKyf/MXuD7mM7I6sERcyZelaJO
         ss4Zx0q4GI3rkUcisHzro/JGPjMyiIW3heT3EHZ4HMI4d5O3GC1883782SyKRcxVSEwM
         Hw6asSmq4WQaLQ5CuVHA2k0y+d8BJdr1xObEXCypNSh2dRHIheOW7KiZ6fwsXd8+N8Xc
         O35F0woWrDgcoaYYBUlAX3ILBJhRayFNdKFM5t9B2HY4QHbQ96wtfgxSlMB9SGlfSl/M
         ezQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0DjbSO9R0UBXcibY5EOq5QJbtEgCdx8GrkUt6poIkuQ=;
        b=WT5I0zMOYfrdBNdcS0Nj/x3eJ91E9JLZLDpXPJH8rtd9Vv6ymvS+7G6Oyo6ocLU04Y
         q+mjXU6TmdMMyoSTOqFU8/Pzqg1MkQooQPAKp8vNHsug0EZNiaaBTfbO4eye7QoewUXf
         TwfdrI8Vv6pXJZ4yeRty/qkngfiZYUN4VQz8u+8V3QQjttEXnY/WLnBnqR3vdc7cZj/c
         OdF6GJoRZBfdLrU6M0EPFoixyDYFsx/4y/1TG8d4+g5tPciuqnjMm2iYbdbUks33TUQw
         2PVBoB/wiePi6LCnnGWh0SWQlUMKv/0qGGgUSelilQYBUXdeOhRJDNZYlcEVgdRtq2AS
         KwYA==
X-Gm-Message-State: ACrzQf2TNvtFntAM8SUABaOtd1bqIk5WABh/ILmkRtHtsy1OvtepIcBV
        WuIe+Clb+fmZyax3UpYz8u0o6Mw0OiDcIQ==
X-Google-Smtp-Source: AMsMyM5oTPICVYzXaOn1FSgi5XlwAseNJ7C9S56SEYc+l+lSBrgtWY5q9/e82psiSoNP1tkjlhdZnA==
X-Received: by 2002:ac8:4e45:0:b0:35b:b34e:abf3 with SMTP id e5-20020ac84e45000000b0035bb34eabf3mr6484452qtw.188.1663366950442;
        Fri, 16 Sep 2022 15:22:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.224.22])
        by smtp.gmail.com with ESMTPSA id w14-20020ac84d0e000000b003436103df40sm5858837qtv.8.2022.09.16.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:22:30 -0700 (PDT)
Message-ID: <6324f726.c80a0220.11558.35ad@mx.google.com>
Date:   Fri, 16 Sep 2022 15:22:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6490646761209911580=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] a2dp: Fix not detecting transport connection collision
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220916214235.1120979-1-luiz.dentz@gmail.com>
References: <20220916214235.1120979-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6490646761209911580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677765

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      26.86 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      8.74 seconds
Build - Make                  PASS      845.32 seconds
Make Check                    PASS      12.12 seconds
Make Check w/Valgrind         PASS      290.25 seconds
Make Distcheck                PASS      236.74 seconds
Build w/ext ELL - Configure   PASS      8.59 seconds
Build w/ext ELL - Make        PASS      83.52 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      515.16 seconds



---
Regards,
Linux Bluetooth


--===============6490646761209911580==--
