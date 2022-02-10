Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4520C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 02:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiBJCIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:08:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiBJCIU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 21:08:20 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C910E1
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 18:06:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id o19so11173740ybc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 18:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NDvs5bGzkppQbiqg0+oQpSG/hspy5IETOTrNFPWggfk=;
        b=K+xuQ4/Cbx/Ip0vimoQjRYjCOqDnoJpBDcm1EzxUiC6peWML+nyqZibFjlvpDqCAcX
         GfmhDNxK6Dp39OmZqLWlV+2RpIVCDfUmuSO5+MJuMVtAP/386R+4ope80/U6bgeTeXMr
         PKyBaFwt6i7i/oHjj+7oiS2vXqGrNTIzVN4+U3OqO21NPp1ClDreEDbmLAN4JdxCAH5e
         fAfZVYqwwPtMR0SbS93R/uhn/NTc7uLP8zHVXcm6eZch2b5mJ8v6Ty2X6HIKy3C+3P6h
         oy36xyEPMdUWOeac66ecYAf6Nqfvi7tq6PcpzaWNITjrhrHFIrSn8KfjgpGkC/pO2vKW
         x4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NDvs5bGzkppQbiqg0+oQpSG/hspy5IETOTrNFPWggfk=;
        b=ryzt9V0l/ZTljQzwN1Byym0cvh+TQqJ1uDfIDjxRetn1Hu8djlJp0uzjWvISZBR/3S
         rkxTbeGOtV41usJfi1uZQ6JgW33qxkc3etQa1gqbLvwUTIreKW45u87l2vZpxcSkJEyZ
         NiBYcSlre47vchBskNSSExhI1oP1Ct6wFfcMuflcxbWkUEJLGEMzhYJwVYLsD3dSFdLa
         V0hTFCpGpEgAX6KFzuCk23zrNqs6Bdz6g+1SmRZM6syO0eOzkhaXNUfd3IrVbBaeM9Ws
         kLBlyaXMjopY/Bb3lynoivHOy3XlmJ11g0EZmwdyenDvohnqxo5QVtW0OERjwM3XG64a
         0V2g==
X-Gm-Message-State: AOAM533KS8qHGZA+UvIdlmjYTLJuHncNkZu9JCJBEfZcn9tZzrMhvReY
        3wUVW7w/BLDJ674+d2tLfec4rdQwwnnx+wUiZUhkvov3MfE=
X-Google-Smtp-Source: ABdhPJyr/9hB4i1+ENczWOp4XNIZZQgGr08KwkW+qXxpNiWafY82nVtN6Eiy+U48gWVw0hh9cMbmIt9qj4DzpOL33mY=
X-Received: by 2002:a25:3f87:: with SMTP id m129mr4776969yba.188.1644451856753;
 Wed, 09 Feb 2022 16:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20220208210541.3883437-1-luiz.dentz@gmail.com> <6203001a.1c69fb81.8c8ae.c2cb@mx.google.com>
In-Reply-To: <6203001a.1c69fb81.8c8ae.c2cb@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Feb 2022 16:10:46 -0800
Message-ID: <CABBYNZ+rqWTNfLvbVXt33xGEhMtp7Bc-q8cpR39F4hr+_Tx4vg@mail.gmail.com>
Subject: Re: [BlueZ] adv_monitor: Fix spamming errors
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Feb 8, 2022 at 3:43 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612350
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.47 seconds
> GitLint                       PASS      1.02 seconds
> Prep - Setup ELL              PASS      49.50 seconds
> Build - Prep                  PASS      0.73 seconds
> Build - Configure             PASS      9.70 seconds
> Build - Make                  PASS      1398.39 seconds
> Make Check                    PASS      12.21 seconds
> Make Check w/Valgrind         PASS      513.32 seconds
> Make Distcheck                PASS      258.23 seconds
> Build w/ext ELL - Configure   PASS      9.62 seconds
> Build w/ext ELL - Make        PASS      1372.14 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
