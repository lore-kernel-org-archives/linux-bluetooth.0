Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BF9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D9520770
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhADTK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 14:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADTK2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 14:10:28 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90495C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 11:09:47 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q205so33252746oig.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9mFi+OzQFrsjagLVDzoiKc+d/nFgX3Is1QAvLppaPs=;
        b=G0DFXF6Tp+tFdNjxpeSa0Zc8ybnffHp5LauHBcafFMETEBwiuOE+Kg4Nr/EsuFjYiF
         wQ5LISDtFP5NxZsBdOnTzO5EBOq4ZpCVjSfvpko7sSq9EUrf9jTWfxnO5LRhRZLO0YwM
         jFRxey+34KfR7hO6jnXctSCSAjnqzQ9Xg/t2CcTZpOX3oQqNy9Ds+2X2D8Cbw1kDr/D7
         aGtVJD7q8Ic7eDjbJnyivODgpQKly6IPZ5o0a/3ztnK7FGGXsvVZIGQPNa9jOyU9iuYE
         uv06ZYm8UaIlUy/JmRjZth9nEAaO8p75Eh4jExm7z6A6q9RzLTFZRlzpeGvTew1HW3Ej
         oFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9mFi+OzQFrsjagLVDzoiKc+d/nFgX3Is1QAvLppaPs=;
        b=WvfwQwxekYKArNYYwM1Zxr0xSMco2k8g5ywHItbSOtyejX1dkMQBRtpYpuBV4nTbjX
         4PTE1tTiWGKQqmomO2eglfH9k+UgMnfI5tYemj/bJH7L+gdQnVSFMR1brkTuvZKaD0fm
         a8dVPTlR2AqskNMJqYJrmFL04ZjrT1hirfffaV5VWB4SBZRh1K6zsRvNexgMquY4ezTN
         NUyHWx1AWzfUiGEq8b2xWRFYGuLG/l1csruBbYcCNZylui5zBgocJdprW0Ds2W7oZfRH
         1haQx9oB42V1yRU2W3/mlZr/eVvs3VOyo80Jk5CeffdEOSEmQhNX+ISEB/SkWBKafb1u
         ACmQ==
X-Gm-Message-State: AOAM5317xPuIlc33tjBxr/BgM5ghG1DsktqexFQIiF7ORSLO/6Ptr9Eo
        Ev9ZlRbK+h5YVvMDllfZOBtWSCLUin1X/wOyfak=
X-Google-Smtp-Source: ABdhPJwI4KCwRFqCvUJw4/RCT0cYaJgyuxRTe31dLNrPzDpT2vCmE5UBJE7AHHJCDV6LoW6ae9Rbe3iFDFINQ8w/uxg=
X-Received: by 2002:aca:1917:: with SMTP id l23mr284700oii.64.1609787386985;
 Mon, 04 Jan 2021 11:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
In-Reply-To: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Jan 2021 11:09:36 -0800
Message-ID: <CABBYNZJ8HOLJv6HFCCp1AYMw79nu7rpkQdmLLJR=uvC5CRH03w@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: Don't remove device if adapter is
 powered off
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Dec 28, 2020 at 10:34 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> If adapter is powered off when a device is being removed, there is a
> possibility that the kernel couldn't clean the device's information,
> for example the pairing information. This causes the kernel to
> disagree with the user space about whether the device is paired.
>
> Therefore, to avoid discrepancy we must not proceed to remove the
> device within the user space as well.

This sounds like we have a bug in the kernel, aren't we calling
btd_adapter_remove_bonding or is that failing if the adapter is not
powered? Hmm it does like it:

This command can only be used when the controller is powered.

> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> ---
>
>  src/adapter.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ec6a6a64c5..a2abc46706 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1238,6 +1238,14 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
>  {
>         GList *l;
>
> +       /* Test if adapter is or will be powered off.
> +        * This is to prevent removing the device information only on user
> +        * space, but failing to do so on the kernel.
> +        */
> +       if (!(adapter->current_settings & MGMT_SETTING_POWERED) ||
> +                       (adapter->pending_settings & MGMT_SETTING_POWERED))
> +               return;

We might need to return an error here so we can reply with an error on
Adapter.RemoveDevice.

>         adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
>
>         adapter->devices = g_slist_remove(adapter->devices, dev);
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
Luiz Augusto von Dentz
