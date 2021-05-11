Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9653FC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DC5616EB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEKHDM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 03:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKHDM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 03:03:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA6C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:02:06 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 82so24996102yby.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qStSycHp7mkQ0TqkvAIzpx7xTVIY/vIzUunFu++Het8=;
        b=W1NXljisTzzUSLP//ElTSrHProMqiRyv/bLqud/1dwX7Ao9oK4BmMvPXsQIDw/SLlq
         zEIz6vCq6n42tXPpOjdHjRdT66gDM/NB/t7Kh/Pu3JujDnLs/MP8zOs0ImSR3qQZPYAm
         G6hayhnuF6MF6t96Pyj9YDWHPi/ZHlBCna5Qu+l8Rsfxl1tWzUqGRg3edRhdpq5Xz3Hc
         9KktvO0emUq9iMM0Tcuie3tbHHsoGJmPOd6rsS5jQmjX1j+75bry6MmXAmsJNZcPoprm
         OWrrujqs012faz1UWMRQussB/RqOieA5ADeVT1AUHseteKboAP4nJCG65XmrlRQwgGsw
         z2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qStSycHp7mkQ0TqkvAIzpx7xTVIY/vIzUunFu++Het8=;
        b=agmpKhH7ZXpUXxdvasAAQNqAu2igRbsBNd941X5r0DASAIzrHcUvQDt/H9alp4+Nz8
         ujpc6+JGnrdYUzpZyULdDMtUrTzUJpHH4FR+MnXoDiFYDvsi580TozzpIeBmt/R5fjGT
         7Ct3tBnot6Rv7UgdWzqm/BaiMv3iSqGCrJi9cpkYcgG4vXGXhfEsu2mmhZNowAM3vPGl
         CidVQDhKHbv+yvrDGhrizt3zm8CxOxd/TqM77DVRFTYdQahNhOnZLu67lFAuyEtu7odx
         SQXwsRoAOAqNnc5lnv22O+qquUfT3tQhM0TVqRSzEXT9nNMIFLERGBp79YZpZDNv1gjr
         6c+g==
X-Gm-Message-State: AOAM5309u1wG7OUOmzTei671cMdMi5o7rX2PvtPa5dsmXsT3gKDz1JcM
        U1w0Z1YNfg5bbgxXok3RKWCBrz6mMwBfRlujGNlDAWvbbNM=
X-Google-Smtp-Source: ABdhPJwfZ1hZZrTqUvNBfwJbXwU4JyyV3j3q4AdrvqZfSvP/gFzG251cxLMSAI+8Qk3HndPu8+b3YwwBxiTgoPelbfA=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr22868029ybn.440.1620716525576;
 Tue, 11 May 2021 00:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210430230501.603111-1-luiz.dentz@gmail.com> <20210511042654.8549-1-youling257@gmail.com>
In-Reply-To: <20210511042654.8549-1-youling257@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 May 2021 00:01:54 -0700
Message-ID: <CABBYNZLEiBzgM=Ur6YuFCNWu0w3E5nYN4ZBmQm95V=s9W9D8Aw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fix failing to init controllers with
 operation firmware
To:     youling257 <youling257@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, May 10, 2021 at 9:27 PM youling257 <youling257@gmail.com> wrote:
>
> I test this patch no help. rmmod btusb, modprobe btusb.
>
>
> [    7.661739] Bluetooth: Core ver 2.22
> [    7.661762] NET: Registered protocol family 31
> [    7.661763] Bluetooth: HCI device and connection manager initialized
> [    7.661767] Bluetooth: HCI socket layer initialized
> [    7.661768] Bluetooth: L2CAP socket layer initialized
> [    7.661772] Bluetooth: SCO socket layer initialized
> [    7.686106] usbcore: registered new interface driver btusb
> [    7.689317] iwlwifi 0000:07:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
> [    7.689789] Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
> [    7.694911] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2
>
> [  230.746397] usbcore: registered new interface driver btusb
> [  230.750827] Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
> [  230.756450] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2

The error shall be ignored in this case since it comes from
request_firmware we can't prevent it, if you don't see another error
after that means it can be ignored, that said perhaps we detect it
sooner by either attempting to stat the file or perhaps check if
revision comes back as all 0.

-- 
Luiz Augusto von Dentz
