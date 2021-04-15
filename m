Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3238FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 04:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6BE60FE3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 04:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhDOEey (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 00:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDOEex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 00:34:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E791C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 21:34:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m18so9143226plc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 21:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KVy1NgTZm6uY7PtJl7I1W5wSnf3FKIPa/vW33PdzMcg=;
        b=T5qoVbuvbgF8TuwpDVGoYTJ0n0xx9/793GpIWIb008tK/BzuGr2u6MJIkU1Quo00ri
         9bw66jO6T9dTM9VQKuCB45i8AqwKawWVKghd2Pv9t6CwCuuxGqWDMA5nmAY6cUZwD/2Z
         y3c2vND3UyxcB+RkKlJz+kGyjARtKM4npt0WhHWgIfiWBW5UxqrAtqIeyhv2nCAHLfEw
         XxTO69Vo4H3ZaM9q5Ykr6302SGykg34PrceWQcRv8MkKyvIIXjrWO/BwsymP0rKuwsDS
         QQmxbNKa2L9Ya12bPGjq/mA5shVwuZmH4yFKN39BgmDVKKjZPj5qTaHnZEzkI/+HaLzU
         FxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KVy1NgTZm6uY7PtJl7I1W5wSnf3FKIPa/vW33PdzMcg=;
        b=R4KMA7g3AeBcVI86bglZpVuQ1M4nTVAbwK7W4bm8+eZmUruscnP/o9TO+1bZjTNSRR
         Y1Gys6/6LifuGlyXP1tQLF8iYWXc5glITwTDGs0cXxsLipurpJRPfm6rUF8OymwNzWuJ
         Ql9UvDDFzvDw+Jd4JVCcWmd+iHYGCzjm3xLhfRmSAsPE7MwiJE/djvNyBzbx8XCrWI2u
         KZpBtO4oz+CclwMmmGmOGpgL6lAV5p6pnCbytWWQCWTQ/M9cyQeq7EGJk/JfZ5T39W9P
         kYg+0P+qIRoKqyyrk7G98tIjc90Ntj+o/3vHo5rQfUn1h+KVtaoHSeSZXNyBja7Q9+xs
         lzRw==
X-Gm-Message-State: AOAM533hdE+S/Kq9v4aIbOSY7pSIyJ/z629zbYO4+WsDtRo2YB6lUkAe
        aZ+tQQcGllx8z1+/gYfp7dc=
X-Google-Smtp-Source: ABdhPJxXUnxAQMmkp7tXeIa8K/If+jhGnX/yYAMonNab7kQYuM2qcot533DfTKpJwMOKBd6y7dzjzQ==
X-Received: by 2002:a17:90b:e82:: with SMTP id fv2mr1774559pjb.139.1618461271193;
        Wed, 14 Apr 2021 21:34:31 -0700 (PDT)
Received: from han1-XPS-13-9350 ([2601:1c0:6a01:d830:dc5e:59ef:71c8:3cee])
        by smtp.gmail.com with ESMTPSA id t10sm811198pjy.16.2021.04.14.21.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 21:34:30 -0700 (PDT)
Message-ID: <89cd3eb83e008ddca8ce3e851d1eaf5826a5731b.camel@gmail.com>
Subject: Re: [BlueZ] monitor: Fix the incorrect vendor name
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Archie Pusaka <apusaka@google.com>, "An, Tedd" <tedd.an@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Wed, 14 Apr 2021 21:34:29 -0700
In-Reply-To: <CAJQfnxFirWC+ned2sCrJb7nAiBqjCkO6guMNZU_5NCqkAdKzpg@mail.gmail.com>
References: <tedd.an@intel.com>
         <20210414043857.371176-1-hj.tedd.an@gmail.com>
         <6D9FBA0A-3058-4C96-8CFD-6BE5B585DE8E@holtmann.org>
         <34494443-5CE2-40F1-95DF-EF05914BD741@intel.com>
         <CAJQfnxFirWC+ned2sCrJb7nAiBqjCkO6guMNZU_5NCqkAdKzpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Thu, 2021-04-15 at 11:47 +0800, Archie Pusaka wrote:
> Hi Tedd,
> 
> On Thu, 15 Apr 2021 at 10:26, An, Tedd <tedd.an@intel.com> wrote:
> > Hi Marcel,
> > 
> > ﻿On 4/14/21, 3:09 AM, "Marcel Holtmann" <marcel@holtmann.org> wrote:
> > 
> >     Hi Tedd,
> > 
> >     > This patch fixes the vendor name is alwasy shown as "Microsoft" even
> >     > though a different vendor.
> >     >
> >     > < HCI Command: Microsoft Secure Send (0x3f|0x0009) plen 249
> >     >        Type: Data fragment (0x01)
> >     >> HCI Event: Command Complete (0x0e) plen 4
> >     >      Microsoft Secure Send (0x3f|0x0009) ncmd 31
> >     >        Status: Success (0x00)
> >     > ---
> >     > monitor/packet.c | 12 +++---------
> >     > 1 file changed, 3 insertions(+), 9 deletions(-)
> >     >
> >     > diff --git a/monitor/packet.c b/monitor/packet.c
> >     > index d729a01cc..91d2294ff 100644
> >     > --- a/monitor/packet.c
> >     > +++ b/monitor/packet.c
> >     > @@ -9325,18 +9325,12 @@ static const char *get_supported_command(int
> > bit)
> >     >
> >     > static const char *current_vendor_str(void)
> >     > {
> >     > - uint16_t manufacturer, msft_opcode;
> >     > + uint16_t manufacturer;
> >     >
> >     > - if (index_current < MAX_INDEX) {
> >     > + if (index_current < MAX_INDEX)
> >     >           manufacturer = index_list[index_current].manufacturer;
> >     > -         msft_opcode = index_list[index_current].msft_opcode;
> >     > - } else {
> >     > + else
> >     >           manufacturer = fallback_manufacturer;
> >     > -         msft_opcode = BT_HCI_CMD_NOP;
> >     > - }
> >     > -
> >     > - if (msft_opcode != BT_HCI_CMD_NOP)
> >     > -         return "Microsoft";
> > 
> >     seems we have a bug here, but the fix can not be correct either. If we
> > are running on Intel firmware and the Microsoft extension is used, it should
> > show Microsoft and not Intel for the vendor commands.
> > 
> > I submitted v2 and I think I took care of the msft_opcode handling but I
> > realized that the msft_event_opcode is also like msft_opcode - each vendor
> > will have a different value.
> > I know the msft_event_code for Intel, which is 0x50, but don't know for
> > Realtek. (Do you happen to know?)
> 
> On my Realtek device the msft_event_code is 8 bytes long: 0x23 0x79
> 0x54 0x33 0x77 0x88 0x97 0x68.
> 
> localhost ~ # hcitool cmd 0x3f 0xf0 0x00
> < HCI Command: ogf 0x3f, ocf 0x00f0, plen 1
>   00
> > HCI Event: 0x0e plen 22
>   02 F0 FC 00 00 3F 00 00 00 00 00 00 00 08 23 79 54 33 77 88
>   97 68
> 

Thanks for the info.
I am going to change the pat to support "variable" length of msft_event_code.

> > I changed the v2 to RFC for your further comments.
> > 
> >     Regards
> > 
> >     Marcel
> > 
> > Regards,
> > Tedd
> > 
> 
> Cheers,
> Archie

