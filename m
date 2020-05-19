Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C883C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 23:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE20920809
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 23:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkQ/qmxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgESXNA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 19:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgESXNA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 19:13:00 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E97C061A0E
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 16:13:00 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f18so964340otq.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stvyxgOVhN6x79FFoaJ8USdkipzacyWPaSvb1e3IQXE=;
        b=mkQ/qmxqx21EiOa/6UFgRw2Rrk6n4L5eD+g+gsAbx0UEbmXAKh89XoEhWsrqt99dID
         s/jsywwShqhRv47JajoVLoklYMrBvkIAcD37rUENuSQP4dduY8A6Elwup1ioWyr0YfYA
         7CvIpiTbYIuM+fUeyqkjUnhHkonf2V4b+iunw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stvyxgOVhN6x79FFoaJ8USdkipzacyWPaSvb1e3IQXE=;
        b=h2joUnBBy9KvyWEZuaOuRDDCeAKIQMuhY/ePeYSZdlqHPIWye5ZLh/85Pgg78bzOlP
         skghF1NJCjSBYBFASXvY/B6aijTm+6TZ8aF+KWHmnfcgH7bRCi9pGkV6hapKiidflrjG
         h22nojhwgnD5AZ16Kx1bVrEvY+X5VgtqqXm8v712TGAtxQYWYczwFMjGnA6wyvPf5hfi
         zLB6OW6/n3KuM4uoRrjLu981rAE5anidM5jfG+QJ6LyKSTpBWA8mjyNv3VbBabd4ffxd
         fQtTH5ilpIdZFKTOBGaJNgIFw9P0RE5ufiPK4GbD5M4P3k4MRwr7s9L670+kyCf36Ab0
         aQLg==
X-Gm-Message-State: AOAM5309niipNVslfetU02itSm+THeksvSE44LlkmLmXnre5/XdFxwwL
        PEp6xFFRq6jJQn94+0pNxdVqFRcSeemfnaTPfrGVZg==
X-Google-Smtp-Source: ABdhPJxRhvkU3jwWrR6D+BdhobSEAmgd3NIhZxDYF+KnSc77zvDL1Lr878OGw5npho+DQllCz2WaVgnF8yjVgPIBHMM=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr1121360otn.70.1589929979485;
 Tue, 19 May 2020 16:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200401221320.12105-1-sonnysasaka@chromium.org>
 <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org> <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
 <68C2E4A8-29E0-44D8-9D2F-F4E2354DE419@holtmann.org>
In-Reply-To: <68C2E4A8-29E0-44D8-9D2F-F4E2354DE419@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 19 May 2020 16:12:48 -0700
Message-ID: <CAOxioNkw8g90tVwQjqgdpX38__f17JHHTTsqBZwCjEkjME0Zyg@mail.gmail.com>
Subject: Re: [PATCH] device: Add device type property
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Caruso <ejcaruso@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

After giving it more thought, I would like to propose that this
additional property corresponds with Device Type as defined in Generic
Access Profile:

As stated in Bluetooth Core Specification Version 5.2, Vol 3, Part C
(Generic Access Profile):
This profile defines three device types based on the supported Core
Configurations as defined in [Vol 0] Part B, Section 3.1. The device
types are shown in Table 1.1:
* BR/EDR
* LE only
* BR/EDR/LE

Therefore, to be as close to the spec as possible, I propose that the
property be named GAPDeviceType, and the possible values be "br/edr",
"le-only", "br/edr/le".

What do you think? Thanks for reviewing this proposal!

On Thu, Apr 9, 2020 at 11:51 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sonny,
>
> > Thanks for the feedback, Marcel. Will come back with the modified
> > patches based on your suggestions.
>
> I also meant to write that the name =E2=80=9CBearer=E2=80=9D might not be=
 the best either. I am open for suggestions. Also if it is an array, it nee=
ds to be plural of course. If we start exposing BR/EDR vs LE or its combina=
tion (and we might also consider HS even while not used these days), then w=
e need to be consistent with our terminology across the APIs.
>
> Regards
>
> Marcel
>
