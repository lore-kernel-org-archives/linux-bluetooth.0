Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33AC619C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCWSta (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhCWStQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:49:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E5C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:49:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so20498853otn.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HC3W49DrUpw4CRfL3oohqCa80V7UIwQ5We0hVuQpU04=;
        b=c6R/3C2ULOfrlfcLpK2OJlvT8G/UxzAsEF5D5F3HOQkUVNce89hiuFqwpM6kWOYqfr
         EknECFSEyuB/UesUq7fg83/2UKMyyoXhIJhQTshvxqNTZRvPXg76l+v0vA31Ga50ymp9
         Rb3eaxgVC5i5n1cdgkzN97bqEeAFTufWVEvwvyji0YBo64rAxPqogGVLV69SCqXOHiEu
         6TAZCE0v7K5wP+0ATjwPjkOYfGFILWYOAsor/llDpOIq4pt1LIgviAV7rUZttd67D9LJ
         lopuyBicyjDdAA3oE6PBPSy+m7EvS0MwukP00lnnN5acvemyM7M2PkbBm9MRlHZw5Nls
         Ws7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HC3W49DrUpw4CRfL3oohqCa80V7UIwQ5We0hVuQpU04=;
        b=HghxhKxUpJFuI+ce87etzXz2NMrstwbcodrOgrH9vZVDa/xK00B28B8pbf7XCq1uyC
         0HolRgOgEM610nA6HxAtR+Iuh1y0oD2OF1DMYYB9XwX8/QMdsSMyzfeqo4he8yV2BSwZ
         sjr17fbIx1JUP4HKQEH62rxXD0dnYbyCwYivy4I67ut1BZUhOjbsK1oSNGx4tnPLsfhI
         0oLA31h/qILydun7GouHYupDh1qy8lRIqFDrkHGr3+F8GNI4o32Sx9i6lAeXuBHcgImm
         Sgs/TDA5SZkpNLKYYfygDaoHohUuPOxoDo+c6YTIxqLcnxykBO2R+CxAznF0D3rDkpdd
         Td/A==
X-Gm-Message-State: AOAM530eal/ldkqfyP0ukoZqymfz7T3EBTMEgKNbJBQ6a0c8ygxB0Nwm
        y4nA5VQySJf341rq3tqCSwxCPh6w/no8CUpIR4I=
X-Google-Smtp-Source: ABdhPJyUnD0eVIcYy3aWr5iW/QrETlENqcCyeFksccHeI6P6h94uOEsAD6jNF2Fx4KZkzyv8RSuhz3defbpZ5lHdS7I=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr5349263otp.44.1616525355513;
 Tue, 23 Mar 2021 11:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
 <6644650bbd0e5748368a2468e1df9f181bdc413c.camel@gmail.com> <58062484-8891-4E66-9B6C-918273C31668@holtmann.org>
In-Reply-To: <58062484-8891-4E66-9B6C-918273C31668@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Mar 2021 11:49:04 -0700
Message-ID: <CABBYNZ+gc8Q1MUExiBVhvwW9NQvRQP53CCE+RDVvW0dvvb8dGg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] Bluetooth: btintel: Check firmware version before download
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Mar 16, 2021 at 7:01 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Tedd,
>
> >> This checks the firmware build number, week and year against the
> >> repective loaded version. If details are a match, skip the download
> >> process.
> >>
> >> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> ---
> >> v2: Add patch that mover checks for operational mode after the version
> >> checking.
> >> v3: Fix not checking for operation mode before using btintel_read_boot_params
> >> since some models depend on that to contruct the fw filename. Also attempt to
> >> cleanup duplicated code.
> >> v4: Fix forwarding -EALREADY when firmware has already been loaded.
> >> v5: Fix not advancing fw_ptr.
> >> v6: Fix btusb_setup_intel_new_get_fw_name error checking for ddc.
> >> v7: Disable version checking for WsP/SfP.
> >> v8: Really disables version checking for WsP/SfP.
> >> v9: Reintroduce bootloader checks and add workaround for version checking when
> >> operation and version cannot be read.
> >>
> >> drivers/bluetooth/btintel.c   | 106 +++++++++++++++++++++++++++-------
> >> drivers/bluetooth/btintel.h   |   5 +-
> >> drivers/bluetooth/btusb.c     |  18 +++++-
> >> drivers/bluetooth/hci_intel.c |   7 ++-
> >> 4 files changed, 109 insertions(+), 27 deletions(-)
> >
> > I ran a quick test the v9 with the devices what I have.
> >
> > Test cases are:
> > - cold boot - expect to downloading the firmware
> > - reboot - expect to no firmware downloading
> > - fw upgrade - expect to device reset and download new firmware
> >
> > Devices tests:
> > SfP, WsP, ThP, TyP
> >
> > Results:
> > ThP, TyP: All 3 test cases were passed.
> > SfP, WsP: fw upgrade case(#3) didn't work but it was known issue
> >               - insufficient fw version information in the firmware file
> >
> > Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > Tested-by: Kiran K <kiran.k@intel.com>
>
> so I should go ahead and apply these patches?

I will send a v10 shortly, there was a build problem when
CONFIG_BT_INTEL is not set.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
