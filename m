Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 18:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245513AbiCOSyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbiCOSyL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 14:54:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730F12775
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 11:52:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y8so2068edl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opfa2o/q/qBMOGcy3HPvItQfleKcfEYUKqYkBa23h60=;
        b=qvymy1/Ski4pc3tLtHceya0HOKfhJDpB8oxo3CoSD37DrX6ZXYPMwJ3rQfx5do2WVe
         UvU/9DC70bJqU5eNg6RZwodUI9/KsmfDxxgRDYTbQBXc7i30h5bQOv69qjOTToWsULu4
         tYPV1L1f1qxg9zLJYRNX8voOefF0PtY1hhNtzhKpJKWre6atCvgXN+FBDpeYSyiqo/GI
         5IOqGD3kgRzhUNvLfGgaOyATP0sgMAtYx2C7yIdsCVLMWPrVvRifTMVYaigkv6MDaka6
         CmmPqylVz8G8wYPtR7L0HiD3qDlD2fZsiG8bCasy7Amkex4+TqwSAbx4r51QeoyA+50N
         Qr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opfa2o/q/qBMOGcy3HPvItQfleKcfEYUKqYkBa23h60=;
        b=alXwxzCXR80na+JPp7jaRPV80BzD1RLqhM84VaBmgST6gBr24kNPhezecIoKHyiunk
         bHS5X1mBh0gAVF/MTOw/yD2xmcP6dJCC4AXkzqj1XAQ47xhTLyXNzZPlak0MQ43L6m7J
         06kRZjwJzmhpTYe+QnZ1c+fF5SY6emsBj4Ix1Fc5m7+UGjwtBTAdozVJEvDh4FC97Q4t
         WTu+YSCF5Vm9kroDX5dqUC3wQTIEYdrfijmDtjVDbiTWI1ySf0aPaIUwBtq3G2azX/pX
         w2HmF5hHMBRC1Essxcpw2qBzxrF3uiIPhqL7gGvNIOllRnmArtKYzXe0sjiqi3t/ZGOz
         2d5w==
X-Gm-Message-State: AOAM531gm6JALfUY5bbzw7+B9P/PEInd8SC0kbg6uWU+QH0sOl3mVO+W
        IWK86Cb7ZGlt/iu+Mh/KbOzb5O+kaS0CKPBa47s=
X-Google-Smtp-Source: ABdhPJxH2OW/WfTgKbq3V8pYwlLDccTIckEyXBNpd5rJolf84JwSiuHh1fdLlpGv4KupZb+1WT/3j2T5nshRTmYB5TA=
X-Received: by 2002:a05:6402:5256:b0:416:97d1:a6a2 with SMTP id
 t22-20020a056402525600b0041697d1a6a2mr26351947edd.280.1647370377664; Tue, 15
 Mar 2022 11:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220315095129.15254-1-tangmeng@uniontech.com> <20220315095129.15254-2-tangmeng@uniontech.com>
In-Reply-To: <20220315095129.15254-2-tangmeng@uniontech.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Mar 2022 19:52:46 +0100
Message-ID: <CAFBinCCZ7Hqq=dSSYtd5UL8NyZMu5q2jJiTJkdTupwUy8yy5GQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: btrtl: btmrvl: Fix firmware filename
 for some rtl chipsets
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Mar 15, 2022 at 10:52 AM Meng Tang <tangmeng@uniontech.com> wrote:
>
> Firmware for rtl chipset is as part of the linux-firmware repository
> in dir linux-firmware/rtl_bt. Today, the rtl8761a_config,
> rtl8821a_config and rtl8723b_config files are used in btrtl, but it
> doesn't actually exist, which causes errors like:
>
> bluetooth: Direct firmware load for rtl_bt/rtl8821a_config.bin
> failed with error -2
These config files can be board specific. I don't know the policy for
MODULE_FIRMWARE macros.
Personally I think: if the driver tries to load a specific firmware
file then it's fine to have a MODULE_FIRMWARE entry. Even if this
firmware is not part of the linux-firmware repository.


Best regards,
Martin
