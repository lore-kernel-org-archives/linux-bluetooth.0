Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17273EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 14:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbjFOOhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbjFOOhJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 10:37:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012DE52
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 07:37:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso1612069f8f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686839827; x=1689431827;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxx1tmOUiKfYcT/P4r7xpeitO/eK6ECGlVf8u10BuwQ=;
        b=bqbCnVsQs57qDlbohh1QTQIGf7bZ2TgiU8OMVRGcUW5B9wRUmmVYrGUMu8Uh+QN2Fn
         n8LvNtH55weXQUQtzzWWydFLvNwOVMc5S5KF3PPXiyzOFe0mtzh/lLyeRSjEcKxgbXfG
         Jf/2yXnGlVX1Q7yra5YjOwp1pmr4/Ys8hhOCDDFp7ePYdOc4xwwHHpfsX1Tz28/cQfX2
         ykf50Q2d8dpd5t/fx7LXUUBXSpDyrmTEvQvg3herSPUoFEunAKtw79lgAVczfUOnnqsT
         vJFBq/3Hk/TrtK2srPCJPylwi0YLyBUD9aoHiwFP9W6I5f7i7cXaEr6u43BOMFz0ROJj
         uvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686839827; x=1689431827;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxx1tmOUiKfYcT/P4r7xpeitO/eK6ECGlVf8u10BuwQ=;
        b=S9s+hA/VGMjFyHZaw3T1hCvlds1p4bV4hrE4mrN3cOiNjL4RF45YZ63/MV/DjDChIF
         TvxJDi/V7BPUSH6nTrglUlz9iMX5tj+LyDR3rBhqNxV8Y5TUj9kD1ybtqiDzLLgzOmXx
         gVdc1NLOF12/VCI200Stxy7LHTbxob7CwU1UKvbMrExYovLbNluxu37py0a7OSHz3E58
         wb0d9WzDMN76Y3xNTaOwRrcQbhqYqRk0LZzHvMXwPRzIpKRbVLEHR7XS7yXqS4G3UB7I
         57d7ZMpeAAbNF335KVncYyq3kY5bbJYOFjZpWMHjgscBnZLTzuSueI82qAku4X2/Ajw7
         JZLQ==
X-Gm-Message-State: AC+VfDwhNXjdbSGzFKoFSbpMC/jSBFTM79AMhXlP4A+QU6CSSrogxmOM
        tHUOG9v7mGb2t4WU120/eSxq2GflV3DpqV/+C1DBGeqqZDEuHLmS
X-Google-Smtp-Source: ACHHUZ4YDumfojVWFr68u1vszP9x9SoA8nDoWbAuHGMfVqgCopOGjHpgoUMWcBj5Ir1IGYvY33+Xg22Mu/HYodH/9QQ=
X-Received: by 2002:a5d:4d4d:0:b0:30f:d32f:c42 with SMTP id
 a13-20020a5d4d4d000000b0030fd32f0c42mr4484926wru.70.1686839826844; Thu, 15
 Jun 2023 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHe0yEZ3_OtS_2g9To6HyBiO359wiiazyGrUNJ2CsuC=gRB4Rw@mail.gmail.com>
In-Reply-To: <CAHe0yEZ3_OtS_2g9To6HyBiO359wiiazyGrUNJ2CsuC=gRB4Rw@mail.gmail.com>
From:   Jake Rue <jakerue222@gmail.com>
Date:   Thu, 15 Jun 2023 07:36:55 -0700
Message-ID: <CAHe0yEZNjWjj8=Q2fZZxMxEPWsJeW9DJNWbUucp2zEZF2FNtkA@mail.gmail.com>
Subject: Re: Where does the DeviceID Version value in EIR for Linux hosts come from?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, May 16, 2023 at 5:07=E2=80=AFPM Jake Rue <jakerue222@gmail.com> wro=
te:
>
> When I look at btmon output of advertising reports for BT Classic for
> Linux boxes, I see something like this:
>
> > HCI Event: Extended Inquiry Result
> [cut]
>         Device ID: USB Implementer's Forum assigned (0x0002)
>           Vendor: Linux Foundation (0x1d6b)
>           Product: 0x0246
>           Version: 5.4.0 (0x0540)
>
> I am wondering where the 0x540 version comes from / corresponds to
> about the host software stack version (I couldn't find such a constant
> in the BlueZ source code or googling around. But for instance a BlueZ
> 5.64 had this value, so it doesn't match 1:1 to BlueZ). But it seems
> to change slightly over time for different Linux machines.
>
> And I'm also curious about the 0x246 product ID, though it seems like
> that's always the same for all Linux machines I've seen thus far.
>
> Cheers - Jake

It's not the most important thing in the world, but I'm still curious
if anyone knows where this number comes from.

Cheers - Jake
