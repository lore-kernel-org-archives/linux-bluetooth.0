Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F87C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiAMVha (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiAMVh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 16:37:27 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB519C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 13:37:26 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 66so3922635ybf.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=y3B5u7z9sSBKkzmNePwagQHagBzD1ynztbveNLX4W34=;
        b=GBP1Cc4/14lbOVjh3Cz/bszbNqlc234Bywi9ZLN2f9Wb2uB+SuIthlIzaM2Gb7Bdef
         p/ZIdOjv3x3tiDD3XNnxVtgU3PHEqoZO/FwqKoIz+Dcu0aQvR+sBuClp8uO9O9Y9CJ6Z
         2t23qG0KNQAumCVnDyz1iEIElNo7dqJoTbZGQmOsu86Ywnftfe9c7qkymj09dxf+SHyQ
         OSrvysVarFYFltEWoLNyeDXZkyHY3ZHDYSX0JwemgZpQjsy6Zcad75HR923C+bpoFCYo
         6T/dm00r4E/VZ+f+t4Vqh/MvG9SVz/K7yau80tQwUY8J7134hpa3GE/xVsK7Thm+1yG0
         VdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=y3B5u7z9sSBKkzmNePwagQHagBzD1ynztbveNLX4W34=;
        b=t/u+Dd/EOtArTtY7xXHi6ScDjGg84RMkq4cGet56R/fGTA89Xxhx6cHWeYwaZMC4Sr
         IBZtwt84MQI5PD34RyQs9xeIjTrXVFhIhoVVHDCIkFa/nlfAc/53fvP2xyIY7gBxkVUJ
         zwBnPLID4pH3dHXN/DRn9EPHTLa0/oa+tM639YUyRDpKFVNCYNgcIeZZPrqtC5Cd5aYa
         ANWxKImRoRsMBXS4CRXjgAAXksYAUGe+wpuczaufOg5/WUSTUd2slDLbyz4PD4YbPS2V
         LM+44X1v6EDsrAGS2LuCSVmT0wZyxlrV0av/iRL54wPeUzX/p+CcrBSZqq7GfV40cesm
         oP5g==
X-Gm-Message-State: AOAM5338CoaLemk6QqISMpU0wO4AbO6UK5MUPzuI9Vwd6+szHdzhsGqX
        YdSDlKUshXEvdZYFGZV+3A3hC52dlC+8A12rBsTbm8f+
X-Google-Smtp-Source: ABdhPJxPQYO+8/W3OMr736BF2f3PtFFrm/KXdlZnRqOtqUSZKOIPahle19iK6VSOcv86Nb80M2GsSZowLjmQ6ijgfk4=
X-Received: by 2002:a25:bd8d:: with SMTP id f13mr2716313ybh.573.1642109845949;
 Thu, 13 Jan 2022 13:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20220112224842.519814-1-luiz.dentz@gmail.com> <61dfa05b.1c69fb81.f4256.34dd@mx.google.com>
In-Reply-To: <61dfa05b.1c69fb81.f4256.34dd@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 Jan 2022 13:37:15 -0800
Message-ID: <CABBYNZJz02QHR+E4uNPbCO9o8scJz_o6xtUHbF4VjLuwwL82GQ@mail.gmail.com>
Subject: Re: [v2,1/2] hog: Fix read order of attributes
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 7:45 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=605008
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.65 seconds
> GitLint                       PASS      0.74 seconds
> Prep - Setup ELL              PASS      50.27 seconds
> Build - Prep                  PASS      0.56 seconds
> Build - Configure             PASS      10.06 seconds
> Build - Make                  PASS      1882.33 seconds
> Make Check                    PASS      13.16 seconds
> Make Check w/Valgrind         PASS      563.83 seconds
> Make Distcheck                PASS      292.14 seconds
> Build w/ext ELL - Configure   PASS      10.16 seconds
> Build w/ext ELL - Make        PASS      1806.94 seconds
> Incremental Build with patchesPASS      3736.08 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
