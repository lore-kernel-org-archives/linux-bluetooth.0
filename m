Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F57FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 22:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbiBOWVc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:21:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbiBOWVb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 17:21:31 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E360DBC
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 14:21:21 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h9so533978qvm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pLypw+jfPKFhOemtNiFoXC3hCOU54wMh0q/RSefPVB0=;
        b=omj6oZGNRWuolv9jRv92HK0L13KQzFAtIhjuv4DOowImscUrUGW0DkVTnU8ZXnYmtg
         gcV7Jvpq9nHZhKJPNZsYJECLEsPGvKTGjV1MSmH9ma5CER0QAh8/aCmhu1plB9Q2O/wm
         aSDtl+6bYJVQnktlwyHxU7wM5+c7icuLEokJLfyufzdFwHb42tP/xiFNxspeCjv7lLj+
         MmfhPgcXk98Z/gW9UlTwj2fEDf3uEEDvVhAJeLRu3xknPT+nppl+fHTweqrkBPSpBqyF
         OQKPdDQiDwGGCc3SgbBhww9wRpja7IAp1autghgGAulg7HAZzol6lIwXNygkW3+2nQXE
         tM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pLypw+jfPKFhOemtNiFoXC3hCOU54wMh0q/RSefPVB0=;
        b=lPBaYE3gkfUXnkfFxi2qhYTy6vxvsc85gpFPatNwlMxr6Yxue7G2FDdJVGPYC2+uma
         vOJe5niilh6YdGQmnlOKZFCuN2AwQJFevS/ofwCrylgPyg/7hEJL+K91H9IrGd+6mj+X
         Iv2tx4pCcy6V820fJ8xHpFTtDKzPCJ+d9wyBdMkM8rNr7306zSEAQI10fuOkyWH/s3a0
         dnr74pONE8iBI76zq7eDu02IIqOU7pfyCSUMojLm7m0SzYn+kOeXy9TYXi4ccN1GA2f8
         z8BHE+ycrXnRF74wnilI7OKlz1AkcDR0Wvn4RZw+Xq5MPa6ZlXhM/BlJvXGTkdD0k3u3
         UjLw==
X-Gm-Message-State: AOAM530tkjwhWdkn4JZDKfONBODnDQY+U1+A8VKikGVzUkdTGLBZ67nk
        FndTIpvcAtc7pY6z6cux8qMoodNFLWyAfQ==
X-Google-Smtp-Source: ABdhPJy8noxhMvD3+DxZ21297p5YCvAtZvBp4vZMgbcT3uFqf+ZBA2nfIhwD7a0BdAh5a9t1uyzEXg==
X-Received: by 2002:a05:6214:2a85:b0:42b:f639:97a4 with SMTP id jr5-20020a0562142a8500b0042bf63997a4mr76765qvb.7.1644963680180;
        Tue, 15 Feb 2022 14:21:20 -0800 (PST)
Received: from [172.17.0.2] ([52.232.165.118])
        by smtp.gmail.com with ESMTPSA id n7sm20800750qta.78.2022.02.15.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:21:19 -0800 (PST)
Message-ID: <620c275f.1c69fb81.720bf.10f0@mx.google.com>
Date:   Tue, 15 Feb 2022 14:21:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3720078079813070264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] player: Fix Track being emitted with empty metadata
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215205012.2130772-1-luiz.dentz@gmail.com>
References: <20220215205012.2130772-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3720078079813070264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614694

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      40.19 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.18 seconds
Build - Make                  PASS      1459.78 seconds
Make Check                    PASS      11.98 seconds
Make Check w/Valgrind         PASS      440.43 seconds
Make Distcheck                PASS      222.25 seconds
Build w/ext ELL - Configure   PASS      8.25 seconds
Build w/ext ELL - Make        PASS      1366.77 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3720078079813070264==--
