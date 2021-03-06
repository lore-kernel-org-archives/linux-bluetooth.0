Return-Path: <SRS0=qbbT=IE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF156C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 01:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF9E6508F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 01:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCFBNG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 20:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCFBMn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 20:12:43 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A2C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 17:12:43 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l14so524093qtr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=L9TTKfHZVEWdbcN+7AcdAJkFB32lS9stQ++fzlI7DW8=;
        b=lgI4kbyADsAv8lqRJD2+wRCuvS167DzPgjSDri0mQpNqL1q01U7zBa89Q7ymFxNZel
         vXHFJ8449rimEqtcNOZ2x8oEj0EJxnEDuleHlBoYaCK3vQXIlYaeaXuhfxYWjtS8gZV0
         plon0yNseS0uGoL9St9jA9WU0rRV0ICefDNStEI4T/4xC3sQN6WIXEMsfNHYxwByoUJ5
         WSfYpnFxJ8QvJl6qmBQAWypYc60ntTIyI2C8cKq73Wq0XSgDVv3BWjeMgtp0xl1nndUh
         glxDYBGBjxZRmvjVG40zYlFVxGax3bPXsPQw5jBd21xN/jvxSI1QNRz8L2VMGZOwxtIJ
         e2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=L9TTKfHZVEWdbcN+7AcdAJkFB32lS9stQ++fzlI7DW8=;
        b=swkZq6rMBySBfZm33CswVM8RZ8+YK2aTrUlHH/38ZUfkh10LBqFZxAU1I3M8ezJ/Ke
         w4tpi57LH8gp4dKqB6FaAVQjXy5nv29dejtoZRWrlZzoiyrr+E+DlB74rBcm9ywf1h+N
         ihL45ms1vhm6M029wQRr+wqrSL/Vszz6KKOmgDhltYFvM9CKBUVYKQsHyBnpS+aoaM7C
         lep+EpTmW8nuIvqSauXOfWwhqP6bud0iRfr9pGoB/v1GhV7TVo96iHLxWZPFbBqx3pQG
         4Enny2zaUv19ViSOFhPlwM4R1XjZoBYeG+vKphvaNOlXEJQ0BlaYPWPn0J70ni6sqp2A
         ntPA==
X-Gm-Message-State: AOAM530UXsayb3g927n3lCQKlKRYRMjEWV/Ar5MRE28t0kQVhY+QY5JA
        L/C+Y24/m8IMwtEaLcH2IIhpZkJ7/PmjDQ==
X-Google-Smtp-Source: ABdhPJxEuLFessiP234JqtLWxkBacE6TpyanXNOUt9KSW1Q2TWf04J7k3X8MsEq8jzmFFqGMgKKG8w==
X-Received: by 2002:ac8:7686:: with SMTP id g6mr11592819qtr.54.1614993162197;
        Fri, 05 Mar 2021 17:12:42 -0800 (PST)
Received: from [172.17.0.2] ([13.77.99.255])
        by smtp.gmail.com with ESMTPSA id f27sm3036769qkh.118.2021.03.05.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 17:12:41 -0800 (PST)
Message-ID: <6042d709.1c69fb81.5cc36.5197@mx.google.com>
Date:   Fri, 05 Mar 2021 17:12:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3767576125015389151=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: Expose extended adv feature support via bluez API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210305155113.Bluez.v3.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
References: <20210305155113.Bluez.v3.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3767576125015389151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=443035

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


--===============3767576125015389151==--
