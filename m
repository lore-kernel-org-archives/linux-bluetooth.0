Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D6DC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 02:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CF821941
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 02:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa6hbvzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgIJCl4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgIJCHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Sep 2020 22:07:31 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A2C06179A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 16:17:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i17so4095887oig.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjnyjKd25dOcqGH9+s24M9hfWxRB0eNJKTA9Gi7wA6I=;
        b=fa6hbvzhSU6l05lBT6QBfJzUoJpXUw1f8EljefohFjMJmbo65cAtsHIUgyJK5otEBn
         hKq8gC0cTPhmPsXqmd0kdAcAauReMkUbZ1zsuxLsh7rz44cV+yC86WVRVWs2xdHeWEnS
         scVZy8k4bgHNYDscHJKipiTKD4thWuPxlQxJj3dYas7qyZLE72EhUFl8fcGvad/3ZmU+
         PtyiMPqvHGQaF0voUfB1o7vFRkiBkHo+CAbwqmtFndJG9OF8r/Ox+ojujv4aC80EFDY2
         xf0d8rMwTLPx1KhKGsUNzrWYP/y8zrML9VbpSl7ULqLsiUQNkBldOXp15BCiScMEdtUl
         vlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjnyjKd25dOcqGH9+s24M9hfWxRB0eNJKTA9Gi7wA6I=;
        b=S0krRJ8gOUnrvhXJZpCEYDwyCJcznmq8e9R464pAei18C0YFfHOZtm7sijaDp/XSFU
         fo5Xsu2NYjlRN4fHRss6WtFedk9etDbrFCeDTy1UmyTZijsE3mxC/6fbkfRkffk0HmFR
         VIkZ0o6Jhhrp4somKpbv1QHaez6xSJsc4oZkTMTpOhykPwkUxog4NTXbpXBkQARHMqSO
         n4oCuCpumTW6SNhoCL+SB0+yJ4tVEpJF9EhT+H0LB4F2/UpT7ndvRliaUE2lxt6XlxAE
         Lg19bOtfbw3/eMGox/bXk1kIDLtRopWL8w4aWoIXlxqsfjVfYbcXGPH1d9VMFYqGuxZL
         7M1g==
X-Gm-Message-State: AOAM5327meC161Lhs5D4CPt/M8uyKsjSR594YAKicDwTerPjC/ou4lck
        I8gxFLus68HUj/P2+qKqUIJLTAUWKZ/s4mPtT3QKnq3u
X-Google-Smtp-Source: ABdhPJzyy7tre9zx1WHEu93cKQpqz3KqB/Mvr+tjTr2n1B2zC7SM+K0kMBQubfxWQ6byxJAtCCppOkxXE73owtY/+/w=
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr2012232oie.152.1599693476783;
 Wed, 09 Sep 2020 16:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200909123943.BlueZ.v2.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
In-Reply-To: <20200909123943.BlueZ.v2.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Sep 2020 16:17:46 -0700
Message-ID: <CABBYNZKyxXQY8H+M1iAWvti-s5J7VejeYEJDqOfJCJEZ075+4A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] Disable auto-connect on device remove
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Sep 9, 2020 at 12:40 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Auto-connect is not disabled when a device is removed. So in case the
> pairing is cancelled, the device is removed, but it stays in the kernel
> auto-connect list. This causes future advertisement from that device to
> trigger a pairing even if the user has already cancelled the pairing.
>
> This patch disables auto-connect on device remove.
>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> ---
>
> Changes in v2:
> - Disable auto-connect on device remove instead of pairing cancel as this
>   is the main culprit of the issue.
> - Updated the title from "Disable auto-connect on cancel pair" to "Disable
>   auto-connect on device remove"
>
>  src/device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index df440ce09..8f73ce4d3 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4447,6 +4447,11 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
>  {
>         DBG("Removing device %s", device->path);
>
> +       if (device->auto_connect) {
> +               device->disable_auto_connect = TRUE;
> +               device_set_auto_connect(device, FALSE);
> +       }
> +
>         if (device->bonding) {
>                 uint8_t status;
>
> --
> 2.28.0.526.ge36021eeef-goog
>

Appled, thanks.

-- 
Luiz Augusto von Dentz
