Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1998C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 22:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CD061260
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhFRWrF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFRWrF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 18:47:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99147C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 15:44:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c138so14753521qkg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=USPzt0jsG/Gh6eBN4Fz8UXWDiF6LUmsdn/nkD7D2M0c=;
        b=UzxeZ8ZcC4KaFM4EYE7K3W1ZbUvwMcD/CKCXOWaVBHvGDzmoi/SMZ6PpZykNzhx7EG
         eoXMNzWdaossrI6iSGkslUxHdFpaKOY5/At3Cg5Ei8dYJpp9WkGgBhcrRxdzvtO81GqJ
         y758hZS4fVzh3ApK4o4stcfxNdNSWJi5Dc4JXkiU8iWcwknlcKSsFNMplb7db9cEV+1b
         +A38dr8bA4TTakaQunKH27vgxPFTpsfRnLy8mr6IqNbi2YzVup96jhAT69eOegnJmg+Y
         Jw1jmqZjfJtcBfkhkxiI4ZVPcCpgEUpLkLnFKdExL8P7eA1/ikQGXgEqHeXnoAsuPV/I
         iR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=USPzt0jsG/Gh6eBN4Fz8UXWDiF6LUmsdn/nkD7D2M0c=;
        b=fOGDzzf7sRADQj+9oESCLM9Y4FuDMTvFaxLLnKYi4L7/q+nYNznKJHYszUOgnB+iiT
         ejlBArQO8T0PCPfvaiLQB4wWwjvYKPjiTBx0aSo2J16jH7AXXdA2yDDtDPc12psElcwY
         7JZe1MHpA52BwQaGsA5Dpaek2gP39FZK6BTaeyT6wfcr/arptjorbWiF1HKfrE/cVATD
         n/vPMpnOjm5dmhCDaAF2INCKNcv8c8Ts9jVun0CL6uW++BuyPQO8g+JqoyF388lemfJC
         jI0vHx39F5euzMEfZuKei774xzKVpmgJ70+Ci9z2Lr5jxtOzRN8lzv5SvYnxRMg+9Wrz
         7sWw==
X-Gm-Message-State: AOAM532XEcq7ZHylhpQ/SEiKpyhaHVZ3e+/hEbKzcd4kd4jm/FTLP067
        Ai6QXLXP/nnD5wtfn7+vszb3rDAWJSe3PTuDlx99ao9dAc8=
X-Google-Smtp-Source: ABdhPJwoM3QL3m9o4S7Cq8Kbel5OYTXSxKZ7/aFKCuSCzkUtCMOR3kiRfrOO7Z2Je9liF8L/GSqgJ3Zmi75SPKX9qoA=
X-Received: by 2002:a05:6902:102d:: with SMTP id x13mr17910882ybt.408.1624056293305;
 Fri, 18 Jun 2021 15:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210618171301.2285511-1-luiz.dentz@gmail.com> <60ccdd47.1c69fb81.5cb52.96dd@mx.google.com>
In-Reply-To: <60ccdd47.1c69fb81.5cb52.96dd@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Jun 2021 15:44:42 -0700
Message-ID: <CABBYNZJJ=j22Qwxx9Lkz5sQfT3nRPrYpXu6yRtfR05q=tgE8wA@mail.gmail.com>
Subject: Re: [BlueZ] device: Fix enabling temporary timer when TemporaryTimeout=0
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 18, 2021 at 10:52 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=503457
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.37 seconds
> GitLint                       PASS      0.15 seconds
> Prep - Setup ELL              PASS      50.72 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.80 seconds
> Build - Make                  PASS      219.47 seconds
> Make Check                    PASS      9.61 seconds
> Make Distcheck                PASS      263.52 seconds
> Build w/ext ELL - Configure   PASS      8.77 seconds
> Build w/ext ELL - Make        PASS      204.11 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
