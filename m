Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC37C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B676303D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhGVR1b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhGVR1a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 13:27:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4271C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 11:08:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i18so9591804yba.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5J0qwBdBS7fcF6aNR2SSsSD6SMyIr5NqfTbUWr3OAbs=;
        b=tYB1uSLrJZSWIfSrc7H/BAQ0E/frZCh33UDSZtvyjDpDKw5t5F82X0PWRdkUPS+qd+
         1N843wGAU8MWmxm2t+xpw7LOcMtSbDYWdBNuDN+QQI9E5+ukmzFTex7gWSzsiq3kyFPz
         emeCYi20WuwaEQGGBLDIDg/y9QQBRO1LigfbR9JgqzeFe2AZ9UhEEEN6dZ+QRhMpG/Mi
         YTxMxEfFdZZl8JSvEqa74ZL3MGG/3icLgyUuUze8Izj3naEsAn7PpLV2IXudr2vb2s7k
         gebj7cTsXKM+wRDXzC565zDOWbs2OoxXOOptXM6ZpEqioI3Okd5z1E6slYsUaK4cKCP9
         PBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5J0qwBdBS7fcF6aNR2SSsSD6SMyIr5NqfTbUWr3OAbs=;
        b=FBJkjPxP72475360riRS+7rXIuWtaZwb1Rpy+9iFTuUlDe0mU5Ty0n/S28WUyB/5GE
         6U3Lcop0ypMb1X+U8zsY9r4dKLqwAssRCBC6+m/y3pdNz9DODC/B9+2dtUwohI9Nv+9X
         Ph83OpwhqhefJHg18Q4jbZMtYq05R3K9b2lLxQFssPuMGxm5+UjvYZbqQWun6JTtDys5
         qU7bC/ZK6Q9GnR2RgkDKhyZuoPvNucKxsX2h/fpbhqz8WgE/dLKbEAMu9Yds0CqXiTb5
         4s+/mRKf8GPurjFAp4aoJX+g8cbhI7JXtz3FMm3NDhYKPnNxlpsdbgYINW2lbo0M+KpM
         k96Q==
X-Gm-Message-State: AOAM532tzRAa9crZ/as1HdZniSfLHS44LXaSEvWPsTsAjEpaKH90Ox2p
        vVudv4mfcWI0gYTfzUu7Xy/FIFR2iQfP+n9+GyI=
X-Google-Smtp-Source: ABdhPJx3CY52ajuTOjS7i3+Z7EeIJiz3wvKCRXq8CgSQygjTOSpfOWSxXww5nXtvaG/nyBrkOU/nvyoS0bBDRadgFqg=
X-Received: by 2002:a25:be02:: with SMTP id h2mr1095352ybk.91.1626977283118;
 Thu, 22 Jul 2021 11:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210630080807.12600-1-kiran.k@intel.com> <20210630080807.12600-10-kiran.k@intel.com>
 <CABBYNZK-bE6vxikRHhxBM_7ucyZqMjxUBY6VEyw_e8C_xxAigA@mail.gmail.com>
 <B7EC95F8-FFDF-40CE-83B6-85861D530FD5@holtmann.org> <CABBYNZKMrq_6Rb9rJKhMU-w=WjznQsVc=yYfDVuxKtEjvtNLdw@mail.gmail.com>
 <87EBBD58-71B1-4712-A5BC-8B53E739DAFE@holtmann.org>
In-Reply-To: <87EBBD58-71B1-4712-A5BC-8B53E739DAFE@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jul 2021 11:07:52 -0700
Message-ID: <CABBYNZJjjxzrSzLHwyzT-KyMOXYArrwVffHd6s=Kn-OLpTZhXQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] Bluetooth: Add offload feature under
 experimental flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Kiran K <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Jul 22, 2021 at 10:59 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> >>>> Allow user level process to enable / disable codec offload
> >>>> feature through mgmt interface. By default offload codec feature
> >>>> is disabled.
> >>>>
> >>>> Signed-off-by: Kiran K <kiran.k@intel.com>
> >>>> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >>>> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> >>>> ---
> >>>> * changes in v10:
> >>>> - new patch added to place offload codec feature under experimental =
flag
> >>>>
> >>>> include/net/bluetooth/hci.h |   4 ++
> >>>> net/bluetooth/mgmt.c        | 106 ++++++++++++++++++++++++++++++++++=
+-
> >>>> net/bluetooth/sco.c         |  10 ++++
> >>>> 3 files changed, 119 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci=
.h
> >>>> index e20318854900..5ca98d9f64dd 100644
> >>>> --- a/include/net/bluetooth/hci.h
> >>>> +++ b/include/net/bluetooth/hci.h
> >>>> @@ -331,6 +331,10 @@ enum {
> >>>>       HCI_CMD_PENDING,
> >>>>       HCI_FORCE_NO_MITM,
> >>>>
> >>>> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
> >>>> +       HCI_OFFLOAD_CODECS_ENABLED,
> >>>> +#endif
> >>>
> >>> That is probably a bad idea as it could lead the enum to assume
> >>> different values based on what is enabled, besides we don't gain
> >>> anything by not having the symbol defined all the time.
> >>
> >> While this would work with dev_flags which are internal and not API, I=
 still don=E2=80=99t like it.
> >>
> >> There is really no benefit to make this a compile time option. And as =
far as I remember I never said this needs to be compile time. Actually I ra=
ther have this as an experimental setting so that it can be switched on at =
runtime. Nobody is going to recompile their kernels to test codec offload.
> >
> > Initially I was with the same opinion, but the problem is the codecs
> > are read at init sequence and the experimental flags are set at a
> > later stage thus why I suggested a KConfig option until the feature is
> > more mature and we can remove the option altogether.
>
> I am fine with the codec options being read all the time. I mean having a=
n experimental option to control the use of offload.

Alright, then we don't need the Kconfig after all, the experimental
flag will only control the use of the codecs e.g. socketopts would not
work if the flag is not enabled I assume?

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
