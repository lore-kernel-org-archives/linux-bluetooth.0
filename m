Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD13BC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiFPNA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFPNAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 09:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43652B4C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655384423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8ZVUkV5slpBiU5gnP3i9vX4TyyFnQAAf/ZHvzAvayg=;
        b=JSbN5IVYKIOJHj8KWgaMO2GoSRpOfhPAcDaba8mAE1qB6/CJBcxcvJt8wyaV2IpJmOezrC
        mBJmszEvyF3/2WBDjrPprMk+vKYtFvgWR5Z2/XZ1yjv2nPDVGE5r/FSI9OX7tsOD5PLVTk
        7Ve5cS1YPt+qRVazTtSUulxk4FDzX7o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-XTNGzqwzPb-PMVRkJswhtw-1; Thu, 16 Jun 2022 09:00:20 -0400
X-MC-Unique: XTNGzqwzPb-PMVRkJswhtw-1
Received: by mail-qk1-f198.google.com with SMTP id bs17-20020a05620a471100b006a734d3910dso1597641qkb.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 06:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8ZVUkV5slpBiU5gnP3i9vX4TyyFnQAAf/ZHvzAvayg=;
        b=noLlyE4l6hOwjnobsj8M/tYuwLg+KtHhsmUr2l+jveCMhVwgRqNKl4ngW5Ox0bzdUf
         QW9UKxuklJnKx2CMbdcsQnPEFT6/RI/pWEtzs/wuapvvdd3rm5p+71H2hBfgeJBp0IG6
         rJoy4XR4zbV4NFcHVZPHBn0s1kVIMT5zKtiOkyZBxS6WaIcpiA8VJohwS7nsuhHnxfg+
         u3Z2YlGtfu523RSybmk9W9VJOBQAhkYk4om2PRXM6Tt2M9s1fh0pMaIwLCcbyzTI2wDc
         mxyB89qidByN1AkmTSSiqF4vyTVYk33waCKy5YX6TjCINmGuZkmgnvKZBTXAuy7o6/NF
         tgUg==
X-Gm-Message-State: AJIora+xNRLj0df/AN4JlhhAghWzPX911+yk9t2PoAJzrC8QDG6NgtBK
        nLNdGzSayr+6RHjA+ccFfCKl4g0e+TMjvBls7w9H/9M8eTf5aPs5DoED5RbUtjw4G68pr5a6e5Y
        fi2ErobHWTgGFJDSUZK3oRhoxkDSBHHJyvhwIiQgFHFp8
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id e18-20020ac85dd2000000b00304ea094688mr3843311qtx.526.1655384419712;
        Thu, 16 Jun 2022 06:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s8NkXax/fhJn4p4KB+vrjzTc8SwiO52rQs1d5sXZGTBSfZ9nwuhdYltnFR7y17gdFUY49O0yt9bUAY4fI7De8=
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id
 e18-20020ac85dd2000000b00304ea094688mr3843279qtx.526.1655384419441; Thu, 16
 Jun 2022 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
 <e3efe652-eb22-4a3f-a121-be858fe2696b@datenfreihafen.org>
In-Reply-To: <e3efe652-eb22-4a3f-a121-be858fe2696b@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 16 Jun 2022 09:00:08 -0400
Message-ID: <CAK-6q+h7497czku9rf9E4E=up5k5gm_NT0agPU2bUZr4ADKioQ@mail.gmail.com>
Subject: Re: 6lowpan netlink
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jun 16, 2022 at 3:57 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello Alex.
>
> On 13.06.22 05:44, Alexander Aring wrote:
> > Hi all,
> >
> > I want to spread around that I started to work on some overdue
> > implementation, a netlink 6lowpan configuration interface, because
> > rtnetlink is not enough... it's for configuring very specific 6lowpan
> > device settings.
>
> Great, looking forward to it!

I would like to trigger a discussion about rtnetlink or generic. I can
put a nested rtnetlink for some device specific settings but then the
whole iproute2 (as it's currently is) would maintain a specific
6lowpan setting which maybe the user never wants...
I think we should follow this way when there is a strict ipv6 device
specific setting e.g. l2 neighbor information in ipv6 ndisc.

- Alex

