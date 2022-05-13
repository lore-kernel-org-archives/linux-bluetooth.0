Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A446FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 03:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376874AbiEMDlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350532AbiEMDln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 23:41:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D92D33884
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 20:41:42 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w3so6258389qkb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 20:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/UHWsw4ju26zKrUSJZu5bfKgoqlQQ2NhWNUCg8aIV0M=;
        b=hdBsU4mRoRdVY942eyrrfV4wldqqx1yjzkOlRD+8N5sFkftjI56EqMbdBYA5GgCn6z
         JLrQDmlxSvIY4jX9h16BNWw7skgBJgw606kI+kFb3wpIkqkBCe/Ii+FdUU0XnSyvw0za
         Y2aX/n7191oZzc46K+Ohbtj3HPoDzpjAUM/FOH1VIWUR/B8FAl562YFMKItE4S0nnFKo
         tpnYC+QpgptVpFaM3z3m4F+RRXHqlWnc43H/0UmiTM989C1BtlFVPGWkRW9UCiM0RBij
         OupICFUzgQiBaO5k/yc9XPRg2Om1JBdjsEc6N+lgk7uV5khGni2bOGBYrZfWvDkVlHz7
         zwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/UHWsw4ju26zKrUSJZu5bfKgoqlQQ2NhWNUCg8aIV0M=;
        b=EuxlT71XGeo8JD4MJpFkXZoToHRTEoI87q9H1SxodL3wtKb7k06q21kSdiyE3bIvFR
         qcfmHf0c3RkGMgE1n4b1KW2IoWcCEmdjxgl8LKQrLvPq5XbYBt3u+Pv5qBcraxNzerb8
         k+pWX91Kk8YTYy4DQRlPjAUO4b57vl8pQ959Kw05G3PfsPibjNY+5Iw1HOAjFEdbM5gj
         vwPAjVCzlFfcIBLoP8WqG48Xn9UC/+b9exLY2YKCcfsaYgQAOmqXfc8uld1yT7FS7teW
         Lus5SfaXFQN49UMer1PnVIc1ixRXAcmNXRxf8vHaPtNSVn44fPJ/pLc1FWjl9X0oq+68
         MHtg==
X-Gm-Message-State: AOAM530Pz4TWxHVHS5/OG2VEnv3w55ANCKoLk+rrN2oxYFpNks+I7q/D
        4u2O44m3bYTIK6vjvoVq+uxBew1lerzgXg==
X-Google-Smtp-Source: ABdhPJyxJWGcnKPlC09NQqp3izgTmQBgq9PgTbc5S4kabURMtLU40Gvn56lFUqoRuozzgjoZBVgy9Q==
X-Received: by 2002:a05:620a:4252:b0:67e:8977:db80 with SMTP id w18-20020a05620a425200b0067e8977db80mr2298380qko.483.1652413301404;
        Thu, 12 May 2022 20:41:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.117.228])
        by smtp.gmail.com with ESMTPSA id 136-20020a370b8e000000b0069fc13ce20bsm784453qkl.60.2022.05.12.20.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 20:41:40 -0700 (PDT)
Message-ID: <627dd374.1c69fb81.d810b.4b4e@mx.google.com>
Date:   Thu, 12 May 2022 20:41:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2760188962973030745=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] hog-lib: Fix not able to read report_map of instances
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220513010359.1061926-1-luiz.dentz@gmail.com>
References: <20220513010359.1061926-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2760188962973030745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641200

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.97 seconds
Prep - Setup ELL              PASS      42.17 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.37 seconds
Build - Make                  PASS      1236.36 seconds
Make Check                    PASS      11.29 seconds
Make Check w/Valgrind         PASS      438.89 seconds
Make Distcheck                PASS      227.75 seconds
Build w/ext ELL - Configure   PASS      8.65 seconds
Build w/ext ELL - Make        PASS      1238.95 seconds
Incremental Build with patchesPASS      1263.53 seconds



---
Regards,
Linux Bluetooth


--===============2760188962973030745==--
