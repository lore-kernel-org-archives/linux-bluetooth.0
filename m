Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48727C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDBE23A9C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgLRTo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgLRToZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 14:44:25 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E098C06138C
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:43:45 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i6so3039614otr.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivK6+hl4hC7mdQNd1BEbN0CRPrfOGC4j2eRBw/PZi50=;
        b=IW6Sdmf0knF/GZTvxghOvROF5XgXLrJs4IkvMF0mh5h5SGQx2VT1utGca+C8r3AKxl
         5BchVXld6eT7234JCiNLsgJNjRKklCSacepsNXmtICqHv48ykZ611VzfkOFZLaa9PDkm
         mDDzVG34/j1zHTZ5i4tJZb4ZruMvmiBAgXfcoI01r6LTMlC+FdRROdaLrujoZnXxsdX/
         CVPPCd6o5DroNYu6OmzJCKvn40i8TsIuWz3tDevtmZUxsQVHRjiCzWJaXnt/zAXOb/pa
         iL1aCQXk85A5+hBAxRFYBnrYb/+SSEQQMC63Y5xoIP9pprBBcdo28o6LSnm/nmuIh5rS
         lhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivK6+hl4hC7mdQNd1BEbN0CRPrfOGC4j2eRBw/PZi50=;
        b=TXJmHNTRYx2m2U6YGf+caIbYfES8/fUaFR1uyIRs1ILsTSYejsXWpPzZcDjToUn3mT
         Y7vhje3RfIfJVhoqARjSzw+Zvng18ink/3n0euQ34P4yE2TTX1IEJRPx8gEhSD9UezIb
         Cs0Slec74Q4RbJ90nZb9ICz4bzdzz2oRcLYXrTWyqQIflCczk3xXlNyvHQFmxo79IoYc
         qzOD3FMtOA6+ZBqvu/iGFxmxfdt0BQs4ITMRZDqUgmW8IzRjZWjE1s4qAWOm9reBaYuY
         dZrP1j2bu7qCs7b/qp5lm6zXrc2FUKwClVsyuEk2+rmgDqT8N2e4gyqeb8BvmVfXQy1Z
         C+yQ==
X-Gm-Message-State: AOAM530iBFUCbemgf8Iug5MU46cVPGFD8QDNh5D+qDf2B4ZfnwRGg+dw
        gpayIdoybUFJYmOKLBJsfhon5DPona5rVU7+lLvLDVsj
X-Google-Smtp-Source: ABdhPJxrWtC1bW+UV4vijqvAoN5XMcf+lZxSLKbfucU/hP3Br6LK00KXBrfSm/9HOMjL9DeUqNsPMnS8sxTRci58ThM=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr4042661otq.371.1608320624784;
 Fri, 18 Dec 2020 11:43:44 -0800 (PST)
MIME-Version: 1.0
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
In-Reply-To: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Dec 2020 11:43:32 -0800
Message-ID: <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
Subject: Re: Default to HW mSBC on capable controllers ?
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joakim,

On Fri, Dec 18, 2020 at 10:48 AM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
> Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?

It is in our plan to support HW offloading, but that doesn't mean all
platforms will be supported since that depends on the PCM lines being
connected to BT controller in the first place.

-- 
Luiz Augusto von Dentz
