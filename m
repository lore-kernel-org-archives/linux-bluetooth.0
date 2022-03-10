Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49313C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Mar 2022 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbiCJScO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiCJScN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 13:32:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4318CC11
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 10:31:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw13so13464839ejc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 10:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U16ZmmTDiCSjx1EOmAD4qsuYNgzPA4Gbw6z/8dsIdxc=;
        b=kxqSHQplxFmaPwR8FLfv5mDHQKNXRur0Tsfjklco4amD3R+zaKLeCARsxxpQGfWwWJ
         4StzMhTFN29JgJEayEgmlklWGKZ1EA/QAOo6JkwcnSvAJVShaFcPjABplrMTikYnNJF2
         qv0eBTQDr/OUO/bRAMBE141Qu06wtsfjqa+m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U16ZmmTDiCSjx1EOmAD4qsuYNgzPA4Gbw6z/8dsIdxc=;
        b=K51N6An7tJ0LutM0WYugXFRHDUDUTLZowlfMz4cK0W6Yx67P+UpQD4utB9znsoOjgk
         GmypUDAYi7C2Fv1n/d8M7NYispk/gfWTtDAYSHYwDiNskuCTug9h2YP2FxrzmTL9zObs
         0TXX1+00crj89kxcYQTJcENJPuPIOHxWfUuBCjT2y9NCfP0Y9qzuQFpW9cDBBZFx9gj3
         3JDjDozY76D2woxpwJ7bZHPvWmIplQjYPOXFTWP+kFRzPx/JHQsLCIOj3ceKHs9XFeLT
         velIEbMgreVAR5/AxtyQx6Zq/BSi8NUYLzcP9CCOIHwWoeyOufylLCggUAvkLn6aoUHW
         pe2w==
X-Gm-Message-State: AOAM530vprvPraK3YENhV5c4ldyzWnanChEDl414wMkTLzMYy2tlmQVM
        e71l30o7TDNvwWB90MuAng8sWf1z5iRuym6r
X-Google-Smtp-Source: ABdhPJz+3Sdypl+CPlboV1zo2kSkElzNSS7Vegq0cIHMPL+NKBkhPepcUVUTfnOrBiwhjfHgeeaFTQ==
X-Received: by 2002:a17:907:6e17:b0:6da:83a3:c27a with SMTP id sd23-20020a1709076e1700b006da83a3c27amr5203491ejc.415.1646937069012;
        Thu, 10 Mar 2022 10:31:09 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm2025144ejh.204.2022.03.10.10.31.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 10:31:08 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id r13so14047901ejd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 10:31:08 -0800 (PST)
X-Received: by 2002:a17:907:1c1e:b0:6db:41fc:f25b with SMTP id
 nc30-20020a1709071c1e00b006db41fcf25bmr5276136ejc.645.1646937067729; Thu, 10
 Mar 2022 10:31:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
 <3DAED89D-72AC-4D38-A092-D2A52AEEE5BB@holtmann.org>
In-Reply-To: <3DAED89D-72AC-4D38-A092-D2A52AEEE5BB@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 10 Mar 2022 10:30:56 -0800
X-Gmail-Original-Message-ID: <CAO271mmX+jMbcuskH23FnWBZc2Or05wLuAc9n6B1Or4g145OTA@mail.gmail.com>
Message-ID: <CAO271mmX+jMbcuskH23FnWBZc2Or05wLuAc9n6B1Or4g145OTA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Katherine Lai <laikatherine@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 10, 2022 at 1:51 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Katherine,
>
> > It was found that a change to the default settings for
> > MinConnectionInterval and MaxConnectionInterval in main.conf broke
> > some of ChromeOS=E2=80=99s keyboard HID tests for only certain Bluetoot=
h
> > controllers. These keyboards aren=E2=80=99t able to connect to the devi=
ce.
> > Since those connection parameters improve the connection interval for
> > most other chipsets, we want to leave the default values but have a
> > way to have an optional override to address problematic models.
> >
> >
> > Proposed Solution
> >
> > Adding support to bluetoothd for an additional config directory
> > /etc/bluetooth/main.conf.d containing multiple files which will
> > override common params. Override order will be lexically sorted
> > filename order. This pattern is already used by Linux distros, for
> > example there is /etc/sudoers.d which files will override common
> > params in /etc/sudoers.
> >
> > Users can add override config files to /etc/bluetooth/main.conf.d
> > rather than directly editing /etc/bluetooth/main.conf. This is more
> > friendly to package managers since BlueZ package updates won't cause
> > conflict to /etc/bluetooth/main.conf.
> >
> > In bluez=E2=80=99s main.c, merge the params for each *.conf file from
> > /etc/bluetooth/main.conf.d with the existing /etc/bluetooth/main.conf
> > in lexical filename order
> >
> > /etc/bluetooth/main.conf.d will be configurable at build time, e.g.
> > with ./configure --main-conf-dir
>
> actually I rather not do this. Let met try to explain this. In modern dis=
tribution layout, the /etc directory is purely for the admin of the system.=
 They can do localized changes. Defaults are meant to be in /usr/lib/ actua=
lly. And override is also meant that an /etc file can fully replace an /usr=
/lib file.
>
> We already structured that /etc/bluetooth/main.conf is optional and that =
package managers / distros should only install it if they really know what =
they are doing. If an upgrade of a package overwrites /etc/bluetooth/main.c=
onf then it is doing something wrong (mind you we don=E2=80=99t install it =
by default).
>
> That said, some time ago I discussed with Alain, that fundamentally you f=
irst need an option to identify your controller, what firmware etc. and the=
n can decide what to load. That thread ended and got no further discussion.=
 Based on that identification we wanted to allow tweaking certain set of pa=
rameters to add known good parameters / workaround to broken hardware.
>
> If you say, that you already know all of this anyway upfront and your fil=
esystem is specific for a given platform, then use tmpfs for /etc/bluetooth=
/main.conf or alternatively, we actually introduce support for CONFIGURATIO=
N_DIRECTORY. We already have this in iwd and it would make sense to just su=
pport it.
>
> The CONFIGURATION_DIRECTORY directory comes from systemd (https://www.fre=
edesktop.org/software/systemd/man/systemd.exec.html), but since it is just =
an environment variable for the bluetoothd process, you can do with any she=
ll by just setting it.

If I interpret this correctly, the reason against this proposal isn't
really about the location of the conf (/usr vs /etc), but rather that
BlueZ intends to use the main.conf already as an override (so there is
no need for another override), is that right?

>
> Regards
>
> Marcel
>
