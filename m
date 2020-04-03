Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C8C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139892080C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VeTuK82O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404225AbgDCRSw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:18:52 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33073 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgDCRSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 13:18:52 -0400
Received: by mail-ot1-f47.google.com with SMTP id 22so8105449otf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mx26Rtzqf+cusG7rWEvDZRiUpFQb0BDrNNKWpw4tv5I=;
        b=VeTuK82OiUJFRWT05NUEHcuXXKKJqr+iYp8tLnSGRNvIq9YDIuyKJp6OF2QTRf/Lr3
         fARWBzFvBLlawWB4vP8rtk5/Abj+1gehOGSYobGYNHSY1BiQcJj73FLutdvaY25wiQIS
         dn4JwE3A97sMhkh7DDZPVA9oH4cg3F0empdoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mx26Rtzqf+cusG7rWEvDZRiUpFQb0BDrNNKWpw4tv5I=;
        b=P6k7z6z84Dj4H/7riUG+MsBwuWtJFeZmXZK5EQEAzxUpGFWwST0Uh5FsmsG4Mc86wp
         atFvuVG9VbmJcRDQUDcQXobueV34enNGAmyPqEIZOPZKUQgSm1aIRc9PV8u++YPm9h+m
         7u+KNjlw57YM73WcY1aQ0yyUL3dqd4JR+qNfr9H2RpR8u3DLThSKEHtabRnY+Fg347wy
         ArcZ8y7XudPc5ru9ia6ocDR0U2qQyNPTWC6PV4vptFOPd19q/ttk2jMjXCt7QIo1KkLW
         W6wROsQKbLBWLGcSx8Eo3xUvPwaL6clBlbGx16Dqc0ePYa5dbsjz4GDSPcTsJBGw70iF
         3AxA==
X-Gm-Message-State: AGi0Pual830dBsijN9HMxKd9FpMORzybmA+pk+qlR25AP4wWHW4kSdvo
        z2vPFI2WJJrg5t2oESNhtmh4x3LdDUtlGgPbYm0+ew==
X-Google-Smtp-Source: APiQypLqHHPn01f2c6swrQ8fXiNfGcy/Z+pF9OF1J6s6cBLog9xwJ4JjyT7XV9ACPYrDMr3i6tsx7/TNZZfZXglIh+Q=
X-Received: by 2002:a9d:1b6d:: with SMTP id l100mr6792151otl.70.1585934331815;
 Fri, 03 Apr 2020 10:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200331003355.14614-1-sonnysasaka@chromium.org>
 <7CA6DAE1-09E7-4CEC-BA78-E8C4E104D92E@holtmann.org> <CAOxioNm27+wmWeCp+hoWCF-5W1=xm_gdvn3xWbDJVeYE=wmyiQ@mail.gmail.com>
 <CC80769E-941D-4AD9-AFB3-C24DD84E940D@holtmann.org>
In-Reply-To: <CC80769E-941D-4AD9-AFB3-C24DD84E940D@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 3 Apr 2020 10:18:40 -0700
Message-ID: <CAOxioNnC-sC1SxcK-=VjMLQa8jmQ6DA-uKX3cLfGK=2zXN6PcA@mail.gmail.com>
Subject: Re: [PATCH] tools/hciattach_ath3k: Load BT board data based on
 country code
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, yixiang@google.com,
        Zhifeng Cai <caiz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

There is no need to apply the patch. I sent the patch because I didn't
know of the deprecation plan. Thank you for the feedback.

On Fri, Apr 3, 2020 at 9:56 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > Thanks for your feedback. I will take note of this deprecation plan.
> > For now, Chromium OS can have a local patch to accomplish this and in
> > the future we will migrate to serdev instead of hciattach.
>
> I can apply the patch if you are still using it, but be aware of that fac=
t that we are going to kill hciattach latest when we move to the 6.x major =
version number.
>
> Using serdev is a lot better, cleaner and simpler in the end. So I would =
urge to make that change rather sooner than later.
>
> In addition, I would really like to kill hci_uart.ko driver as well. That=
 one has become a beast with a bunch of hacks that will eventually backfire=
. Since we have serdev now, I think each vendor should get their own driver=
. I have posted examples to btuart.ko and bt3wire.ko drivers that could be =
used as base.
>
> Regards
>
> Marcel
>
