Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED63C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 22:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75C12245F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 22:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="JAD+QS0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgKTWAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgKTWAc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 17:00:32 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E012C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:00:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w14so9179639pfd.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OI96Zy1V/4lU5dOONsziQGTVrP+VTwHiHiv21yVY+LQ=;
        b=JAD+QS0tHpTr84rXmtnOvuqzQIKNxleVVsuoGfyJ4KD+PVNI7ngGbOPLq4FFl23RxI
         nzXQo3oZ11IpwwC/9FqtCqKoxHBxSPPUlPoDAYJyv2HJCBmL6ddLaVzWpP+pgTyFV6r7
         PgPyZow3vU0P8PHKqT7IoAYhIE0mu5O0w+xy+r8pjy/IP6LxyUHQCkfvxlEDEJ8t3G8F
         yNnQIsbYVb4QiQy6PlEsxitLXGl87Qy43U4MMvA/USsiq7R3zDFJasd9VCWTyqIgXG3s
         yayhnQTeheDpBnSUvM2YQLuIMIxqnPL3WEqpj12Cv2DCS1iOktQS4PNbKWxGNWkbjpOS
         On9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OI96Zy1V/4lU5dOONsziQGTVrP+VTwHiHiv21yVY+LQ=;
        b=tIqTJ99J07VvXSZKrJ1Y6+hGxppzyUSMPr5WykCNYdBSu66IMSbl00gDh9GN3Ev7G7
         bN9nGTcYjSyup5vuTXqM9iQidt25TRYzgbz16K8jV/FGoRFMPAqlhYpTjswrr8Llew+I
         JtU0rdzjNQEx+t/+Sf+us+Ew9bjCo9ghTHglScQa+HwzVyALKUIGdy/hXQoYeiTDZhsV
         GibSpMCQ11PmH2MB66RPijNzKdVCxMM7SuOdwBiG9az2L7fVgI+VPja8Eu4dSW7CiYPI
         PF5pMzhdKJe0Ihg0y+aGcipi79dk9HqiWV62aIBgIg4bzYi5+prgZdFDZO1PavCAK13j
         +xqQ==
X-Gm-Message-State: AOAM531axQV2JYxhy/zB8ljZYD+sqFJK/MBZ78yRAKLo9roit8KjkgsV
        EDnDyEWfsjYkylG2ZOkTBnJDDYlF1VutS5lg
X-Google-Smtp-Source: ABdhPJwiAMg/m6oEvOp2F6t1UjCHx9BYM84fJBqb55CTuU6IWNB3BbQeiA2LbGVPcMPFCk3XMniV3A==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr13074097pji.67.1605909630132;
        Fri, 20 Nov 2020 14:00:30 -0800 (PST)
Received: from [10.0.0.4] (203-123-108-233.ip4.superloop.com. [203.123.108.233])
        by smtp.gmail.com with ESMTPSA id m2sm4360153pgv.0.2020.11.20.14.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:00:29 -0800 (PST)
Subject: Re: [PATCH] Fix HOG profile incorrectly stripping off read report
 bytes.
To:     "mathieu.stephan@gmail.com" <mathieu.stephan@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <a542b260-7eb1-8917-9379-e945003d7817@fourwalledcubicle.com>
 <CABBYNZJK0rnkkmkgg-qsd-50aN0ribGd5H5Ux2-hg6wZ3k8xdw@mail.gmail.com>
 <CAHdu5-74egP-m3pUPKEb_TWHRm21DMnbqE2K119wGoO9TgXioQ@mail.gmail.com>
From:   Dean Camera <dean@fourwalledcubicle.com>
Message-ID: <a6c0e09a-f650-ad7f-6bcb-8d14bf230146@fourwalledcubicle.com>
Date:   Sat, 21 Nov 2020 09:00:24 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHdu5-74egP-m3pUPKEb_TWHRm21DMnbqE2K119wGoO9TgXioQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The existing behaviour for a HOG device with report IDs was broken, and 
likely wouldn't have worked at all as the first byte of the response was 
being discarded.

The missing prepended report ID is theoretically something that would 
cause an observable difference to userspace, but as it's only added in 
the multiple report case that was broken I don't think anyone will be 
affected.

Single report HOG devices make up for the majority of consumer HID 
devices, which is probably why this has gone unnoticed for so long, and 
the behaviour of those is unaffected by my patch.

