Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 00:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858AD6124D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 00:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhKKAcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKKAcP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 19:32:15 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3AC061766
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 16:29:27 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id l43so8521379uad.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3IcMLP/5aZqm0TMfrySdAWaqIHXGMzcO1toMn7PdmY=;
        b=hUt+3Qifl3zdcnEEdEotxgMDNqlmt+NIu50tLEjpIly8GcxioAWBWNG6o45nVC6VNk
         LgMgGFtW1H7cyKYQMaZaewymf1c6uEjkzEfbp8G3GYdpNn77oxoLg6fjHj7KeiF3TbSL
         9F7admy5H5raVRIMPh9bVNTimHrQ0fRNN1o8Y51Bg/RuEzLlFtAL/eOIllLdFiZC1uxm
         JAgH22lfyXoEcr8dQNI4AKbwWrrenzdBlPnFwnUibqKEWNqiVf9KTC+56P0qn4FWOSiQ
         TxmlyNU6/6+wxB7zXyXEPQC+hMSXZh+r1G1UtHTvN4ABvMa2O/6wjGKPbCU3nkSF/Yqv
         HbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3IcMLP/5aZqm0TMfrySdAWaqIHXGMzcO1toMn7PdmY=;
        b=UZz1uw7L2amQXGUdFIJ6CfY0JZ1ZYBNlEtUgDXbNrVr8RztlnPr8CnKtkkubNvyRCL
         j0EAJd95N09Edpacm/YOxqW4pgpqLkKR6GREM2ylEhDWrH7sl8yAmnZwzgMvLAPzlnUO
         yEjAOTw5x4NKezFceQ2IwSOKwyCd9jk3P7mxbp3WaoNsTuJ3L2QjOOhFOLDhKmA7tXjq
         NBx/Ov2NOlenrOiXrK0YnDrd6s1GvOoQvJedmnqtN29KsnPB2WfaJxNPZhFkl4tyiezZ
         irtPFkahA/ndBCVkX91/M2dbKBsq2ir9/B3lIL0sktgppTw39n1/cHO1jWHuOfY8Dngb
         iR/g==
X-Gm-Message-State: AOAM532dHv8tGaB7PzzN0645sm7BYntxZ7h+LjQxPMGhm8mThT+Mc2v9
        +xS/QlKLxxEHoZyg2iuuU9SNm88C/tDX+/DKxlMvzehxrCg=
X-Google-Smtp-Source: ABdhPJyZA7HXd7d+EAZ368j9eadgUVMdAhGmQj7ezF2SNlu1gnh+8fWk3gSXzi31x3Kh/r1Kz+5GVjHHbOYH/w7voD8=
X-Received: by 2002:a05:6102:c06:: with SMTP id x6mr4354372vss.23.1636590566582;
 Wed, 10 Nov 2021 16:29:26 -0800 (PST)
MIME-Version: 1.0
References: <f657c955-2a04-d6ae-cc10-3b0476a33fa3@systech.com>
In-Reply-To: <f657c955-2a04-d6ae-cc10-3b0476a33fa3@systech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Nov 2021 16:29:15 -0800
Message-ID: <CABBYNZLcCEPUuqrzeQRiOWh34Z+E6wAJB8u4tfwX3Pog9N5=tg@mail.gmail.com>
Subject: Re: BlueZ hciconfig: Segmentation Fault
To:     Jay Foster <jay.foster@systech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jay,

On Wed, Nov 10, 2021 at 7:47 AM Jay Foster <jay.foster@systech.com> wrote:
>
> From: Jay Foster <jay.foster@systech.com>
>
> hciconfig segfaults in the Bluez 5.62 release.
>
> The 'hciconfig lm' command, used to show the current link mode settings,
> de-references a NULL pointer when calling strcasestr().  This results in
> a segmentation fault.  This is a regression in release 5.62 from the updates
> to implement the appropriate language changes.
>
> The hci_str2bit() function handles a NULL str value, but strcasestr()
> does not.
>
> Signed-off-by: Jay Foster <jay.foster@systech.com>
>
> --- a/lib/hci.c    2021-10-13 11:38:34.000000000 -0700
> +++ b/lib/hci.c    2021-11-08 09:19:59.880207913 -0800
> @@ -323,7 +323,7 @@ int hci_strtolm(char *str, unsigned int
>       int ret = hci_str2bit(link_mode_map, str, val);
>
>       /* Deprecated name. Kept for compatibility. */
> -    if (strcasestr(str, "MASTER")) {
> +    if (str && strcasestr(str, "MASTER")) {
>           ret = 1;
>           *val |= HCI_LM_MASTER;
>       }

You will probably need to rebase:

Applying: BlueZ hciconfig: Segmentation Fault
error: lib/hci.c    2021-11-08 09:19:59.880207913 -0800: does not exist in index
Patch failed at 0001 BlueZ hciconfig: Segmentation Fault


-- 
Luiz Augusto von Dentz
