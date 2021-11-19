Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 01:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8D061AF0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 01:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhKSBdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKSBdI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 20:33:08 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E61C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 17:30:07 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id f20so8091457qtb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 17:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dx54vnhm2dS8HR+brBtx4fFrZUHDS+2UysYnk3+SJm8=;
        b=O6SES1RXeg8RUzSSZsn76CIILT+WMQGhYsJKYt4jsG2kzskCp2UAen8Jnzvnpxx9v9
         GM37ZjFbfOtgyHX3nmlc5YQyfK+syQtNkk1q4B7LkBf7NIzj8Vi8iJZGXw0vvpTtOIJa
         rT8Elw3dJe7JPfgGE5xArciav4HqJvy+OgC92SmVwEqWUuHOa6trIkASZYWIXO5CZM6e
         rXy8ssFrLfYgtcIXQ+QNMjEPY+CteHO2J2/PXumf+WiABRVtnUoiiuszOUvNUwXrMc8K
         sU0Zxh0nqLQTAAs+F4bHCZ031sKkM60Nb4MRKXVuc41W+icBNVA9heS8pK7ThB//lgib
         5ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dx54vnhm2dS8HR+brBtx4fFrZUHDS+2UysYnk3+SJm8=;
        b=xnfPXzjrpqzHYualH+S3TvShLgYmAdbzXGevLegA8h8Iy2OkFc9/bY6weqZoYjhKJn
         v4HQ3b6gxDJdGHr/k9SCOg5mChPU5Op50AZ9qaN8BBFY2S2O/fb7fH4Dm5iPBtY+T5aK
         Is3QFTAWgfCC9rZOkJE2DvxMAmMiOSGnQpus4QL8lpLP6KEyU2ir3E7TG0M7QlswnkS1
         gNv4kRvPKxzQZ1aNEu3O8+i3I6fMXgPejYH5pPBzP2aTgBIwPqr8g+Ybja8gqKvhkVYB
         N0XkyWslnGbz7d/UFcAvlUJQH/vFJMeCI5yTUhxqocPjQv112C81gvEOoxR3UnoPqgm4
         /Dyg==
X-Gm-Message-State: AOAM530qhRxFedrduTPBw/ExZq6QPXowrppGFNlaokBXwvl9QN0Cl4aD
        b/dGJ4UaXsykMRca7lIOa6ilhDG8ZGS7Ng==
X-Google-Smtp-Source: ABdhPJyyUeJ6KRwxrUADZ/AS90R0mTS6ogH0of5DQVB+zhxMoJYtcauaZT+i8plIsQO/H2cSSNXTTg==
X-Received: by 2002:ac8:5f84:: with SMTP id j4mr2235698qta.271.1637285406872;
        Thu, 18 Nov 2021 17:30:06 -0800 (PST)
Received: from [172.17.0.2] ([20.65.63.186])
        by smtp.gmail.com with ESMTPSA id f11sm932952qko.84.2021.11.18.17.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 17:30:06 -0800 (PST)
Message-ID: <6196fe1e.1c69fb81.ce196.664c@mx.google.com>
Date:   Thu, 18 Nov 2021 17:30:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1953408685847201324=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Fix Get Device Flags tests
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211119011113.1033964-1-luiz.dentz@gmail.com>
References: <20211119011113.1033964-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1953408685847201324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=582777

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      57.18 seconds
Build - Prep                  PASS      0.58 seconds
Build - Configure             PASS      10.70 seconds
Build - Make                  PASS      246.86 seconds
Make Check                    PASS      9.67 seconds
Make Distcheck                PASS      289.81 seconds
Build w/ext ELL - Configure   PASS      10.10 seconds
Build w/ext ELL - Make        PASS      226.16 seconds



---
Regards,
Linux Bluetooth


--===============1953408685847201324==--
