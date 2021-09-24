Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7A3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 00:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4202261152
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 00:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhIXAS0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 20:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXASZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 20:18:25 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 17:16:53 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id y141so8352729vsy.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5kmWLvX9IoKnNl+s7q8bRDvFqhlNkK0L2wOwBjh6b8=;
        b=LvI/pJV0xpHVc9n5DKVwPxX5yKI5xYvByNxCTrNx2t6/ibnEvvxAAVDdCH/6NQOkln
         VtE5zC16J2RAvzwi/IGL5KTi352oBCa2ShNNkXSalk8ebZ9VUGsRHdN0qxq4caBw8kP+
         WGGqXQq06ulzcULsdD4n9C3IegZysO6fHKpAdhFrFjm3PFNdb3Msp8WP0Mycndd4f7TW
         wBBAy0vLUOjjzrBR5zG9IQqvUI9sqs9EFScC1bPEeec3H5cxi+b8qRa0aKA+16rtj+9q
         rNhPPKm7EN1Dp/Sf8k9lkzrhcUrp1KsS68aUJ+38WzmVvRDU04r3oPG0PBOn2SJ3r1mW
         CMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5kmWLvX9IoKnNl+s7q8bRDvFqhlNkK0L2wOwBjh6b8=;
        b=srO2VvjcBo4VPCsq+2xeztoWFYI9bdyF40DZTnm4zRB4thh87VbMA9Sqpq7V1YnoZO
         NEN6rWzxOF5WQx6Sn/9iH8r33VUq0WNo413Pns2kxNmaazgfBnxgRSZEjJ9jVE0U+VVv
         Nj6P4ZGsUqD+bCVN091TKFl2z8UY7MMuMmHc9m0WvGXTcnZPDMrhqAPi83qzJElVSuqI
         Pa4lswjOn8Xmd9eZgKIz4WLMLkqv4ChiNOTrtZJ4HS1gYYJWMZcEFwWuh/Ikcwnof8Rq
         YWqE1E0faWl/56iOZXSs2zr+0kOd+QOOnx4MTFMKZ34hCouB/2c8aIRBVPAikqe4zSve
         7ytA==
X-Gm-Message-State: AOAM53328/dCLzzRiGcfQGUf+S3X6oZOKywm/1Sg0RXAtaDHPvAgx+Dj
        tC5vZ8U3NvxKcNi57GWgnqlA4t3YO4RgPwk/HX1670Cc
X-Google-Smtp-Source: ABdhPJwg2MSnD4/fPI4PmgTCSHkIznQWGdOFVTB68MZTrxPX4KVbN/DHIbUG2ntd7p3MiUejEBPqr1ejGLVl/0UcKg8=
X-Received: by 2002:a05:6102:318d:: with SMTP id c13mr7647777vsh.10.1632442612285;
 Thu, 23 Sep 2021 17:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210923161816.Bluez.1.I2d4be6229452939310ccd165bc949c0f6708dd20@changeid>
 <614c3dd4.1c69fb81.97ea4.30cf@mx.google.com>
In-Reply-To: <614c3dd4.1c69fb81.97ea4.30cf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Sep 2021 17:16:41 -0700
Message-ID: <CABBYNZKG4EFbVP+E3od6-9o6jDJdyqndZegzXpDPMSvY2E6Xgw@mail.gmail.com>
Subject: Re: [Bluez] device: Check both bearers's paired status upon removal
 of connection
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,


On Thu, Sep 23, 2021 at 1:43 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551527
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.54 seconds
> GitLint                       PASS      0.95 seconds
> Prep - Setup ELL              PASS      52.48 seconds
> Build - Prep                  PASS      0.47 seconds
> Build - Configure             PASS      9.60 seconds
> Build - Make                  PASS      221.38 seconds
> Make Check                    PASS      10.32 seconds
> Make Distcheck                PASS      263.71 seconds
> Build w/ext ELL - Configure   PASS      9.62 seconds
> Build w/ext ELL - Make        PASS      208.63 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
