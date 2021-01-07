Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE4C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C186623406
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 18:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbhAGSRR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbhAGSRQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jan 2021 13:17:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBCC0612F6
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jan 2021 10:16:36 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j20so7167444otq.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jan 2021 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+620c/QTbsGUBgK4Z0ms5xZDTRboPUQhBWSnRWnTkHM=;
        b=al2RgBUz/ffrwv9+WCiTuxtZVZ1Pd4Ch8MJmkd3D0gTtgV8kNwf4+/nQgMTR8BA2kI
         Hgh+gaQAiG6XD4ecvWUgJr06K3+w4Q7AjEDQQIvNk3oO11wQmrWXPmcsiT/F/8fctgVw
         oDujYOgAulM3KltiGmXpwOo0pe+VMpknpq6TpZ/2ntSPCjgYD9N1DIcQpM4OakZuAr1F
         BBVlk+onr+y9LFfEtZY8srjc3DCSDJDEFuGRoJXPa3/3/SzQzLuHFjqvPAdQl7oknlOw
         ZaKTrgje/BcmsgReCPZFsI9I214ZVWrPPGjarntPzW21HjjVROHuvzQnTm+mAR8CK5J7
         IWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+620c/QTbsGUBgK4Z0ms5xZDTRboPUQhBWSnRWnTkHM=;
        b=tZCJL63uBIljCWyeufbqQjiZD5wUOdazwYNyRiCZLSZEWSk83LwdHCqygAZhNAb97Q
         ocwWxaTNExBcYD+6nrAhPDyw9YioJ+KVNuoNIV9KElAnbHf5L9RSLLyb2qIEOMmhws5F
         TarunV9ghAZBH7P5xEXbzYPR1s85IGETNEZIE49QmKVUj5xHiOwDWQAqoo06ZApjI3mT
         cNr+VXkq4Oa3P0iwnYau3BqQ7xOgNw1f6y2ZW9VYQnlItc5bK8YGzPSMomHTnyqQwOk6
         +ue3lx+k0hXtNNftQNhyaJfEZDO+YtDatoFNPMS3IGJOCxSkM/5kQNJ8UG3SZiMzou9c
         BkJg==
X-Gm-Message-State: AOAM532GZRHaGzjH21gDe6aalXUmNq1feLslZU674oj2WsAt1CEu+6Sz
        9cjSwXunmtdQK3rOj9aVvlAdZj46eWgqIur97nnKzV+q
X-Google-Smtp-Source: ABdhPJw0Ldz1W1UlM8wjlGKgWSyZuzBvAhLiWGd4yw0gAMQolVHyXJnfzzHK6H9hDDWtqkm8NHKGNGEn7BqeV2NqNHA=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr7653828otq.240.1610043395118;
 Thu, 07 Jan 2021 10:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20210107014811.3812318-1-luiz.dentz@gmail.com> <5ff676b3.1c69fb81.8a2b4.8179@mx.google.com>
In-Reply-To: <5ff676b3.1c69fb81.8a2b4.8179@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Jan 2021 10:16:22 -0800
Message-ID: <CABBYNZ+oQnwV4PrOGV3cjN57JCWS+C9j9D6HVM6FTvebTvp4xw@mail.gmail.com>
Subject: Re: [v2] shared/gatt-server: Fix not accepting multiple requests
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 6, 2021 at 6:49 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=410281
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
