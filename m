Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11465C63777
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 22:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8763122464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="S35gB/EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgKTWWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgKTWWn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 17:22:43 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:22:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t21so8525774pgl.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WApHsSLiRi8AwBoP1j9A7QtURZRbhnQE6NVIL6Lt+FM=;
        b=S35gB/EG6nqCR0MXdJ80VXaTK2pVN6CMCEy2+OSMoLS9iJBNyL0iHMHYL9zWZnPS8z
         Z/i6XuRL23z7qLiqLcq1n0tCEcnLC3mnGwBwZX6xUJ21jEBn4bK0TIh70FczHtfpY1Nh
         iXNH7SXIdGUVBLD/7QsmHOBQ4eVIxmfZ7oQIs50DtsLxH2Q1CWyazQPO9lrItliBVqZu
         xtzqR8ov8hQMSAYMpRCwrZyqIj7Nf+qESQBwYaC+LmzWyKN3vt+4m6KT/1PLUvKm4Y++
         0QVtfNHhBkZ3GB6qKdczPZgic5GYe0heS5+0MajF43PvsFWZBwR1jYWPXPs9XRkM286C
         vy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WApHsSLiRi8AwBoP1j9A7QtURZRbhnQE6NVIL6Lt+FM=;
        b=sf07RsZAPBLncCrbTC2dfQvruC7WJguFggh6Twt8BGCF1p0END+NO10GxxBhj3CCHh
         BF7GQFDu6ZFV8saNe1dgrmVoYywauRhvXu2cyDtJf2WhROtfHtqttuvTmIgsmGGlCs6p
         u1gIS2/nok+r4H5pH30EFkua6w6ByHxenSZVkbEESwnCrcSwqiYkZXu5ofcbleyrjC30
         f942cFjGzpsX0m6Z+1GTLh3INjSWSlw3dyZ5ktHVNJ/m+cWGS/SYydIR8T2j+U7eM6Gz
         m6M9Sq7j7EZWZ5BtxIPlL4QxCt33ghgNMnNt+DT3fladc/D75AKF3043A24zujnrY6Hl
         JWlA==
X-Gm-Message-State: AOAM533eNGIdpnit0q8gU1iAYNPV1AgLX7qydPHD/wsR1iQrXx4JdwZx
        K9WvADTEw3tjJdEbjJNfcxuEleuX/WvbU991
X-Google-Smtp-Source: ABdhPJy2a8FuOfT/GNqH76NXDNVczshKOKgMY7BMcOolQGJ1rfOZ5kxEP2o8GS2IQNYXHyviN+Mfhw==
X-Received: by 2002:a62:52c6:0:b029:18c:a1fa:2fc2 with SMTP id g189-20020a6252c60000b029018ca1fa2fc2mr15381039pfb.50.1605910961327;
        Fri, 20 Nov 2020 14:22:41 -0800 (PST)
Received: from [10.0.0.4] (203-123-108-233.ip4.superloop.com. [203.123.108.233])
        by smtp.gmail.com with ESMTPSA id m20sm4698338pfk.31.2020.11.20.14.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:22:40 -0800 (PST)
Subject: Re: [PATCH] Fix HOG profile incorrectly stripping off read report
 bytes.
To:     "mathieu.stephan@gmail.com" <mathieu.stephan@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <a542b260-7eb1-8917-9379-e945003d7817@fourwalledcubicle.com>
 <CABBYNZJK0rnkkmkgg-qsd-50aN0ribGd5H5Ux2-hg6wZ3k8xdw@mail.gmail.com>
 <CAHdu5-74egP-m3pUPKEb_TWHRm21DMnbqE2K119wGoO9TgXioQ@mail.gmail.com>
 <a6c0e09a-f650-ad7f-6bcb-8d14bf230146@fourwalledcubicle.com>
 <CAHdu5-6MgMc9DQK=pAH0qHJYRy+aaJV98bG1ct+2tXyRv2yx-w@mail.gmail.com>
