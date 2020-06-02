Return-Path: <SRS0=y60a=7P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E949206C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 17:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPKHkXiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgFBRBO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRBN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jun 2020 13:01:13 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96601C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2020 10:01:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o13so11460741otl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2020 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcP7sI1Ubg4IGjyYRXdbvTFKUH/Dpavej4eYK53EaTI=;
        b=kPKHkXiu1valSAEXp64dVP0XUL+rtpH3nihFMr0UE3WNJPXg+yRbkQGtTsdAxHIMpb
         GMNk1kWFas0iJaYNxV7/jDSXQeQC/YvmYspkTEpFo4pXa3AsncHnx5fVyLlAtRUUzRO7
         su+Du94PIde/8gJNwfKqqrBcLflDvagsqvelHwQDKTUHD6l9AWLt9bM9FZdBQ08sJD0O
         QFFUJC+jj2tzoFNid8IwrmpxoMWlPwvob9eUDgh81w3VpkSjIqxxm6B+EjTYYO6zfUkH
         gOfknoquliSlN6NIMN6AzUBpa0Ypynip4PMnvvoG3LeXdaOiGNxnW2RHj5kt7eyupX8m
         QzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcP7sI1Ubg4IGjyYRXdbvTFKUH/Dpavej4eYK53EaTI=;
        b=BeRRaLb6FKpF9fMM4QEyRid6mA7ZZeKOBEQP/Azy6pd5LKJMrUX+BZaDIPV3wNxfIl
         sY/j2nRRGOhT4WzrqBD8fg1nq91+X/KatyYQT7UeCQWpj2lQRD8vUYaiu5wramO+tywk
         Flc3FITZxGGDl96+CCRgz+E3mh+bH7p1BP3QUMBkO13per587z1N7k3usFpLcdbfj0ts
         pcOAnnOYuNxt3lFVQdf/5fduQQVdHyiyQADU9E3iMmkbuKaTDP4giFgxfsl3jAPZrhhc
         6wDjHnDqzDFNJdXcq+GymTDSHM3umgYxwKf2hCPnf3A2GTguz1UFgrC1pDZP5p2sOm5S
         6ZEA==
X-Gm-Message-State: AOAM5329T2UhZWxPu3f5ceSAvZpVcVklKqixaTzjhmKz3muAB3dykI51
        247lPqaF5MYGU/YWxvbyTlbKyvVzh+j9RZ8LJ20Oaw==
X-Google-Smtp-Source: ABdhPJxvgSsytU3MkFWGppiJ/mFeBFFXJR0ALtXbJQF0u6nFop4zyNF3gj9tILpbCLHR38N4sid+7JiHOa2zTVZbcII=
X-Received: by 2002:a9d:2049:: with SMTP id n67mr155613ota.177.1591117272729;
 Tue, 02 Jun 2020 10:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200601213902.389278-1-luiz.dentz@gmail.com> <CALWDO_UDqCm_tgA5aGyeRz=GDQYFnS+UC-AJ3h2NjGfJCSSwLw@mail.gmail.com>
In-Reply-To: <CALWDO_UDqCm_tgA5aGyeRz=GDQYFnS+UC-AJ3h2NjGfJCSSwLw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Jun 2020 10:01:01 -0700
Message-ID: <CABBYNZJFwv+UTU=h_AvUU5hOy2r3A+iYQ2UwpjcL+ZOEo0gBsQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Fix crash on transport_cb
To:     Alain Michaud <alainmichaud@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jun 1, 2020 at 2:52 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
> On Mon., Jun. 1, 2020, 5:39 p.m. Luiz Augusto von Dentz, <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> There have been reports of crashes on transport_cb where the setup
>> would most likely already have been freed but transport_cb would still
>> be called, so instead of assuming the setup pointer would be valid try
>> to lookup the list of active setups and log a warning when it happens.
>
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
>>
>> ---
>>  profiles/audio/a2dp.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>> index 7f14c880a..d88d1fa69 100644
>> --- a/profiles/audio/a2dp.c
>> +++ b/profiles/audio/a2dp.c
>> @@ -2217,6 +2217,14 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
>>  {
>>         struct a2dp_setup *setup = user_data;
>>         uint16_t omtu, imtu;
>> +       GSList *l;
>> +
>> +       l = g_slist_find(setups, setup);
>> +       if (!l) {
>> +               warn("bt_io_accept: setup %p no longer valid", setup);
>> +               g_io_channel_shutdown(io, TRUE, NULL);
>> +               return;
>> +       }
>>
>>         if (err) {
>>                 error("%s", err->message);
>> --
>> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz
