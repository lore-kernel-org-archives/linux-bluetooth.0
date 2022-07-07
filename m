Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A03C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jul 2022 13:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiGGN3B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiGGN3A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 09:29:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A63136A
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 06:29:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id p11so13280291qkg.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jul 2022 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=n+66CbWgmREl/vpQCTxPqnD6dwlrKsWbolNQkh8ha9w=;
        b=CsSQFe70K1gsweYAgnsfhHu8dT1V8QXt5JenS+BAJnECbQ+lBQFCr+v4mEaAHKyOra
         xUzztNJwcMq7lV2HFrAQulEcM/SW7kSsFl69i0xFzp2vJFYsCrla9bbnzE1ig4VW51tw
         4D+t0uK83WudQmMhg72jOSyJZw5+xaqk2TZmlzZlb59yYbkhyl5Y5RMSiikPa4XcshZk
         KwnyAovjgRcdGjuKMiKIJq546MKhi210frONFNH2OH8YHTu+VQzN2VuKqm0RbTxTZ8S7
         0iSfC+BktyzEWuB61tyVimE/EFXplGx7DLmQfpo9rTZk4Vu8BuVoSinu9B/3gh1i6pcW
         IlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=n+66CbWgmREl/vpQCTxPqnD6dwlrKsWbolNQkh8ha9w=;
        b=4ZbK9uQKpeJvHjw3wGxL9iix2nWzVpE34Q5N7ziWKvkrKsFoHXtY33G++hoHvlYOxr
         nz/8mzkfq4paHkSnNXBpapjJOq+Olf+pgWqEZG8m1BFs7TeHYuTnDpa0jBPfN98zB9Vj
         JjHSIKI/buT3rhgbZN1QMq+YqCkIa2avbv7qXT5G4ayRMaaN+KKxYIVNegw0mZ32Un74
         cdxoJJRR42W1Eg/cowHcnrQajPKS7PEJ+eBM5LmxxzwAAS+8qbCQJ0fglgzQHnbZdpMF
         qsxqowNNoWF4yWQPqZIX+AG30iObdoDXk+yHxXgEHymu8O5UUnXj+Lk5Nc1JQQUh3CLP
         pTWw==
X-Gm-Message-State: AJIora/CTunDlfONENRHtqEIYddby17ol4lETNPK9za6aGrWU4eAw7Pf
        WOpBEP5MZ5DW2QLXRcimyNAZqs/7I8o=
X-Google-Smtp-Source: AGRyM1twubRwnU3gwjzOII/LDyvoCAL5zck6pDZFqlJHL5ugLEyuloJeF9shHyPwywP992gdctZhuQ==
X-Received: by 2002:a05:620a:12d8:b0:6af:590:457d with SMTP id e24-20020a05620a12d800b006af0590457dmr30247580qkl.496.1657200538954;
        Thu, 07 Jul 2022 06:28:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.117.47.187])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006b253a6dd1fsm15439574qkb.125.2022.07.07.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:28:58 -0700 (PDT)
Message-ID: <62c6df9a.1c69fb81.ae648.06a3@mx.google.com>
Date:   Thu, 07 Jul 2022 06:28:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9034096297599309020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix small probability problem
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220707124348.25184-1-wangyouwan@uniontech.com>
References: <20220707124348.25184-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9034096297599309020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=657391

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       PASS      0.94 seconds
Prep - Setup ELL              PASS      26.77 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      8.51 seconds
Build - Make                  PASS      932.41 seconds
Make Check                    PASS      11.63 seconds
Make Check w/Valgrind         PASS      283.30 seconds
Make Distcheck                PASS      230.61 seconds
Build w/ext ELL - Configure   PASS      8.65 seconds
Build w/ext ELL - Make        PASS      81.16 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      491.14 seconds



---
Regards,
Linux Bluetooth


--===============9034096297599309020==--
