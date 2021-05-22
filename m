Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C357C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3027611ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEVA2j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 20:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhEVA2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 20:28:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3A3C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 17:27:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z38so193138ybh.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8jIPPWJ/4N2rtUa3UOyKZ4pnnFi2BTgvLx3qmgOD5Y=;
        b=LqOMno/sRQyE4ec6Ovz0XaOiTM3XPkxyeJH6uy6NTkzF/TftpdQg268VNfwofugASo
         4cymEI1hvuJfLZeNHYU5FoC562112j7+p7uHheiufb3ToSzWrQb2+R4obROcLzRsVn3O
         wlWiE+OzD4mMTu8Vdgd+Yb6MkKXJxVfRx4hLXwUdxNNMeCaUf0bXOU2SkTr8ukTSGz81
         gYDVBXjzD0IdArseLzZk1dRyHCeCDDTYL9V5Z7GHqKNz/ivWpfkhClZMjMb5CUssB7dY
         45xgK9N+hHhebyX6mvPpYVBObzT6xSjLuQxjsYfwgFwlMPUscWro0cfmFHMMwdF8ZAq4
         V1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8jIPPWJ/4N2rtUa3UOyKZ4pnnFi2BTgvLx3qmgOD5Y=;
        b=Y+H0XtqTUr//pb2u6ToM0IvoZOHmW9vDNbI3O0S5HAfXlRE2vsCqbmsgNNlXwUNp8b
         AyGwAwUi5qmtAoyVv08Br9+UCDKwgXmwlZDl45KVB997HKwUh2BYIEQk8Ld0y+2lm8lI
         AYxoxCzTyzUsYlUcMDb9veR0Ou5N3b6aUE33DCur3qBf7XME5ibBl2XvRFJy3iben2vF
         4VxST3xTwFz/5G1/oV/MTa7ft30/f0TC598qFSDquSuLAffocZj4yThxb0FxqNmbHyRa
         K4/4Vis9U8+nxpOEh+J73RlyD2Slx9KCy+9GBJtPquJchBgXuT0laRm2RUEnCFwgXU4F
         kybQ==
X-Gm-Message-State: AOAM533xZFl2czttCv8sN1fFukDhfcpRJZxJ5n0WYujOZcfj+OykiUfH
        Ie07JXnmGrgMVce6vtdDSqcO67i9zLRtnf96qWwH0A8S
X-Google-Smtp-Source: ABdhPJwHdLz8UESCxYZsa0N1GW1tIGe17gkqvvReZYEcS0XlAiPf3skqvWCC36Mgk+R7Lnqk8EUDuqDjtNrIPDlSjAw=
X-Received: by 2002:a5b:286:: with SMTP id x6mr19989529ybl.347.1621643233687;
 Fri, 21 May 2021 17:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210519211907.157397-1-inga.stotland@intel.com> <60a58641.1c69fb81.c548.4937@mx.google.com>
In-Reply-To: <60a58641.1c69fb81.c548.4937@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 May 2021 17:27:02 -0700
Message-ID: <CABBYNZJMU2j_C=btoA8iwj9PLwv_d2vGaESO6fBnqp6hCDjo5Q@mail.gmail.com>
Subject: Re: [BlueZ] tools/mgmt-tester: Fix "Remove Ext Advertising" case
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Wed, May 19, 2021 at 2:46 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=485351
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.50 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      48.33 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.50 seconds
> Build - Make                  PASS      206.92 seconds
> Make Check                    PASS      9.88 seconds
> Make Distcheck                PASS      245.45 seconds
> Build w/ext ELL - Configure   PASS      8.68 seconds
> Build w/ext ELL - Make        PASS      194.87 seconds
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
