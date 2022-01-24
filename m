Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08147C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jan 2022 20:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiAXUnJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 15:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385510AbiAXUd2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 15:33:28 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226ADC07E29F
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 11:45:44 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i62so8378268ybg.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dr/8H708HlzR8fZGy1Nk94SphgYYIl7qw5wz3FvbK98=;
        b=B1VJ7YCGTkAKYMc4UDximVNVBlhAVMhqPif1hG6t7iRRFGLqICsi/Se8Yyf9VkxIvx
         /ZE+w1ZPAtr63EYyPs96MkOsln3lp9uNeMs972DDacw2YiWR9COCgSNC3/PdH7tjN3IU
         1nXuM8SX51SUPFfTnMG1As2l9FROMysVjh2phZPHKYapxNvGqrh9BMLCPcYbUl/8MqDx
         oN+S201AeK6rfYGyRw2GT11OnucnWnWFR3yK4I+NV79i60clWlFhRA5qGzy0/AnWI/3L
         KVCOzORZv01J3ku//0jlhizs9s3JxGO70bVAGEf5B+CzlGlN7YiXLQEz+uoVFVJynsRV
         kYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dr/8H708HlzR8fZGy1Nk94SphgYYIl7qw5wz3FvbK98=;
        b=Vf8IQUX4NKnZNG+PF4Ac/dQ2PYZdqbBahQKLm+f8v4FNM0HBarOTREFe4SHTWvtyKs
         8BMvr+u4gSo7FmkNa6fXEbOBow6pSmqvdgAz127/JT1JlYTaOgw+6125g0ruO8UGXVh2
         j6Ttjtz3t677qeKMLgqF5HX/eYdilvcGvEmYupml1Y8it4MQ814i6nD0ts/njrfawVMq
         uLPmQnp1Mjzk5U7fJ4lCQ/Qv6AJSLS7M1jVXdpq6FasmAK/v0C9vVJNClTzU7MQM09tU
         /4mWwi5aPktOi+962ht/oqcvkOe9RdgAyfuEQNBHh1YQIsp5TiMO9S7sjrOw37RXRZdD
         I5eg==
X-Gm-Message-State: AOAM532w3PRIzv5aEhKB+Np9Xh4Rmyrc6NXRq4Q+F/f3jejr1oa80TkI
        DE3VDxRaZET2DWEdWC7LYTnHkWnpD9cmJ3Sqj+7Fw36SEw8=
X-Google-Smtp-Source: ABdhPJz8Ipa01fNQYhHUNmP6WeRHAeDDAeeeLdPikSOiMPK5U3+jEXpmTID/fjKtox5p4ZIBoCFIy0D5VbVUSRIM+mk=
X-Received: by 2002:a25:8583:: with SMTP id x3mr24044936ybk.188.1643053543248;
 Mon, 24 Jan 2022 11:45:43 -0800 (PST)
MIME-Version: 1.0
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com>
In-Reply-To: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jan 2022 11:45:32 -0800
Message-ID: <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenneth,

On Sun, Jan 23, 2022 at 8:33 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> I'm running Linus' master (as of today, 1c52283265a462a100). With this commit in
> place I get no bluetooth ("hcitool dev" shows no adapters) and/or I can't see my
> MS ArcTouch mouse.

It would be great to have some logs, btmon, dmesg, etc. If the adapter
doesn't work this might be related to firmware loading and not the
commit you mentioned above, anymore the LL privacy feature is not
enabled by default so I wonder if you had it enabled in userspace?

> I have an Intel 7260 BT adapter (and have the latest linux-firmware version of
> intel/ibt-19-32-4.sfi).
>
> I'm sure you'll need more information, so let me know. I'm in the process of
> reverting this from my branch, but it's not coming out cleanly so if there's
> some code to try (nothing obvious in the linux-bt git), please let me know.
>
>         -Kenny
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA



-- 
Luiz Augusto von Dentz
