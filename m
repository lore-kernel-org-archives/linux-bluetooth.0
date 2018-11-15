Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613FC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9420868
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="Y8AOiuvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeKOU2J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:28:09 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34575 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbeKOU2J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 15:28:09 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so4354114vkd.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 02:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsOizrWJhjndg1bZLwC/5usTViMyHTqPiG8BZ04wzWA=;
        b=Y8AOiuvVWDaANpkBZtMQP5jnYlU47ULasqj9031S/UBtcqfzPeFHQRVJ6JhUYF/eVh
         UZqKSvKolBTDGWScyxDtcy/lWYD60KRhDBQj6JNd1WpDF+vKgIjwRGkThhKlUiiXD/2D
         wUjNRzVZ+TKGWyUT6tBGn1GVZSweJCiKTZoiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsOizrWJhjndg1bZLwC/5usTViMyHTqPiG8BZ04wzWA=;
        b=oraZ0MvLXeDlbbmDUph7+yPybLoVKOgRXhn7eRqRox9hJEE8cB/FN2THPkFXGBxN2k
         +mse+TbVLGmXfUrfiBz1eudsXBgpIY76zM3lyPfFZOalMbb407LaRL07Llp6ijtIMzYl
         w0bqZhwFsmEqZWLwZghn9szw57CmgbJisEY1GRV5ay4tlzyJ7ML6OG46yt9WHkpWboF4
         cIVHtTRYgxhCJec5pvdVh+7WBzJ1aw05fz/rFZpBBO0ihYjKFdIdh47GwZjHAtQL1cEd
         6CCkZk0CvdxDSeuy4LYtzW8ApDy1W8Ue3dYdP/HX2Ju7oTMStm3Ptk2Ko4W8fSBZWem7
         /GKw==
X-Gm-Message-State: AGRZ1gIrtNDHHcQilSjmky5nm/Zlh635imuTiZFf92BaY2TXVCXDiqzy
        wavekev9v7Yhiw2Qwe1LcaaN2JAJf362vZnHXfdtZtOW
X-Google-Smtp-Source: AJdET5f3RW8R9X/M/7HarK9J3AN7p/wTlARTNAN5dC05uEIM5Sr+1wEzYsemhra+9dSGhhtJqUR7BYB/X8StmqnId5Q=
X-Received: by 2002:a1f:83ca:: with SMTP id f193mr2319387vkd.75.1542277255498;
 Thu, 15 Nov 2018 02:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com> <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
 <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com> <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org>
In-Reply-To: <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Thu, 15 Nov 2018 12:20:44 +0200
Message-ID: <CAHotPr9Jb3Prqk_tkaeTRsJk0VgsGWbj8tsSdEp-Q9mb9Dt=-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     marcel@holtmann.org
Cc:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I can try to create another patch for it

On Thu, Nov 15, 2018 at 12:18 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Gal,
>
> > io_send can use poll and check for POLLOUT and POLLRDHUP before
> > writing to the pipe
>
> that should be done anyway since code that writes to a pipe descriptor (or socket for that matter) without checking that it is still valid is broken code.
>
> Regards
>
> Marcel
>
