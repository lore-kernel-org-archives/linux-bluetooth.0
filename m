Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7212AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 19:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A43C23AF8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbhAVTs0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbhAVT0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 14:26:41 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3334C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 11:25:55 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v1so6175523ott.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AjMp3lXr1VqjsZQbCqEsJ4nOPXEmJEeoUIk3FJ0VdA=;
        b=KJV7e7hezDVFTzi2+HltESUs1yGCi73V6efz4qX+KymR8XSHi8vwCrye0ha1v9fy9N
         XfR/y01IFLLxCTCcqEmQk17yg40vcoeIKTilSNMmWVUoq8yO6Tf7O2KYdPqFYLvuGM17
         F4ykRQ/Q2/fyv9xW8+T6Fur413MKcGUWt8yh5AHCix0FAqqZ+5G9pnln2n9jjoz5BrcX
         j59yfbpgVvIuxDLWYFSoUZLmqu/JgNDtrSNDDuJWe2GTyZG2LamzWmo9U31J7W9E1EZm
         /CiQa0orT7lU95iXrwtIzX/a2/a8H7I2Spfj2WkIyosukvZKUiiZy5zPqqITIn20E/sB
         Gteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AjMp3lXr1VqjsZQbCqEsJ4nOPXEmJEeoUIk3FJ0VdA=;
        b=Q4cesX/TTqT96IM4BPRdIA5YISY9hpASHlGOB7Zc/Sz3hGY+U76hFhbihuWE/eVntu
         lFWt3yj/qhIjGsR9sD9g2UYYX81/MEUsSYr06tspP0cHTLX3+N2ECPTrJhXaiP1FhjoY
         44FfnKTfV81r4YeqLA6Qrg/YmxCRiQcZR3oboW68jDuj95OX1vLKZH3Mu1r83qyRMmIj
         nokp4+zAbGfPMWiJIMct1nHmUk50n+c6jjp5tArp1oH+qFpFn3nPbJX639ZExSSKihtY
         o+ZVP8x0/f1eVucAV2eyBu4b5tomwKY/28poDDZEPBdF5cTSWZ27VufjMexAH1JojmWZ
         XD3Q==
X-Gm-Message-State: AOAM531mFyEhaBTUwIlTISf4mJrQXbJw79W/QjdPl1TvQTSuV4jNlh88
        zNWYZmm6IcNI/1gyNNnZnQpHEFg3urAFbbbqtH8RAfdNP5g=
X-Google-Smtp-Source: ABdhPJzFKe0u81y+ZMk865IQ5s0c+gz3z79DSniN7SOh1TJR88GpsD6eRpL4ai8X/AyW0YBwQLvFqFWMdTLID83ewp8=
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr4704799otp.240.1611343555081;
 Fri, 22 Jan 2021 11:25:55 -0800 (PST)
MIME-Version: 1.0
References: <09143537-3eb6-dd27-47a6-791d30ba921c@kernkonzept.com>
In-Reply-To: <09143537-3eb6-dd27-47a6-791d30ba921c@kernkonzept.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 Jan 2021 11:25:44 -0800
Message-ID: <CABBYNZLTjjsoUn0YeoJAvL1gkme=d5tTaRM2utyhbf7EYHBwOA@mail.gmail.com>
Subject: Re: Use headset mode of Klipsch T5 II
To:     Marius Melzer <marius.melzer@kernkonzept.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marius,

On Fri, Jan 22, 2021 at 5:54 AM Marius Melzer
<marius.melzer@kernkonzept.com> wrote:
>
> Hi,
>
> I bought some Klipsch T5 II bluetooth headphones but the headset mode is
> unfortunately not working.
>
> All details in my (unfortunately unanswered) stackoverflow question:
> https://unix.stackexchange.com/questions/629197/use-klipsch-t5-ii-as-bluetooth-headset-under-linux
>
> I tried this with Fedora 32 & 33 and an up-to-date arch linux. Both
> Fedora 33 and arch linux had Linux 5.10 and bluez 5.55.
>
> Any ideas what is causing the problem? In which part of the bluetooth
> stack (kernel, bluez, ...) is this most likely situated and is this a
> bug or a missing feature of a driver or simply a configuration issue?
>
> I'm happy to provide any further information needed (config files, log
> output etc., just name it).

Lets see what we have on HCI logs (btmon) and bluetoothd logs when
connecting to it, does it at least pair?

-- 
Luiz Augusto von Dentz
