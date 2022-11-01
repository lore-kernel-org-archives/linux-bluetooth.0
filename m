Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 19:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKATYs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 15:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKATYr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 15:24:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8F12D17
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 12:24:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j16so24770059lfe.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Nov 2022 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSgzb5JL25yZqBYLoXM2r6ENo/Rysjp3EHqdn7HgFUg=;
        b=O9WMWaRNU4EPd6LEVFXPEEl1W7UkmofEvZrCWNv20iwBtuFFkEZ1RXBdivlp95rK/A
         c177GERo1HRzheO1G4ASYpDm5CU1NzNIOpzKXcj7pl/RZCa78izwwiIESfxgRDEzQaTV
         YRWtOPStfAWJqr+tsiCy6U5Pnp4+VDdIePmjm4KGdkcGaWWPlNCQ5q/VDWMc6E8HEsnS
         4yhP2QARMYqfTVeBjgsMZPSby6KKnFhPAube9sQHLZi0pW+PR2Z0wHkhqm3SyW9Vr34b
         zSR17iOUxsHWSO6Z+8zBYrr/nq9O4bGzQEKJzz1dHYtn8ofN0byAAHKa/pBAp0NAi1Hj
         MWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSgzb5JL25yZqBYLoXM2r6ENo/Rysjp3EHqdn7HgFUg=;
        b=sPFNowBrMyeN290jUdZoF0YvCBMeoYGdw3idVf8jATH8sYiEtKQZGt2WOGm3xqZg5N
         GVKNJXEcodFv+SDpp7ersP1/zHRtDaBiFX1JGlLhfLTge0+rA/RS5qB+Qg6khRtIcM7X
         /WdzFuCsw6TviXz1fDjklU9M62cZEQzGOU2IeZsUrNHipm0ER92nBnM5JD+GN+Z/eXG6
         9wWAQ2+gS2mLcolLXbmJo8S8KDlI0GVS7S0hRqHwI6ZLWkquv4XhjjdOgfa6YrRsNbfD
         ejW5RGQ84jZxn7kxuTp8xy+nSvO9M5+iR5hzSZcTHtg2iU+7Fq690lPXNW3fnAloZl8Z
         pDTw==
X-Gm-Message-State: ACrzQf0E1+4PT3TENN4pbTB+Gn+2KUO4QqVSuo52QW9eMOB1fAoKbUyo
        qOoqF1zbNszeBeeHXxQAYajBa8/zCarDPZMvvPO6GVib
X-Google-Smtp-Source: AMsMyM4TqQQ8h15ljeVcHaqOla2fJoE5Qpyi6Zwjld7xOJgQO4gsE0ngF8CBeV6NWFh9Wz4HKypm0uynX0gfHoiAJiE=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr7982499lfq.57.1667330684846; Tue, 01 Nov
 2022 12:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221101115333.18223-1-marex@denx.de> <63612127.4a0a0220.ee3ae.be5c@mx.google.com>
 <1f4bcb64-9402-3975-960a-fc1c1f7cebe4@denx.de>
In-Reply-To: <1f4bcb64-9402-3975-960a-fc1c1f7cebe4@denx.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Nov 2022 12:24:32 -0700
Message-ID: <CABBYNZLQKEJZc_bDNOEqVHqZNv8pOnCxEAQBT68i693t87Ur_A@mail.gmail.com>
Subject: Re: [BlueZ] tools: Make hciattach_* firmware path build-time configurable
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

On Tue, Nov 1, 2022 at 8:45 AM Marek Vasut <marex@denx.de> wrote:
>
> On 11/1/22 14:37, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690839
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      1.01 seconds
> > GitLint                       PASS      0.86 seconds
> > Prep - Setup ELL              PASS      26.44 seconds
> > Build - Prep                  PASS      0.68 seconds
> > Build - Configure             PASS      8.16 seconds
> > Build - Make                  PASS      723.76 seconds
> > Make Check                    PASS      10.90 seconds
> > Make Check w/Valgrind         PASS      287.82 seconds
> > Make Distcheck                PASS      233.70 seconds
> > Build w/ext ELL - Configure   PASS      8.17 seconds
> > Build w/ext ELL - Make        PASS      83.94 seconds
> > Incremental Build w/ patches  PASS      0.00 seconds
> > Scan Build                    WARNING   476.19 seconds
> >
> > Details
> > ##############################
> > Test: Scan Build - WARNING
> > Desc: Run Scan Build with patches
> > Output:
> > *****************************************************************************
> > The bugs reported by the scan-build may or may not be caused by your patches.
> > Please check the list and fix the bugs if they are caused by your patch.
> > *****************************************************************************
> > tools/hciattach_qualcomm.c:218:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
> >                  if ((n = read_hci_event(fd, resp, 100)) < 0) {
> >                       ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > tools/hciattach_qualcomm.c:253:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
> >                  if ((n = read_hci_event(fd, resp, 100)) < 0) {
> >                       ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2 warnings generated.
>
> That's unlikely caused by this patch.

Yep, the scan-build rebuilds the file you have changed so any problem
it finds in that file will be reported, anyway I can ignore the
warnings but patches to fix these warnings are welcome as well.

-- 
Luiz Augusto von Dentz
