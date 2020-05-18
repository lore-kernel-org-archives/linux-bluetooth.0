Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E962AC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7B9207F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbQm2vAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgERVR5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgERVR5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 17:17:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A64C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:17:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 82so9381922lfh.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y18vKrcmEKPppUBjrJbtG9UWZNophIPDoPWGhmstEJs=;
        b=cbQm2vAf4/ml/CVf8N2deMEpvDGhnkr/fYt5yhVYypt/NglKEY9BVkPfvPc20ILxqc
         JxFSqKubC/MgK86t883Ywx+KYD3v4TZcHyYcDfvhjjjjo2C5Pkv6vAqbJGQn2cPCS9ht
         xRh1xb2QqBwz8rxeHQPUGUrlj6uJ8lFLdce34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y18vKrcmEKPppUBjrJbtG9UWZNophIPDoPWGhmstEJs=;
        b=d+wbymwtjbAu9pMEsoBaQog/iGyKs0Xr/UnIviJG64Jj+gRw0GHWAdGjk2WZ5lamVy
         MSFf7QRBo2F/3bZJmf9oum273X8/OoYRIP9zBfh16SZC7xAkbVqrcSfJgoYO97Hay1AD
         QLQh55JA3TCkHwM2df3ZaXMITsCWUb3/g7Xzt/hSJWJHPg2eV7WCtwKZoE4svle0Zj4x
         n3N8WcRjKI2vNMMw8K4L4OpdzLQQUGTIGzCm/zZ6v7GmwzKKEpCT4kKj1CK3Pu/OveW6
         /dHLLao23D5O+NBDWkRw+iohkx8aQAIfuaae45JhA5LaX5ZrQIXW9Fto70nQzfSluI45
         6jmQ==
X-Gm-Message-State: AOAM5307enPf+YWcHMn3indSNUF2q4eUcjdSR9UhUMn/lBeH+M+QsZC7
        aX5/Oxn9U+4vUh2x5/LCdI5RT5SClL+CYuUVY+3f9cpt
X-Google-Smtp-Source: ABdhPJwnQJCTer0OpXmsamc12cJXIvKIluhGzpRpMqS4IOogG8iKmmsQiRL+0D8iWKRXCwVqxpeNNErRbmHb8RilJfA=
X-Received: by 2002:a19:5518:: with SMTP id n24mr13052050lfe.61.1589836674603;
 Mon, 18 May 2020 14:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200507145354.BlueZ.v6.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
In-Reply-To: <20200507145354.BlueZ.v6.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 18 May 2020 14:17:43 -0700
Message-ID: <CABmPvSFUJLfjZj139p_XaSobMYb49GUTBB1xDzGhiu5mQ-1knA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6] doc: Describe the new Advertisement Monitor support
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel and Luiz,

Can you help with giving more comments if any?

Thanks,
Miao

