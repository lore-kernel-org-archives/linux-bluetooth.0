Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E3AC4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 12:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006BA61002
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 12:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFWMRs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMRs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 08:17:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0788FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 05:15:29 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so1674830ota.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3S2Lgtx7Of3Ddy82wfcJaqPcQoDodgBHFGCGyeQpc/0=;
        b=Yisz0F9B6sslUM0he/jk/9+dbG79AmHUT/ct2RitllGrE4nyzcKlyyc4ZSI+Jbk89K
         A6BWkpAiy6UC8A9LMoGgh3xjXAD38oDq6o3ta9uOO1ikEaLaDfPndnJUk90tGu6iazs2
         0b+L1T0DWjjwShwI2KLDQLcDGuUvb+yTivsUWWyu/vtGmSz6s7iJIudjqQ4HEoDhdplH
         oqbX5+L2U01CTipieSAW4w9wmeQFiHkHjAUXsJlRcAQWCjF8Gckqs4Zol74r+0h/r606
         /ezEs0cfIuTtJVN0fFUrF84Gr2T5G+3YIkYmS+Yt3YPLjDbzvJPTVDGEzRaH/1lS+KNM
         kXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3S2Lgtx7Of3Ddy82wfcJaqPcQoDodgBHFGCGyeQpc/0=;
        b=rtwH+RiFylFPmKFMkqmxUc27e2gGjo0OdqJENVymDvEO7paJSNpP+7ZVKAbGMhCmL9
         TxtBMdQY70lW+UfaEJm6P6AsrlW5+efDxUikH8MTJFXToRYnHUHXPshZHAC/q8verVU8
         xivLJm5v6+3s7lnNw74JbpypQkE6rXa+5LobyhGs2tecOPcvPoFtXvMpE7wUHeoQRv8P
         Vt/3iGu5ZdZFGTjK7rkMmpgaISmAy4uJ5YL7WMWQo22hZ7vLsU/hbeT6EvxzgEdgHIJo
         +q02vc7G3KkkB3UtdbEpr+Zm6uPpUM6rRoY8+yqB/fs/YYPHfV69jsPF7RjH5JCv0QL6
         StTQ==
X-Gm-Message-State: AOAM533thOt0rLDz+lkWOA0qpbkxW/F2WHI9KtXE3t6zxidIx5stPLHL
        /suCavExM6ZAuqmHVF1nxQK6X0Mk1mWGNX1uO+6aJgsgQpY=
X-Google-Smtp-Source: ABdhPJxPSqey6lxQuKg/KwpESjAr7kNj6jMm85ucWZtgl2094XzybLSyxKb9IRvfW/+kV5OuLuEyf+3k8UqQE6RkrKI=
X-Received: by 2002:a05:6830:1283:: with SMTP id z3mr7535099otp.346.1624450529177;
 Wed, 23 Jun 2021 05:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAG17S_ND46_G0bC00T5K7zhEUE6e9Etab5Re-YrSnsAdqwTp4Q@mail.gmail.com>
In-Reply-To: <CAG17S_ND46_G0bC00T5K7zhEUE6e9Etab5Re-YrSnsAdqwTp4Q@mail.gmail.com>
From:   KeithG <ys3al35l@gmail.com>
Date:   Wed, 23 Jun 2021 07:15:18 -0500
Message-ID: <CAG17S_NcPuvXefSV3Lhb0gjLZWMvTqBbQLSvjY_uKpJvisEFBQ@mail.gmail.com>
Subject: Re: Keyboard paring failures, still
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

recently upgraded to 5.59 and still cannot pair a keyboard. I posted
again to https://github.com/bluez/bluez/issues/55. If I can perform
more diagnostics, please advise. I would really like to be able to
pair and use a keyboard with my RPi. If it is a driver issue, please
help me point it out so it can be fixed there. If it is bluez, please
let me know how I can help.

Keith

On Wed, May 19, 2021 at 10:08 AM KeithG <ys3al35l@gmail.com> wrote:
>
> Still struggling with this. I have posted here
> https://github.com/bluez/bluez/issues/55 as well. I cannot figure out
> why/how it eventually pairs, but I have to type in the provided code
> many many times and then inexplicably it pairs. The latest Arch
> package is 5.58. I have also built the latest from git and get the
> same thing. There was a comment that maybe a couple commits seemed to
> fix it for another user, but not for me. Is there anything I can do to
> help get this resolved? It is pretty strange that I can pair a phone
> for audio, but not a keyboard, one of the earliest BT devices... It
> does not seem to be the particular keyboard. I've tried 2 different
> ones and get eh same result: Failed to pair:
> org.bluez.Error.AuthenticationFailed
>
> Keith
