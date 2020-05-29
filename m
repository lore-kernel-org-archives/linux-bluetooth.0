Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9C8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 20:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30F520897
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 20:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgU6Gh+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE2U4o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2U4o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 16:56:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB077C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 13:56:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so5402947wrr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2RP91tNPJ9sbLZPT2r9Qi87Xb7qQvAPK+PWgsOwOKiM=;
        b=NgU6Gh+rvPxPyboeL+y04ZREmeTJGd+midwZ/PTtV9ULcBVcIGbpTuJthxXhHJdHqs
         lpNf33cNmVj0D+wbuENAR4d6nQX6Jdl/v+xA5cK5i4gl61DS5ZAC5ySbns9hYLYeK9Wf
         5lntJP4V8PnV9DB6rOyZJxSyVNUwOACM+8hCB0yxHQ0b3HxXg5ReltAbl8KQ+RLwRmOp
         8DIqP4N3FofFdkj21Gr/lXCjP1PP1AEo3COF29/pBHu3z93Lg5hXvQB7NLjWgEuhiBhP
         iwsskgOe4g1yU9pbRm+tjckeuqeGh2/3c6Z+Kn+IoG7zc3Z3iO6vGSGH16n+shF9KcBt
         9U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RP91tNPJ9sbLZPT2r9Qi87Xb7qQvAPK+PWgsOwOKiM=;
        b=H1OGMbakM1bqr1j2UMbaOhZazC0YKdftuCc/s+Ddzf/eCXQ1uDZEqmeiHfxIf0msOS
         ILZF+wXtCMoWOuHJ+llb4z07sqeLTIMAzWpfIBmdGm3xQp3KTG1HCuTE+Azm88xTe9Hj
         mQQRTaCh/siRfNxcrRpfcyTbS1Q9dYKZunw8e7b+4rrgIlTzUndIszEeGrCClbjY4F6p
         7pgUCGZ410QhktH8BwaHe7+Ucm5pmtKuXDDafaGNhPgoqEAT2mtj+VuuVtQseSeRRzJp
         wf4g7A3eWOQFIL9emjfdFRFiFfYC2LifkI6FIjLuZZR8p3RGTCgs1U2Tc2ou/ml7Fe09
         1H7A==
X-Gm-Message-State: AOAM533baslkhbhd35dzDnYa96M2o9WSklxjvPtZMKdRfG4HREhFB29Q
        EGZ0ahczLTviEcOewUyYezcCu6/IgMY=
X-Google-Smtp-Source: ABdhPJxjRWk4NGKq5E9Gdxv6Oap2A9C9Xamj39+CKxzO5E4pWwVt55l6RNI7X97C1weRigjof9TQsA==
X-Received: by 2002:adf:a387:: with SMTP id l7mr46310wrb.300.1590785801953;
        Fri, 29 May 2020 13:56:41 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-255-20-215.ip.moscow.rt.ru. [188.255.20.215])
        by smtp.gmail.com with ESMTPSA id z7sm11300754wrt.6.2020.05.29.13.56.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:56:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] avrcp: Fix always requesting player settings for
 category 1
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200528215300.225894-1-luiz.dentz@gmail.com>
 <CABBYNZ+RQooYxKUYLd6TPL-o7vN6Xzeq0RN3E-ii_wbTfPyQtg@mail.gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <ad6038f9-9b03-1853-1c12-fb6599c248d6@gmail.com>
Date:   Fri, 29 May 2020 23:56:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+RQooYxKUYLd6TPL-o7vN6Xzeq0RN3E-ii_wbTfPyQtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-05-29 23:29, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, May 28, 2020 at 2:53 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Player Application settings is not mandatory for category 1 so instead
>> of always listing the settings the code now checks if
>> AVRCP_FEATURE_PLAYER_SETTINGS is enabled.
>> ---
>>   profiles/audio/avrcp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 773ccdb60..75811bf98 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -3814,7 +3814,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>>          if (!session->controller || !session->controller->player)
>>                  return FALSE;
>>
>> -       if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>> +       if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
>> +                       !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>>                  avrcp_list_player_attributes(session);
>>
>>          if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
>> --
>> 2.25.3
>>
> 
> Applied.
> 

Thanks. You may want to close 
https://bugzilla.kernel.org/show_bug.cgi?id=207625.
