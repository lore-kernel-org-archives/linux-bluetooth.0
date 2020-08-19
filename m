Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC46207BB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpfuU1gI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHSTuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSTuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 15:50:21 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD36C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 12:50:21 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id z22so22113009oid.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwSEAG7n6KPttdgMR92zRf9Po02yJGr0+n784gk5TSk=;
        b=MpfuU1gI5FQEjmnLuKHWGcDgfblxOs+TlshI3Vbyu5Jp8SIVazIVHTQxQG1UkNXQ1Z
         3gEQRv6HMtcfLjuLg2bsQ3rM5E23pZxmfyydHP8qoNbfGd3XIAqeHBYErjEDKYzsjktC
         GYkcZdZCqEl5zKfauk1jj9uS6nqQsgnMk/+QDAkeOpup+HBClcJ5niG/ayvTcpruzHNW
         wU+6nxfFaMOh6sNvAO0OLMp3oSPhQcj3mg7qlWzc5mUNbV6OgYxRpJd6dNU4JK53Tf4m
         jktcgHvVxeWx4DjKCnej2rJsk67+RYOSBOKN8awjHynTJGVLBpiC5wA+VWuj/SPJm3VO
         yfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwSEAG7n6KPttdgMR92zRf9Po02yJGr0+n784gk5TSk=;
        b=uN+rkYli9mrfX2T4ic/C3A5WKV35f7SKEPj82Wa8veJDMAQALoOr8HmaOxWCmFSS4N
         tndtF81r+lfcpgQIvC5CjcPbF9ocN5AMAdoiPLcqlNTOeUe+Rpphl3cFYp6VcEDcleCY
         Iud2YnhwtRZokXMkyWPmkemZkGClpR/t+536+QmyQnp/9do2u9ndGvUNWQWidpQrP+wA
         o1vK9rcrU2sbYTsTE/ei9AbF3qfT5X+VnMqbuSc46g0nHqazW+saJM1el8XXezi9U/wa
         GwX6EcSDkYkorYi8uUOEKXR95aTRoGk0NYrB/QoRdv0qLsfBzMNlPpZ7Y5ytXXsJdTqn
         i0Qg==
X-Gm-Message-State: AOAM532myLkxEEY4sEeLK2BviW1sYKKiIwiIezlIH8DMi2Zug4/LBEsM
        zZT2OpJtvsyNfju+TeDxvkBDKAOU6isfU9BIV2mGKz8q
X-Google-Smtp-Source: ABdhPJw0U6sr2cfBbNUTlKd+ilMq1hhnNm8IRlsGULujRbNLxVCzR1L9RzRWwMbJVzzovXn7cV5h1uyeh9dbUcNrgn8=
X-Received: by 2002:aca:f504:: with SMTP id t4mr4418735oih.137.1597866619391;
 Wed, 19 Aug 2020 12:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <b39b3395-ad80-bf76-caea-490666cea671@daveborghuis.nl>
In-Reply-To: <b39b3395-ad80-bf76-caea-490666cea671@daveborghuis.nl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Aug 2020 12:50:08 -0700
Message-ID: <CABBYNZJysyOYZPWVd1Cpq7C055G2Pwdu+x_9WaFfZUzDb-4_YQ@mail.gmail.com>
Subject: Re: Cant see Android Covid Exposure notification beacon (no problem
 with iPhone beacons)
To:     Dave Borghuis <dave@daveborghuis.nl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dave,

On Wed, Aug 19, 2020 at 11:47 AM Dave Borghuis <dave@daveborghuis.nl> wrote:
>
> Hi all,
>
> I don't know if this is the right place to ask, if not feel free to
> forward the mail or point me in the right direction.
>
> If I look with btmon i see no Covid exposure notification beacons from
> android phones, i see these beacons from a iphone. When I check with a
> ESP32 with a monitor I see both beacons (from iPhone and Android).
>
> I using Raspberry Pi 4 with  with all software updated. I updated bluez
> to last release (from 5.50 -> 5.54) with same results.
>
> Used software versions :
>
> Installed image : Raspberry Pi OS (32-bit) with desktop Release date :
> 2020-05-27
>
> Bleuz version 5.50 and last release 5.54 (build from source)
>
> If needed I can recompile from source a new version. I tried to find
> source of a more up-to-date developer version then 5.54 but could not
> find this.
>
> So is there something I can do to enable to see Android Covid exposure
> notification ? Do I something wrong or is there a bug in the bluez stack?

You probably will need to set some filtering since the advertisement
may not be 'visible', you can try with:

bluetoothctl> scan.transport le
bluetoothctl> scan on

If that causes way too many notifications try setting some other
filters like UUID/pattern if there is such information about it.

> Background : I am making a 'CoronaCounter' app in python, I want to
> count the Covid exposure notification that I see. In python i use
> beacontools. I noticed I don't see any android beacons. More about this
> projcect you can find on https://github.com/zeno4ever/CoronaTeller

Is there any specification available for such beacons?

> Regards,
>
> Dave
>
>


-- 
Luiz Augusto von Dentz
