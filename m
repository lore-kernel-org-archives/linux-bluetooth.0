Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9DCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 18:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJDSoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDSoB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 14:44:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B0065646
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 11:44:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 10so22429459lfy.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GfxiAhQpdpPGjG448B3QzOG4f4Fm/s1KvqI2Bz78cfg=;
        b=Ir2l/I10/469GO+rQopvlIBYkwV6UowssuGJ5pXpQzvBXgbzEhU+L8FDw+qby2wewv
         iCzVhlKMf1/d58wAoSq48dBP5uSduEXvZcwVOmM4YP30myiXIz3wM8No4L2jUZ8Gt+9J
         LJHdA3pYNoIXQQlOOlB0iaXqUV3VGo0fkJtuBgfhGC8Ci7RcMSNSFj7Q9RT/H1bVYwgT
         vdJnKpPgMEJjXBWM5BLd4vfJjj8bMQPM0u/2XmUsV+uisjjU11jBH5E1HH7rLhZ/0jTN
         FBZN0coMwFcXaTP3bQ/YV+MzTjGNNCs6BuPglPZ4RYaWzeXWtOPGYaqQvb3Jgxk9PATE
         nt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GfxiAhQpdpPGjG448B3QzOG4f4Fm/s1KvqI2Bz78cfg=;
        b=3S7+0okQKpIZROKzZV6dsNnfAi08KzShkh4BEkY71k+VkbKvKBVLMhGM/bQCI44lK+
         D9U9SCY4fbOFsNZ5BgY4ZMOyQNTQC6MTR5ys+C4Wafy11OHTY40jQVsJlg+r9a2R0ATR
         WzG5WUhDmyuUuL9amU+ufzd6BlEvb4o8254Kh6wB1N73zmkQSMz7eM+Uw4IB8EfCILje
         lcV+wbRYldAWEL9TmzR+E3k/sL/C9wAyyKOV1uQEiYG3aQkj3EhW6Rph7q4YL8VHmQDB
         wYh3tEQsT2io8ySpsQ+ZfsCj4waW8OXDiMmpBq06QsW5Rxda0JumVyL6dT6zM7dSt9RY
         AIqg==
X-Gm-Message-State: ACrzQf2xAS0MlNphhs0uQMTRsBmn3yp9uc5GUrokbh2rgwkHNJFsUkO2
        05i576IiX480XEKzi2b5G8GPy5bjckbGKi+cZr9ib84G
X-Google-Smtp-Source: AMsMyM6QEmzNfaEKEYct9oedikPilU1v0Al+FRzz8/pWJM5jLKssvqNA28nhir8FytVjwuB98MSTjaaebJSdetnDR/4=
X-Received: by 2002:ac2:4c8b:0:b0:4a2:2432:93ff with SMTP id
 d11-20020ac24c8b000000b004a2243293ffmr5343663lfl.26.1664909038572; Tue, 04
 Oct 2022 11:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221003064836.11414-1-kiran.k@intel.com> <633a8ff7.c80a0220.2df53.e4b0@mx.google.com>
In-Reply-To: <633a8ff7.c80a0220.2df53.e4b0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Oct 2022 11:43:46 -0700
Message-ID: <CABBYNZKuQk0CVi6FG9iBrmNSYwOEdVi7jMYXtzx8yi0_HTMEKA@mail.gmail.com>
Subject: Re: [v1] btusb: Avoid reset of ISOC endpoint alt settings to zero
To:     linux-bluetooth@vger.kernel.org
Cc:     kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Mon, Oct 3, 2022 at 1:27 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682688
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.79 seconds
> GitLint                       PASS      1.02 seconds
> SubjectPrefix                 FAIL      0.86 seconds
> BuildKernel                   PASS      44.01 seconds
> BuildKernel32                 PASS      37.35 seconds
> Incremental Build with patchesPASS      52.88 seconds
> TestRunner: Setup             PASS      611.23 seconds
> TestRunner: l2cap-tester      PASS      19.50 seconds
> TestRunner: iso-tester        PASS      19.65 seconds
> TestRunner: bnep-tester       PASS      7.79 seconds
> TestRunner: mgmt-tester       PASS      119.75 seconds
> TestRunner: rfcomm-tester     PASS      12.14 seconds
> TestRunner: sco-tester        PASS      11.26 seconds
> TestRunner: ioctl-tester      PASS      12.80 seconds
> TestRunner: smp-tester        PASS      11.21 seconds
> TestRunner: userchan-tester   PASS      7.94 seconds
>
> Details
> ##############################
> Test: SubjectPrefix - FAIL - 0.86 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
>
>
>
> ---
> Regards,
> Linux Bluetooth

Should we add a Fixes: tag? Also is there any bug that shall be listed as Link:?

-- 
Luiz Augusto von Dentz
