Return-Path: <SRS0=9bU/=4O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858A8C4BA24
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC5024656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 20:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqP9VdmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBZUkJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:40:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40929 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgBZUkI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Feb 2020 15:40:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so333360lfi.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2020 12:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgFkbxcVJcwLzLpd7KnVVQMOrDO22hFhKkLIs9IHl7w=;
        b=jqP9VdmEf/4C2G0sEQEyyV1OClgM8gGgBYsNAzVsYKt+DRlRu2vPUqu2CjJtBm4x5N
         h9QJszQH9TqzCMcyxaZF/OzK9XF5xX8h+SAM1VunvyssfZPyHuDeWyi8GmiE0zlDOiVu
         aARHkAkvrGk2ytVche43e7a6ITr/Kb+tc3FV5/HkADTHjZdcr/V5HpP2hJB+2MtoQIHW
         z31ZzMvT5EPUc3eynd2+UgLwDjl38x+gpBkXA1e14sJF0S5ozTq5G1A4TNOVOcwoYMQ4
         cxN5hiaUiCZJ2YpEZXOJ0mNGmoCVCTOM35lKdrCj/FI5vKH7wuVAa++SHmVWmUMnBj2X
         4V6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgFkbxcVJcwLzLpd7KnVVQMOrDO22hFhKkLIs9IHl7w=;
        b=UCORMN9P1m9JrAeAvWFvtV6jPg7y9kfW12zuXXADNyS9YrN15UlzPNyzSMYsBecyDx
         PxLHNMkC5vC3+Qz9hdCRy/4ST+6+w7qNe7xw2wR33MUgPhXX8N9syxhyJQXtW7q5bCkj
         kD+7erQZPm9Ul4kvj59FrzoaRXjJag8N4TpPrryitSAsA/gp6m6eiGBQY5I+qOpyUHWk
         BqZhG9jPL7EfCSzUyoW/C3N0wYJIjLfu1r5+uO7c0i0icpBMOEgxBXGqeE31NhzkiGKj
         VhyFpKYFdg/YSoxLDhb3gZs1u4NHJ40vSpBwNp5k62ZBJ58OqT1TmQnVY2g/aVRBcA/u
         QyTw==
X-Gm-Message-State: ANhLgQ3soQ7xl26eGopXC6t2YKgYoa3GVwsFwV3cJYb/bAdpBAA9TUhX
        fNglTGrRTqYNDHUV2n4IwrXtM7nujJ9MN6J2WZfBEg==
X-Google-Smtp-Source: ADFU+vt4agZFODNNVqu1R6lo12+6iAgHun/hGTQ190ePCbhoIiWBnpnpdghkkg8FsR2rF9rVqoc8Uu+0Rfzo4ngMguk=
X-Received: by 2002:a19:5e5b:: with SMTP id z27mr219630lfi.129.1582749606309;
 Wed, 26 Feb 2020 12:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20200224151935.169330-1-alainm@chromium.org>
In-Reply-To: <20200224151935.169330-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 26 Feb 2020 15:39:54 -0500
Message-ID: <CALWDO_V9DbS6h43b+_4B=p4-X+14tc9KgCPzGXJgeMyvKcEDPg@mail.gmail.com>
Subject: Re: [Bluez-PATCH] Add mgmt interface for Erroneous Data Reporting
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 24, 2020 at 10:19 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds the MGMT definition to support Errorneout Data
> Reporting.  This allows higher level application to query and set the
> Erroneous data reporting feature of the controller.  In particular, this
> can be used by an audio subsystem to support wideband speech.
>
After further consideration, it is believed that this MGMT may not be
necessary and instead rely on the driver's indication of Wideband
speech capability to unconditionally enable erroneous data reporting.
This patch can be abandoned.
> ---
>
>  doc/mgmt-api.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 1e59acc54..953c2793d 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -307,6 +307,7 @@ Read Controller Information Command
>                 13      Privacy
>                 14      Controller Configuration
>                 15      Static Address
> +               16      Erroneous Data Reporting
>
>         This command generates a Command Complete event on success or
>         a Command Status event on failure.
> @@ -3048,6 +3049,26 @@ Load Blocked Keys Command
>                                 Invalid Index
>
>
> +Set Erroneous Data Reporting Command
> +=======================
> +
> +       Command Code:           0x0047
> +       Controller Index:       <controller id>
> +       Command Parameters:     ErroneousDataReporting (1 Octet)
> +       Return Parameters:
> +
> +       This command is used to set the Erroneous Data Reporting property of
> +       a controller. The allowed Connectable command parameter values are
> +       0x00 and 0x01. All other values will return Invalid Parameters.
> +
> +       This command generates a Command Complete event on success or
> +       a Command Status event on failure.
> +
> +       Possible errors:        Busy
> +                               Not Supported
> +                               Invalid Parameters
> +                               Invalid Index
> +
>  Command Complete Event
>  ======================
>
> --
> 2.25.0.265.gbab2e86ba0-goog
>
