Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0267C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 04:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F2822D49
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 04:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPEdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 23:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPEdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 23:33:53 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF93C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 20:33:13 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id m12so45089710lfo.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 20:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/th1joOkeBXCqJ4mLAVLdt6T15Ue2X6Wbw61ReZyyOg=;
        b=lZ61g0DMAWptC8e66kYer41Cn4PWvHY+iP1T3pazHnLIVZi47lTK5zIzqe/X2zuTxk
         uZ3YtKP/DtliiVkalBiRVEFnwQmt9WjiMyYtAMLtpSf9rG2zvgrIrJQg9E62q2prNZHa
         f6Aavn840BdNqVacXogayj91wye53OK4J3l+vkCD54wn8plsMW5d0wf7lfHnnNUMdArC
         xsLrC7H1HhwPCEQKeyRYRMYXgTlc6Tec8sZ5g4mT3MxPCkaQUCEL9MCDE45nWTBChlC0
         lnU6xkMH1KcPDv5fV+H8sGEIOC5vyhCj9atHMAyWx0ld2iKN3NPiRiSPO1l0eBXkXu8g
         15zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/th1joOkeBXCqJ4mLAVLdt6T15Ue2X6Wbw61ReZyyOg=;
        b=j0EaS2X264mUMcvGqRDUHFZO7A/y+0wdgUhjBwsJKOz9pTyOb+8jlAmxNplvuwq+DH
         /gI3M0ux1N3d5nVrTXtFJJ7LiogHrOogbP1ZEn7vuuAr/pZ43/I6QDE52GOp4yk+x5hW
         agwTsmhUTeuGi49BNLNvQjC+MY5I5X1RmRu0U3gfqk+rgnyqsp26kU1KCKtz94lqCW1E
         0JNVNMAEuRFSBRUydmUPJpKcG9Ev6GWckLOyaVIoHHZx0PBFrnzq1tn3wkvP7vOMA1Yv
         qSH4katN7Fs25MWPuqgorZ0omTPNvNtUf1qWopXTBvoTg5VwX2Thez/T4AXOB4l4posb
         FpiA==
X-Gm-Message-State: AOAM531MetlA+qw7UNXSTo+KVSE+ZjNH4x/LbyNsEXGlQsYBCQHPj/Ms
        qir+jZ0bGiR9vlpFXgMmlwR0lyJPO8e7OEnY1hlYbA==
X-Google-Smtp-Source: ABdhPJyswal6xKAMCbk3QX9ijR9beRQ9p0nM2k/1kJ2XWVWGdLHQnhwfS5cVSshK6JtuUlMsZ5KjBXw0ALrScxbxDWw=
X-Received: by 2002:a05:6512:3f3:: with SMTP id n19mr4593457lfq.586.1608093191460;
 Tue, 15 Dec 2020 20:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201215163106.v2.3.I2bdb3d9953a91dc7865da6e57166260b3a75c146@changeid>
 <20201215190354.GI2809@kadam>
In-Reply-To: <20201215190354.GI2809@kadam>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 16 Dec 2020 12:33:00 +0800
Message-ID: <CAJQfnxGdUq-yfDxXNASDC-piP9Sv-9UWAQrQWTKJa=dy+d=B8Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Bluetooth: advmon offload MSFT remove monitor
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, lkp@intel.com,
        kbuild-all@lists.01.org,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On Wed, 16 Dec 2020 at 03:06, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Archie,
>
> url:    https://github.com/0day-ci/linux/commits/Archie-Pusaka/MSFT-offloading-support-for-advertisement-monitor/20201215-163858
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> config: i386-randconfig-m021-20201215 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> net/bluetooth/msft.h:45 msft_remove_monitor() warn: signedness bug returning '(-95)'
>
> vim +45 net/bluetooth/msft.h
>
> d8ca4cbc63c57c8 Archie Pusaka  2020-12-15  41  static inline bool msft_remove_monitor(struct hci_dev *hdev,
>                                                              ^^^^
> d8ca4cbc63c57c8 Archie Pusaka  2020-12-15  42                                  struct adv_monitor *monitor,
> d8ca4cbc63c57c8 Archie Pusaka  2020-12-15  43                                  u16 handle)
> d8ca4cbc63c57c8 Archie Pusaka  2020-12-15  44  {
> d8ca4cbc63c57c8 Archie Pusaka  2020-12-15 @45   return -EOPNOTSUPP;
>                                                 ^^^^^^^^^^^^^^^^^^^
> change this to return false?
>
Thanks. Will fix.

> d8ca4cbc63c57c8 Archie Pusaka  2020-12-15  46  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Regards,
Archie