From:   Dean Camera <dean@fourwalledcubicle.com>
Message-ID: <4c241eeb-c59c-3640-540d-a2c006d4a04e@fourwalledcubicle.com>
Date:   Sat, 21 Nov 2020 09:22:35 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHdu5-6MgMc9DQK=pAH0qHJYRy+aaJV98bG1ct+2tXyRv2yx-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Mathieu,

Quite possibly! I discovered this while trying to implement a user-space 
application for a commercial product, which uses multiple reports quite 
heavily, as it's a lot more complex than the usual keyboard or mouse.

I hope your project works as expected once this patch is applied, and 
that it leads to more companies developing more complex HID products now 
that it should work correctly. You shouldn't need any special "is 
Bluetooth" handling with this fix, as the reports should appear 
identical to a regular USB HID device (as it should be).

The HID report byte has caused untold amounts of bugs and confusion 
after it was decided to omit it for single report devices in the 
original USB HID spec to save space on the wire, which was a neccesary 
evil at the time to make the basic reports fit into a Low Speed USB 
device packet, but still causes trouble today. The fact that it's not 
sent over the air along with the report on HOG just compounds the confusion.

- Dean


On 21/11/2020 9:10 am, mathieu.stephan@gmail.com wrote:
> Hello Dean and thanks for your reply,
> 
> I had completely missed the preprended byte would only be there for 
> multiple HOG devices.
> I fully agree with your assessment, as we indeed discovered segfaults 
> when our 2 reports HoG would connect to Linux 
> (https://github.com/mooltipass/moolticute/issues/671 
> <https://github.com/mooltipass/moolticute/issues/671>).
> That makes me think we (until recently, maybe) are the only ones to have 
> such a device and (unlucky) scenario.
> 
> Mathieu
> 
> On Fri, Nov 20, 2020 at 11:00 PM Dean Camera <dean@fourwalledcubicle.com 
> <mailto:dean@fourwalledcubicle.com>> wrote:
> 
>     The existing behaviour for a HOG device with report IDs was broken, and
>     likely wouldn't have worked at all as the first byte of the response
>     was
>     being discarded.
> 
>     The missing prepended report ID is theoretically something that would
>     cause an observable difference to userspace, but as it's only added in
>     the multiple report case that was broken I don't think anyone will be
>     affected.
> 
>     Single report HOG devices make up for the majority of consumer HID
>     devices, which is probably why this has gone unnoticed for so long, and
>     the behaviour of those is unaffected by my patch.
> 
>     The only use case I can see that would be broken would be a userspace
>     app using HIDRAW to communicate with a multiple report HOG device,
>     which
>     was already tolerant of missing the first byte if the report.
> 
>     Cheers,
>     - Dean
> 
>     On 21/11/2020 6:56 am, mathieu.stephan@gmail.com
>     <mailto:mathieu.stephan@gmail.com> wrote:
>      > Hello All,
>      >
>      > Is there a way to communicate to users that particular change?
>      > I'm reacting as this is something our team heavily relies upon
>      >
>     (https://github.com/mooltipass/moolticute/blob/master/src/MPDevice_linux.cpp#L91
>     <https://github.com/mooltipass/moolticute/blob/master/src/MPDevice_linux.cpp#L91>
> 
>      >
>     <https://github.com/mooltipass/moolticute/blob/master/src/MPDevice_linux.cpp#L91
>     <https://github.com/mooltipass/moolticute/blob/master/src/MPDevice_linux.cpp#L91>>)
> 
>      > and I'm guessing we're far from the only ones :)
>      >
>      > Regards,
>      > Mathieu
>      >
>      > On Fri, Nov 20, 2020 at 6:52 PM Luiz Augusto von Dentz
>      > <luiz.dentz@gmail.com <mailto:luiz.dentz@gmail.com>
>     <mailto:luiz.dentz@gmail.com <mailto:luiz.dentz@gmail.com>>> wrote:
>      >
>      >     Hi Dean,
>      >
>      >     On Thu, Nov 19, 2020 at 5:47 PM Dean Camera
>      >     <dean@fourwalledcubicle.com
>     <mailto:dean@fourwalledcubicle.com>
>     <mailto:dean@fourwalledcubicle.com
>     <mailto:dean@fourwalledcubicle.com>>> wrote:
>      >      >
>      >      > If the HID subsystem requests a HID report to be read from the
>      >      > device, we currently incorrectly strip off the first byte
>     of the
>      >      > response, if the device has report IDs set in the HID report
>      >      > descriptor.
>      >      >
>      >      > This is incorrect; unlike USB HID, the report ID is *not*
>     included
>      >      > in the HOG profile's HID reports, and instead exists out
>     of band
>      >      > in a descriptor on the report's bluetooth characteristic
>     in the
>      >      > device.
>      >      >
>      >      > In this patch, we remove the erroneous stripping of the first
>      >      > byte of the report, and (if report IDs are enabled)
>     prepend the
>      >      > report ID to the front of the result. This makes the HID
>     report
>      >      > returned indentical in format to that of a USB HID report, so
>      >      > that the upper HID drivers can consume HOG device reports
>     in the
>      >      > same way as USB.
>      >      > ---
>      >      >   profiles/input/hog-lib.c | 18 +++++++++++-------
>      >      >   1 file changed, 11 insertions(+), 7 deletions(-)
>      >      >
>      >      > diff --git a/profiles/input/hog-lib.c
>     b/profiles/input/hog-lib.c
>      >      > index 78018aad3..49d459e21 100644
>      >      > --- a/profiles/input/hog-lib.c
>      >      > +++ b/profiles/input/hog-lib.c
>      >      > @@ -779,7 +779,8 @@ fail:
>      >      >   static void get_report_cb(guint8 status, const guint8 *pdu,
>      >     guint16 len,
>      >      >                                                       
>       gpointer
>      >     user_data)
>      >      >   {
>      >      > -       struct bt_hog *hog = user_data;
>      >      > +       struct report *report = user_data;
>      >      > +       struct bt_hog *hog = report->hog;
>      >      >         struct uhid_event rsp;
>      >      >         int err;
>      >      >
>      >      > @@ -808,13 +809,16 @@ static void get_report_cb(guint8
>     status, const
>      >      > guint8 *pdu, guint16 len,
>      >      >
>      >      >         --len;
>      >      >         ++pdu;
>      >      > +
>      >      >         if (hog->has_report_id && len > 0) {
>      >      > -               --len;
>      >      > -               ++pdu;
>      >      > +               rsp.u.get_report_reply.size = len + 1;
>      >      > +               rsp.u.get_report_reply.data[0] = report->id;
>      >      > +               memcpy(&rsp.u.get_report_reply.data[1],
>     pdu, len);
>      >      > +       }
>      >      > +       else {
>      >      > +               rsp.u.get_report_reply.size = len;
>      >      > +               memcpy(rsp.u.get_report_reply.data, pdu, len);
>      >      >         }
>      >      > -
>      >      > -       rsp.u.get_report_reply.size = len;
>      >      > -       memcpy(rsp.u.get_report_reply.data, pdu, len);
>      >      >
>      >      >   exit:
>      >      >         rsp.u.get_report_reply.err = status;
>      >      > @@ -846,7 +850,7 @@ static void get_report(struct
>     uhid_event *ev,
>      >     void
>      >      > *user_data)
>      >      >
>      >      >         hog->getrep_att = gatt_read_char(hog->attrib,
>      >      >                                               
>       report->value_handle,
>      >      > -                                             
>       get_report_cb, hog);
>      >      > +                                               get_report_cb,
>      >     report);
>      >      >         if (!hog->getrep_att) {
>      >      >                 err = ENOMEM;
>      >      >                 goto fail;
>      >      > --
>      >      > 2.29.2.windows.2
>      >      >
>      >
>      >     Applied, thanks.
>      >
>      >     --
>      >     Luiz Augusto von Dentz
>      >
> 
