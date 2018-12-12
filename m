Return-Path: <SRS0=UWae=OV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BFCC65BAF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 21:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE9C20851
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 21:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOvgtLfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE9C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeLLVW7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:22:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43690 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeLLVW6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Dec 2018 16:22:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so16268477oie.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Dec 2018 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKeuYahfMsm+v0+tLJYsHVPzjV2rGreMpPdJKGX93QU=;
        b=fOvgtLfyRemNKeoEQgkN+oiRkeWJJA6tAFY1yhQzUOLnwwaK9Mdd40kfQW9YGBA+Ua
         FZdWfJOfuTqnvVJy/FmfXMb50vcUmPPJh61DaVemLYb7BODBA6+nDC20AqUNjsnr8c9/
         LuqshEoa66BtLyYZqT0PCHxC6/UUE+N6lSi0cHQkMJb7ZpJZQsTbb3L9hM3etLLE9Yec
         Q5+jhERSyXz9zIRtP9rQOQ8BCkLnPdCdhiIQhE3rFVhaA3+gVA48woFc7r3JT/sEdq+S
         YA7XdIu137/jmW0VC7AifIr9cHNcSsDtEl5pNef7N19VNAMJ7lLh4VNcpsNTmA8VDW6J
         5Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKeuYahfMsm+v0+tLJYsHVPzjV2rGreMpPdJKGX93QU=;
        b=S+xhebm3n9JSC78plaW4NGo1FKRodrIdNwUImmCi8Yix0nQN7TG445aVTMiQFTth+M
         QeTGitUcizlFUnIow5ggQX6lYQTbVskATlznkrLpH19cACo0Fea5QOB/gV8jnNv9Ya3A
         RQpwyZDd1g5iIIN8Om7+dNjfSLFhXGXh+vb21IadXvkW1R+9/WFU9oG4T1QAG0kur0HJ
         oX10qVqjnXkKWMs1jOA36t4fOcTDRicsGcwlGicHa8eemCLlIwzCflUQFM6PMtyKODfe
         AjSjzFLF5q3G3ldGV44QmyEGe09enrHX93llRJa8HAoU4jrCFl+4PPmWqx7GA/ZH2lf0
         yTjg==
X-Gm-Message-State: AA+aEWaXGq13GSoxjVlhgRQmu30TghzROui3IcZdk97KFJcXLw+OU/tc
        vuvjVyMXxu5qC8qBjCR4P3ll9xSOl1GUUG29wEU=
X-Google-Smtp-Source: AFSGD/VhIWvUsmmZ6Gfb4T7T/5AJtQY8tkfYkJG0gNz1KWQJMIIcYqtpP58YuY5PFZate5573i9czDAeV6hQaczhpWQ=
X-Received: by 2002:aca:b882:: with SMTP id i124mr1420012oif.127.1544649776717;
 Wed, 12 Dec 2018 13:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20181212204810.GA30878@r>
In-Reply-To: <20181212204810.GA30878@r>
From:   Austin Morton <austinpmorton@gmail.com>
Date:   Wed, 12 Dec 2018 16:22:45 -0500
Message-ID: <CAPWKHJQFdGqioCOMO+3bn2B1cR9ZYuH4zRHSEgSvpje53N0Xtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sbc: Use extended inline assembly for armv6 primitives
To:     r yang <decatf@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resent due to HTML rejected.

Hi,

I am the original patch author.

I submitted the patch to the mailing list but received no response
from a maintainer.

I am using the sbc codec in an embedded project and have to maintain
other patches for it anyway, so it was of low priority to get the fix
merged for me.

I previously submitted another arm related patch to the sbc library
and it was also not merged (although it did get an initial response,
just no follow through).

I get the impression the maintainers are simply busy elsewhere - the
sbc library code has remain unchanged aside from a single line bugfix
since 2014.

I also submitted a bug to gcc, since the issue was clearly a
regression in a newer compiler version.

You can find that bug here: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85593

There was actually a patch made for the bug recently - so it may soon
be resolved in gcc trunk. Although that doesn't do much to fix the
issue for anyone using the compiler they have today.

I have not had opportunity to test the patch for gcc to see if it does
indeed fix the issue in the sbc code unfortunately.

Cheers,
Austin Morton
