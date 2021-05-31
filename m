Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0BC47093
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 00:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9989361222
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 00:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhEaA2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 May 2021 20:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaA2n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 May 2021 20:28:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6029CC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 17:27:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y2so14148422ybq.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPk2gLXkdWLBqSGf/Fd4TOtAuxbtCfYrlERdK5WWZeg=;
        b=gzSfYhfYmX1DSQPr5nVGy85BCG8bQv5QkiG+z8QGhJY2Jz0JQIzJH/y+a4s3nM5+h2
         4uPaRTd9uQbNv2zHfzDrRg8f/c5tNIo4Dwjv71tsqGlL2NcPlxqHuOKCVNbgfxl3uYxE
         HbyBfA8m0M6dbMdtOZwMlovGOQltMbM4odqkNhTSjN9aedsT0Nf0XjHENbkWZJoAOjsW
         oFJqy0Y2fHKG8oEaORQ93N5HDDrmTdlV6yYTMKpoVCxoV/m9UgfAdWyzCbJg/5kVQsno
         NROgErcBcD9+56bDDlsdqaFYvsBqFo/gMdfcwHHBn1+Vf8+lKcvXeEOkmpy+Ij9H1eUk
         VFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPk2gLXkdWLBqSGf/Fd4TOtAuxbtCfYrlERdK5WWZeg=;
        b=i8ms6+8OT6TvbFeBxYhJTKdtP6nhrjE01IZJPkw0UO1SkQMGMG3rh0MiW74cttKCq7
         Rt0+NE5odocEkIzJ4XlcfrIjIMW+B1crHuzMnn6t7r+UEsRLXl0V82FeEadbLG27eAJs
         nFAV1358D9OqNFhtuET+2UgklWxvLGVCB2uKWZrSGtVkmwApF1THL5YIyDCsXEmE3tkz
         lAjhf34EHanOwxI7qdJtLFP/acJX5wOxyeoc/hrrg+SFXgMVxTkpN3Fnd7qg5hlzna+T
         T09Ajkj4uin+rhsRQv3hHBXGNIwtzSKn8RAFvHN4oiTrxu5ToJtAjvT9XIgMtgiqOytv
         I/5Q==
X-Gm-Message-State: AOAM533S+ZIAPbcwmWO6/iKpw4W/61/XyHT2QlOb2U7Sq8SxAihPHVpX
        Mr31+49dPsiMwOO0bK9/Y34GFyBZuMpP4uXI9sfQ7nEj
X-Google-Smtp-Source: ABdhPJxt3Jo5TeRTExB95UdCsoUMF+DG7bq0KCmIgZFa0fDNqV6IrsnshSBD06nCaK6Sc8uJ2OBarDIOZHBMU1Y5Sfw=
X-Received: by 2002:a25:2388:: with SMTP id j130mr27640284ybj.222.1622420823452;
 Sun, 30 May 2021 17:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <0feae4a19f7afbecbcb233d169cf04d42d7bb3c6.camel@mailbox.org>
In-Reply-To: <0feae4a19f7afbecbcb233d169cf04d42d7bb3c6.camel@mailbox.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 30 May 2021 17:26:50 -0700
Message-ID: <CABBYNZ+iy41jKJt5B066wi0HBTDnZsg2Tda+1RdJAZBrqGEofA@mail.gmail.com>
Subject: Re: Audio playback over bluetooth stutters during scan
To:     Christian Stadelmann <dev@genodeftest.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Sun, May 30, 2021 at 4:58 AM Christian Stadelmann <dev@genodeftest.de> wrote:
>
> Dear bluez developers,
>
> whenever I start bluetooth scanning on my PC, any audio playback over
> bluetooth stutters.
>
> Example #1 with GUI tools:
> https://gitlab.gnome.org/GNOME/gnome-control-center/-/issues/409
>
> Example #2 with bluetoothctl:
> 1. Connect a bluetooth speaker or headphone to the PC
> 2. start audio playback (e.g. using totem)
> 3. run `bluetoothctl scan on`
>
> What happens:
> As long as bluetooth scan is runnig, audio playback stutters. Once I
> kill `bluetoothctl scan on` or close gnome's control center, audio
> playback is back to normal.
>
> Would it be possible to modify the scanning behaviour in a way that it
> does not make audio playback stutter?

I'm afraid this may be controller specific, afaik our parameters for
scanning are not that aggressive that would force the controller to
throttle but perhaps some controllers would attempt to prioritize the
inquiry requests over an ACL connection, so we probably need to
investigate if there is some way to get work around this problem even
if that means we discovery will be slower. Btw, are you testing this
in a crowded environment?

>
> Software versions (Fedora 34):
> bluez 5.58 (5.58-2.fc34.x86_64)
> kernel 5.12.7 (5.12.7-300.fc34.x86_64)
>
> PS: I've attached the output of `$ bluetoothctl info` and `$
> bluetoothctl show` but I doubt it is relevant for this issue.
>
> --
> Kind Regards
> Chris
>


-- 
Luiz Augusto von Dentz
