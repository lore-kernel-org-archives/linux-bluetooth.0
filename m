Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B235DC38BE1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8867C21556
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqbB8sdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgBXS5e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:57:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40382 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgBXS5e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 13:57:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so9968109oii.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 10:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hH0Rcw0BsM3EY/d50oiMd/K5+d1atGdLZCMxKEGiRvo=;
        b=rqbB8sdZCI33D5vtRKcF2G9AL9Mpmm2gwCsUem4ev/1yJ4lTVVz7OTUaW55cF2jWBG
         nV9tMdFhtHHa01BH/doiPL5VuZxvBZV40TXOqH0cXnA5UIKDGwql7kuaMhdDZrc1TbPl
         Owvk4cpkW58NuEYBm3pUqST2kQ/cI4JaLzcaWfN41flBPfuxlXx+crxgO1DB24583jtW
         9YMhLeDlf7Eh2s8KIOPDH792jykZNK+088xrs0Yid1/3+5aHmpW1BcqeiXirHAL479ve
         ZFV9N8kajwlXafHuia/xpLwKN4KhsIpAZRTDRdjKMqYspWfM7PiVPUUMk4QzuwHHg7Dg
         MbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hH0Rcw0BsM3EY/d50oiMd/K5+d1atGdLZCMxKEGiRvo=;
        b=V8Ja/4wPUQWpssM+ymJcmpvblvM4Sfxo5s1o+nBXDsCFu2KDEffKCC1Fwm3DHqp+Es
         otgiwsqjiFDEQc/jfmYnBfkT10UGaegJPRVa+WRtMrmU1gnW0+B0DcIp37DV6+JKTmZS
         3q5tr4PIaGV8uCSaW2Wfvi/bIYBzfq6ws9emAxEG9VJPemUXf2O0F6/DMkSc/fYPTpOW
         NN1m523Wr1ST5bUqc3DpLmEBP6bLpXArkN8eXOrOVk+AAQhVt6yyvTvJ2xuZdJyMyMWx
         hH9ZtqqNAbNOvquWUgYGKcamHSerBCdsF8jZk3l+ly/fnfP7boWtY9jJ9qzEx+poj/I+
         Z25w==
X-Gm-Message-State: APjAAAXIvXK7Hd6cjWiA4faRgYv6BIEtXBxNfbqno+SccJLIH9aH/KEo
        tRbqK4FzHDDkydxEMYltdZKUiJX88XyzolvE8xU=
X-Google-Smtp-Source: APXvYqwufs4Z6xqKEzShoxQCjzEUX/Bpt4WYlBlZ1BFAO79nHTZvKw7eKrRxVzn6T07SxstAX2kL3/WKsUU45ULUMQo=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr423137oie.110.1582570651743;
 Mon, 24 Feb 2020 10:57:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJ_gUqbKKxt15OhizRN_x4Dy-RvyuEUH0Bwcah_KEcMsQakQoA@mail.gmail.com>
In-Reply-To: <CAJ_gUqbKKxt15OhizRN_x4Dy-RvyuEUH0Bwcah_KEcMsQakQoA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Feb 2020 10:57:20 -0800
Message-ID: <CABBYNZKG6hFMgy7ifuEW2kxyQYd=Gw0cWefjBy-fdWS00OWL+g@mail.gmail.com>
Subject: Re: Adding support for DuplicateData into the kernel
To:     Scott Shawcroft <scott@adafruit.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Scott,

On Thu, Feb 20, 2020 at 8:34 PM Scott Shawcroft <scott@adafruit.com> wrote:
>
> Hi!
>
> I'm trying to create a bridge between BLE advertisements and the web
> for sensor data logging. The BLE advertisements use manufacturer data
> to transmit the sensor data. I'm running on a Raspberry Pi 3b.
>
> I've been trying to use the Bluez dbus interface with DuplicateData,
> trying both true and false, and I never seem to get duplicates back. I
> dug into it via hcidump and noticed that the scan enable still has
> filter duplicates set to true regardless. I can only manage to get it
> set to False when using hcitool.
>
> I believe I've tracked the issue down into the kernel here:
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_request.c#n858
> where enabling duplicate filtering is hardcoded. It seems that hcitool
> side steps this by talking directly to the hci device.

Yep, the kernel code don't actually allow setting the duplicate filter
unfortunately.

> Could someone confirm I'm on the right track? I'd be willing to plumb
> the DuplicateData value through to the kernel if someone could help me
> find the call path down.

In the past Marcel was against turning off the duplicate filtering but
since we do have a similar setting over D-Bus, though the later shall
not be confused since tracks duplicates by itself since over D-Bus we
are doing it to prevent duplicate signals, Im with the opinion that
DuplicateData could be used to disable duplicate filtering, default
should be still be enabled though.

-- 
Luiz Augusto von Dentz
