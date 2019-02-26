Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A333C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3170217F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEKuvrwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfBZO5u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:57:50 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55224 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfBZO5u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 09:57:50 -0500
Received: by mail-wm1-f51.google.com with SMTP id a62so2720645wmh.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVMwYr4trWrwClyLWoyaQdbGqeFC7f01gCpjWthRKW8=;
        b=AEKuvrwP3tqvJbBlzlUlQ3bcjN2PgZDXy5/xauE6QIUBfqBvYYTViNVZEdT5vxw01T
         W8pMex5Wgxcc4cklbCWYla/JZNXx6gnSvB5P7UZlcPc5Evc/Rur5CKewrPVm/V/Ot9la
         XsOnODMiI2UTTLvekV1GaV7z9SF/bI7OCwDohcBdY0bYUbhI65laXG1ZDIzEhO/i2NHh
         8k5UzSjJ7y9mTr+EAu29mRgyoXRw5sXr1A7D+lEUIAi8rPPj875QKa/gf3YyADJFaAF5
         1gE1lTiy54Aik65vIqX2D26onYxmmhHGlg12C1sRwbKh9wMSQC7o/aTfqx4fQ1C/iNYT
         7Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVMwYr4trWrwClyLWoyaQdbGqeFC7f01gCpjWthRKW8=;
        b=qiK1go0bfr81XEhAVRs2od7k3t0SZqG5ohpkA6qJkbT+kb1q7Bcl/EbTCm2V+P1gkE
         lvH1MZnzOr7hz0p20cSPM+SCTjz3EDXlguZpmyhK2nFU0BCQREAshOzvqaw9yMZKkQkz
         6isJrV7sB2TaFth/oJ9E4yKhmjO8JbQ1SSMrGJ7glq77ET2ki9xLvwR53m99hxKT9L+N
         T5tL4Ao0nS6M7KL6PosvrliUs4lJVne1rSLIPz78Ei5v2gsEPnFaPWCbHX2TAaQrkqql
         ZiWUEqq5f2TOaSz42P9JMW80jgFg/YfH9srt6I/chqc0Wb8pfUuxPGtJR11nGdQlvKIX
         yUDw==
X-Gm-Message-State: AHQUAuZoSTF33SwAGmt/BuzOE1H0pJboPBCVjGJ5UM3uKDKvBZwc85hk
        Y+H+ksbyz+J7CyWnXXi0aGNTsJ2TRNqGJYt7kZHjxQ==
X-Google-Smtp-Source: AHgI3IY6yelqOuSsE+hWiPfSP4t9iB/06zpU6ELN7WmOnDpBvQgdHuMmB+F0hTZPUathfLZk9UvV3Owx4lCk+q8mLr8=
X-Received: by 2002:a1c:9693:: with SMTP id y141mr3058701wmd.33.1551193068244;
 Tue, 26 Feb 2019 06:57:48 -0800 (PST)
MIME-Version: 1.0
References: <CALGdn=JFB0yCgWmmo9iMF740wpUapZ-6rU0OKcF73mM+Xw7XbQ@mail.gmail.com>
 <1576789.oDElsqhQaV@ix>
In-Reply-To: <1576789.oDElsqhQaV@ix>
From:   Edward Jo <challenge.jo@gmail.com>
Date:   Tue, 26 Feb 2019 23:57:37 +0900
Message-ID: <CALGdn=L128q8dB+dEfJgm-5mhVB_VvT5P87+CSoR-Z2SCtWw4A@mail.gmail.com>
Subject: Re: Does BlueZ support the LE only controller which does not have BR/EDR?
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Mon, Feb 25, 2019 at 6:12 PM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hello Edward,
>
> On Monday, 25 February 2019 09:04:17 CET Edward Jo wrote:
> > Hi,
> >
> > I use CSR chip that support dual mode as LE mode by setting
> > 'ControllerMode' in main.conf to 'le'. I'd like to use LE only chip
> > which does not have BR/EDR.
> >
> > Does BlueZ support the LE only controller which does not have BR/EDR?
>
> Yes it does (I'm using it with nRF52 based controllers running either Apache
> Mynew or Zephyr). Also, starting 5.44 it also supports LE-only controllers
> that come without public address - bluetoothd will assign static random
> address in such case.
>
> --
> pozdrawiam
> Szymon Janc
>
>

Oh. I see. Thank you for your help!

Regards,
Edward
