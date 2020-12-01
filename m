Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57797C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCED21741
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 20:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzSpAv7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgLAUeY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbgLAUeV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 15:34:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A604C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 12:33:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u18so7088797lfd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 12:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nM6kC60+bd7jKDVA8K2nig5T606XGyoCcED6wCJX9z8=;
        b=VzSpAv7zcv2S8+7NAlXUuEDmPfCxmE3BP44+Jyw1Hlnbic3eKZUkfBiVSyP2sss+MI
         Ocmkm/Dp378/Gxd+Hyd+zihAMQMMYEkz52AVxirQqTLmB10E9OLyFFmTl7RDyhpguTix
         faOwKK6NswmXAZ/U+VPTCmB4UlLmcQTrM7FrSwFSHQe2X8UPsHkHvlayV6io4LW44omc
         DELXlCmeYdWyJoQ1ALbO/ZySRG5YVmJe1XPjHxZlAzjqnnhxQpmnlM0ceJYNsgao0iY0
         F3d8xhoQ035FMAt8WSXiZK0TyUaTYtNr9g+LxTgFN1YVD4Cbv59XyvNohHkFIbCwl/lu
         PRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nM6kC60+bd7jKDVA8K2nig5T606XGyoCcED6wCJX9z8=;
        b=gFYf5lGoFQTHN7xw2XgGQS4uJ97vmLj1zZ2PReI9IFvn+az8EOx6ftwOhAEGSGVOQu
         AfmJzUpTatV6R3P6fxQRxEbmIkfecsgMi/VzWJtoW+MQFWBaFh8W+8yy0kwF0SzGUR4B
         cC0HUDqH9yUPauLQpnLI2rKk1MXLUNUKjDBgmd+sJNO0UxyTvgH/hCZbfHftNConA88c
         Le/LJyJCLIJPUp9vvhdmA4KAuTtEeMR/E8384TRo5fWebdifJcwdcoBQqtXgwbSEGjiI
         jnhxxquaGOSXg4tep87IKh+x4ar+O1RogUSkLgFr+zqvIihJzjqExyOG31oOl00NyfUo
         WKBQ==
X-Gm-Message-State: AOAM532IQ5efKQrcP3WfZlfdOqfaT6kIeMSU+GCF9wXvfWAcEu8FeWee
        sJku4UnmfVlFAq7GcVqXlcACUL2WaQjjY2TxXuqj5i1idQ0zfrZ+pzk=
X-Google-Smtp-Source: ABdhPJxwgkc73p/c2cKoAxdfVM8rf8bPSY9XWuoSRuutIG+h+2UzwL2q+t1H8YdFmWMHneUpno8zWahOmDuT28cFWVg=
X-Received: by 2002:a19:8883:: with SMTP id k125mr1970474lfd.10.1606854819421;
 Tue, 01 Dec 2020 12:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20201124224658.32605-1-rpigott@berkeley.edu> <5fbd9701.1c69fb81.12fae.4010@mx.google.com>
 <CABBYNZ+PsG_8E_2j4_p7Qp==MyXKNnPOH=dGJc4T7wh18BNKvQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+PsG_8E_2j4_p7Qp==MyXKNnPOH=dGJc4T7wh18BNKvQ@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 1 Dec 2020 15:33:27 -0500
Message-ID: <CALWDO_Ug-VzXmrTOUmMKgQSqqVx-b_L5rekwnv53d4ynjzyfYg@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: use correct key for BREDR configuration
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Ronan Pigott <rpigott314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz/Ronan,

This appears to have been an incorrect fix since
parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params)); will
attempt to read from the BREDR section.  My suggestion would be to
update the group table entry instead:

static const struct group_table {
const char *name;
const char **options;
} valid_groups[] = {
{ "General", supported_options },
{ "BREDR", br_options },               //<------
{ "LE", le_options },
{ "Policy", policy_options },
{ "GATT", gatt_options },
{ "AVDTP", avdtp_options },
{ }
};

Thanks,
Alain


On Tue, Nov 24, 2020 at 8:21 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ronan,
>
> On Tue, Nov 24, 2020 at 4:07 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390539
> >
> > ---Test result---
> >
> > ##############################
> > Test: CheckPatch - PASS
> >
> > ##############################
> > Test: CheckGitLint - PASS
> >
> > ##############################
> > Test: CheckBuild - PASS
> >
> > ##############################
> > Test: MakeCheck - PASS
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
>
> Applied, thanks.
>
>
> --
> Luiz Augusto von Dentz
