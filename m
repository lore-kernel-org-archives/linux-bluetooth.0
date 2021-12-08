Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38396C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 23:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbhLHXPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhLHXPb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 18:15:31 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191CC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 15:11:58 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j17so3769073qtx.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 15:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=btB3ahgqZMXNdHJ/oRR8LTGaRfpKkEORfEGWVQJV2Fk=;
        b=GhGzXlVudWgtD+6eVyMgzcDnsdP3R5Ecw7hQlUDEqgMY9XK4UotWA/1x7c0Keh7MKd
         Kbu0DV7RTlyHkSovhV4B+t43zL+IFmDbID1oAVvmcTuqKyTRqXzejCm97GVGVXkuuQZA
         tSOmXEzJU0NDUhKgRpfaDJUAp3rpszBobyXYOum+ebJbOMjy4EfsyjZCAbONGtUtGV3Q
         B0SZe33qwZXmkLvGOkCcf+Br6nBFTOJW+QhQ5n4P4ujoLMxW/otpNZ7vZGKPEC17a2x/
         h+fcr1dwnYxO1YWbR0MVEVOImWXYU8fyYNCCoBHwZj29+J/PpqOG9uO/rSY9CGnM2a9D
         BTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=btB3ahgqZMXNdHJ/oRR8LTGaRfpKkEORfEGWVQJV2Fk=;
        b=qW5tjn72pHhZHk4B1qijgkZ7wHFtEDeRIS/ukl8+o9kbEHe52HEzYJ17RqW9k3nxK1
         x1sDq9H9wbO1Ia0/F6sE2o3tKwfKmOAhJPntRyNEpj1dSTENOBsqMkGkXJYApNYcFxIN
         YRclazLXu1x5VHbXjK4T4tKdcigBNKXCzagAqLFw4VxjgR2i5ipU/hVfgIY5XmD7CvAt
         Tci3NrvGDD2Fu8vp1JkCZOjQT32wNp0U9JY+hN+lXuU6gSuOAGmp4xZGptfkb15KJA0e
         V3nQUduwtylDBGREUaVgWgo5y8GXqY142PGXSyIVVHpYzbHQROiq8DGGTAT64Vo3FgJY
         Kyog==
X-Gm-Message-State: AOAM531wo79FgXw+SJtqQBpyg0p4NH3HN7cwXlMa2hut3S+6sJ8fv6WT
        jm7Cxhss5DgPk3R31uJ2CjfT5ot45n8=
X-Google-Smtp-Source: ABdhPJx+vocfb4tH0cOknVeLFBK8c+yxUl6sleIRNTxZepbneu5f6EzpxWAnYu2cv4h+fWxT/XGiqg==
X-Received: by 2002:a05:622a:54f:: with SMTP id m15mr12154413qtx.540.1639005117900;
        Wed, 08 Dec 2021 15:11:57 -0800 (PST)
Received: from [172.17.0.2] ([20.122.117.179])
        by smtp.gmail.com with ESMTPSA id k19sm2304350qko.73.2021.12.08.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:11:57 -0800 (PST)
Message-ID: <61b13bbd.1c69fb81.8efeb.d47f@mx.google.com>
Date:   Wed, 08 Dec 2021 15:11:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1802250694991519431=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: Replace random number generation function
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211208223923.519664-2-hj.tedd.an@gmail.com>
References: <20211208223923.519664-2-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1802250694991519431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=592617

---Test result---

Test Summary:
CheckPatch                    PASS      6.87 seconds
GitLint                       PASS      4.68 seconds
Prep - Setup ELL              PASS      42.33 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      8.11 seconds
Build - Make                  PASS      179.48 seconds
Make Check                    PASS      8.97 seconds
Make Distcheck                PASS      204.63 seconds
Build w/ext ELL - Configure   PASS      7.72 seconds
Build w/ext ELL - Make        PASS      169.93 seconds
Incremental Build with patchesPASS      955.83 seconds



---
Regards,
Linux Bluetooth


--===============1802250694991519431==--
