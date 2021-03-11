Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA560C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7378864F8E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 21:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCKVRb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 16:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhCKVRG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 16:17:06 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F065C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 13:17:06 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u198so19700923oia.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skO2IRWlLBj32Mea+pwo4wllD2y6Wq5xMlM2t8195cA=;
        b=Lvqc50lCZXXTKibcNXOpSttwuOMnPAM22XpLZ7C5L/BAILwIkyyBkrvdLqGl/hxZ+S
         jZksqy9eu2HghUpv7mWH5mxIDgwfO05968lDvpGyFJIu8n2sumePHxkdADTxY9xrGgL8
         qWjQ9CJXHmydSWJPQQgdsaUQw1dioo4GovK5HYQK7q7E2f8ej9Z1MK3gxrj+iMo106HD
         WCNCi8PmyVvF8oVLMaF1Pjw4VfLkUoEH0srojNhMJ3AIEIZk9s6oywDHWtsqcqNNetvW
         YUpukdjuBk3r8femXZpLH4aj4ubzufX3SS4Ihyzw8J54VHflHc8eWUvWiBnZjRPpxB3U
         VMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skO2IRWlLBj32Mea+pwo4wllD2y6Wq5xMlM2t8195cA=;
        b=WUj+0BjPdKNMBst65Ga+CKLFWB5HvGwrJ+ZL4tM5ZO7TKlZvg+4yVn1NbGixLlSfij
         fwQWO9tBx27SihHMa46vrJWZZk4sHA7FkpCWdkN9GX2SIlckOk0I7kNaL3gaV4T6/nqS
         cwi2BkQVJoAkGib9+BqwbZghXTw2VwMcR+GEJMeX+9Tw9dMAauTqFI43IqsBHyKB3jwl
         wl7bOdW5heaQaLQbXMCXu6CoQGYaehblj4fil9o+6xPcb0VNo1sDLPrUFxBD3ARFTbX1
         S1g2scsEP+ICgxhLbpjNUBp9bo1KNLYsPZIELmtyLRwlzcVxTmooe9VS2vfmUENFqgYm
         CL4A==
X-Gm-Message-State: AOAM533VNtYtVFW5BGssNaZTQcglW9Y0pvi/Zp7rilIn4YZ/h1CP8ktw
        mk5D4k50rbosudbnROc0i2ZvfCft6gzYfdKUr8EBj1cZOla+qg==
X-Google-Smtp-Source: ABdhPJy7oqmQNvx1tzKwx1afMpVfEMcCFnsqkSVsBE9PgQgxKEVsNTDmUBJbCloMji7WQBdCGg4lieIHalJddkkZ6iY=
X-Received: by 2002:a54:468f:: with SMTP id k15mr7854217oic.58.1615497425544;
 Thu, 11 Mar 2021 13:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20210310221309.894602-1-luiz.dentz@gmail.com> <20210310221309.894602-2-luiz.dentz@gmail.com>
 <5976CE60-F269-49A8-B787-C5ADD6DB4CEE@holtmann.org>
In-Reply-To: <5976CE60-F269-49A8-B787-C5ADD6DB4CEE@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Mar 2021 13:16:54 -0800
Message-ID: <CABBYNZJx48Z+61LCosgXbZz-X0EnqhRztPrHm5zHeEqOsyKW-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 11, 2021 at 2:48 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This converts instances of BT_ERR and BT_DBG to bt_dev_err and
> > bt_dev_dbg which can be enabled at runtime when BT_FEATURE_DEBUG is
> > enabled.
> >
> > Note: Not all instances could be converted as some are exercised by
> > selftest.
>
> so you added the note and then still converted the selftests ;)
>
> Regards
>
> Marcel

Looks like I missed a few looks like I didn't have BT_SELFTEST_SMP
enabled for some reason, I will send a v2 fixing the remaining
instances.

-- 
Luiz Augusto von Dentz
