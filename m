Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC14EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 06:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350794AbiDOGsf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 02:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350787AbiDOGs3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 02:48:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C26B3DD9
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:45:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e128so4003737qkd.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=f8lKGsNPta18yGXl30L5iJSlwqsB43FhhirLRE+ir0A=;
        b=jxQQaVrWMwFrT22rMmCh9e46hzuvCFQTDA3gWUGkUYivXG+WD85sJd2uHhHf/5qlKy
         i/5uZlTuCuZdw8F8gGom9ExwJS4mg8j7FOWeXHoPkfDlKUEFb8GU1RFlxOevxqNpmRPH
         qLiP1SeD5mMsxueQ3kuQde4C57PhcEOeqKrURnz3KRe3OhQ3NFVKdHV+KwnwkhvLe0Aq
         QKdzLkPnw0stb8hXlfhw74gHWu2+r1kFlbjt6wHkNz0zqpkxutGU4SrH+A7pboIxc6Fh
         0GYL8u3e9zNTPEjWUql+NfPHAnDNiSPJxhjUZ858A9/ELBoC7wAT00huicmXOx7faqjD
         /ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=f8lKGsNPta18yGXl30L5iJSlwqsB43FhhirLRE+ir0A=;
        b=GoLFkl6uJucGJPyeaMMwbPpchnCzZ6whDSTYn2KLuRvldVtCDsj3rY37Ske9eIg8RY
         IjPAN2WXG7BCjN8aNqbNVUoBTiCT0E8pRQffmG+mHe+8WYV9eD8joOFktY7+Fg3jHXY7
         6fyV29wq9/UY+z8QGXohnED1jr7ttD9RrfEgF3PM/zfweBpLNHtwrcbTef1ICZ5WHK2A
         Ww0m/bAC45uaoRG+lpcSTR6Gkt8tzICKXQe3vBEQ0RanG/zlxMf4O2q5RmU/DqEKcaJI
         6OWe5Iq+wQQiPzrRhKsXaouoKYsYtCWdPnhWiWvJyVqJC71e8z+hlbBxMi6+VW9yD8eW
         K0jA==
X-Gm-Message-State: AOAM5314I6IXRjzJjhzBasF4dWcpaBHuOlrk37BV/5Abwn+c9iNQ6GrA
        EmmL6+dpoCkcm60d4c/gni3xHTkoOhcO4w==
X-Google-Smtp-Source: ABdhPJyRVxR/hmc42f5phffvTEZiTKGxogMEH3b78zBTq2D2TtkEF6lJX3wtsxNwttZkgtnBPWQazA==
X-Received: by 2002:a05:620a:410b:b0:67d:d23f:13d5 with SMTP id j11-20020a05620a410b00b0067dd23f13d5mr4671118qko.705.1650005151883;
        Thu, 14 Apr 2022 23:45:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.243.52])
        by smtp.gmail.com with ESMTPSA id a4-20020a37b104000000b0069c2ba88bdasm2124937qkf.85.2022.04.14.23.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:45:51 -0700 (PDT)
Message-ID: <6259149f.1c69fb81.ca1aa.c52d@mx.google.com>
Date:   Thu, 14 Apr 2022 23:45:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2131442990130496328=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] policy: Change AutoEnable default to true
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220413222425.187199-1-luiz.dentz@gmail.com>
References: <20220413222425.187199-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2131442990130496328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632044

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      42.71 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.60 seconds
Build - Make                  PASS      1282.51 seconds
Make Check                    PASS      11.48 seconds
Make Check w/Valgrind         PASS      438.79 seconds
Make Distcheck                PASS      226.86 seconds
Build w/ext ELL - Configure   PASS      8.56 seconds
Build w/ext ELL - Make        PASS      1249.86 seconds
Incremental Build with patchesPASS      1279.41 seconds



---
Regards,
Linux Bluetooth


--===============2131442990130496328==--
