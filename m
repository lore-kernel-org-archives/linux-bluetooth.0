Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AC1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16FB23A56
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbhAOT5s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbhAOT5r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 14:57:47 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8DCC0613C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:57:06 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i6so9719674otr.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PgeIwV3UrXHM04K5UHiSCEzQNZzbtqNfT0QwH1DtNQ8=;
        b=O/9wzlDmoMGh1WD/NElA7oAwS77YFzJb93l2R3WuyjpXeuyd2drW8LEZJCkJ4/B6Sv
         tvee9Zw4UeP9tUEwqj3cFibdMoVTzNwGhSwKO0gBUPMzkpUAOGVOODUPeJa8dhRLA0AI
         RM7NuLlEMlMGos4OHIqgB4kwTjVmtM/BgjPwAJyKpDiJBRvwfn/95Azwxf7h8sQLXhiN
         q8xR+ujRGVbJejz0495dYcZ2qaNphF/Sx9Dq7D6zlhmcy+usJ+kKhzoLaurrkABNRgcA
         c4h2MCB1M6GjYbhbejpJ8MBWbLEo/5pKC2nCyorRTQd2ydrMRU5PeK2TZra+op1ahGV2
         uImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PgeIwV3UrXHM04K5UHiSCEzQNZzbtqNfT0QwH1DtNQ8=;
        b=iiQi7G+8oBKFuHs76zSuzvA2E/W4oR0HFxG5HjcKjRSlSM6xi+KEAxQOtCAAw1VgJF
         rBYtht/s6vfoCbnsqiFeebCndI0KuAN2BFWPUz9VNcw6GzcLnWEyihzduon6LtMX58Y0
         MypDF7MKoxuI71X3XsaKJR07s/eSgpVUQbh6hPTjzcAnAmme+E3zoK3TJGTnqiDDue2q
         L5IZf6X86TNHpxS2YAdnT9AjA8BBCBhHEncrGQYSZ2HppnGxHN3NBb4jvnLS9R6GLSs5
         z6ZaqrDRfnPol3cL0KbwXNIMaVGkuHS53pIH9wivTvZ14AL2gJHy+Oz5vIQQg3Y1ls5F
         w1xQ==
X-Gm-Message-State: AOAM530r/WcO5TJHGyJN5vvYYM2fdvSo087H9+fHX1sbVOZHe3W/S378
        wfoiZH5ZH7l1bY/+llRLEX0hbCGMAbZFM24KH18fQ69o
X-Google-Smtp-Source: ABdhPJxXtGPx5s8obks2meBrGVtBh1drV39oSsBQgYWnHM2+B87AvsDw/44HFP/Xy3i5F4OSAtMp04sOwH6PGrdiq8M=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr9175104ota.44.1610740626032;
 Fri, 15 Jan 2021 11:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20210115190229.186479-1-luiz.dentz@gmail.com> <6001e9de.1c69fb81.f24b7.335f@mx.google.com>
In-Reply-To: <6001e9de.1c69fb81.f24b7.335f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 15 Jan 2021 11:56:55 -0800
Message-ID: <CABBYNZJpvLGY=tetYc2WsBp-JFP+Lb2KdBRQtL8E5=MRUZ-aZA@mail.gmail.com>
Subject: Re: [BlueZ] shared/crypto: Transform bt_cryto in a singleton
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 15, 2021 at 11:15 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=415727
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

Pushed.

-- 
Luiz Augusto von Dentz
