Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Dec 2022 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLNUd3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLNUdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Dec 2022 15:33:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4336C7E
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Dec 2022 12:21:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so12448292lfk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Dec 2022 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2J0fPJKcPV5h8o5I/EmrH4fVbl3ZR1DjGkLSiicRi4Y=;
        b=ZD9pmTQI7u6TF/ZOmacnrz/AmkmoGNtCw3z8n52usxAkQkO57D8IsRSsSuzHN8j6ho
         +ESJhuY6JcgWQQp1mCcaHEsjslJa7q8Fs8DHlqNg23yzwUiwIVmxVWawruwpXaID55Gk
         /aNoeWJS3ye253QlQjYKAepdNwnX+nb2cOn8rxY27YpRXZg+jZn9WaMwXF2Mta7KKrtD
         1Pco7wTi48UqaaBZsqyExYy5ylJLgy3rj619md8wAvhrfBySwKxABA4rWhGejOQj9qAz
         OFhiMkM70+BUaLFaLHO6kHS4wWNiaYShfxu4d0AyaLpXodBDje4EdOfqO/D8wDyjxGzO
         NnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J0fPJKcPV5h8o5I/EmrH4fVbl3ZR1DjGkLSiicRi4Y=;
        b=oSaxog7ik9EPNMGsLSCvqvpU1886E0Z8nKkzneYy7LX8hPcXm9SqvMyDfJY+vm96pd
         29ItG4JvS6SCLfwGvlvuQfhN6cRJOKKvkaLvpCweoose+QDnvnLL23KQCb2VdJcjPtxP
         J+1V6oxa+5Y/KkPHOl/m9ufF7Cic03Efze0fQCJ+0eV4fOUl0jm3v5fJRi9r0XS79FUk
         c7aSVFiQACEc7j4VJeqdvpa2cGyTBhhnLsbw52bpvp95k5HfJI7Ab6USZl559BJwW0md
         w2yYfO0tuNkQcaw6tkyaSag2yZYvphwBN/+k2MgHOOgu2Qb274/sf65q+EliGl6vfv+/
         z6Tw==
X-Gm-Message-State: ANoB5pnwTWycEIcgFmf/rfzw1jjMbJA1gn3EtVOLKG433xVSmxpQ4JM3
        o3jBx/xuX3mNTJ8xiiUYnLoUkNymXtoORjILztStKlnol6jneA==
X-Google-Smtp-Source: AA0mqf4/U4/xj/tCO99ktZXh2b0gHkMlsEYF94RZat3Z+GrMQvKhSf9+0E5QlTlPrQWs29HK1tAXkyb6gGPgK4UaCkI=
X-Received: by 2002:a05:6512:251:b0:4b6:f627:e65a with SMTP id
 b17-20020a056512025100b004b6f627e65amr569188lfo.564.1671049287115; Wed, 14
 Dec 2022 12:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20221214002129.2105777-1-luiz.dentz@gmail.com> <f55ffe12286895920ff43916b3f715375a5950bc.camel@hadess.net>
In-Reply-To: <f55ffe12286895920ff43916b3f715375a5950bc.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Dec 2022 12:21:15 -0800
Message-ID: <CABBYNZJ7DCCTYxBbXdpyOjQgn0hPLX4FE=xOjwXBgYEr7ktF3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] client/player: Make transport.send non-blocking
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, Dec 14, 2022 at 1:13 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2022-12-13 at 16:21 -0800, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes transport.send command non-blocking by using timerfd
> > callback to initiate the transfers.
>
> This might be more elegantly done using a GMainLoop from glib, or if
> there's still this bizarre aversion to glib, implemented like glib's
> timeout functions.
>
> https://docs.gtk.org/glib/func.timeout_add.html

Yeah, I thought I'd have to use nsec but msec should suffice so I can
just use mainloop_add_timeout.

> Cheers



-- 
Luiz Augusto von Dentz
