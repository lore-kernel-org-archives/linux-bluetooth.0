Return-Path: <SRS0=Xy/k=D4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FCC55179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D869722248
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPmGzM8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444510AbgJUQrz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Oct 2020 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438600AbgJUQrz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Oct 2020 12:47:55 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02CBC0613CE
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 09:47:53 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id w7so701573oow.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kl3ukS93Y+C7sUZ/gc8WCCTv3ZdrG2VWemUndMBKV2s=;
        b=jPmGzM8M+BuzRx1U48MPn4m91B4jlHHwo1oDKh+w0cs8d5VBOfuGgSGiyu+yh4v64x
         pbHD7xCRBjLxwMl1RdE6bEfLiJYBEzpRA+VKvuV8u+mSjOylRzZghfdbR0PFaU4329LB
         C1IEL/TDdJHiCRCkH8oKhDsjZQQ7BZL0Xlwf6IU9Vfd9CS0w6pJU1VSjEOhCeANRR8T8
         15EVIxZK3SOoD9yrrf1S8i2kFlZi7r8xtggVoTibArHXQ6RXBW/4gjDlRXf0oCRio3UQ
         OxCQOUqzunTka22KjR/CamPi0KOde2B2sojRM2zIdyAan8MwoQHK1NRODQMPBO6J8xoW
         ieFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kl3ukS93Y+C7sUZ/gc8WCCTv3ZdrG2VWemUndMBKV2s=;
        b=SZo0TPzEtebbJfCMdeP5FUoFvp7wsMQebtUiVNK7KNLjXgi87tXY5UQuGmUMqPD6SM
         /BC5HxrGpfCQZfnCCrDpMqVuqW7hnPp+AiOLso6OvVZnjfoVhrVWYYx6W0HwF7u5BnrB
         bAXZsJuHsFPpO61SuexuVBG6OwgnZT0Ga87buxiCfrfqC/MqBiIB2w1u2QQNGK8zu2PY
         1jHXxXV/JINriyZtFmOWHumZynW2zOGbEJ+MEqDCByTPejYRhhkLiEw9dqqeHS4BOJwF
         MOCRXDUijSvyjRXJlYxvlRvif2JCAa7WFKPtMYWsh/naEgQqBgcVCQD3rMgnPPcdMDVJ
         7J3A==
X-Gm-Message-State: AOAM5323WB0wwsIBycBqbgIqZDi5UeunjSfsYrK1TUX3lxuJGndqkbwO
        GR66aI0wR1vkOp3Ogg9lpdX3QGvGALRGkRHbO6JSQ9Ng
X-Google-Smtp-Source: ABdhPJzfuBQFLX0zUTfh8xwsHtFSE7uJov0kvYCJ+bG70LEEuz2PBz7mJ5Oed6/MzOzYlO2Cm3BrH0N4ElfkRDnVgOA=
X-Received: by 2002:a4a:5385:: with SMTP id n127mr3219709oob.63.1603298872705;
 Wed, 21 Oct 2020 09:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201020180230.Bluez.1.I67bbd887ee5c0b214a77cb0ed8f9e1d3812ffe73@changeid>
 <5f8ebd43.1c69fb81.78a60.5ecc@mx.google.com>
In-Reply-To: <5f8ebd43.1c69fb81.78a60.5ecc@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Oct 2020 09:47:41 -0700
Message-ID: <CABBYNZKGdFyy2vWb=zkf+bLzqe0uaxcnQpqVAb8nEDtLt+PYhg@mail.gmail.com>
Subject: Re: [Bluez] device: fix temporary_timer double free
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Oct 20, 2020 at 4:30 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=367425
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
