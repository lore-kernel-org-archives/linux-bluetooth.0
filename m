Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0123C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 22:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhLWWMc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 17:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhLWWMb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 17:12:31 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D41FC061401
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 14:12:31 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 131so6805619qkk.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mTTyYfcP/ojZZl1vuL3IIFjd7Mjcnnu8W+X+TEnGgqE=;
        b=Coo0oajbQ2py4wzmRWpdTO1e/yLGGS8Z5V8fQ5RWYjo3YQr1X3nakO166mIVmFhlF6
         uNEvjvPel/AKJIQTKrli/0FskLRfHrepSCg619CGsTzseVGrgvOgbP8q+ltyQ+tmh7IO
         89F729bdX4K8XSZ5uVwAiAHkl+oECOhs2dIacOgFXmOEbTD0oyt6nbZidfHGdNpbrUAr
         8WWvpRrvc56w0JRO0VQIwu0kIqmTF5eAZkqzccZ7iKk3BlymJu+x2K+SbFHeJn166FKO
         TlR9bqeb8mUIS5wgSy/z+ZUPmaqvXkS9h9pQWLZKysJSFIOWKL4O0zzgZg3Vu3ANszVr
         N2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mTTyYfcP/ojZZl1vuL3IIFjd7Mjcnnu8W+X+TEnGgqE=;
        b=7lbiF4vj35hUl7On9xH9jefHeGIzChzQuGCfDeAQ60NPACs2w2EuI38YIfLO+XrraF
         fU/5kDe5qaQfGmPJykxa494rgfT06Acos1RemQXChYI/HFcrc6Lk45yoTqfnvnNt9pim
         m1/hPvSx+Z0bSkNEuFvnbC51IwPShKVpU2lIw9NBA11EIIq+pjtSaUnopTJNViDA8R7v
         FPmoQS/TbZvo7/9HbdUlJXOMYvjIXiMti3ylalQ60fwy7UG2BlOiL52q20lRxT3a5AEL
         haqiRYh/7CsQUsra/Z4GqHS8hv8rcdutEAenHDFlPXjfDR4E7ntWhtyy1uiBWk/lAxO7
         o09g==
X-Gm-Message-State: AOAM530NSELrmiiwesV+AvwFGKZb2codot8RlvS0p8sIH6jIHRJXodSV
        La8jLAob8YHbtWP7kkGU+w15rd7614hMrA==
X-Google-Smtp-Source: ABdhPJwEov5duQTglH3bsm3yZNsqiVXfpKjWy0fWb/7gMsTdLcp5UjQlbxV/az66R5OPpkFZwnyLjA==
X-Received: by 2002:a05:620a:288c:: with SMTP id j12mr2894373qkp.66.1640297550566;
        Thu, 23 Dec 2021 14:12:30 -0800 (PST)
Received: from [172.17.0.2] ([20.122.142.171])
        by smtp.gmail.com with ESMTPSA id s8sm5471331qkp.110.2021.12.23.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 14:12:30 -0800 (PST)
Message-ID: <61c4f44e.1c69fb81.b9e4a.c3d0@mx.google.com>
Date:   Thu, 23 Dec 2021 14:12:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0135122632399305020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/4] build: Add sanitizer options
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211223195003.1647434-1-luiz.dentz@gmail.com>
References: <20211223195003.1647434-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0135122632399305020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=601103

---Test result---

Test Summary:
CheckPatch                    PASS      5.43 seconds
GitLint                       PASS      3.74 seconds
Prep - Setup ELL              PASS      42.12 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      8.43 seconds
Build - Make                  PASS      1390.99 seconds
Make Check                    PASS      11.98 seconds
Make Distcheck                PASS      227.47 seconds
Build w/ext ELL - Configure   PASS      8.57 seconds
Build w/ext ELL - Make        PASS      1367.60 seconds
Incremental Build with patchesPASS      3218.00 seconds



---
Regards,
Linux Bluetooth


--===============0135122632399305020==--
