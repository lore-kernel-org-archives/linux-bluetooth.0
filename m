Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0828C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 15:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjCWP0Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjCWP0Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 11:26:24 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D71DBB9
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 08:26:23 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17997ccf711so23123359fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679585182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc9nL3Z+xSiL69kxjUGEQvhPpICpIf77Iyt6i+V1mnQ=;
        b=Im90CwK3Tj0F0p/mZCOfdv63rC5TqQO6wIUYvEuc8Xe4FBpttQgAH49CZrn8HtUVL+
         7O/wHBgP4CrCfw09hA9wfbN5XLRnk5cCM+RavNtMjTj+BaIXamdogtK43iHmTSZXKP7x
         PGmXmV1msyS/My3BgbQVptET42CJKgL/xOiAze6zrBNrhsAFElgc+b6s/+mffJb/ZeWn
         EOBdv4VHEoleCK63ay6Tyd0ZicUyNKAukpBV1wT5gKEBcyIVx1aP+BzGix/TCdf0ILdY
         DpV+Xf1xaSRXIz3GXxMJT7dbbTyhtPbb2keHKPaTifvxycGi8po3aJa3zsY53MjXWAXO
         JxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679585182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc9nL3Z+xSiL69kxjUGEQvhPpICpIf77Iyt6i+V1mnQ=;
        b=xLIWPYOBe2ILGyhTH39UxfP/t41/nzsmj61Nk74+0vIyR11xyii62otsbbqfExxZkM
         nJRvyM3dS3WmBAGYn8LecPpuv0VXuy6Ks/xGnbr5btGaI5k2WSN2uBJyQ9QjmGt0CiTq
         pSMoSGFoql4K1z7Zp4f06S4NqNCRN9+UaXoVIoE3aNhLM4mvhE9YLibM/cN32UUifrkS
         DfK8ngnnlo8zwQxyw8P4mVHxrEHkxb7FXFpTSdjJkXsYdpz7APPMsYoOzw1IAVx+7Uff
         vB0Cl5NM89kcpIdz5vqzWE0zKY6ZYWsRRT0rr4aYk7YlfiBuOYJ5cbWmEDRoGU1wZWZC
         pWNA==
X-Gm-Message-State: AO0yUKU10DdArC8z5gg3NA4SbMOEFldtgnvwTn/XB0guiDuGciTPWRDb
        nl4cYwQltHFwXF6ezz53jo8cFZ33yW3a7rteeV4=
X-Google-Smtp-Source: AK7set+1gvicxGZLmRTGEaWwp8V6gIhfsWMGHwUPFYRCTC9ZhN1Kzjh5bDQqOTa6CTfn9iIl7AZCyc4gE7OZWYMWlmk=
X-Received: by 2002:a05:6871:8f01:b0:17a:eab4:b67f with SMTP id
 zz1-20020a0568718f0100b0017aeab4b67fmr1254990oab.10.1679585182615; Thu, 23
 Mar 2023 08:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230322012428.2662664-1-raul.cheleguini@gmail.com>
 <b48ef5be-a64e-48a1-2b43-6e72cc3a0f9f@molgen.mpg.de> <CACk7upz0sLrCeb8sm04PD8F0wxXm8yfBfpaXkRae=55F16EMig@mail.gmail.com>
In-Reply-To: <CACk7upz0sLrCeb8sm04PD8F0wxXm8yfBfpaXkRae=55F16EMig@mail.gmail.com>
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
Date:   Thu, 23 Mar 2023 12:25:46 -0300
Message-ID: <CACk7upxmobMGDS=x7dE+MS2_T1Dj3WRuzaPjcZVFLm+OE+pmSg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Partial support for Actions Semi ATS2851
 based devices
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>
> > I=E2=80=99d also split this commit into two. One for each quirk.
>
> Thanks for suggesting this and reviewing everything else Paul.
> I will split it in two and improve the commit messages.
>

Hi Paul and maintainers,

Please disconsider the patch in this thread as it has been split in
the following two:

[PATCH] Bluetooth: Add new quirk for broken set random RPA timeout
for ATS2851
https://marc.info/?l=3Dlinux-bluetooth&m=3D167957918920723&w=3D2

[PATCH] Bluetooth: Add new quirk for broken extended create connection
for ATS2851
https://marc.info/?l=3Dlinux-bluetooth&m=3D167957998621276&w=3D2

Regards,
Raul.
