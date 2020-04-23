Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39198C5518C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 01:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1285320776
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 01:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DCPCgQQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDWBNB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWBNB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 21:13:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB8C03C1AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 18:13:00 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so3383806lff.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIxIDnkpkhXz/Rc3cKucNn2E6xJY9rIKzkCq4UkDqbE=;
        b=DCPCgQQbkwvxW+acPi2jNXJa75MrIF7s0fecTlKtK1XtknhlFTWaxIWPZcKmhZULS/
         Mu3ezsYSCJJtg7HVA1jzXPjqG6S7BM/KVr4iYjOeH4rZWDF0wsDxDh+VFRaHgfvBNoOh
         gwRIHrskoLJcBOKSlhcfbqiztk6YpqD1eMH+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIxIDnkpkhXz/Rc3cKucNn2E6xJY9rIKzkCq4UkDqbE=;
        b=LXqNaWa2gYOmkIPnersxQr/GNfYwoczukJY6gTow4Ld5NyWLt4uA03HnSO9ck6ixox
         TdGJjkWPyHvUvoCyaJah2ZNK/xR0BiJHMVBAy0s+EF8XVUHyHLsSdQWBL2xbHZFjAcmi
         Ecuj5ZpEyqZnQVeaA/xw2g4Wo3r4Sb5rfF+c6Rl0j1TjungUoZS5SNmFC3UQ0xtCmkZT
         5zzaBGXD2aDcMgf+oElbQ+OW3HDrqj0xcuOf8zhCMbaEzRNk+dkWGnAlzGCeFb6qWhC+
         Ly8p91afMcnu+NGvXdv92kZXs7hQtzXYCXwzny60dGt7kQ0o9azlD0PjBL2CYg7qGzQ/
         nURA==
X-Gm-Message-State: AGi0PuaAIOgu5t05pDmTEiMW/ytmdPK+7G6kJxkzQcpEqhcoiNPKIjiE
        QKz/PTMR5G1i91M0fmtefQDFB+b0yJmVKmAwSeB0LFsD
X-Google-Smtp-Source: APiQypKqN/FPs/eo8pxt/2mx0D3SfSWh2nPztdQgTnVZdw74iV+izYb5WHgupaY6HSsrNlls4QybxxsTCyQipmipsug=
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr797307lfd.110.1587604378911;
 Wed, 22 Apr 2020 18:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200422180939.BlueZ.v2.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
In-Reply-To: <20200422180939.BlueZ.v2.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 22 Apr 2020 18:12:47 -0700
Message-ID: <CABmPvSEFc+0Cm4CQk9vU3LJvjp57pFEFdbodpnKoLfLGxkB5fg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] doc: Describe the new Advertisement Monitor support
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please ignore this patch, I should have update the version number.

