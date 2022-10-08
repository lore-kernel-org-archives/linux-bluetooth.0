Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61091C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 03:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJHDDi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 23:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHDDg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 23:03:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE688E9BE
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 20:03:33 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a2so3357783iln.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l12+ZRy5itlqRasSiN2dQLVD3WxGgZ0WIVy1WgiByoM=;
        b=Eq/0bUDlDGYhu5ddG/9kZz2ztiM7Kj1TWAHrPlnnyFGTCFBqT+oyqDuIUNmLl0MVxv
         N+1eHrxIvesWYhs6xUTsEARYQS9/gZYV3aTdaIMsgA61z2+aOMfNd6Gyxwkd0U6wkIC2
         P6xa+oGtRXbOprooxt/lL2Ce/5y3Zqyp+Qq7hhtQkNaIddxvXWAu1xrocFkq5hjIN0Vq
         KWM8Ad619CgZK3z4+HyvZ+AvK/GdCC1l8Q90V7Rz4Fxa+Gc5uvTOGpzsn4fRVLq90Kno
         Nf3aeageU7RgXRmw63qHoJ8q215dswShIhhMlMi2cdTLDHDpbUcKo2GDDFk0WDizplbr
         LNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l12+ZRy5itlqRasSiN2dQLVD3WxGgZ0WIVy1WgiByoM=;
        b=OzwxVSk/gWtX3//lEilG88iZrhe4553ljj0fyLPt/HK+a1QhJj+dxvR4RDsvO14kA5
         TogCUf692Kt/6uEqAaE7eWSMTY7uRMo0sn8RPBLU5N3PxxuLP3gf4+HeG+Oa2fAN/Qaz
         bCq7ouQ403paRJ81WXoeljGr8f6yUyckyt86LybdtZEvC/8gPxolnr8E1n1yFvh6CBlT
         Y1pNf/CPAjlLacQ/X+yjq7GSdVjfZIqzkEB/JUBYC+ZYX5A3t2DpQShvp1+jRsHGgLGj
         vQfbRD3qC5qRfuLvxKEwzljlswR6w1UKbreAMOogHyue61B9twtlBIC6kMGsajgsQqeW
         REmg==
X-Gm-Message-State: ACrzQf12qGzIuZ32JGgmiwv/93OtpLHPTpYXzspjIssbsxMWRJtlnB5r
        m5z5lrKUxOqlMHw8KmMpWnrpZFP0yBo=
X-Google-Smtp-Source: AMsMyM6j+wMV4/Vci/2MJnE9k0HxXhUA6I7uub4jbRi0rMZ5DBieL2mJbeB6FO7jGOfZbtYlXnDARA==
X-Received: by 2002:a05:6e02:19c8:b0:2fa:a5c2:f837 with SMTP id r8-20020a056e0219c800b002faa5c2f837mr3893049ill.1.1665198211826;
        Fri, 07 Oct 2022 20:03:31 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.58.91])
        by smtp.gmail.com with ESMTPSA id v6-20020a023846000000b0035a578870a4sm1517296jae.129.2022.10.07.20.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 20:03:31 -0700 (PDT)
Message-ID: <6340e883.020a0220.7a3d5.1c2c@mx.google.com>
Date:   Fri, 07 Oct 2022 20:03:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4514998619493101143=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] btdev: Add support for setting bdaddr
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221008011410.1907549-1-luiz.dentz@gmail.com>
References: <20221008011410.1907549-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4514998619493101143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683864

---Test result---

Test Summary:
CheckPatch                    PASS      3.44 seconds
GitLint                       PASS      2.31 seconds
Prep - Setup ELL              PASS      26.22 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      739.73 seconds
Make Check                    PASS      11.41 seconds
Make Check w/Valgrind         PASS      290.45 seconds
Make Distcheck                PASS      237.93 seconds
Build w/ext ELL - Configure   PASS      8.38 seconds
Build w/ext ELL - Make        PASS      84.79 seconds
Incremental Build w/ patches  PASS      297.39 seconds
Scan Build                    PASS      506.66 seconds



---
Regards,
Linux Bluetooth


--===============4514998619493101143==--
