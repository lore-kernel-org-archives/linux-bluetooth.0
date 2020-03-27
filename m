Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D11C2D0E8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 00:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDCB206E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 00:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdxLoqgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgC0ALe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:11:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45910 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgC0ALe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 20:11:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so8398112ljc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Om0czkdlZ/W7CWzm10Sp8n/DnGjyBb+31UnGPUf/8ao=;
        b=bdxLoqgsqXEsawKrEEQCjxEEU4SVqGM7oftF1iV9Uv3/ABxpystWJhynlOqOLrU4Hi
         hx6k8DReGKF6ijQ3b+bSrJfho9k8R8jP3/0xDRIAzQzUadL9wUHkv+yI5J5m8czH9knK
         d8NtmT64PYlpoxQR0zgJLnadnFbDL9hsxNndQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Om0czkdlZ/W7CWzm10Sp8n/DnGjyBb+31UnGPUf/8ao=;
        b=iW9TMMbhaqZQJO/QfJxYEWHkufY6MYcM7Iyd2ZN+/OF6mtP9SCKDqqdr9QIZUTp4TG
         iUxj7cbwH2Yi/aGzB01K54yZRkeL8yOe5d2xibBlLeJH4elO2InVz7MerX9A+vD4q3GQ
         odQXy44F6DVJ7VTcWUem1nE4qJRJUK3Qhxbiq+9KeNtTGLDLiLjVlHFBc9Zj/Pfe7rUJ
         spuX2lNbfaRvNmqUX39wqJaKwrGWnxo1QWDIw8bImEs+Che9vgQ4wXBOE25JDoCvIJUB
         ta07g0u+JH1CVTvT8KKktfdeR086QPMnY8q7Jqcc8qr8JxXUb34XbiumB/cmktnpe4nS
         alHg==
X-Gm-Message-State: ANhLgQ13583/2AaV4C4JyH0S1UQEU7/+GMUPuk6kfDp+1Npm8gB1iEpy
        /fopgHnADeMoKdJIL9OFLwUXzwXd8clXRHgg0BVVDg==
X-Google-Smtp-Source: ADFU+vsUOMh8Po1kt6T0m/lsy5OkGbexpu112fy3gnBAGNzZ5mv6hf9SyERLmZOD9NOtJV13YX15ZgAmSTIvz0Xi+fg=
X-Received: by 2002:a2e:9ad2:: with SMTP id p18mr6574780ljj.15.1585267892097;
 Thu, 26 Mar 2020 17:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200326075938.65053-1-mcchou@chromium.org> <20200326005931.v3.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
 <0cb96a93000c02e4c4816c64492afef10bc76fd9.camel@perches.com>
In-Reply-To: <0cb96a93000c02e4c4816c64492afef10bc76fd9.camel@perches.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 26 Mar 2020 17:11:21 -0700
Message-ID: <CABmPvSGbVqnE82Se=ZfTM=h=WTJaibRfP+0Prvz2yxsDLK7Ukw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
To:     Joe Perches <joe@perches.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Mar 26, 2020 at 1:16 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-03-26 at 00:59 -0700, Miao-chen Chou wrote:
> > This adds a bit mask of driver_info for Microsoft vendor extension and
> > indicates the support for Intel 9460/9560 and 9160/9260. See
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> > microsoft-defined-bluetooth-hci-commands-and-events for more information
> > about the extension. This was verified with Intel ThunderPeak BT controller
> > where msft_vnd_ext_opcode is 0xFC1E.
> []
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> []
> > @@ -414,6 +414,8 @@ struct hci_dev {
> >       void                    *smp_data;
> >       void                    *smp_bredr_data;
> >
> > +     void                    *msft_ext;
>
> Why should this be a void * and not a msft_vnd_ext * ?
The intention is to hide msft_vnd_ext from the driver.
