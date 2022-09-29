Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE75C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 22:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiI2WiA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiI2WhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 18:37:13 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B094D17A
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:32:43 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id c22-20020a4a4f16000000b00474a44441c8so1090723oob.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=xpfTAIntiWxQZOc5AlQrkRXAJUWwlTpL8kDzUQb0eBA=;
        b=QZJsh0r4qTxubayFaRwC6OiNi/KimsAJob9qPUpiap7QQEzP1R4ayJyA+SPMT6/Fg1
         ZUT7SQVa0I/1qO4eZBhc3KApCrcWh6husLk1xhq6rnjqBNolYNmCEYQt2fSKekWGFKlW
         pdHHeGjQzak5imBJko//NRbUFSuZSEh0TeK9mq0TPIR3XoBGSl+wPxvYlBf7iLJ84niK
         q72C8hmgEXBWj+NmxwN9r+a9FcxGdfT54NnUg44jd7aCuK9xoPNQhqniaV65Gl9xpb/e
         RHUceESJ1lpXLFZrTKgbV3byuIZIjptTqxqU4HpBJeThRjJm5/YX6D4A7i9NpVQs6zXL
         84fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xpfTAIntiWxQZOc5AlQrkRXAJUWwlTpL8kDzUQb0eBA=;
        b=z0JdmMVhaksZBf8iJ88grJZLo9LOfWhzdlKheLQm0C3DpiNMfECeGEZNHM0rQAFL1t
         rx+RxaZvBDVJtCvqMGFLwgl317fIKjm/HnJEngSxPuR8urVa+ezmy5C2HkRv+JfVpM1x
         CFhwS2tOgKSBttPTftZYw9p3PordnBpW1SAgdonK2n/gClDv7sH5Lhatll7R7TcFjeVS
         y8qEhi2rCP2Qsu+9nXdFFelRGqXo6xC/FsAso/7LZH1FMA8kbqwB5afKSxyadkg0eDvV
         HbLY79m26Z6+C/2yFgNM+ScxFfZNF2fsSVqU4wAcHoc+3wMnX+pIU9kGWWHlxuLTlrMZ
         yrKA==
X-Gm-Message-State: ACrzQf0cyyurIM8aZM73Y4HL2wWUc64owvzdlQwwXTAnzDi+HtQ6JzKL
        RnNoIgZ5jQrLvbRiKWCs6EQxJUrdDMg=
X-Google-Smtp-Source: AMsMyM6A8/MtgXEZTRpABbPYrbRC8YyQs8cj6A/9NpCEVpFVDbS6K7EgPpj7pzWOZBE6l6EDWK8oHg==
X-Received: by 2002:a4a:2243:0:b0:44a:e5cf:81e5 with SMTP id z3-20020a4a2243000000b0044ae5cf81e5mr2286494ooe.44.1664490762736;
        Thu, 29 Sep 2022 15:32:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.30.87])
        by smtp.gmail.com with ESMTPSA id cj16-20020a0568081b9000b003430d6696e8sm148315oib.8.2022.09.29.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:32:42 -0700 (PDT)
Message-ID: <63361d0a.050a0220.399d.0ac2@mx.google.com>
Date:   Thu, 29 Sep 2022 15:32:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6495572135682263903=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6495572135682263903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6495572135682263903==--
