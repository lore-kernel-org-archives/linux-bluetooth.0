Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E492AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 00:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiBRAQO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 19:16:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBRAQN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 19:16:13 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB3381B6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 16:15:56 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2d66f95f1d1so49889617b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 16:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFCLr9hmq6/j4HWE6M1b+ecTVGjzCMlG/ePLwm+vbJA=;
        b=QcMCFMV7bXcVgsRVkG01bM4LbE08gyzj5QfVC6b9YheVznqCBwxWgt7hIW2+sPqx2t
         x4fhA+FitADOp23vpv1wZwAFw0hVk8sOoPk0YNEFv2JuEvE8edo0DMudf3Sp6PU75goL
         BTN6IK844QmPEGEPAzYm7PP/nfWwRkw60CW/Wh2YdtGgLembJ9+gk+/zYKCRDzaU7epK
         WIA53dJ4GwiT5AF3DX3gL0TwVTSLDVNQjIciJXyMfDRAce3/IEIn7jPZ0TdKD/Dsz0gO
         beFUuPjVhf/HOceNSoO8oTsApsyHV+jLsH6d04StlBcE8aY0aGZhjrSX0WNA62zlC4wI
         ZFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFCLr9hmq6/j4HWE6M1b+ecTVGjzCMlG/ePLwm+vbJA=;
        b=yIMVRYJSGw24pZ4x2r7mypt0OHn9KhhHRT+eKFPOdN6ho/31gujwkgHK4pUWml9uRc
         kNFGlROExoEnucy9dGIu0Jw1+70I0jzdTh6jGhFIIXt9O7MyN0Ffmed3Sr5qCjZFrJBA
         ZRwMYwYDimNfmTDOTl5pqoM/uhtW3hrtjK3x9niwqktTdJcKiDt3/Ey2sau1J4m29BfF
         qJBIbfkV5nQ6irBN81r6fk+qyB37UZ2TtHrcGKltPkveLpYCXsU6+4DO+nHV05VdxXQW
         izTjcUN4kT37Yis6H+yMcnArz1u7t1WHZ2t3Vz1gc4VwjzbjB2ULRCwlkkhesFnVkajd
         271w==
X-Gm-Message-State: AOAM532oSBEdKCZR0v477ddsaosOzrdje4o2drKJfBvFGSPUGpFSLCOx
        RfM0PPJXbqRuAtHi+d5qrzQOvir2m7Hq7h6R4a713q8b
X-Google-Smtp-Source: ABdhPJwOuG0nIZksmoXA1ZvMMawAbtDyqdOj/WHiSYVROrqUYNTGDQDdWFHp4oEAXJDt1bIWBlwT0ABpn5K/AIp3djA=
X-Received: by 2002:a0d:c781:0:b0:2d2:d059:19c1 with SMTP id
 j123-20020a0dc781000000b002d2d05919c1mr5338256ywd.376.1645143355168; Thu, 17
 Feb 2022 16:15:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com> <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
In-Reply-To: <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Feb 2022 16:15:44 -0800
Message-ID: <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> OK I started over, and for now keeping the reporting constrained to
> the hardware I personally have on hand.
>
> Hardware:
> Lenovo Thinkpad X1 Carbon Gen 7
> Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> Jefferson Peak (JfP)
> Sony 1000XM3 headset
> bluez-5.63-3.fc36.x86_64
>
> kernel 5.17.0-rc4
> * remove the paired headset with bluetoothctl
> * reset the headset so it's not longer paired either
> * put the headset in pairing mode
> * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> * click on Not Setup and nothing happens

Well from the logs it doesn't seem the GNOME Setting is trying to do
anything, have you tried bluetoothctl> connect <address>

> The above activity is recorded with 'btmon -w btmon-w-headsetpair.txt'
> and i get both termin output and a binary file
>
> terminal output
> https://drive.google.com/file/d/1fFbyRm32Lf0yzrHhE1vEE0ztnSeoe7VB/view?usp=sharing
>
> binary output
> https://drive.google.com/file/d/1BmnO-utOooMWgcEHTuoz13Ndd5hGuqe_/view?usp=sharing
>
> kernel 5.16.9
> * bluetooth panel says it's connected to LE_WH-1000XM3, as if the
> previous pairing attempt above worked
> * bluetooth panel name for the device flips between LE_WH-1000XM3 and WH-1000XM3
> * headset is still in pairing mode from when i was trying to pair with
> 5.17.0 (flashing blue lights), it eventually powers off so as far as
> it's concern pairing didn't succeed
> * again remove the headset with bluetoothctl
> * put the headset back into pairing mode, click on LE_WH-1000XM3 in
> the list, "Not Setup" flips to "Connected" in the GNOME bluetooth
> panel, and the headset reports pairing is successful
> this is what bluetoothd is reporting during the name flipping
> https://drive.google.com/file/d/1qjAlkODkjJzR33WpHD2Sxze8zq4t1UhS/view?usp=sharing
>
> Definitely seems kernel related.
>
>
> --
> Chris Murphy



-- 
Luiz Augusto von Dentz
