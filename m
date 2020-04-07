Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7710C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB72620719
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvZP/6cY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgDGQme (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:42:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35788 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgDGQmd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 12:42:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so3820315oto.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hiKdD2CXh3pCaRz4/0Mf/AO2XuDJSsEVnArneEbaZI=;
        b=EvZP/6cY04quyI8OEzNsb9Z+Y2lsABm+s5SScmPPWQU0W+V23AXdR1Hmzf3TAQ6K5d
         q8Z20W1SJXfjCbtx2bQ5wqxvlytFlPft9W72Lb4kwF7ynUkFyJUHzLJAj2LgPAk8dkcY
         DQpesP5NYcbk+wfA/yVV+/tPfgSCndZgL1lF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hiKdD2CXh3pCaRz4/0Mf/AO2XuDJSsEVnArneEbaZI=;
        b=Zy6kTXJ+5gZ86HCsPrAaSXeTpmWQgtCkCbc8VPfmGQNBvl/j0vhIUIq7NDtisFo4fx
         gEtYVqizR25487Zq/ixAT2dRnvfmvuf4oFP+karAS7R/m3cEnoOP9flIPTALbz1vciEO
         EgbvvcIO688AV1wzHzdVthYcxNtt6jiGFiHAQb8CPdcIwSI4ik38srKvoHY5P3cB6nzg
         D75h8c4NR4leFqk1Puq/4iy++LrlXEfY9MiqfVqRIyNfq2tCduHdYkDO2vj6xSXBtdHK
         JIl2BSWsMmy38MGCKfh8kynavpuA0eaBoayCb7Si5E8/Xah0dlozNNeTR30cD9sF3Yx7
         UNFQ==
X-Gm-Message-State: AGi0PuZP6mMCDDeXAv8LZLFc6nhqTu/GxDECZtmyr3gP06CsGLILAZ+v
        6S9+fKDEyjKyq39pzoAXnKcGWu5Xkfe/8E8o3t8RpQ==
X-Google-Smtp-Source: APiQypI2qoQhM82e8WZm1d5Ahe7NFVEQFUsp2rztzIkY8Ig443MVmVqwKgtvjvQE0D2JAnapM0IEG8bO14EWfjt003M=
X-Received: by 2002:a05:6830:2017:: with SMTP id e23mr1480499otp.329.1586277751615;
 Tue, 07 Apr 2020 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200406184523.GA49680@roeck-us.net> <20200406185438.13576-1-sonnysasaka@chromium.org>
 <B002F0D0-77CA-4ED6-A810-9C8940D47A43@holtmann.org>
In-Reply-To: <B002F0D0-77CA-4ED6-A810-9C8940D47A43@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 7 Apr 2020 09:42:20 -0700
Message-ID: <CAOxioN=gi+-ag4eHQah_8fQoyLO1s-asfpnqM7Yz-oU5YRsdug@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify / fix return values from tk_request
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks, Marcel.

Thanks, Guenter for finding this out.

On Tue, Apr 7, 2020 at 9:35 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > Some static checker run by 0day reports a variableScope warning.
> >
> > net/bluetooth/smp.c:870:6: warning:
> >       The scope of the variable 'err' can be reduced. [variableScope]
> >
> > There is no need for two separate variables holding return values.
> > Stick with the existing variable. While at it, don't pre-initialize
> > 'ret' because it is set in each code path.
> >
> > tk_request() is supposed to return a negative error code on errors,
> > not a bluetooth return code. The calling code converts the return
> > value to SMP_UNSPECIFIED if needed.
> >
> > Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
> > Cc: Sonny Sasaka <sonnysasaka@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> > net/bluetooth/smp.c | 9 ++++-----
> > 1 file changed, 4 insertions(+), 5 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
