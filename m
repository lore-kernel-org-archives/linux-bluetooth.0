Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A4DC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiHAVrD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiHAVq6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 17:46:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763A71570E
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 14:46:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r21so9092156qtn.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=/ReIPcxU/CrsRtgNWp+O0OBshfKA26ufFVbu4sIGeKU=;
        b=bKFGa7qWN7qe1lvmWsafaZt0zMBG3A+ne5DrBPumQjxQJvNhkzCdYtIVVBMBHum6pX
         peSRk1cQB4S5UXeJNWMTJCTHjG6Sn7C+/9uM5Jj69L5TtRmIXyjNaSZm+LoFCi7UQlFT
         Ra1Yps86IdxPxQT545a74MNfGhJgBSNr1IYKD7p79mzw2LQbPu1ZfXxh5et6oDCTFu30
         890gP9zvsyTo8p36HN0bs4xowe+t//3lX4PhH0s+4tAG7u59VNFi5I6S/oq+y6ld3oOy
         EUGIQzs0WWz6rAF7vpK9qHpxmqK09UAAAmCH1P5m96j5Sd/j5AZFglmPdZAU1qvHWl7V
         M5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/ReIPcxU/CrsRtgNWp+O0OBshfKA26ufFVbu4sIGeKU=;
        b=PttwKIJ/lsFkRoZchFrkSJg7zSmQ13iM0VuryQMDUwLKf4NTIL142MyMbGDXzkUqEZ
         Sk7vajgsgzGOsuhMC3ykpp+UjbedaJHFdB/hk19yGt3P7xGUrX0BVzZE3Y620mKupaO9
         pPY/7u6boI/v8FKyU6dH/hu46Uh8IRmS6VZqJUKjhTmMDtnpND3mhWmQB5Kc5NsPtC49
         FO5wPGd+pADF8mLfwf7X0dKcH1Hmnas/YfFDd1jqtTnXDz9W12lLPTAymP43ml9wR30Z
         8CeyYksEdTeu54s+/aWCKpYVw3a9E5YzZUpgIIurq7SCnxuzZHRjr7HmrfKgwj4XCu3o
         liQw==
X-Gm-Message-State: AJIora/T3ckm2y9tiLMWwmSealQUaVkqhumtuXdBBaqNy6KStsgWpgMl
        bYzXf+o5vl/DI/Z3GTVXYhZ2i5Xv2sI=
X-Google-Smtp-Source: AGRyM1tXkj/9Dgjw+b/J8nTICrB8dRosidCqxqUYu00s+IIlAUdzrY5Syi4hyoTNQ5slWq08q1D5ng==
X-Received: by 2002:ac8:5bca:0:b0:31e:f9e7:da2 with SMTP id b10-20020ac85bca000000b0031ef9e70da2mr15894703qtb.446.1659390416272;
        Mon, 01 Aug 2022 14:46:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.40.232])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a24c600b006b633dc839esm9344500qkn.66.2022.08.01.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:46:55 -0700 (PDT)
Message-ID: <62e849cf.050a0220.76794.a436@mx.google.com>
Date:   Mon, 01 Aug 2022 14:46:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2549653869779469137=="
MIME-Version: 1.0
Subject: RE: Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220801210609.2183766-1-luiz.dentz@gmail.com>
References: <20220801210609.2183766-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2549653869779469137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/l2cap_core.c:1992
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2549653869779469137==--
