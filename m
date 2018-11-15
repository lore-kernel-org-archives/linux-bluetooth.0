Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5356C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 11:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85837223DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 11:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="dq6n9dqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85837223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKOWCy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:02:54 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45279 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKOWCy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 17:02:54 -0500
Received: by mail-vs1-f66.google.com with SMTP id v10so4104663vsv.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 03:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hluAns2WCpo6lbuW0LCHAZT+njLgi8WppR5QuKFd7s=;
        b=dq6n9dqR3hF82zlG9UICV7mRWhmNps2QJmx1J8ckBZ424Gx0mtTX4JvKruLEXH16Hn
         mEqWgFxnY5NXcrT6J68ufrfrLMVjvkBPBMpuP1tfCdH88I9Ux/N6q9yXvlTxlfPaXd8O
         uAm1hMGnuSNJdzVQ9CgOEjRkUpaMRgLrarzrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hluAns2WCpo6lbuW0LCHAZT+njLgi8WppR5QuKFd7s=;
        b=XZO1uJU9o+0b50bsPwl62rPQFtTo6N5kAHuGccofdLujteaOENBHJRX28rKwIWL5+o
         73qlK6gX/uaTIuDPm3gFuTsWT0Sc3j7PXER5uSLeM+IOSbUUXmthEkyvVbBMe5ypbH8Q
         If96ZjNHtyjkCrjCt28dmfhUHJl/o4BBV/YfZ25ceY/1/bligxnR7MjfEHdKd3OGAFq8
         KW2eYbFZa1nbREazBvepsYThY7LTFTW2XBUiEBKIWWEsyX3r+vrR/ufwXtd0OC5sgy6g
         MA0fZwm4z9xk6Md1IarF2Lkpf2bH2stFE4yghI0RIMrKeWgIl4vtrfBl8ORphRc5V5jH
         Dm/g==
X-Gm-Message-State: AGRZ1gKcCZFEJorCCGGObfm5o/CksUA4KozKOyZzIoTVmiMMMpjwcjVY
        RKgk2LEhiiaw1LiIve0sfSuGotfyIjAUFkG/QTNP++C0GGQ=
X-Google-Smtp-Source: AJdET5f+ceoJj4ZdzDp9NYe2JCBd4wTDKQ0jRtyu650ZKN++8utg9H6c8hlhnnEtyUey6opBTzP4uwv46iOwNQ86ZNs=
X-Received: by 2002:a67:3144:: with SMTP id x65mr2584674vsx.186.1542282921351;
 Thu, 15 Nov 2018 03:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com> <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
 <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
 <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org> <CAHotPr9Jb3Prqk_tkaeTRsJk0VgsGWbj8tsSdEp-Q9mb9Dt=-A@mail.gmail.com>
In-Reply-To: <CAHotPr9Jb3Prqk_tkaeTRsJk0VgsGWbj8tsSdEp-Q9mb9Dt=-A@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Thu, 15 Nov 2018 13:55:09 +0200
Message-ID: <CAHotPr-BO=RE6HZYWsC1+MT9oSZ58Xf-8XLz53BJq0Z6Em9Hsw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     marcel@holtmann.org
Cc:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I submitted a different patch -
https://marc.info/?l=linux-bluetooth&m=154228281730667&w=2
On Thu, Nov 15, 2018 at 12:20 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> I can try to create another patch for it
>
> On Thu, Nov 15, 2018 at 12:18 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Gal,
> >
> > > io_send can use poll and check for POLLOUT and POLLRDHUP before
> > > writing to the pipe
> >
> > that should be done anyway since code that writes to a pipe descriptor (or socket for that matter) without checking that it is still valid is broken code.
> >
> > Regards
> >
> > Marcel
> >
