Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282C1C004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E594B205ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6sU+BN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEGKNa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 06:13:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37423 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEGKNa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 06:13:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id 143so11935873oii.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A76qJ/uukd4zYuD7nF3rqvMTIKIq13UzhmHLftdVehk=;
        b=F6sU+BN7LCGhexxMHiy5YoET6D4yoEOmAPjCRSDIxRGE8kJLdv55GBZaBJucqTY9Ko
         KCvpJ0z1l2g9kGvofm5max7mOO7VqVHtZ3fnvFm6oN1oi27zdjxlSiXIbNCzIqaUbuSM
         9jd5Fs6fCvRdThhuXnGEy5ngYGr5rNP44HGOPW72BftDhbHK940KdcZQIqFIyid61Iaw
         rZ+plffN5ko13Ag0/EJNM7stWpnW5OcCviEq2Keu9EtP8kHSLaXue19F+Up7hoDT7Atg
         43lVVLbm1OfcNUTLcuh++iZW72raXiycX1HSXgn5jCFxzxI6CbkaS43Zj8aMJoOnl00t
         fb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A76qJ/uukd4zYuD7nF3rqvMTIKIq13UzhmHLftdVehk=;
        b=cUBF1z92ZyPxMKBllbn9bpJcRlcQdXzvY/jWqgOJmuMlq8j7AmOPNURfVoIU9tiYLH
         O6DyvWp4ThVSer5XCQKAmbdWdkXTP5bUc1Bhol4v0DlshgL12lgnrqcRHhdsz/hAfoRm
         tozhEX/MrOUj5HWCcUWA5HceSGLXOegZBM6SK+6QsAMw7+hyNWl86zK+Kgsa/tTmDphU
         RVRyO2ODEdi1YFbHzZ8iqCpV+1/mc+e+H1aKAf2Pz1RljJr9flOqkRAA2mTvTFTQYFdi
         STPMohT+xJOuqL5UWvwMwDYPNkh3H/Ei7SQKmF8Zm0mj2W7Fm7a7N9OkglmSirFWZqBI
         HYqg==
X-Gm-Message-State: APjAAAUTVytrrx18UPnPTi0W9RnaeJ49mXI2rlF1tsuI5a/9MQFcZ3a7
        pQiBWRe+KBZUD6cDqkBHXLMgafDTZLPMn+9bDkE=
X-Google-Smtp-Source: APXvYqyrPe6o1ZMt7OQ4yE02gTZPsx9HS1YJedu43ZiGyUAVCejArbBF6+Yu2+Ap66WadLWyn/EM3qC7Pqk1++4smF4=
X-Received: by 2002:aca:d984:: with SMTP id q126mr2036852oig.108.1557224009220;
 Tue, 07 May 2019 03:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190506124310.19151-1-luiz.dentz@gmail.com> <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali> <20190507085255.zplj5ddopl3z5n2v@pali>
In-Reply-To: <20190507085255.zplj5ddopl3z5n2v@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 May 2019 13:13:17 +0300
Message-ID: <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, May 7, 2019 at 11:52 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Monday 06 May 2019 15:02:25 Pali Roh=C3=A1r wrote:
> > On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > I hope this fixes the problems you have been seeing, it should at
> > > least take care of the issues with wrong order of SelectConfiguration
> > > and restoring the exact same endpoint used last time.
> >
> > Hi Luiz! Great, this should make bluez to be more deterministic.
>
> Hi! Now I looked at it and in cache file I see:
>
> LastUsed=3D04:01
>
> What would happen when A2DP application (e.g. pulseaudio) register DBus
> endpoints in different order? Or e.g. do not register some endpoints due
> to missing codec librayr (aptX).
>
> I guess that in this case LastUsed information stops working...

It would most likely fail at SelectConfiguration and then try with the
other endpoints.

>
> Should not be there stored rather dbus endpoint name identifier?

Originally I tried to avoid having the local endpoints because of this
problem, but now that SelectConfiguration can fail it shouldn't really
be a problem. At least with the seid if you have a system that didn't
changed the order or number of endpoints it will keep working as
expected, if we choose to encode the D-Bus connection, etc, as soon as
PA is restarted, the system is rebooted, etc, the D-Bus connection may
have changed making the stored values in LastUsed invalid. Anyway
chances are the LastUsed is only invalidated if you update PA, in
which case there could be new endpoints or a change in their order and
package can also provide a script to clear the LastUsed if that
happens, but then again LastUsed setting does not actually store the
configuration just the endpoint so SelectConfiguration has control
over the configuration.

--=20
Luiz Augusto von Dentz
