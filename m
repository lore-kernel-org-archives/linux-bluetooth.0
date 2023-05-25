Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9156C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbjEYJ0W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjEYJ0V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 05:26:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1B191
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 02:26:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d20548adso1240343f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685006779; x=1687598779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6Xjs7JNhv6fDRsOU5aojTEF0agT6Mpp2dZLZN2fQTI=;
        b=UoDXvJhdhLzxEu2Z7q5txkPXNa5koxE0XfcBaKANhlH1elw/1VCRgRtwz75USFvffH
         kv8uxh5UmCX9jP0SOBQvnrJmjqm/jnZOb3pAlPvZYqaSWh6TmEj49GSwAnztLvVPNzIj
         zA9oJZ54ikvou6m95ZOl0zbzqYPUZoQXjCxI0lDXu7wj+7KDtNT8Orp1eB9NFV+vSV+d
         h1iapNCf5FuJucy6dVDs9rWIDqu18kNKbEV3qoZedtNnuL2hdTY5QfuLlGeuhf6JCMId
         V1Yj4uAbFme2N+HXIEP+qypEtqcSvbWK7kGOolUQrVWjkHcG8ilbyr9sska7oYQ59CrS
         PKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006779; x=1687598779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6Xjs7JNhv6fDRsOU5aojTEF0agT6Mpp2dZLZN2fQTI=;
        b=WKK5F3C9MocVokpIp1h8IZLtD/T8W1zZQ1xdGkmgzzqc3JEa4ZksoJLsHXa4wNh3d8
         wwZT2fSUNynOeo+AqnV7zE5qzmXF2el0BOLiO32EGMFEaNC7b+DckCEfElSydsu9Pjp0
         xrnNDyxTKGdk4nWfN6sJ0GJBFV43RcMFEmMrInIaNm2+CFVHXgJQRxIyRVF14D77wwA2
         4HC1w++ckq0StQrg9nhfL02iNc+bYS0MYkuIpqDSyJ+2UDMyhzYHkDW232OinCZ/fRVI
         EgZQ5yNT51ULjJ1lvYVZgys2jH81aUtXfxbGRomsbt5Irx0Jsvz93OEakQOty0/2rlLe
         tfjg==
X-Gm-Message-State: AC+VfDz5Xdz3sRJUwwQJAhUyINHSgFOqwGDjG36mv1H2kJxWp8uKPu5l
        cYuK1MvjMU7cZgFZG5v8BUYb+/O1mCakquuNH9A=
X-Google-Smtp-Source: ACHHUZ4AOfe+OhIjbXkHnf+JwmUwMUcGMoyiJWKkMoR/vit2ZvrtZTefgu3OofKkP308Cw6+0vDAxQ==
X-Received: by 2002:a5d:5966:0:b0:309:3a83:cf3a with SMTP id e38-20020a5d5966000000b003093a83cf3amr2067166wri.0.1685006778927;
        Thu, 25 May 2023 02:26:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d45c5000000b002fda1b12a0bsm1186613wrs.2.2023.05.25.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:26:17 -0700 (PDT)
Date:   Thu, 25 May 2023 07:40:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: Add initial implementation of BIS
 connections
Message-ID: <2426ffbe-0030-44b6-ac06-e4b3b3db93a9@kili.mountain>
References: <e52365b8-f5ee-48d9-ba86-34c4b350c8e3@kili.mountain>
 <744fd69a-c5a3-4e0f-8c47-33096a1cd374@kili.mountain>
 <CABBYNZJ2WSHKiQ0ZtqfNZdxaPY+FVO1=gDeNPwSz2zcKWX6ZMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJ2WSHKiQ0ZtqfNZdxaPY+FVO1=gDeNPwSz2zcKWX6ZMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, May 24, 2023 at 12:11:08PM -0700, Luiz Augusto von Dentz wrote:
> > >       net/bluetooth/hci_conn.c:943 hci_le_remove_cig()
> > >       warn: passing zero to 'ERR_PTR'
> > >
> > > net/bluetooth/hci_conn.c
> > >     939 static int hci_le_remove_cig(struct hci_dev *hdev, u8 handle)
> > >                                                            ^^^^^^^^^^
> > >
> > >     940 {
> > >     941         bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
> > >     942
> > > --> 943         return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PTR(handle), NULL);
> > >                                                                          ^^^^^^
> > > handle is a u8.  It can hold error codes.
> >
> > s/can/cannot/.
> 
> This is not used as an error though, it is more like INT_PTR, that
> said I'm fine changing it if that is triggering static analyzer
> errors.

Yes, please.  There is quite a bit of static analysis to ensure that
ERR_PTR() values are actually errors.  For example, people pass the
results from copy_to_user(), or the return from true/false functions or
they accidentally return a positive ERR_PTR(EINVAL);  All those lead to
a crash in the caller.

I'm sort of surprised we don't already have an INT_PTR() macro...

regards,
dan carpenter

