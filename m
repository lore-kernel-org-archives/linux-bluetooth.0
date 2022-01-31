Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E20C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jan 2022 18:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357216AbiAaSo2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357254AbiAaSoY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jan 2022 13:44:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B9C061714
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 10:44:21 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so43399474ybk.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dHZx7ERbc1lDVUvGxtl/jnhlF6AXqS240PsRl3LKzso=;
        b=Ezubq+nDXqKytF44QTJWRYvbgEdLME+9tCq6Kv8Qq1zNVmubek7Ev/zZ8urxcKM5Ij
         YwneBYgri9q5qOmiWdHUfKrhl7l3Ki443XqoZKhDPY8DRQRa3yovkluZD/z/4ffcKiE9
         8RBZExdCYp9xunPZpxpZrl76fgQ33b5Xeip3j9moYDeI6x2i6no3YPfbkeWC+3Lf6Lp9
         UQfqx18aSZCdaPWLT/kjGTsCE9vPp8+/X5u4WE/nbcsmVsVC5aUl5Ki50CY/j0Anw4NA
         vRLbzGACUoug3DE6lwyaCUKkbtDqttLT6k6Y+2ukNDbp/qSBl33ySLAWtwVzJRMLqvhn
         HqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dHZx7ERbc1lDVUvGxtl/jnhlF6AXqS240PsRl3LKzso=;
        b=Kv0pg6LfzdKRC2Hly9R9mJk01s4sWWl+B0h/iGbAYrkWUwLkJZWeVg664QnYc3Yny/
         tu5MgDVjuSSUt/XqpHJs17/a1u9e+YJAbJVg5AQ5ld+iEWAc4LGzflH4vNgdKX5zJhiw
         Gb/Gu35Ljrs70Tc0XcB3S+vafY3d9HHZ6WrcRbyk4thPcHuB96Rvv0l+njD4TFPayull
         bWFe0B8Hc8cVnmhUpdrhHYSeu2vWGkGQIBYR3bcT1wBQMS1lAuJgOZzcDUX+2cSA8qP9
         nGHf4+TNNv8QnWdL/qIHKTN7urc12nQhnIzvBUBzrLvPBFTOdjMLlj1vsC4LPcyJnbct
         JjVw==
X-Gm-Message-State: AOAM530q6YCuDhkyY31BvTMlBCyKA0w3ILalUkrJ+5af2E5zBhC92eeM
        YV9ZMCKNDd2+sdlTz5cXJh+eBliDH1U6cRcGhfkhb/LOOGk=
X-Google-Smtp-Source: ABdhPJxBa+ZJ1kqrif/ul++uh8UaqIZagXNQWztRlGXunyz8WQLUOTN2Sg42DI1AsCc2YaZBv/L0iFQGIBPO72KvqNM=
X-Received: by 2002:a25:8011:: with SMTP id m17mr30677616ybk.284.1643654659536;
 Mon, 31 Jan 2022 10:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20220128210554.3997506-1-luiz.dentz@gmail.com> <61f6771e.1c69fb81.9e82f.05c0@mx.google.com>
In-Reply-To: <61f6771e.1c69fb81.9e82f.05c0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Jan 2022 10:44:08 -0800
Message-ID: <CABBYNZKA8rNs1aXhAnX0gBNUODuh3V1-UMP+Dszyu=akUpDVmw@mail.gmail.com>
Subject: Re: [v3,1/2] shared/mgmt: Add request timeout handling
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sun, Jan 30, 2022 at 3:31 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=609643
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.31 seconds
> GitLint                       PASS      0.74 seconds
> Prep - Setup ELL              PASS      49.36 seconds
> Build - Prep                  PASS      0.61 seconds
> Build - Configure             PASS      9.55 seconds
> Build - Make                  PASS      1706.14 seconds
> Make Check                    PASS      12.84 seconds
> Make Check w/Valgrind         PASS      515.20 seconds
> Make Distcheck                PASS      270.46 seconds
> Build w/ext ELL - Configure   PASS      9.86 seconds
> Build w/ext ELL - Make        PASS      1689.54 seconds
> Incremental Build with patchesPASS      3406.26 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied.

-- 
Luiz Augusto von Dentz
