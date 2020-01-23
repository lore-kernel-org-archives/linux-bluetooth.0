Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C839EC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B32253D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzufNcOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWSTJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:19:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgAWSTJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 13:19:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so4694659lja.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2020 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GgjRp5rLRonO/ZU5BfCUTdYCUWJZ13Z1t1s6bRUsqd0=;
        b=NzufNcOKQ5pRI6mIoPD+mqksuWhHOQ7WDlBlhckKqk3W5LGUrBhtXbZENkx0CBoO81
         pQvqBa/GRJh0BAT9EiEvHUgxc2ut96ULOc6wbuhZwgQuwZUVn3UyWcWA91eGpLouGaKi
         b2bd/AO6qo3WgK63iD/Uo+9CGy1Ft/pw9USk3It6+8T40sTh72ueC7BuXVg895QzekSI
         tQkN+LmXyUrlkf6sSASjwI6IROKGwgSiUzgZQLmb0o0UxEGDoHT5jdn7u5+mdAk5urNr
         2kNRXpFL7IPdDVRZONurqriHKvOk2xUWy9FAShsh1GL483wFiTDnHpBcIsWUXZBoBykx
         J7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GgjRp5rLRonO/ZU5BfCUTdYCUWJZ13Z1t1s6bRUsqd0=;
        b=sPf9Fv3Rgq3VMyniDI+xXI4aIBYLo5HVzgpzaGqobNLfo7OM3q2IOSqzEjeNOV3nFI
         ig0j8e+cPOUmc4/AscC8LzN5wknZF9CKCgaAPx4Lu550K/MV8FlxsezOoNJ1xPlFa0rv
         dxTZh/MQ9fJASY6nICnfaKWTGlh/+nxI8lw0zTqGQ6DoDX3izUANg9GYSw1nRhWN9dxl
         oBuxNzK1BICofzL7gEAsQh0BPtA0shufK5CD9Jkb7Y0VxdDJ2sChSeJWHa6atQ2wnPX6
         5u+YCvFDWZRr2YTzyA4umrmqUG370YfAxRMENTL0MdHK/hnbViaQFLUKymS5zdHPo624
         PH1w==
X-Gm-Message-State: APjAAAVAg1bGyFlPsNnp+V9WyvDikNb1xpAf5rTWQhzyCty+C6qW30tq
        J1M/9gBY2R1d06pLsfxoFQnSSi4YkV4e9i9HX2n38w==
X-Google-Smtp-Source: APXvYqyEjjfPm+XeFWZmhU7ASsLnUGgvjI1LAyAIddVbnaQ4XM1+1fd7FbkSjTnBXDzX69sl4tjnLpBkP94jipPhcXE=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr24424153ljc.161.1579803546697;
 Thu, 23 Jan 2020 10:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com> <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
 <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org> <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
 <F6319DB4-FE70-45C8-A61D-D965CB659C9E@holtmann.org> <CALWDO_Vqboxt4JfV9yGVd5Jv5jZ-vwtOghh4tffpQpQzHuq6NQ@mail.gmail.com>
 <D61B5AA9-A509-4253-95D7-F6401C832081@holtmann.org>
In-Reply-To: <D61B5AA9-A509-4253-95D7-F6401C832081@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 23 Jan 2020 13:18:55 -0500
Message-ID: <CALWDO_Ub-orioZmPkCC4BoVfxHv9onP9QXz_M_T9nmh7_78LLQ@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
To:     Marcel Holtmann <marcel@holtmann.org>,
        Archie Pusaka <apusaka@google.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

That makes sense.  Adding +Archie Pusaka as well who may have input into th=
is.

Thanks,
Alain

On Thu, Jan 23, 2020 at 1:16 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > From a high level, this looks good for me although I agree, this is an
> > order of magnitude bigger in terms of scope.  Can you suggest perhaps
> > an interactive way to deliver this over a period of time, perhaps
> > prioritizing the BT_DEBUG kernel messages first? :)
>
> I am always in favor of increasing the ability to debug things, but we ne=
ed to do this in a clean fashion and not some short term hacks (since they =
will come back and haunt us). I like to get some review on my idea first.
>
> What we could do is work on the BT_DBG etc infrastructure to allow switch=
ing when dynamic_debug is not available. Then you would use some debugfs to=
ggle in /sys/kernel/debug/bluetooth since that is no stable API for us (and=
 of course the clear understanding that this toggle is temporary).
>
> Regards
>
> Marcel
>