On Thu, May 7, 2020 at 2:54 PM Miao-chen Chou <mcchou@chromium.org> wrote:
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
> Changes in v6:
> - Refine the description of commands.
> - Add Monitor_Handle as the return parameter of Remove Advertisement
> Monitor command.
>
> Changes in v5:
> - Add more fields in the return value of Read Advertisement Monitor
> Features command.
> - Refine the description of commands and events.
>
> Changes in v4:
> - In Read Advertisement Monitor Features command, rename
> Adopted_Features to Enabled_Features.
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
>  doc/mgmt-api.txt | 147 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..3290cc76f 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,125 @@ Read Security Information Command
>                                 Invalid Index
>
>
> +Read Advertisement Monitor Features Command
> +===========================================
> +
> +       Command Code:           0x0049
> +       Controller Index:       <controller id>
> +       Command Parameters:
> +       Return Parameters:      Supported_Features (4 Octets)
> +                               Enabled_Features (4 Octets)
> +                               Max_Num_Handles (2 Octets)
> +                               Max_Num_Patterns (1 Octet)
> +                               Num_Handles (2 Octets)
> +                               Handle1 (2 Octets)
> +                               Handle2 (2 Octets)
> +                               ...
> +
> +       This command is used to read the advertisement monitor features
> +       supported by the controller and stack. Supported_Features lists all
> +       related features supported by the controller while Enabled_Features
> +       lists the ones currently used by the kernel.
> +
> +       Supported_Features and Enabled_Features are bitmasks with currently
> +       the following available bits:
> +
> +               1       Advertisement content monitoring based on patterns with
> +                       logic OR.
> +
> +       Max_Num_Handles indicates the maximum number of supported
> +       advertisement monitors. Note that the actual number of supported
> +       ones might be less depending on the limitation of the controller.
> +
> +       Max_Num_Pattern indicates the maximum number of supported patterns
> +       in an advertisement patterns monitor. Note that the actual number
> +       of supported ones might be less depending on the limitation of the
> +       controller.
> +
> +       Num_Handles indicates the number of added advertisement monitors,
> +       and it is followed by a list of handles.
> +
> +       This command can be used when the controller is not powered.
> +
> +
> +Add Advertisement Patterns Monitor Command
> +=========================================
> +
> +       Command Code:           0x004A
> +       Controller Index:       <controller id>
> +       Command Parameters:     Pattern_Count (1 Octet)
> +                               Pattern1 {
> +                                       AD_Type (1 Octet)
> +                                       Offset (1 Octet)
> +                                       Length (1 Octet)
> +                                       Value (31 Octets)
> +                               }
> +                               Pattern2 { }
> +                               ...
> +       Return Parameters:      Monitor_Handle (2 Octets)
> +
> +       This command is used to add an advertisement monitor whose
> +       filtering conditions are patterns. The kernel will trigger scanning
> +       if there is at least one monitor added. If the controller supports
> +       advertisement filtering, the kernel would offload the content
> +       filtering to the controller in order to reduce power consumption;
> +       otherwise the kernel ignores the content of the monitor. Note that
> +       if the there are more than one patterns, OR logic would applied
> +       among patterns during filtering. In other words, any advertisement
> +       matching at least one pattern in a given monitor would be
> +       considered as a match.
> +
> +       A pattern contains the following fields.
> +               AD_Data_Type    Advertising Data Type. The possible values
> +                               are defined in Core Specification
> +                               Supplement.
> +               Offset          The start index where pattern matching
> +                               shall be performed with in the AD data.
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
> +       This command can be used when the controller is not powered and
> +       all settings will be programmed once powered.
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               No Resources
> +                               Invalid Parameters
> +
> +
> +Remove Advertisement Monitor Command
> +====================================
> +
> +       Command Code:           0x004B
> +       Controller Index:       <controller id>
> +       Command Parameters:     Monitor_Handle (2 Octets)
> +       Return Parameters:      Monitor_Handle (2 Octets)
> +
> +       This command is used to remove advertisement monitor(s). The kernel
> +       would remove the monitor(s) with Monitor_Handle and update the LE
> +       scanning.
> +
> +       When the Monitor_Handle is set to zero, then all previously added
> +       handles will be removed.
> +
> +       Removing a monitor while it is being added will be ignored.
> +
> +       This command can be used when the controller is not powered and
> +       all settings will be programmed once powered.
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               Invalid Index
> +
> +
>  Command Complete Event
>  ======================
>
> @@ -4020,3 +4139,31 @@ PHY Configuration Changed Event
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
> +       Event Parameters:       Monitor_Handle (2 Octets)
> +
> +       This event indicates that an advertisement monitor has been added
> +       using the Add Advertisement Monitor command.
> +
> +       The event will only be sent to management sockets other than the
> +       one through which the command was sent.
> +
> +
> +Advertisement Monitor Removed Event
> +===================================
> +
> +       Event Code:             0x0028
> +       Controller Index:       <controller id>
> +       Event Parameters:       Monitor_Handle (2 Octets)
> +
> +       This event indicates that an advertisement monitor has been removed
> +       using the Remove Advertisement Monitor command.
> +
> +       The event will only be sent to management sockets other than the
> +       one through which the command was sent.
> --
> 2.24.1
>
