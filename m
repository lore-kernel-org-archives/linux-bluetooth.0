Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 22:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B0461501
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 22:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbhI2WqF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbhI2WqC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 18:46:02 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32AC061768
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 15:44:21 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id x207so1944365vke.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KH76xyxQq7GBUr6jYmNQ/VQPn3/FPw8OrERTdvS1/4=;
        b=g+/qD4MKgXDeeD8wZGO9k6EJ6qM+yjRM4Z0hU5diBEOt9LaeMhf6uFLIzD5dUp4hAe
         P1SXJmS9OUFUm1L2NJXvsLbOIHVxvf3trSDA7GLAiV6g9Br6XYTZjkeSHgcp65sOKrRN
         07B8p3ykt/oiebqTaMOmIBukLotFZ9CISrtaCOYmp2p6tprQKRtateRWjKRiTnF1v1h8
         VneICI5g+wKfrk9yzJaXlrgwaoD2uGrXtW14AusUUaLqAvEWJfd4v2e2qDdAaJsozwhT
         bS+8zDkHVALX8hoLlzdWV6JekkP+6DitL6SMF1xVUIWyo4xxl7kxpcHSJhJ6zXr98Zgy
         AnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KH76xyxQq7GBUr6jYmNQ/VQPn3/FPw8OrERTdvS1/4=;
        b=IcjI1InPDz31joeUHHB2BqlIL8DwE4aI1H3ytb/2C1wVuUza4I4SPlQi0nG/vmvGM1
         QZl8myrp6X8biqcbym9AI3iE/y345nxagkcG97qby5LRuh9AN9J+rGImN2sedD7aGxOn
         WGIi6UGSYAz0b6QVnIgwArhwqLMqkx9aporKS0j/lkyVl2WYhuPAgB/KhzO/bf/fd9X/
         tvuOM9YmO6dD+yr7wnkeW4s5wJ4YkpWlz8Lvdg2Z2AiYHZ8sQ73ZYO1kdKUmv/0szwhh
         H4eqf9k1OSP6M1rfrjBirfHqzov9BlFSV6YlhRlesJOYahTQLwUtgVNcbz8/p/6q2e2N
         zS9Q==
X-Gm-Message-State: AOAM5313FN3QhY8EWST/EHFUuBeDXKCtHoAPN1ggybVWTK3fLu6k8Vxu
        QjHJztHhtrbqpbkpXXa1nSPBFo1nHsOgBFAD3It6iYC2
X-Google-Smtp-Source: ABdhPJyof7lj5N9SdWJBli1R9ph7dpoApuTGaWG8CU/VZomE4/K66r1NhhJeDePKxNmAzizexAw4JwPvuhqWfRaPdAI=
X-Received: by 2002:a1f:5c95:: with SMTP id q143mr2224076vkb.4.1632955459524;
 Wed, 29 Sep 2021 15:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210928013820.288289-1-hj.tedd.an@gmail.com> <61527e8b.1c69fb81.91cdb.2376@mx.google.com>
In-Reply-To: <61527e8b.1c69fb81.91cdb.2376@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 15:44:08 -0700
Message-ID: <CABBYNZKVZYnEKJ2A1Me6bSK_ndAR+N8EXf8qtinCoEuxXaFEJg@mail.gmail.com>
Subject: Re: [BlueZ] tools/mgmt-tester: Add suspend/resume test cases
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Sep 27, 2021 at 7:33 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=553871
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.83 seconds
> GitLint                       PASS      1.01 seconds
> Prep - Setup ELL              PASS      56.08 seconds
> Build - Prep                  PASS      0.54 seconds
> Build - Configure             PASS      10.62 seconds
> Build - Make                  PASS      247.73 seconds
> Make Check                    PASS      9.78 seconds
> Make Distcheck                PASS      280.72 seconds
> Build w/ext ELL - Configure   PASS      9.92 seconds
> Build w/ext ELL - Make        PASS      222.60 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
