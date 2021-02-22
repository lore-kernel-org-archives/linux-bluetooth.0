Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF10BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9521264EC3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBVS2D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhBVS1e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 13:27:34 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51987C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:26:53 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r19so5654152otk.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6z++P5NNRRu8p06caHojxQ7y7AgtbO7SuQKL6+6DaOc=;
        b=QiZxNVgcztYZUmGdwWcmLw791RRz6fszZiJMuMG4Uqlt7zCiqgNhtCIONc3RS5O4cg
         bkAKwIsxU81x1KoKcBXBN49TpoIHOSzzbrmPWaEIYz1qsjKZ9CXxWJB1Ysq1at8LC/0Y
         yVhY66GMkLHvxFeIzD/M+ivpmiTMICpza+g1a4rPOOVu+NIXjmPPOK7d8GCtksLqSDVA
         NdYOJTmG1AFbR9m33MP8CLnvyDoQkFq8hrJ5tdmDX1HqTxnljHW2NYEQjhp/whuvaIZG
         THhAoH1zVzQZVTUfgRyNVT+lgce+0ghrbcnjUpVrltcV775iawVgy7u/+aPsCSPzvcfy
         gOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6z++P5NNRRu8p06caHojxQ7y7AgtbO7SuQKL6+6DaOc=;
        b=ndydWDwbEmEUhKUUyBCVndWBqfQ8+5M/VCCKPLZUSA8s9ARB4yBeNMB5/CZzrPLu7M
         rqdem6t9iCLPCeQnCr8tMs0ABmZcfCiwHKyWpqdG71k8Rv9GA0W3ta0ZOK6w0IMfyMe0
         ygtxWovrNSRgKOd48FutGbkDbLLEV5Bqocpdjirb2f2zQlLevtxDL9kOtrDqP1gJmM+6
         ooOPMhS5RXeaIlGlrESv6e154/6642wmD4F0GvZ3yFlBVAEQ45l52jBWxWqwX9Dl+hEv
         jAEcHWlRHt8qBsOdxeHbLSCHflCy/UxlupRQxoWaTds0G/GOTKUFtom1pv88sC3f8gIW
         c/hA==
X-Gm-Message-State: AOAM530F2P/p4EiUXlRzAQTRjdlt+q2PJ422Twoq+gT5EuENa6aCjbHt
        f0azKND2mcP5K+z7iRpX33llQ/JfNPzWaZ5MdDuhV6j/
X-Google-Smtp-Source: ABdhPJwuCaOyGZI4PmpLzBGblYK7s71MBEmHE07ipXbp/nMtSeKTdF9pBTJTgRRtsbCNNgZb0w87GTaqpXe8iWaiBVk=
X-Received: by 2002:a9d:4b16:: with SMTP id q22mr9451640otf.44.1614018412607;
 Mon, 22 Feb 2021 10:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20210222131802.Bluez.1.Ic834b418cdbb81a6e9980632567fe9d7c23cd8d4@changeid>
 <60334299.1c69fb81.5c44f.60ff@mx.google.com>
In-Reply-To: <60334299.1c69fb81.5c44f.60ff@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Feb 2021 10:26:42 -0800
Message-ID: <CABBYNZJKD2LMOQxyna6-75WRmwzyYaBJop9o9F9g4i7ZdGpv3g@mail.gmail.com>
Subject: Re: [Bluez] adapter: Check whether adapter is pending powered
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Feb 21, 2021 at 9:38 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=436321
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