The only use case I can see that would be broken would be a userspace 
app using HIDRAW to communicate with a multiple report HOG device, which 
was already tolerant of missing the first byte if the report.

Cheers,
- Dean

On 21/11/2020 6:56 am, mathieu.stephan@gmail.com wrote:
> Hello All,
> 
> Is there a way to communicate to users that particular change?
> I'm reacting as this is something our team heavily relies upon 
> (https://github.com/mooltipass/moolticute/blob/master/src/MPDevice_linux.cpp#L91 
> <https://github.com/mooltipass/moolticute/blob/master/src/MPDevice_linux.cpp#L91>) 
> and I'm guessing we're far from the only ones :)
> 
> Regards,
> Mathieu
> 
> On Fri, Nov 20, 2020 at 6:52 PM Luiz Augusto von Dentz 
> <luiz.dentz@gmail.com <mailto:luiz.dentz@gmail.com>> wrote:
> 
>     Hi Dean,
> 
>     On Thu, Nov 19, 2020 at 5:47 PM Dean Camera
>     <dean@fourwalledcubicle.com <mailto:dean@fourwalledcubicle.com>> wrote:
>      >
>      > If the HID subsystem requests a HID report to be read from the
>      > device, we currently incorrectly strip off the first byte of the
>      > response, if the device has report IDs set in the HID report
>      > descriptor.
>      >
>      > This is incorrect; unlike USB HID, the report ID is *not* included
>      > in the HOG profile's HID reports, and instead exists out of band
>      > in a descriptor on the report's bluetooth characteristic in the
>      > device.
>      >
>      > In this patch, we remove the erroneous stripping of the first
>      > byte of the report, and (if report IDs are enabled) prepend the
>      > report ID to the front of the result. This makes the HID report
>      > returned indentical in format to that of a USB HID report, so
>      > that the upper HID drivers can consume HOG device reports in the
>      > same way as USB.
>      > ---
>      >   profiles/input/hog-lib.c | 18 +++++++++++-------
>      >   1 file changed, 11 insertions(+), 7 deletions(-)
>      >
>      > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>      > index 78018aad3..49d459e21 100644
>      > --- a/profiles/input/hog-lib.c
>      > +++ b/profiles/input/hog-lib.c
>      > @@ -779,7 +779,8 @@ fail:
>      >   static void get_report_cb(guint8 status, const guint8 *pdu,
>     guint16 len,
>      >                                                         gpointer
>     user_data)
>      >   {
>      > -       struct bt_hog *hog = user_data;
>      > +       struct report *report = user_data;
>      > +       struct bt_hog *hog = report->hog;
>      >         struct uhid_event rsp;
>      >         int err;
>      >
>      > @@ -808,13 +809,16 @@ static void get_report_cb(guint8 status, const
>      > guint8 *pdu, guint16 len,
>      >
>      >         --len;
>      >         ++pdu;
>      > +
>      >         if (hog->has_report_id && len > 0) {
>      > -               --len;
>      > -               ++pdu;
>      > +               rsp.u.get_report_reply.size = len + 1;
>      > +               rsp.u.get_report_reply.data[0] = report->id;
>      > +               memcpy(&rsp.u.get_report_reply.data[1], pdu, len);
>      > +       }
>      > +       else {
>      > +               rsp.u.get_report_reply.size = len;
>      > +               memcpy(rsp.u.get_report_reply.data, pdu, len);
>      >         }
>      > -
>      > -       rsp.u.get_report_reply.size = len;
>      > -       memcpy(rsp.u.get_report_reply.data, pdu, len);
>      >
>      >   exit:
>      >         rsp.u.get_report_reply.err = status;
>      > @@ -846,7 +850,7 @@ static void get_report(struct uhid_event *ev,
>     void
>      > *user_data)
>      >
>      >         hog->getrep_att = gatt_read_char(hog->attrib,
>      >                                                 report->value_handle,
>      > -                                               get_report_cb, hog);
>      > +                                               get_report_cb,
>     report);
>      >         if (!hog->getrep_att) {
>      >                 err = ENOMEM;
>      >                 goto fail;
>      > --
>      > 2.29.2.windows.2
>      >
> 
>     Applied, thanks.
> 
>     -- 
>     Luiz Augusto von Dentz
> 
