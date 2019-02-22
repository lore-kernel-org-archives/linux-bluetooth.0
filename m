Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3ABC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952A62075C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 22:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bltQQJBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfBVWLO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:11:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36103 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVWLO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 17:11:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so3090532eds.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Feb 2019 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuHwDkyo+FE+kx/nk3ypUawi0rYD4PuoS1hwu59DHRQ=;
        b=bltQQJBq77iVWZX8IQbvi4zj/TVzxkPp4uD+6beKh9il3NgC922hIXmrNvJ5nJKX+R
         xux+2kSNS3JZM/F762m4oOQhE6QbqSF7CJMR8o2Vra8pC207nD+20jVqx5KocXNGKAg6
         qrpKUWtRWWVJPdDCI1voshOEkZ2Pje8Qo+Yq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuHwDkyo+FE+kx/nk3ypUawi0rYD4PuoS1hwu59DHRQ=;
        b=nB8oCL32eCLGA3/M9igxI8jlI6zBcI980BT83lwir3je6z7hWBh3U8nOODZe1r/vxt
         uAylqb/ZSDjFujgKKyPGkLXqJZ1NwBl14g3r8TPM1MZBewEMzzdxy68lsWIx99zS2e1t
         SPYWlCZ3ztbBlSXji0YjzqnxZaq8TTjwZc6LXQYOlmXRhXJ07jCu1iGCjaph4Me/MZCf
         2dUmxgGsY9Duaa8na96EJcRPfJzXDqtYh+S+m0lv7sgSLkw6diL8erfom2cUd52YBAm8
         VAdgUcfgp4EJNCuZFyoH+4KeiWwxoco0nmtFQp8ywbODqWpGiRadfBF1TKnp1cDxvw3D
         5J/Q==
X-Gm-Message-State: AHQUAubgf3IrSbDwz0+WjNL3ty07FdEXy7iu5h1c8CD6ukzGmm9RGB5p
        h6sWpO1x5JR9TK1b1OodZvSOfQ+axoc=
X-Google-Smtp-Source: AHgI3IbNkpdgyHO881TKg6COyEGLzome8OcVEktiWDwrgMf5A2UZyDxfYQBshJpiHrhzWRIbhGdg3g==
X-Received: by 2002:a17:906:82c2:: with SMTP id a2mr4469547ejy.8.1550873471761;
        Fri, 22 Feb 2019 14:11:11 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id c20sm690725ede.76.2019.02.22.14.11.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:11:10 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 10so3064187eds.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Feb 2019 14:11:10 -0800 (PST)
X-Received: by 2002:a05:6402:164a:: with SMTP id s10mr4911135edx.6.1550873469625;
 Fri, 22 Feb 2019 14:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org> <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
In-Reply-To: <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Feb 2019 14:10:57 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOFTYmXHw6DD6f3P-0DfyKGZUt9MANEYZXfBBkiXqikYQ@mail.gmail.com>
Message-ID: <CA+ASDXOFTYmXHw6DD6f3P-0DfyKGZUt9MANEYZXfBBkiXqikYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajat Jain <rajatja@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Feb 22, 2019 at 1:57 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2019-02-22 12:34 am, Brian Norris wrote:
> > +               "usb0cf3,e300" (Qualcomm QCA6174A)
> > +               "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
>
> Nit: the USB device binding states that those leading zeroes in the VIDs
> should be suppressed.

Ah, thanks. Didn't notice that part. I'll remove the zeroes and resend.

Brian
