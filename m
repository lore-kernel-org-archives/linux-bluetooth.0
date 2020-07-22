Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26EAC433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABCF20787
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fhLZ/Ya/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgGVDTD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgGVDTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 23:19:03 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF36C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:19:02 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k7so398752vso.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msnUWH+TlT3OvBHqrc8dcTnpYvjDPCiZd6MOKcGt6yo=;
        b=fhLZ/Ya/fXEsadc4ZkOXfRtFfbH45MVSgVTu4fDNgzstBzSQPgo1YCiCINjEGIM5z8
         HCHiXzfBnDzNR79ddpJTDmqO/SxZVHdVUtGxIvFRIb5J0Zwo5IMd+0+GF87MX5+ueRjy
         kMAlcep8sMJkzaGILuwtv4bNFh1Ow83dwTVyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msnUWH+TlT3OvBHqrc8dcTnpYvjDPCiZd6MOKcGt6yo=;
        b=P4vSAN6dOXs3ogTmd3BcZtT/HCSYG24MEIndnQGzLE9S2u9KyZm78FYn8hYsF+zSwM
         GLuFvBfXT4G9hFRO6Du/Qq1s567oR3N3P1XiYDPz+6LYhMDBAdGifHubXImTBjZrm1qw
         uusXNHQzNXwM427ORg9rxrC7gurHJRqJveABI5aXt5KFj0NgqafFwBUjMcYPGTcitBzS
         T/YM13E5SFvhtzizi2iLymthV9KpxEww0/ESHz6uCHBO8ZvYkYmSV5PssTi/mB5oZCDg
         XwXi/TpCBce4SoS4IB1qAEbyq2GWm2At0Vlw8RUC1ewD0Mrnbfv2R9o9axSLpCOWFm8c
         wvhA==
X-Gm-Message-State: AOAM530xWicId4WmfQb/4CfItr+RtoOc4E+Tuh0XNc4ecZ+2w9i3wWNr
        /KHk0f7FHIiY2rsYtAoxzcgFo5/P2EITbZ6jr0l99Q==
X-Google-Smtp-Source: ABdhPJwXGOpkro1pNwYymoO3cxCJfjOkPDDFv8cui6cm35shb30xdtYO/HxpSfooij9etavppczVU3cmkYIbRa2l3IA=
X-Received: by 2002:a67:fd0b:: with SMTP id f11mr21027225vsr.93.1595387942008;
 Tue, 21 Jul 2020 20:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200714125120.Bluez.v2.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
In-Reply-To: <20200714125120.Bluez.v2.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 21 Jul 2020 20:18:50 -0700
Message-ID: <CANFp7mWRZWnC6FB3noMq8NBpgT1J7EfYe1-n8_FxpY5LQaSxaA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] doc: Add Suspend and Resume events
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Please take a look at this v2 patch.

Thanks
Abhishek

On Tue, Jul 14, 2020 at 12:51 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Add Controller Suspend Event and Controller Resume Event to identify
> suspend or resume of the Bluetooth stack has occurred.
>
> Also update Device Disconnected Event to indicate a new disconnect
> reason: "Connection terminated by local host for suspend"
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> Changes in v2:
> - Moved Wake_Reason to first value
> - Reduced Wake_Reason to not Bluetooth, unexpected event and remote wake
>
>  doc/mgmt-api.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ca0d38469..e7a713824 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3834,6 +3834,7 @@ Device Disconnected Event
>                 2       Connection terminated by local host
>                 3       Connection terminated by remote host
>                 4       Connection terminated due to authentication failure
> +               5       Connection terminated by local host for suspend
>
>         Note that the local/remote distinction just determines which side
>         terminated the low-level connection, regardless of the
> @@ -4577,3 +4578,50 @@ Advertisement Monitor Removed Event
>
>         The event will only be sent to management sockets other than the
>         one through which the command was sent.
> +
> +
> +Controller Suspend Event
> +========================
> +
> +       Event code:             0x002d
> +       Controller Index:       <controller_id>
> +       Event Parameters:       Suspend_State (1 octet)
> +
> +       This event indicates that the controller is suspended for host suspend.
> +
> +       Possible values for the Suspend_State parameter:
> +               0       Running (not disconnected)
> +               1       Disconnected and not scanning
> +               2       Page scanning and/or passive scanning.
> +
> +       The value 0 is used for the running state and may be sent if the
> +       controller could not be configured to suspend properly.
> +
> +       This event will be sent to all management sockets.
> +
> +
> +Controller Resume Event
> +=======================
> +
> +       Event code:             0x002e
> +       Controller Index:       <controller_id>
> +       Event Parameters:       Wake_Reason (1 octet)
> +                               Address (6 octets)
> +                               Address_Type (1 octet)
> +
> +       This event indicates that the controller has resumed from suspend.
> +
> +       Possible values for the Wake_Reason parameter:
> +               0       Resume from non-Bluetooth wake source
> +               1       Wake due to unexpected event
> +               2       Remote wake due to peer device connection
> +
> +       Currently, we expect that only peer reconnections should wake us from
> +       the suspended state. Any other events that occurred while the system
> +       should have been suspended results in wake due to unexpected event.
> +
> +       If the Wake_Reason is Remote wake due to connection, the address of the
> +       peer device that caused the event will be shared in Address and
> +       Address_Type. Otherwise, Address and Address_Type will both be zero.
> +
> +       This event will be sent to all management sockets.
> --
> 2.27.0.389.gc38d7665816-goog
>
