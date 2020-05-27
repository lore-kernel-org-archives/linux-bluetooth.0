Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8016C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 21:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49A92078C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AewgrwBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgE0V1C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0V1C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 17:27:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D874C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 14:27:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c11so28623151ljn.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5Db74v/hPJKYS7U9JsCbGvD5C6Doz/Q/n6Sl5zN03s=;
        b=AewgrwBhTTbmNXi+AgxiQo8t7su4gOi0qnvud91AfqiWJC/VQ/o+CNeR3XrGeC0BcC
         9IEhR6TLqpEBOfmH1Bp97YWOdv0t8Cjo/4yvAaYhiJ/qXM6pYjATmfPoVpGTE3F1T8ti
         JWOaTeM/+Fnq8vPRCXrQ2EApxdN2C7e39L704=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5Db74v/hPJKYS7U9JsCbGvD5C6Doz/Q/n6Sl5zN03s=;
        b=cz0yyPtKbgzblkjY6W/gkY5nIK2LrV1bsRjknGPYQXxF5HlQ4CZIDoe5wZLVTACjdW
         FTmxW0lS9v21tlL8D4FQlPeqP8crvh2S/ZO4yV+kncgYjuIeY/7ofS6Mye+E71QKRrGP
         lPj3wZoyqNe23Rlo7KYnn+XXbi2i/kdhrB8I5enG4iBAe4DqZFvhAugidwIhsJ89rvaV
         WKUuxr7SQ2hRpPC9Dz9S/y5ZgjpWEVUPDmmNyOtF1yoyfMVTnXnW/i9Q2zmqIgtKvey/
         n/UFGyoq0bfFPDiYhNQXh6CKlpHYUfTcRtXVMmZqyarFv3C0agYKbalk96YSVpjZ7fnZ
         676Q==
X-Gm-Message-State: AOAM533nve5dnANrAemXSg3ludOR6RQUCWvl32OezmlD5G6yjYau7Djc
        tfwMoQ5QQtI9CORDahLkxE5psZPLwJB4qYTP1dYplN1x
X-Google-Smtp-Source: ABdhPJybQdaoEwnPFhKCLibqK7IM0ySa2ZJvDQQZ+/yBT0RqzgvTTnuGlxtafpRgN+uVBLIx6Gpgc1oFxj0BtvspHVs=
X-Received: by 2002:a2e:9a0a:: with SMTP id o10mr3910366lji.359.1590614819594;
 Wed, 27 May 2020 14:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200518203627.BlueZ.v8.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
In-Reply-To: <20200518203627.BlueZ.v8.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 27 May 2020 14:26:48 -0700
Message-ID: <CABmPvSHEGPfL3wGrfKih6cK84NHwmcozG658a2Go4eBOpN+inQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v8] doc: Describe the new Advertisement Monitor support
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

Any further comments are appreciated. Looking forward to hearing from you.

Regards,
Miao

On Mon, May 18, 2020 at 8:37 PM Miao-chen Chou <mcchou@chromium.org> wrote:
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
> Changes in v8:
> - Fix bit index of advertisement monitor feature and remove a tailing line.
>
> Changes in v7:
> - Update command/event opcodes after rebasing.
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
>  doc/mgmt-api.txt | 146 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index b7c4db907..211f085fa 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3218,6 +3218,124 @@ Set Experimental Feature Command
>                                 Invalid Index
>
>
> +Read Advertisement Monitor Features Command
> +===========================================
> +
> +       Command Code:           0x004b
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
> +               0       Advertisement content monitoring based on patterns with
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
> +       Command Code:           0x004c
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
> +       Command Code:           0x004d
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
> +
> +
>  Command Complete Event
>  ======================
>
> @@ -4118,3 +4236,31 @@ Experimental Feature Changed Event
>         one through which the change was triggered.
>
>         Refer to Set Experimental Feature command for the Flags parameter.
> +
> +
> +Advertisement Monitor Added Event
> +=================================
> +
> +       Event Code:             0x0028
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
> +       Event Code:             0x0029
> +       Controller Index:       <controller id>
> +       Event Parameters:       Monitor_Handle (2 Octets)
> +
> +       This event indicates that an advertisement monitor has been removed
> +       using the Remove Advertisement Monitor command.
> +
> +       The event will only be sent to management sockets other than the
> +       one through which the command was sent.
> --
> 2.26.2
>
