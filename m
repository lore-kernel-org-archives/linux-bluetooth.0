Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854AEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 06:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599F220734
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 06:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1SuvxPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgFPGiP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGiO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 02:38:14 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742D9C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 23:38:14 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g7so15108351oti.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvHRN5NEGaaSU3n1SAkZgJkjL/zaT73fM/L2ReTzvQA=;
        b=C1SuvxPcoU3n5lvpPT7qnCh1aO0mo0vTwR2YAltyPm1fSumMmmLqCrjYd+TZGtlyqF
         VffpNsVNlOz64vB5/PjOTVFjxFs0nzQ2VH4amwhLaCR9JDR04aA+8D15c92vUL+UutbI
         ALq1grZQLCTqtz8F7cqY36MJHkG6q93rQRHSNMJc6Y8Rj6dV9R5fLxwIhN7NDYlmHbOY
         t28rrUSdNyqaq1BQseshXrY5k4ugHHB/x7Poy7lRMuVAmTqEeI/emb4+eRCWn4+3Vkos
         u+3EF2+5XGIRq9CNiF91mmd7w+KHEb7+AQT4cOTjdb7mh/jrkfx2rfrg+IP1ALebFLx3
         Hlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvHRN5NEGaaSU3n1SAkZgJkjL/zaT73fM/L2ReTzvQA=;
        b=pfPl9eMN7+X9vQzdlUU9R7k2L0u6VYnd+6yJMRDZRtPPXcgUa/yluB4FuIAo3YDt3q
         w1aLtMwlTK4PLo0WlZOp6KLEcgFcuuXIbYZYyr63Eev3ZF0YG+h+UceeJQp2kaYHPaav
         dSIvlcuHUgXUHK5Rw/q+9m8BxWrGsUc8zGTzZFs/BlqkKCJhw8fjJl6xJecTl0awEwIe
         1DqOD+u8o9Xmow3tfr+HzQkY5GaB2cvPE+vxzN1dBPX3HvK3+6QHQjXQFS8Sm35Vjf1+
         Sf98uOqWoDgWZyzTQwZSHvfNDSYG090240TI3ckUo2BcvJteV+rjIseuoH+9eeVFRZ/K
         bjUA==
X-Gm-Message-State: AOAM533uxlrlDoHaYRPtJwmCS/FTpxKmzcfPIUJAlMFmyA7V54gNIxBT
        8Ig/ubyzdau3LFNTUusGJHvbi4u60oHwHKOWC5fvmg==
X-Google-Smtp-Source: ABdhPJwg4gQqVN7DJVkMGY8HmZHA5mixEXcQXL6+78DazjRX6CvEMpeOHVBOeNhKmWAZbl9QTEN463d5l6MuEM8jSeM=
X-Received: by 2002:a05:6830:1d76:: with SMTP id l22mr1143561oti.177.1592289493769;
 Mon, 15 Jun 2020 23:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
 <CACumGOJuBW+F9KsFJrtFCTErQj8u6jrR+3rTi8t4xuG6ow7gsQ@mail.gmail.com>
In-Reply-To: <CACumGOJuBW+F9KsFJrtFCTErQj8u6jrR+3rTi8t4xuG6ow7gsQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Jun 2020 23:38:00 -0700
Message-ID: <CABBYNZLCUqNsomJpap7LiAc3=G0RYJviavVf=RU4qhiyDQrpug@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] lib: Correct the name of Add Advertisement
 Patterns Monitor Command opcode
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jun 15, 2020 at 11:18 PM Von Dentz, Luiz
<luiz.von.dentz@intel.com> wrote:
>
> Hi Miao,
>
> On Mon, Jun 15, 2020 at 9:28 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> >  lib/mgmt.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index f44f2465d..bb31156ab 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -673,7 +673,7 @@ struct mgmt_adv_pattern {
> >         uint8_t value[31];
> >  } __packed;
> >
> > -#define MGMT_OP_ADD_ADV_MONITOR                        0x0052
> > +#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x0052
> >  struct mgmt_cp_add_adv_monitor {
> >         uint8_t pattern_count;
> >         struct mgmt_adv_pattern patterns[0];
> > --
> > 2.26.2
>
>
> The name already contains PATTERNS:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n3499

Nevermind this is actually the command name rather than its definition
which is what you are fixing.

-- 
Luiz Augusto von Dentz
