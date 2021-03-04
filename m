Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C0C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB29A64F60
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCDTlj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhCDTlc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 14:41:32 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2CC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 11:40:52 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id z126so31410312oiz.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 11:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tH9SiWbR7mbBMPr/Kpt4Qq0s7hSg7wfPiX6kQm/uWk=;
        b=WLInGgg8W6ywWPCwoTGxzHhQy6/DtdIIhbJ+eDbS+V7yVWtH4bqOR5k06UwmT8x3IC
         gJtO5d2vJDvr1/WlceM20BmJR2h56+7qYT44JsLpFhJ+VPCNNyfihEHn0Zu79hkAWm9N
         Kn6q3PQjt/Fyp8RES/+WIDZLRlqtf4/r+CzUnAVbBs6Gc8xddHeYS/hWIHGG7wsj6/r9
         bH25NxMJ8oQTSUdL0OS3JjyWUU93xjmn7E5Jk4UnR1sQOHxxuPUxDVRR9wE7G17yWHno
         +I9hsNeN3z4LB5kMO19LTk8EAL/smk4wzrN/D1j76uu40/GRymnI8nfDzQ7asbx980Yl
         lxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tH9SiWbR7mbBMPr/Kpt4Qq0s7hSg7wfPiX6kQm/uWk=;
        b=J0aZy26tmz/Qa97l3FemSxAqLSMn/l/uI0qB1zsW2B4uHGtLAliIRseRfKu2kQ6arw
         TmsINMGTOJaxP5Vr/8CKNDWxO2BHdXNyBQ3r5Ghej9bl1pw9yg8eVCIzc/n9qUPCCya/
         jJ9BRuz59/VlvsQtMtj/IdlVkzwqkbSzF/RZ+oHjn6+XYJK5fDrZwwcWFjn8aPBvv2QD
         AWAnfMU91nehywdUXjPQCosw2U3nDRvwf44pMQTnOPpv/qk2+PWo45BxLsPznEynOqam
         rII3wHbpSMxPnCzHq5MCDmF7CvijKkZK669NPHBP8xVvtWTff31WMyDr8+QsU4r1Y6o0
         Jy6w==
X-Gm-Message-State: AOAM531HAxfjjuY+OugZnIuWDFX33A+uWiYWZg4qoI2e+KZEoWvViKo0
        VlUDLY3nNQ/LHKoG6usO22fnY/FPuJ3v4DaRacL6NTolYE8=
X-Google-Smtp-Source: ABdhPJyxWoL503KwI3yI0QR4oKC/8UZKZNA0VuUzRCc+PuxN/g263YQ8x9HmHbq4oywxiQBuzvxUrAU1tVZ5wAiyEfU=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr4163100oiw.161.1614886851775;
 Thu, 04 Mar 2021 11:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20210302102506.Bluez.1.I4b5a2f5249af5dbb7234c6831943dbd8de7c271c@changeid>
 <603ed12e.1c69fb81.b0c65.097d@mx.google.com>
In-Reply-To: <603ed12e.1c69fb81.b0c65.097d@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 11:40:40 -0800
Message-ID: <CABBYNZK3k=yqWt2NMHf2qbxQOeEuFcR3ARFJ9khrDKOeN+TNVw@mail.gmail.com>
Subject: Re: [Bluez] core: fix a typo in dev_connect
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Mar 4, 2021 at 1:02 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=440757
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