On Wed, Apr 22, 2020 at 6:10 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This describes the following commands and event.
> - Read Advertisement Monitor Features command
> - Add Advertisement Patterns Monitor command
> - Remove Advertisement Monitor command
> - Advertisement Monitor Added event
> - Advertisement Monitor Removed event
> Note that the content of a monitor can differ based on its type. For now we
> introduce only pattern-based monitor, so you may find that unlike the
> command of removing monitor(s), the Add command is tied to a specific type.
> ---
>
> Changes in v3:
> - Remove Advertisement Monitor can perform the removal of one monitor
> or all monitors.
> - Add Read Advertisement Monitor Features command.
> - Add Advertisement Monitor Added event and dvertisement Monitor Removed
> event.
>
> Changes in v2:
> - Combine commands to remove one monitor and remove all monitors. The
> refined command takes multiple handles and an extra field to indicate
> whether to remove all monitors.
>
>  doc/mgmt-api.txt | 118 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..3cef3edbf 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,102 @@ Read Security Information Command
>                                 Invalid Index
>
>
> +Read Advertisement Monitor Features Command
> +===========================================
> +
> +       Command Code:           0x0049
> +       Controller Index:       <controller id>
> +       Command Parameters:
> +       Return Parameters:      Supported_Features (4 octets)
> +                               Adopted_Features (4 octets)
> +
> +       This command is used to read the advertisement monitor features supported
> +       by the controller and stack. Supported_Features lists all related
> +       features supported by the controller while Adopted_Features lists the
> +       ones currently adopted by the stack.
> +
> +       Supported_Features and Adopted_Features are bitmasks with currently the
> +       following available bits:
> +
> +               1       Advertisement content monitoring based on Microsoft HCI
> +                       extension.
> +
> +
> +Add Advertisement Patterns Monitor Command
> +=========================================
> +
> +       Command Code:           0x004A
> +       Controller Index:       <controller id>
> +       Command Parameters:     Pattern_count (1 Octets)
> +                               Pattern1 {
> +                                       AD_Data_Type (1 Octet)
> +                                       Offset (1 Octet)
> +                                       Length (1 Octet)
> +                                       Value (variable length)
> +                               }
> +                               Pattern2 { }
> +                               ...
> +       Return Parameters:      Monitor_Handle (4 Octets)
> +
> +       This command is used to add an advertisement monitor whose filtering
> +       conditions are patterns. The kernel would track the number of registered
> +       monitors to determine whether to perform LE scanning while there is
> +       ongoing LE scanning for other intentions, such as auto-reconnection and
> +       discovery session. If the controller supports advertisement filtering,
> +       the kernel would offload the content filtering to the controller in
> +       order to reduce power consumption; otherwise the kernel ignore the
> +       content of the monitor. Note that if the there are more than one
> +       patterns, OR logic would applied among patterns during filtering. In
> +       other words, any advertisement matching at least one pattern in a given
> +       monitor would be considered as a match.
> +
> +       A pattern contain the following fields.
> +               AD_Data_Type    Advertising Data Type. The possible values are
> +                               defined in Core Specification Supplement.
> +               Offset          The start index where pattern matching shall be
> +                               performed with in the AD data.
> +               Length          The length of the pattern value in bytes.
> +               Value           The value of the pattern in bytes.
> +
> +       Here is an example of a pattern.
> +               {
> +                       0x16, // Service Data - 16-bit UUID
> +                       0x02, // Skip the UUID part.
> +                       0x04,
> +                       {0x11, 0x22, 0x33, 0x44},
> +               }
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               Invalid Parameters
> +
> +
> +Remove Advertisement Monitor Command
> +====================================
> +
> +       Command Code:           0x004B
> +       Controller Index:       <controller id>
> +       Command Parameters:     Monitor_Handle (4 Octets)
> +       Return Parameters:
> +
> +       This command is used to remove advertisement monitor(s). The kernel
> +       would remove the monitor(s) with Monitor_Index and update the LE
> +       scanning. If the controller supports advertisement filtering and the
> +       monitor(s) has been offloaded, the kernel would cancel the offloading;
> +       otherwise the kernel takes no further actions other than removing the
> +       monitor(s) from the list.
> +
> +       Monitor_Handle can be the following values.
> +               Value           Operation
> +               -------------------------
> +               0x00000000              Removes all existing monitor(s)
> +               0x00000001 or greater   Removes the monitor with that handle
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               Invalid Index
> +
> +
>  Command Complete Event
>  ======================
>
> @@ -4020,3 +4116,25 @@ PHY Configuration Changed Event
>         one through which the change was triggered.
>
>         Refer Get PHY Configuration command for PHYs parameter.
> +
> +
> +Advertisement Monitor Added Event
> +=================================
> +
> +       Event Code:             0x0027
> +       Controller Index:       <controller id>
> +       Event Parameters:       Monitor_Handle (4 Octets)
> +
> +       This event indicates that an advertisement monitor has been added using
> +       the Add Advertisement Monitor command.
> +
> +
> +Advertisement Monitor Removed Event
> +===================================
> +
> +       Event Code:             0x0028
> +       Controller Index:       <controller id>
> +       Event Parameters:       Monitor_Handle (4 Octets)
> +
> +       This event indicates that an advertisement monitor has been removed
> +       using the Remove Advertisement Monitor command.
> --
> 2.24.1
>
