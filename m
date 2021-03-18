Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24309C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 02:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C833A64F53
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 02:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCRCLV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 22:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCRCKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 22:10:49 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A434C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 19:10:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 30so2463406qva.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 19:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=D1FMcARfrtgREqRSQk703Vl/zKVW8Wp1LJdRdGb5Vqw=;
        b=BK5HRfEjniqUIOZMiV10lBmgzHAG3KAiUQEt6gMqdH+RDGLDkCJTv8BhRum/hp57Er
         26BhM7iP9YbrthPw8LdtCde4OiEzXOYF+bDzU5caHq+SP3CbkaRNeGbkFUJEC+HgAONz
         FdsRHYfbzPWWGSrwuxZZSjOo/oNdRSxbNpxZznTx4wBi00vjDn+gEspcxhYcxiyCCzkn
         NdrrkeipESI30daf5+t24EFtCiNoMDGrWWKPChstNHzXE2f6dqwxQBm2MYzvzppMPMJp
         MrHX775UTMxwVkIKenJwSfu138XvHo984m6kqQ50xVUNC3eAk4mQ78LUkWwiRVZCoOy4
         z+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=D1FMcARfrtgREqRSQk703Vl/zKVW8Wp1LJdRdGb5Vqw=;
        b=PuoKKUL9VfnHo05/5V+NIbfa1MzxsDV2EaBKhM61ZluHeb37eAuXNqdyRBQGgbcJth
         R9kufWgx35Cr6n0R3Xr3G5dk6dHDHZ4lvZ6E3DiN6LdVlM/7/1rfFg7wc09plR9ji6eU
         NvOfJDMcuZR6lvcEPWUh1Dka/OzZTR7q2svy2zrM4sFeIzB3/OTSjP4MyLhbBXyVA3KL
         jjwdDqIwufU1E3soa8fComPJYl2+uFsT2GWV9kC7iKDpjz0qjWlw5vWqQgt+HZdGnjHL
         qP48W3+wLoe3vC2jazytVr3ictoItv8OZhIWq1xnoRtFzZ2huYngi9GN/GojUO1UUa5j
         b04A==
X-Gm-Message-State: AOAM532s+qaNvCEoJbKLxsnC3ADv/Z+oYscPhdAz+h+gzs9htJnOkygz
        Hs5/vA7an1R4BiblajlNF3eo18r/ak0=
X-Google-Smtp-Source: ABdhPJy0C2STcGUaxpvDvUas1aK48L97W5jMgM2kUk5ilbxR6UdQcfTcjUrJyyu9iEMW5kqNl3Q6Ig==
X-Received: by 2002:a05:6214:1bcc:: with SMTP id m12mr2259574qvc.47.1616033448443;
        Wed, 17 Mar 2021 19:10:48 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.247.114])
        by smtp.gmail.com with ESMTPSA id z11sm745384qkg.52.2021.03.17.19.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 19:10:47 -0700 (PDT)
Message-ID: <6052b6a7.1c69fb81.fecd7.4bf5@mx.google.com>
Date:   Wed, 17 Mar 2021 19:10:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5420454992187342166=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: tools/mgmt-tester: Fix for scan response in read adv feature command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210318011545.407405-1-hj.tedd.an@gmail.com>
References: <20210318011545.407405-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5420454992187342166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=450367

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5420454992187342166==--
