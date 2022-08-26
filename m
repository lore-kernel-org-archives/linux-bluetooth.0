Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF692ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 10:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbiHZKaF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiHZKaC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 06:30:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81B4DB09
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 03:30:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso7543720pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=qWbBKmpYX2i0LskIK7IXBk1p/Mht1vWwmIQN3MQq0QA=;
        b=Rk+vOAZI18WKWCRmth4spgRzhwYYJ47FpkYqpFE5EVUYfc2cR1ZywYlqsrUtNa/CCi
         PjxwZ1eUcX7GRUTG7mL9QhFDbnI7xkgxkEtadz3hYMGaQ7i+XwtJQogpmEMqaA31/XMD
         xY2DoxJAfe6/+4TMwKNGNS8ZW1qbKIrrZQtgRg/HB+y98VPiHM0E30ugh1gxSJi1TOac
         U6b8WFCTFvDg/xH4gXfSHnwUr0/2I4mwj6JvrA6F1KhxRveYqBX3LzjosX6PN+VRN27n
         GzBg2joML9sO30c0dpDYIzdFAv5JPlHigAhBa95tpFw318go48PaWnzz8efWymZXsHwE
         UE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=qWbBKmpYX2i0LskIK7IXBk1p/Mht1vWwmIQN3MQq0QA=;
        b=62DBQZCUmSpSJdWg2MUEKtgfhFpDD+Z64DNlroeSu+ZtVJzLCBqlmFLdj385OSM4xp
         sZ2etBeCrzTSJ2DpeD/lIS/s7IxwseWxIXjRvUe2HqF8nM7tE/zhrI1uGBBteEsGwKQ4
         KCzmPHfWOxJnxthxfaycYytUlZkfa2l/McVxGrUVD3eRh5PEPtFOek2jKJtuQQ7yuhkS
         N5mutaQZ2H+I4aTuQiAwxxlQIk97z/WdAJOTM8bgoRf5jQoxWqpCCxWxQ06haU60WMi/
         A0bwIOf7/BVfzLeTVVzuCzA5iMHTedg21LR/rnN17LqqYyJQpwYoQdHMXvnxfMr+9n7K
         RlAQ==
X-Gm-Message-State: ACgBeo2zGUm4a2V2Q/W8sM3Sv/KAq21Z+wg3SvAvPdpB7H3wkGjdTyhe
        oj5giDCnDxdv+PCwESFMnUDB2ZI93T3Weg==
X-Google-Smtp-Source: AA6agR7YG5Yyjj1v3v07Y7WodVpUiu10MKY64KvZ1tALE0yh/cg6AE+bMt9zMA5u5cyk+9/2xgJwbg==
X-Received: by 2002:a17:90b:38c5:b0:1fd:64a9:c994 with SMTP id nn5-20020a17090b38c500b001fd64a9c994mr1889638pjb.239.1661509800581;
        Fri, 26 Aug 2022 03:30:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.83.229])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902d54300b0017286f83fadsm1209070plf.135.2022.08.26.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:30:00 -0700 (PDT)
Message-ID: <6308a0a8.170a0220.879ef.1fff@mx.google.com>
Date:   Fri, 26 Aug 2022 03:30:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6862052981867720208=="
MIME-Version: 1.0
Subject: RE: [v3] adapter: Implement PowerState property
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
In-Reply-To: <20220826101509.124704-1-hadess@hadess.net>
References: <20220826101509.124704-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6862052981867720208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/adapter.c:643
error: src/adapter.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6862052981867720208==--
