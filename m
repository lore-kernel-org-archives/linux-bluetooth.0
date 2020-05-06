Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B050C47247
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 00:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E34206E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 00:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B1U1KxOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgEFA75 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 20:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729247AbgEFA74 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 20:59:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253CC061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 17:59:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d25so2929529lfi.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPAW4bbe2M4P8Ml3BobukMtErUA+qywn9gXeW5XwNPU=;
        b=B1U1KxOWnSwTAG6qa4s0/YDP6q4pHeCW1opMlEGP2/U403iYKh/ZlV8cdwoznCiGpL
         tL5MD4Iq5atCC/5J2QuUVsc/rKOofbdG5wZeOE0DarEnTPtBTRNBul+/y19PFSZ+u1SG
         nJJS0HhLVhKs/GjwWeMKMZpoHPzyg6DBWdYT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPAW4bbe2M4P8Ml3BobukMtErUA+qywn9gXeW5XwNPU=;
        b=Z3h3ZUDH2x6+aMg5ZnUuEDkUWySBpeu8hrJEbeimSa3J2gjZQpMtFKaBBL6PTCITXd
         9v0UBmaIe7PXgay0AEH8CoARo1xQUonCuGiXFD0FvjO2Q/s493yS68XUp1jimuSSOfQ6
         D9MGwk6nb8rhR2lAkW5KRFkk4ZYt22BX2XdRr/Y8Z8k1Ss3tbHFR88Lo5ASXxZ9Au8q1
         dvP2Vfo5I3V445RyeZA5940vbUxRO55sP4LLcAQpDonDlP9K3CSOqAUEPxodZRY+Z9xz
         NPIVdvC7ZqnWMjSgJrX7VLG8ts47ALLjTfhadUMSAdS2oFy081jcoU/p7XChlxWp0TNP
         5lNA==
X-Gm-Message-State: AGi0PuYv9xFBRU29dQyh12Rrq4Cl3w55PqanlaODnVSmSwdwZ1WPObAZ
        9PfBucQLmRlVCzEwIMxL2d01tJ20buzScEk4GRNngtf+
X-Google-Smtp-Source: APiQypIH1oywXFbnBtWNi+cCSS/Kup4H3qds2KhaBfkXI/LF+426nmwpHDwNe4ORG94EoS75JiLXijyLIF8wVmVol4U=
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr3328850lfe.163.1588726794351;
 Tue, 05 May 2020 17:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200429203031.BlueZ.v5.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
In-Reply-To: <20200429203031.BlueZ.v5.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 5 May 2020 17:59:43 -0700
Message-ID: <CABmPvSG8ATtTSJdFw1nfJ5hpYkmFWPBQvXo6NRw3g25X_wYkiQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5] doc: Describe the new Advertisement Monitor support
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

In case you didn't notice this patch from last week. Somehow v5 was
recognized as a follow-up of v4 without having its own thread.

Thanks,
Miao

On Wed, Apr 29, 2020 at 8:30 PM Miao-chen Chou <mcchou@chromium.org> wrote:
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
> index 39f23c456..4aa755c45 100644
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
> +       Return Parameters:      Supported_Features (4 octets)
> +                               Enabled_Features (4 octets)
> +                               Max_Num_Handles (2 octets)
> +                               Max_Num_Patterns (1 octet)
> +                               Num_Handles (2 octets)
> +                               Handle1 (2 octets)
> +                               Handle2 (2 octets)
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
> +               1       Advertisement content monitoring based on Microsoft
> +                       HCI extension.
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
> +       Command Parameters:     Pattern_count (1 Octets)
> +                               Pattern1 {
> +                                       AD_Data_Type (1 Octet)
> +                                       Offset (1 Octet)
> +                                       Length (1 Octet)
> +                                       Value (variable length)
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
> +       Return Parameters:
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
