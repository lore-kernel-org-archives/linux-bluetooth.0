Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbiC1UbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345874AbiC1UbG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 16:31:06 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DFD14037
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 13:29:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s11so13506424qtc.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NPaSt0kiSNq+lI4jY5DNblHcVxHa6Ejsyvo6kpWTn0k=;
        b=c/gy/kJeO2gNDM342qrENCn6To4DzfMA8Y0w4FNDlV+Mu01IAob4HdW8CIuTFha59D
         CvY7ssulxwZPR2AvxIWAS8crkV8Cf9rslOGJLLBre2rS5YMJybk/vC1EI7hC0z2hgr7q
         9h2UUAZcJ0odVCqXvvPjjLAwhBN/fd5JrF7lZv5kLdvHAlozOCgExqW5C4Y/31Z5PKyF
         M5Mg4paIxx//sNi7GcVCgkr8FGkbqClhw2ngw6iVEEQKfEh9MQyxTIlfXe2u7i1jq4OU
         gO+/n+tPE2XSt8pxi8uZTOVvryM2aUiLkNin6HMWQ1kxiaGxbDs5kpq4rzkop0vrYGBO
         j+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NPaSt0kiSNq+lI4jY5DNblHcVxHa6Ejsyvo6kpWTn0k=;
        b=4gq13us9HBJKzFRxy0VUKePHrIHLdStkJv4gvKj2FCYN70AC5wQGl20h8B63fOO9DK
         nxAujN+znjR84+8L7grYUPR0CXIPp1D6mcRZ8Aa07Zh4LxBgzHvRBzLI0nioGjd7+E5E
         cVRrLpuINZuxntNywHOZzhEOofEHbL7p5TV67otg7lRNLGl4p2dslBfgARA4plgfObai
         lztDNVH7p6B8Rmh083ssoE+AmQcvM5ZIWb0iwrfEexIdx4kUfqjZVMenDI5n63onGK73
         TL+rWydpqGdUAZ/lu/PP+S2OeYBgpR7XPqF0nZb3LJlcv8r2Hxzf06WrBVnp5Sb8uNjB
         6enw==
X-Gm-Message-State: AOAM5310MH//FfZbFFaUwlLJVgmeEbA8p4GAfznkd5d5Czs3VUHbC8jB
        h6ZN5ijfmPfAwLkB1CvNCuwfpvhHXEzlcA==
X-Google-Smtp-Source: ABdhPJwuD0KeTH97BfgFp7WUPUB6pCoKzF1FfGeNG7hkWbUqCNn98BoV/ByEnlf+amBEZJZswvnCJA==
X-Received: by 2002:a05:622a:1901:b0:2e1:d655:d426 with SMTP id w1-20020a05622a190100b002e1d655d426mr24260729qtc.159.1648499358214;
        Mon, 28 Mar 2022 13:29:18 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.94.210])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm13107151qtb.28.2022.03.28.13.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:29:17 -0700 (PDT)
Message-ID: <62421a9d.1c69fb81.24f59.212a@mx.google.com>
Date:   Mon, 28 Mar 2022 13:29:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3240244062906682920=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v2] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220328185753.161203-1-frederic.danis@collabora.com>
References: <20220328185753.161203-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3240244062906682920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626977

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      54.92 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      11.01 seconds
Build - Make                  PASS      1681.06 seconds
Make Check                    PASS      12.56 seconds
Make Check w/Valgrind         PASS      457.14 seconds
Make Distcheck                PASS      275.17 seconds
Build w/ext ELL - Configure   PASS      9.61 seconds
Build w/ext ELL - Make        PASS      1626.88 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3240244062906682920==--
