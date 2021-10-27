Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE95C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 20:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A4560FBF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 20:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbhJ0UlW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhJ0UlV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 16:41:21 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D80C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 13:38:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h4so3162234qth.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vfE+GpH58SfPG+nauBKAXbh9ln28F4F7C9SEjF9njTs=;
        b=nY7jvB+fyNY9wHjCXiBqWnCOaRNW1MmLjIHSbMIubtjmQVOU7Al6/NKgPu/lzgDpoR
         qHEUcdSmb1dhqqg9mxi8lF4ii8VMZHvAjO8fp9hv4+xJM/KWWXDr6CmzJqmVyQUbic99
         lzauuWVGzyyjF998t7Mc3tjnIY2FOYdQaRN6wg8544OGsmDNBpJxmy5Eb45oqjvq/HOL
         Ttv45nfG5WlaNzk0vSdWqw6L9DfvcJ8R4fc4MElnhjr1JN/YN3Ba7yKsSLTGBqHgz3la
         CE7Nv/bISdqhwwhxBfZWpBQqNgi3RQKpiEJm1UeB+H++PhKeqfdpaYIwCWwpjdDL7IzH
         +r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vfE+GpH58SfPG+nauBKAXbh9ln28F4F7C9SEjF9njTs=;
        b=CAD5N66Og5Gg1/zMi2bcO5Ok4jYreWFjXMo1hglISEiUcjXyfGecABJTKrac5VfPsF
         rRexJVZIe0a1GNxtqVgMRjG6mwmxcSIpLMHcUEQ4PFFhiQSZ5OQMyJTmWMR7ADnFkPJY
         PitBF2bs8rhC+Cqc6XeK0wSXxbrm6fg8ufIfPSXZiXV9DgMrfm0+PTs1Mez367R1gmZv
         2oE/NuGI0L9lEbtbkGWU+Txs83g5lRUbcS1cjhPu047iQM+mfAKCcArS9rN8/93WctT+
         ojRV7oOO8DV7epSnQ8MmUimdybBqoka4D3/wLFl1lEECuSjMxcTHNKh/L6uGiT9G5+KY
         rxtg==
X-Gm-Message-State: AOAM532km+SPGxoAvX2EXTabe7ISuKV2fu6FpE/EOgySIDJhBFkwCCBR
        hn35vziNfS2JgO6bk0w9HIUrP5Owsd8tyQ==
X-Google-Smtp-Source: ABdhPJzvTJej3iQ00u0ejPaYaPXPls2/6O38QNkd0Ujg4dL2QbITi2IinwxX5TuGzR/8fmrAnu81Ww==
X-Received: by 2002:ac8:5a07:: with SMTP id n7mr52287qta.304.1635367135004;
        Wed, 27 Oct 2021 13:38:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.185.114])
        by smtp.gmail.com with ESMTPSA id a15sm650512qkp.17.2021.10.27.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:38:54 -0700 (PDT)
Message-ID: <6179b8de.1c69fb81.de3e3.58be@mx.google.com>
Date:   Wed, 27 Oct 2021 13:38:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2615879028939127869=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix not clearing error on update_bredr_services
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211027201103.1668266-1-luiz.dentz@gmail.com>
References: <20211027201103.1668266-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2615879028939127869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=571395

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.88 seconds
Prep - Setup ELL              PASS      52.02 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      9.53 seconds
Build - Make                  PASS      220.14 seconds
Make Check                    PASS      10.02 seconds
Make Distcheck                PASS      254.72 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      208.22 seconds



---
Regards,
Linux Bluetooth


--===============2615879028939127869==--
