Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Dec 2021 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhL0GYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Dec 2021 01:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhL0GYl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Dec 2021 01:24:41 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE1C06173E
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Dec 2021 22:24:41 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d10so44823460ybn.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Dec 2021 22:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D+KOvUIrfxhOGrOtJNXfZtAfyLA4yuPmSn1t8ozTaFU=;
        b=UOwusFQlIYeXMEv7H30ThUGtxet6nPoZXUqyNc4fYlCt3dyFjUaM59ArXyy8cuj446
         uapPmbihC5DBKsJLV4909RuBm7JhDPhBj12Ev+7hp1z30u4DgOx1euvfFsFDP5iVwzd8
         IpI4GrQOpX0jvlzwpyv6qYZZXwHtQFjioWivqtf90UVuNdEwhKqbq6A1qFveiWY7zMpR
         HQe7FclHU5b6dfSEZYsJQ0tZdDrO3ddHuOtFm+s21x3Rdb7v+q7FT4gJzOZ2TtCgu5Qv
         ofXzVD99CHiA98GcGlvDhxPlo4t8rQkhuzq3z4jNAJPk+W3kDbmokpQMesDs+qUrQ9OM
         0SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D+KOvUIrfxhOGrOtJNXfZtAfyLA4yuPmSn1t8ozTaFU=;
        b=Je/uvBn/HBDuefXROz0JBlRkcupS8tRh5QSfvoTRQJ/EanJa8YTIfn/dveCHDQHVtM
         dr/sk0XwqgzbsX5qidXxiVvAb1PP0yYgcK4np1iw7SjtqqqppJFqW9OATPotT0t0bfNO
         8B5AVMS6FKFqI6x8iQwblWiZc2eNd6G4Gyd3V55qGQxchGozQp5UvYnu0iiAzomjDap6
         O4gsh6MAQhiWuqQsJG9mcpTKQI9p33n1kIu4GAtbOg4erxBw9fBws3EXVZYL2a6jTJ6a
         TLLYn6/m2tQBpX254dSh6LI1J2BfRowTuQyH78ftEqhZ1fc9A15Z7sgE+MToz/CWJCuw
         VMHw==
X-Gm-Message-State: AOAM533Sa60smnlDDNJY2rHev+HVuXeBhAJR7HGpp1BhWzIcvLRu0MR1
        Q0K+raYsqcJHh5qOwFKvWgNi+7uHH8Kq7Mf7qH4ySNVp
X-Google-Smtp-Source: ABdhPJzR638VM+U8NrkJgJIb/JEBoC/zZOsrQDq1JNVkOF3RotcY/gprxMAza4Qi8HY4i5Ak43J0EN82FmmZObyQwaM=
X-Received: by 2002:a05:6902:150f:: with SMTP id q15mr18474169ybu.398.1640586280643;
 Sun, 26 Dec 2021 22:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20211223195003.1647434-1-luiz.dentz@gmail.com> <61c4f44e.1c69fb81.b9e4a.c3d0@mx.google.com>
In-Reply-To: <61c4f44e.1c69fb81.b9e4a.c3d0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 26 Dec 2021 22:24:30 -0800
Message-ID: <CABBYNZLmd4Qb9zvSTMpWRBFCWECSOo1EMLVLMA7i+guxzm_34Q@mail.gmail.com>
Subject: Re: [v4,1/4] build: Add sanitizer options
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Dec 23, 2021 at 2:12 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=601103
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      5.43 seconds
> GitLint                       PASS      3.74 seconds
> Prep - Setup ELL              PASS      42.12 seconds
> Build - Prep                  PASS      0.61 seconds
> Build - Configure             PASS      8.43 seconds
> Build - Make                  PASS      1390.99 seconds
> Make Check                    PASS      11.98 seconds
> Make Distcheck                PASS      227.47 seconds
> Build w/ext ELL - Configure   PASS      8.57 seconds
> Build w/ext ELL - Make        PASS      1367.60 seconds
> Incremental Build with patchesPASS      3218.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
