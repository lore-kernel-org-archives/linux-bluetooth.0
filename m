Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCBAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 15:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5B164F9C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 15:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhCKPGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhCKPGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 10:06:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC727C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 07:06:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so14540702pfg.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 07:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WS4YudPgkpEWvo/Q7CoVNiUQtOFZ447A3qEELpvk7ME=;
        b=UnQGnpsw2vaqrGPrjvW9LEHBU6OvKG0XsvZB5t5wfTr8pW4CqL6lD0KtYAeADpO0Nj
         ONQxA6FQQmZFxBpA+LJ0prXInUm9M2kaRv8efGtnXjLC629APCqeE2fF4dx8ipQIMRM/
         L3yqk972rFUqFCn3xhJTQd95TIMhXzjLbre4SZy3cOiMXZHVAXuTGemJiBsvOeaqX4X7
         E64u3iyBW3KY+q/3rVTfptjO0LIInG9zxnl2CkbA3eoigjdzPRldwnUagPO1lf+87FHC
         0v2mndFKeJHFsJAlrqgTbKCDtbuD+4s9VT3YlPYEZdFqNL9zTQ/Qgk0m3Rw9z+3zJkQn
         NEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WS4YudPgkpEWvo/Q7CoVNiUQtOFZ447A3qEELpvk7ME=;
        b=udnGAiF9ZV5Fm5BCeRuaKKxLgDDCCQ+867E/oGAqWih7NUddF2xZwAepDDfz3n9adU
         4qBkKEDFYhXon6BNSuu3RuWWkZpYk+i9Gv2WkiytzkEyjdGuoGDTJ3ac5cpkPY386BTr
         ZlfxN0pNWAb5djGEURfd9rS00EYgA05pYUemwmqlHbIEOV0UCXWUjW4T7SHCnTZjZveq
         jUn3jsz0+m+gf+7lliha57uBqiHqy9/fuXcA9GAw+14O3ZBPef2ivDA5PFYlzbLG/mVg
         4p+mO9jN/asqY+27748xvkq2/3JdMXZaYdstlFGupST5FCqfX1SpZjMB6gFnD6LvYDCi
         aVTA==
X-Gm-Message-State: AOAM531Mryz+kY7muVuVDtSM1YyPd4ORXaHFFExUUwxlrzCDhZQmhxvj
        HIPIeXwrQHd/DgIwGC08QOWJAtOVTNA=
X-Google-Smtp-Source: ABdhPJyJGfaQ0wdu54K8igJWO5t/9PU6VJkHoqIsBSoeeXC8GMqbGGByHR62hu3cb/2VgFZ0WrkiUQ==
X-Received: by 2002:a63:1723:: with SMTP id x35mr7693836pgl.393.1615475160058;
        Thu, 11 Mar 2021 07:06:00 -0800 (PST)
Received: from localhost (ip184-182-39-99.ph.ph.cox.net. [184.182.39.99])
        by smtp.gmail.com with ESMTPSA id v35sm2542248pga.3.2021.03.11.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:05:59 -0800 (PST)
Date:   Thu, 11 Mar 2021 08:05:56 -0700
From:   Taylor Phillips <taylor85345@gmail.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Bug caused by moving to BlueZ 5.56 (bytes stripped from HoG
 reports)
Message-ID: <20210311150556.7ym24egif67k6ilq@taylor-lt>
Reply-To: f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com
References: <f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ricardo,

Just passing over this issue in the steam-for-linux github that seems
like it may be related:
https://github.com/ValveSoftware/steam-for-linux/issues/7697.

The latest BlueZ update seems to be causing issues with the Steam
Controller's ability to communicate specifically with the Steam client
over Bluetooth LE. I'm a casual non-dev, so can't tell you much more
than that.

Thanks,

Taylor

On 21/03/04 03:02PM, Ricardo Cañuelo wrote:
> Hi all,
> 
> I discovered this fix https://github.com/bluez/bluez/commit/35a2c50 while
> debugging a fwupd plugin for a HoG device that implements its FW upgrade
> mechanism using vendor-specific HID reports (
> https://github.com/fwupd/fwupd/blob/master/plugins/pixart-rf/fu-pxi-device.c).
> 
> Initially, the developers were using BlueZ versions prior to 5.56, which is the
> first release that includes that fix, so their code was written with that
> behavior in mind. After moving to 5.56 we found out it crashed and we needed to
> adapt the code to the proper report format. I think this is the kind of issues
> that Dean mentioned here 
> https://marc.info/?l=linux-bluetooth&m=160590969013204&w=2
> 
> Have there been any more reports like this? Is this expected to have a greater
> impact than initially thought?
> 
> Cheers,
> Ricardo
> 
