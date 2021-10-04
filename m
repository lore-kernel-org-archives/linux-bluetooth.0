Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF94C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE726113A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhJDWtj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhJDWti (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 18:49:38 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54792C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 15:47:49 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b67so8417463vkb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4bkWGF+I8ewZ97VzVY3bAyRXjrlH7knH95Ik/OioE4=;
        b=P7lwDfL8v5tCmTJi6FYQ2Y/b+mYnbgAVE7CjxGx+m1UBsH+xxz8YtzIUIXEQ/7Cknl
         YS9lRmDn3UkUZvk5gJOfMuKnrWVLIXUDxJ/e36H1J0Kq6SQrCbIs8Hw4eLxhLKlJupO2
         u2F7Dnql+5Wd46ftytTQZC7fuRgYFsMcYv8BJZaam8rNJqHZdr49eVFpzIm4iDQw1fh9
         MdxOMkVo2pkYymjUOGIqRprb2VQLSoUzNT0FaDr4b+1W48lCMslb5BCh3aDWcWNur4Xi
         5uqlzIQEQGxCa3z+ErovnnexXQka0YZNDzA9fdFrY5iHtUb3p1srkQinhiUnIGIGEuJR
         4wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4bkWGF+I8ewZ97VzVY3bAyRXjrlH7knH95Ik/OioE4=;
        b=1OFDQFc2fvYZjP83V6oh//WCt8EMgsukVtSI8ec/ZerBSMLDCrTrqn4+I7lI6Sd1he
         OE/4b+XmJc+LTbwXsQmKFYoS2atFFP7ZNU7sGVdQADWplMDAvxFio8QZeK9EOqgrlF3A
         zyXgrndbExpUFHXKZV0j6zAV0fNeuPcuy1CiGqmF6vWruMOoMngVMQ9+w5lx3fKdR08e
         Y/O2AWBMP5OP2oYLDWKHG3xIc1K4oXdkNGdV0FjTl1McHDKjWg2lVUsoqvqALEmPXW1T
         IoU9FfsVxxIisk/VOY9csK8GwlJr/8NvKYKjPzEDpsrZEFT2fBaLiLhxcLU2rPF44p8/
         G59w==
X-Gm-Message-State: AOAM531xbL7yzOz+7HquXuON30z9kx4yMUw1s+rIbmq0YCoK0iuMA0zJ
        03BXTzwIKfoD4IPGJUaohsO+maTsot5cR6zm21w=
X-Google-Smtp-Source: ABdhPJySwWjPqLPzjZ6wrShPyqOvJbbg48IaB5TCmZ8di1uV0Zlbt3wuem4z19dApEbA7YPhowi8IhfMW0s0Owov32o=
X-Received: by 2002:a1f:a9c4:: with SMTP id s187mr19438936vke.9.1633387668260;
 Mon, 04 Oct 2021 15:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210921181243.BlueZ.v1.1.I261f9c1ee78b90f81a6c323c23065615be917c33@changeid>
 <CAGPPCLDZF_BFbGV4Cd1s0SOKYJwwpM-cM3zvDdjHOTtBcvDT0Q@mail.gmail.com>
In-Reply-To: <CAGPPCLDZF_BFbGV4Cd1s0SOKYJwwpM-cM3zvDdjHOTtBcvDT0Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Oct 2021 15:47:37 -0700
Message-ID: <CABBYNZJYjecA503BWTDc-+SgDTAnda3p079H2d4W4j3xS-VpZw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adv_monitor: Mark the device as lost on device_lost_timeout
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Mon, Sep 27, 2021 at 11:30 AM Manish Mandlik <mmandlik@google.com> wrote:
>
> Friendly reminder to review this patch. :)
>
> Regards,
> Manish.
>
>
> On Tue, Sep 21, 2021 at 6:13 PM Manish Mandlik <mmandlik@google.com> wrote:
>>
>> Mark the device as lost on device_lost_timeout so that it can be found
>> again next time.
>>
>> Verified this by adding a monitor using bluetoothctl and confirming that
>> the DeviceLost event is getting triggered when bt peer stops advertising
>> and DeviceFound event gets triggered again when the bt peer restarts the
>> advertising.
>>
>> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
>> ---
>>
>>  src/adv_monitor.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
>> index 715ac5904..a55e1ea2d 100644
>> --- a/src/adv_monitor.c
>> +++ b/src/adv_monitor.c
>> @@ -1892,7 +1892,9 @@ static bool handle_device_lost_timeout(gpointer user_data)
>>         g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
>>                                  report_device_state_setup,
>>                                  NULL, dev->device, NULL);
>> +
>>         dev->lost_timer = 0;
>> +       dev->found = false;
>>
>>         return FALSE;
>>  }
>> --
>> 2.33.0.464.g1972c5931b-goog
>>

Applied, thanks.

-- 
Luiz Augusto von Dentz
