Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2655C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BFC64F03
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhBVS2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhBVS1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 13:27:55 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E47FC061786
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:27:15 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b16so12966199otq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ceCxSxdwVIXTy0wWtWRTIFBkpOArAvR8ysXdP9E5Dzg=;
        b=YD06gM6ULmd+7/P6W+pwaA35I9S9a1DmdKPFcXqYjKXFSWhzncwbXIMhTkMkLu7rdW
         wDbMVGtUy6lJVJ3tK/zUqAkTMh4SOQ4G6smJq3UeARC9g1BRFtWZZxKcXSn6rjkaz6xG
         7QTmKtjY96UbnDUMNAqWPRKYYKMuoAZNBkj407wuVwbsoLa0tnn9LUvXJVzugVl32SbA
         99FZYauJ/na944T2clozZo5ZgT7vGs/l6UjbfrxuswiBLxHjVdgjA4KMfE2lGgJ9L4kw
         jzbOH7FL+VswdmtoJ/S+fNJIhK1n51L4ynTVanbKB7WUsiZiuo2qFl4FZLfwZ/2eqN4Y
         aMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ceCxSxdwVIXTy0wWtWRTIFBkpOArAvR8ysXdP9E5Dzg=;
        b=nJPep0PdKYRDXGmCY/KtTPwxzwfwaYZdqzA7fupsIBUxPdBe7SdErHK9YFYSuZpt9n
         pXvebyfG4yVHdTecUQn5VaakIOd+MBwx2cIyFBxyJDOKJDN6+/BxSbG19M3+wOfRP/b5
         6Enb60R4P+VF7ffGjfuJcMa61Pe08PQUJDo/pXeRTc2m/0tLiXhwUFGTNFzTg+gIdOh5
         Mv9phxiHL/9/eLwSbOdQjWTJDtrwQs8fvlXjbIrLnAZTr8it3s1fBdVFZUnW08tkAzfX
         bE1ShkptWWbvYZWixFmzVYMt8psXsEZrIs4RWGZ/Mg65b7Zx2vuoLN9WalSKngRcUfO/
         OABQ==
X-Gm-Message-State: AOAM531UQXY0sBV6nN0alSAFSpHrcaZQT/xZtVEDXk7wDfzzlPQTgAsX
        L+vdTCJPq7fzn3AhZ89GvwmF+WkZs31URNDl6duNxJOP
X-Google-Smtp-Source: ABdhPJxLWvmLbZKXjOVH4oa5dnfDWinsWEz1/Uwww2FV7Qk90fD8vO7+cmWnlC/GKSXF1fBYlGK8hlgOUDDHTnJ/x5k=
X-Received: by 2002:a9d:4b16:: with SMTP id q22mr9452679otf.44.1614018434490;
 Mon, 22 Feb 2021 10:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20210222140727.Bluez.1.I127ac7b2fadba6ef4cce42360efd9b8129251753@changeid>
 <60335183.1c69fb81.117b2.74cd@mx.google.com>
In-Reply-To: <60335183.1c69fb81.117b2.74cd@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Feb 2021 10:27:03 -0800
Message-ID: <CABBYNZJk1RtyBxtOR0ME2tOJ+b8R2x_MK2C0gwjE0sz1fypoAg@mail.gmail.com>
Subject: Re: [Bluez] adapter: fix set_mode MGMT_OP_SET_BONDABLE
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Feb 21, 2021 at 10:41 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=436335
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
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
