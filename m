Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741CFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC272075B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GISbxeCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHXSY5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHXSYz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 14:24:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB3C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:24:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so3051618ejr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1XFwEzoiD+SioB0C34JWH1YNNT6L1PvGIichsFvB7Q=;
        b=GISbxeCQ8sn95jeTrha8+Hwmr5DQAquFgSUijv7NmkaRKVQkWlvsSdEq4coGS386bI
         qk9umOqcH2bFwmBeiqb1UkqFwrQ5AcmfUp0ASytqy1XpH7nNrHVIrNielTLTO2g/O7M0
         aKMkE+KKDHe2upF2G0YFSSXnuiO6Y1HkKH0QVzYPNv8jvwmI6Nl8aXWylDnAl02ptuIA
         5SPUBL9r4vKXQfA2g3AjTKbaatwgSYvvDgZYtk1btTyBzrtzdvIMCh3QEu4EqVSC+EVI
         A5wVJ4P32P943aU3HvbUuZ0Rpc26le8wEntyKWC3h/iZQGgynfYDGIFQhL/rZW25wuSG
         amKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1XFwEzoiD+SioB0C34JWH1YNNT6L1PvGIichsFvB7Q=;
        b=YnSLEVcq2bePKH2vm/izF317nKlAiTNBJ1TlTzexb7Fxxbh8t0Mv8dZxHun0xGSTlP
         jFL6m0BJzQ3z2FIPYwQOCybpYtOfabuHjh+pdkgnc3i5/QL5M4s6lKBvOs8P+CBkHxko
         bsM13VNvCIOc8HB87YPVEymP8ZdfN/uyyoTc4AMINKZoVO7AhEJGKY9pz4KZB251Jtwu
         JJnInAuJtmYxgOp+K0bDsDjmnSQ6+IjbJXdpeiNwIXXWRzINGS7GpuQY96miyiv8nID8
         /Iza0bO5DElTdrqS4WVeGEGOH3IPRPt/xCzhY7RuliORPLodtLK7SEmDJDwHEecIms8i
         oQgQ==
X-Gm-Message-State: AOAM530sV/8Sx4gmBCzAGKvcZg8aMXodMx51insXYMwKYGi8UOt9aMBZ
        ce1yj0EGgdnU+mIBg5kO7Zzy+e9fiHcTbp0/P12XMA==
X-Google-Smtp-Source: ABdhPJzfMAPoXZAqTfAxZpVn1xvBPwMIoan2ZR2WZu61EswhaSnBGwlheRPpNvH+Cnq+TIQg9mgI/zoVmPA0vuMyQPg=
X-Received: by 2002:a17:906:560d:: with SMTP id f13mr6613583ejq.102.1598293492732;
 Mon, 24 Aug 2020 11:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200817135606.Bluez.v2.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
 <CABBYNZLfmuLHvvMUwz_-Lg=q5aFYt6S3UEV-SA--ESmRMX4DVQ@mail.gmail.com>
In-Reply-To: <CABBYNZLfmuLHvvMUwz_-Lg=q5aFYt6S3UEV-SA--ESmRMX4DVQ@mail.gmail.com>
From:   Yu Liu <yudiliu@google.com>
Date:   Mon, 24 Aug 2020 11:24:16 -0700
Message-ID: <CAHC-yby56jfNS7Lys0sDMpjV00z7tjWcXnJ46J=W=Ax+yY8OmA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] adapter- Device needs to be in the temporary
 state after pairing failure
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I just sent another patch to address your comments. The issue this cl
is trying to address is that when we pair a device by calling
pair_device, it removes the temporary flag very early on, then it the
pairing failed due to reasons such as failed to connect the temp flag
won't be removed and the device will be hanging around forever. Please
review again. Thanks.

On Mon, Aug 17, 2020 at 4:24 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yu Liu,
>
> On Mon, Aug 17, 2020 at 4:04 PM Yu Liu <yudiliu@google.com> wrote:
> >
> > This caused the device hanging around as a discovered device forever
> > even if it is turned off or not in present.
> >
> > Reviewed-by: sonnysasaka@chromium.org
> >
> > Signed-off-by: Yu Liu <yudiliu@google.com>
> > ---
> >
> > Changes in v2:
> > - Fix title length and format issue
> >
> > Changes in v1:
> > - Initial change
> >
> >  src/device.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index bb8e07e8f..93e71850c 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -6008,6 +6008,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
> >
> >         if (status) {
> >                 device_cancel_authentication(device, TRUE);
> > +
> > +               // Put the device back to the temporary state so that it will be
> > +               // treated as a newly discovered device.
>
> Use C style comments /* */ above.
>
> > +               if (!device_is_paired(device, bdaddr_type))
> > +                       btd_device_set_temporary(device, true);
>
> Hmm, are we perhaps removing the temporary flag too early? Or this is
> a result of calling Connect which clears the temporary flag? Then
> perhaps we should at least if the upper layer has marked the device as
> trusted as it should indicate the device object should be kept even if
> not paired.
>
> >                 device_bonding_failed(device, status);
> >                 return;
> >         }
> > --
> > 2.28.0.220.ged08abb693-goog
> >
>
>
> --
> Luiz Augusto von Dentz
