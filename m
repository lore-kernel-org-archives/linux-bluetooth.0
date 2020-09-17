Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57282C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BD221F1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 17:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYLgtnPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgIQRH5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgIQRHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 13:07:46 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB732C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 10:07:11 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 60so2597313otw.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xL7o0moQLOuLb4VqMYy2UOe7s5yYUhMOpghHZTauRKY=;
        b=BYLgtnPNv0pLD4FyaMzO05l5MnZGGgI0g45likrAMwmuZEKXA9Ms9EKVXv2kBKM1Da
         6VsKxziCITqzYKmmusc0jLl7noB7Cx0uQWXOFKlV4xARdJKdPBLFLBOZc13DxXwlHLRL
         nrsc9KMFPThHKgKpErq0jd/My5jEfL8VQ/fOrRRrNfazXZxQjIx9Qp+WFxVXNpCz567y
         KiaoLWIJHNsLT8wTO39Iulyv3YDTtHWRPqVl7KN2qTrsdwW44zd33bCO7nzkIOwdEI+U
         AF9AzGV190vVhvG7TDD/vrObRXOVGtwkW6xxOYGeW0aZkBrw6wmrK70+OAyliOgt721x
         JQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xL7o0moQLOuLb4VqMYy2UOe7s5yYUhMOpghHZTauRKY=;
        b=uTT8t1ty6hO1D4pyekk/5lVeXW3o9W5SPywQzE1NnQr+yuyej/yEfKhCI+m3gxRB3t
         1rC2RKXb51vAhPUNlpkkxKvFoJbmexxw8v+qwohpvWiMFkUr6e8LwUZcF9oBHEsT1FNB
         sRlobQPjnP4nm4mDyjc5kY35W/wExl+lNsgX8xKtRDum4Ug42yyU1L73OV18fZVxXjB3
         AFnIpSI61tBy9Zie+zKkrJRiaWlI0dvvev1RYOTFZL2/+j2YXgq1qIprWrDFVxUNq4Hq
         KTmwxYVNVREJf3irQeNjOazDpatxBTDF9zfD7gz75CH7+fIYth/R/9YfwIzKDmDJsrKC
         5m2g==
X-Gm-Message-State: AOAM5303tDcSSaZ3tb9uFN3aXxQiHcBdkU4u++/5vwQ+AS8Op1Ew7OmI
        bxFc9sQCjQokdBUJPFH5fu8dZeVfvYVged6TmHfldThM
X-Google-Smtp-Source: ABdhPJzUU8XH1ylyspqTz1T553d9v7tK2lBT7n+a0J1Hf6Mb6U4J2TsA0xvbD7uPso9V0z/HpZR8mdAAoBcalsvC6GU=
X-Received: by 2002:a05:6830:22e6:: with SMTP id t6mr13833025otc.88.1600362431032;
 Thu, 17 Sep 2020 10:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <5f5baddc.1c69fb81.8c960.760a@mx.google.com>
In-Reply-To: <5f5baddc.1c69fb81.8c960.760a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Sep 2020 10:06:59 -0700
Message-ID: <CABBYNZ+sKWktscabOwRMQ6q=FyVoPr_vuADsUJzmkMXHM=VXQw@mail.gmail.com>
Subject: Re: [RESEND Bluez PATCH v2] doc: Add Suspend and Resume events
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Fri, Sep 11, 2020 at 10:03 AM Abhishek Pandit-Subedi
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
> Re-sending along with kernel changes.
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
> 2.28.0.618.gf4bc123cb7-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
