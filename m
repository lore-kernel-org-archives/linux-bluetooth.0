Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8532C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A79F2070A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 21:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO+sWNW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGQVwo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGQVwn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 17:52:43 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F90C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 14:52:43 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k4so9220228oik.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HM65dzyo59lndgA/bc5swjwlUj2IqjCWZFL5dFvIYZQ=;
        b=PO+sWNW/asCK96pjlUtTRg01ehPfMQfWl111aTegNAFUvKqUaIqpEfjwmC651+lRIA
         K64vgyXJZC4Kc/mtoB0nnxyBnjlfHMYu0bYO9OTMi2ACvEeZ2vZgweZswCIE+oMJJqHM
         IaUW8g85s6aGFmfSrj3Jenj4LIZRyelM46uaqWI5yUSVMncYKhHSosTiGlyx7iNcXxK8
         Ems4PDtJiUHzT9pbccMr/kaMCUCEyXdwe17FlvuIH/o0e4r+7ZDqIDFXAfzAUAAW7Q1B
         zH4MrAlY4ptZKRkTpuzwcYHYeebCmtqOsD54q3QwkANZaNAx2dU3rNsOGyKGLoO8BbYN
         iNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HM65dzyo59lndgA/bc5swjwlUj2IqjCWZFL5dFvIYZQ=;
        b=sfrCPBMaGh/JpiQKO79AZELqzgSF1yS+WwiK0IRcpNveYVnNm4SxCl1cSU/83iLw6E
         rHu/ifVLGTN8xL72+OEB7IT/yHen83RmLnxnei1EUMVTKTLw3Mb34WwfSE5BUS5QNjSg
         0nWpAFTizSmGhP4+VPomh1oPghx1sMQwhRhEPKUx0IG8qGl4V8X0OEtC9aFJR4PC5I2U
         BWEyJvfvDGjSGt4YtAotAfARfyrmMPZxBzgFNxFflq2ItBr+tEPFwdAp4PmGqWxI3FEM
         ChPm34vkY2Tf8rXY4GNYigBLoAqdS9FtVUmAzBtR9MU8RtVKrSPFOdWtU4G6yv4afEgR
         6Uhw==
X-Gm-Message-State: AOAM533BHSdABWvIZltgSMoVMudVzmWdXofdGt3J3V2RiuYHWZwpo6Of
        OSXgnY7ab9srbhKCvNBQJhTo34GOMlW+rx/pSnuGpGEW
X-Google-Smtp-Source: ABdhPJwFgbsl69Z0K9FU7CbNMuVM/3Kb2peBwYBn0nBxjpxCXgyBpqcpIV4ASCD9bxJtlHOoq37caUjDM7wZ4rqt8uw=
X-Received: by 2002:aca:cf81:: with SMTP id f123mr9527980oig.137.1595022762823;
 Fri, 17 Jul 2020 14:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200717191515.220621-1-luiz.dentz@gmail.com> <5f11facb.1c69fb81.6f815.57f7@mx.google.com>
 <dac373c76940dbf30302a1420fceaf7a01e00397.camel@linux.intel.com> <CABBYNZKNBRT-3t_SSh8dHWVZk6S7NBU9rY2X-miE6bKwLOqQnw@mail.gmail.com>
In-Reply-To: <CABBYNZKNBRT-3t_SSh8dHWVZk6S7NBU9rY2X-miE6bKwLOqQnw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jul 2020 14:52:31 -0700
Message-ID: <CABBYNZ+UEAxJ3vHOou85sC_xiXnVZUoN+xJiwAcSDUTcpJhe8w@mail.gmail.com>
Subject: Re: [BlueZ,1/5] shared/att: Fix possible crash on disconnect
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Jul 17, 2020 at 1:45 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Tedd,
>
> On Fri, Jul 17, 2020 at 1:35 PM Tedd Ho-Jeong An
> <tedd.an@linux.intel.com> wrote:
> >
> > Hi Luiz,
> >
> > The failure is from test-gatt
> >
> > DEBUG   :FAIL: unit/test-gatt
> >
> > I will update the CI to include the test result.
> >
> > Regards,
> > Tedd
> >
> > On Fri, 2020-07-17 at 12:23 -0700, bluez.test.bot@gmail.com wrote:
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > While we are preparing for reviewing the patches, we found the following
> > > issue/warning.
> > >
> > > Test Result:
> > > makecheck Failed
> > >
> > > Outputs:
> > > ./test-driver: line 107: 14830 Bus error               (core dumped) "$@" >
> > > $log_file 2>&1
> > > make[3]: *** [Makefile:9726: test-suite.log] Error 1
> > > make[2]: *** [Makefile:9834: check-TESTS] Error 2
> > > make[1]: *** [Makefile:10228: check-am] Error 2
> > > make: *** [Makefile:10230: check] Error 2
>
> Weird, it start failing for me as well but it doesn't seems to be
> causing any test to fail:
>
> Total: 192, Passed: 192 (100.0%), Failed: 0, Not Run: 0
> Overall execution time: 0.849 seconds
> FAIL unit/test-gatt (exit status: 1)

Ive send a fix for it, there was a crash detected by valgrind which
don't make the test to fail but it actually shows in the logs, there
might be a way to detect the crash and make the test fail to make this
more obvious.

>
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
