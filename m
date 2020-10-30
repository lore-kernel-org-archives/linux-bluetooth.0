Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE5C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 00:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B654D2071A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 00:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMxnlvZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ3Arr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 20:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3Arr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 20:47:47 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABEC0613D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 17:47:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c72so5033883oig.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNS1iXRP7m0LtHaHqd0Pe+LsJDurJu8OyJChE/LO9pE=;
        b=sMxnlvZR2SYpAZO/T0ssFd4Y+cJrtNJeUFi87fhldVcGkjnDyA0m7FrxXO+Dc4cH1b
         R9EmIS1NOJMP6PGftYSxA6aNseF95BekO/r+rKANehcoHAMa4o3VICBln0lLM8pH1VTv
         bgrDf7gc1QBSV9DYW6pA9XktaMVDwdsY/vfSgUOwrYS6rz9bYG2FdURVFGOI97L7lWnD
         Jc+sWBVn4GzvLLA9+J+huK2FhfCNwfJB1c9+rYOGdS/c26cfyc23ULJL375Fa8SfeSA5
         rhq401HIQt2fVzFFdLNldDy4f7ZrnG6I1qU7kVDDsks3Sxm3enmjWv+B3+1n4h7BXRho
         ysFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNS1iXRP7m0LtHaHqd0Pe+LsJDurJu8OyJChE/LO9pE=;
        b=HXHjMrVQAm9ASw9q0u/HMLRYLXr+3nsfzjI/tjZzfRhG9vUlVa5zL/dRB1Qduxn0PN
         inAUM/I+s+TjZjfa9HZJQTkRM4G0vLhqeQ7lxqHnx98ZQomwvd3jDQ9zkgFVwTJwnc/q
         tBzb4ORJ/qgtNEaMCWVLfOE3V9o6wVYiNITD3O9ikDMh+75T/AsryFyMv3Ud/qgaCQt9
         mC0/NEfbafpwQfhG4LKpUoTyUTpXuGS0YEAGnRSOEYFBcUNluSPEv60vGc8PEY0ejJj8
         Yr21FqIWjbUHtafYMgEY2ovmgMipjxuu0fjdPDmMjr0nckWnACiLQsf8zylzc1uye0xe
         kXBA==
X-Gm-Message-State: AOAM532V/mD5suox8Yupgrr2YhCnRsvouGglwakEyGcupaOv9Tez5Vr2
        LAVdUzaPzq8fcTcOrYVvG3XYZi44iKPDTwkhYXo=
X-Google-Smtp-Source: ABdhPJx+lgKowcpA1h2HWvfxLMhcKodh52zbrDX5IHcdh60edjMzpvqPxJREbS+QqzF3TVA537YAIwSFettURsj5Dg4=
X-Received: by 2002:aca:cdd8:: with SMTP id d207mr1262780oig.64.1604018866253;
 Thu, 29 Oct 2020 17:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com> <20201029160317.Bluez.v6.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
In-Reply-To: <20201029160317.Bluez.v6.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Oct 2020 17:47:35 -0700
Message-ID: <CABBYNZLqmmhjud_qW9amrtSH7XAS5mD-goT7H4bTAh-U9aG7Fw@mail.gmail.com>
Subject: Re: [Bluez PATCH v6 01/10] doc/advertising-api: update API with new interface
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Thu, Oct 29, 2020 at 4:09 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> This updates the advertising documentation to include the following
> features:
>
> LE Advertising Manager:
> - New SupportedCapabilities property
>
> LE Advertisement:
> - New min/max interval properties
> - New tx power property
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v6: None
> Changes in v5:
> - Changed interval API from jiffies to milliseconds for clarity
> - Changed new dbus endpoints to be experimental
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  doc/advertising-api.txt | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index b0565eab2..541c57004 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -138,6 +138,31 @@ Properties string Type
>                                         "2M"
>                                         "Coded"
>
> +               uint32 MinInterval [Experimental]
> +
> +                       Minimum advertising interval to be used by the
> +                       advertising set, in milliseconds. Acceptable values
> +                       are in the range [20ms, 10,485s]. If the provided
> +                       MinInterval is larger than the provided MaxInterval,
> +                       the registration will return failure.
> +
> +               uint32 MaxInterval [Experimental]
> +
> +                       Maximum advertising interval to be used by the
> +                       advertising set, in milliseconds. Acceptable values
> +                       are in the range [20ms, 10,485s]. If the provided
> +                       MinInterval is larger than the provided MaxInterval,
> +                       the registration will return failure.
> +
> +               int16 TxPower [Experimental]
> +
> +                       Requested transmission power of this advertising set.
> +                       The provided value is used only if the "CanSetTxPower"
> +                       feature is enabled on the Advertising Manager. The
> +                       provided value must be in range [-127 to +20], where
> +                       units are in dBm.
> +
> +
>  LE Advertising Manager hierarchy
>  ================================
>
> @@ -209,3 +234,26 @@ Properties byte ActiveInstances
>                         Possible values: "1M"
>                                          "2M"
>                                          "Coded"
> +
> +               dict SupportedCapabilities [Experimental]
> +
> +                       Enumerates Advertising-related controller capabilities
> +                       useful to the client.
> +
> +                       Possible Values:
> +
> +                               byte MaxAdvLen
> +
> +                                       Max advertising data length
> +
> +                               byte MaxScnRspLen
> +
> +                                       Max advertising scan response length
> +
> +                               int16 MinTxPower
> +
> +                                       Min advertising tx power (dBm)
> +
> +                               int16 MaxTxPower
> +
> +                                       Max advertising tx power (dBm)
> --
> 2.29.1.341.ge80a0c044ae-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
