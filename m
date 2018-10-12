Return-Path: <SRS0=J5Jk=MY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A92EC6783C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 12:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A30206B2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5QFhCiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A30206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeJLUI0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:08:26 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46386 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeJLUIZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Oct 2018 16:08:25 -0400
Received: by mail-ot1-f41.google.com with SMTP id o21so12183967otb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Oct 2018 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCmgOAzqGjgrFxXgdjyJsDwEaXCo07OTkGaoXPVacO0=;
        b=L5QFhCiy5WzIQGGQs+sYFI5xyUzFzQ59CpAfdEZSL40U2wNANw2DBOoIdLbL4VboNH
         oYGVNUnlpvdNBLq9Z/989JF7IgNljPORgORYbSwqn2G/Yg1E8qtbQeoIS/3vgzcxvLK+
         B4dW3UkB/gLEWuWuLj59fnTB81/kQ5f29QixyZuujT3yIkoKhtX9aOM9LOx6s9mNB0B1
         nX0/hxQV/4sGzPrGyFo+8MKUBqST1HKiT4qUvcrn77X8GnvbZjD+DLssEA9K6i4DDuLv
         zmMcGsjyphHVKJg6PE2pS8Nlym4ON0M8RPcKYo7Bl82++W7efIvrbrWTbQIWWE53ht9m
         K+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCmgOAzqGjgrFxXgdjyJsDwEaXCo07OTkGaoXPVacO0=;
        b=nU9Nk389OmNe0dQBFr5ijk8awjxzlBMG/mQZj0H4TYtYrlXEhvSNoLRbcRpr93SPNO
         FhboIeNWEMzvBa3GobYXUS/uH+kKDYi3And31BQFBLjCHQy/Qilh0e6CuTUaUAVyI+L4
         FpcNAPeNJPwv6GV3BE8wIVzShXlfWYjxIEQyTVbUAJIIkReD8JSQj/3yFkgR9JdWab+/
         EbAt+0rEu2rePfdHrDoCtaKiPtKh0h56fcNgXYFVOtpL/MLOhHBlaCQ9MkbhN6SJVRQw
         huirmDQHABvtfXFahdroXZdbDKiZlTtrNJsjj1f6kfcwpx9vrNAtHD+xsPVUdEqoTfW4
         RuAg==
X-Gm-Message-State: ABuFfohriz5rhdj0TinIucaEz83fYofi39abz8USBZPKQzh7CgYoDx3Y
        6ewyKs6ifdFsoRcCwLxcZju9UlHqaUF9xqarPlQp0A==
X-Google-Smtp-Source: ACcGV63ey4pfS9GDIXaR5JNrpp3q9OuPvqpuGO5+ILVhc0ZBSdb0mTB9D8vB74+nRMuT9suYRHEDG1MGWFmf07KYF5k=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr3851072otf.242.1539347769176;
 Fri, 12 Oct 2018 05:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <e0c92bc0-5a44-ffbb-ec04-05742ee53e7a@chicoree.fr>
In-Reply-To: <e0c92bc0-5a44-ffbb-ec04-05742ee53e7a@chicoree.fr>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Oct 2018 15:35:57 +0300
Message-ID: <CABBYNZL+YePJrp1C=O5bK3J5QGhrABcKVV2DOWTX5xhF-HMX-Q@mail.gmail.com>
Subject: Re: How do you pronounce BlueZ?
To:     sylvain@chicoree.fr
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sylvain,
On Fri, Oct 12, 2018 at 1:58 PM Sylvain Leroux <sylvain@chicoree.fr> wrote:
>
> Hi everyone,
>
> I will make a presentation about the Linux Bluetooth support soon, and I
> wonder how I am supposed to pronounce BlueZ (I think this is the correct
> spelling)?
>
> So:
> - is it "blues" like the music genre,
> - or "blue" "zee" (like the color and a "bee")
> - or something else?

Most of us use the second form, though Ive seem people using the first
form perhaps it 'sounds' better them :D

>
> ;)
> - Sylvain



-- 
Luiz Augusto von Dentz
