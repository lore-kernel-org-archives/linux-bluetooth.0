Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A84DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 00:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbhLGAR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbhLGAR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 19:17:58 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEFC061746
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 16:14:28 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so36104752ybe.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Dec 2021 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Wqt91dXRi596UZO7r9E3crzQFFYVBLSq2h0LJf7P3qM=;
        b=NKqg87sZCABor4ugV8zu2eZi16a46aYMTns2RP5t7pZXep6gx+aJrBjzlt2yXcjduR
         n8HesJWvLRN9jZLoBBE2kh2Da2P6iY9yUK84ti2/Ksc/U2hcMJP6a2FrNdCDXocHzkcs
         DDuFLdHrGqFpw4i0FOGCJcwoaEofenjVR3vM4JwOEGzSTBDrsZUdTaMQ0pyh58vWeeHZ
         BD6B8MGowqXWwtVovreZpV61XroTVLMPaMslh9Zs6i5mY++Sv3sPPY8FjtDhx3hh/YSH
         NGlluCB34I/6J5oOrCtQj4+7ou2OvNuYE/9SnaVI9s+GQoiW40ECyqE5IosbiVj018Va
         9Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wqt91dXRi596UZO7r9E3crzQFFYVBLSq2h0LJf7P3qM=;
        b=j26FPdogSHZPz51Ee01aph1O4/82RXF2YoJ2Pa3lXVzNZf0ztQ1ry5eQtUwNh6JBGa
         qNjGcai3U0GlFoxoUaNCL4jOQ7dR9+5wME319isCjWJA/cAPf9uus5NuWm15mEZTIjUf
         PCgX9l5RMz/GHRQhkVoREaviB6duO/sFYJH5a7YeWQnvSq5EEg5jMP34XovtoEc2Ayrh
         NBf9PmfCjmqxdKYsKvP1y9+exE6t4eZI9J/4xwKD8fC0T35I98IAr2TD4uM7sSPXLsff
         wncP3bMZuCw+0SSfrDs1sCTTBfv1Bv8sVncO0s8AKPr2/CbwKYqIYJk1UOt+KWuerxxS
         n2Sg==
X-Gm-Message-State: AOAM530PsdJrqAfV/qE8tR2m8RJYZjxZ6WegGuoRGcR11Z+ZrmLh6YKQ
        wgGRbveMi/WYTFyaY0BX7bkgsPZYZOZud+j4maGlgjFhV3csLHBS
X-Google-Smtp-Source: ABdhPJyzpWKcC9fhwPJd66gjGq+n615gC9YSom9jONvQLW3um0zVcXh5pUneYZZVDDnbT82aKLDj8R0Wd4sGx/rgBgY=
X-Received: by 2002:a25:bfd2:: with SMTP id q18mr48649428ybm.542.1638836068032;
 Mon, 06 Dec 2021 16:14:28 -0800 (PST)
MIME-Version: 1.0
References: <CAC3L_ehiFCotnFo7G==70s09FQqbwJdt-SkrcLb6aj-XaS6-Cg@mail.gmail.com>
In-Reply-To: <CAC3L_ehiFCotnFo7G==70s09FQqbwJdt-SkrcLb6aj-XaS6-Cg@mail.gmail.com>
From:   =?UTF-8?Q?Ulisses_Ara=C3=BAjo_Costa?= 
        <ulissesaraujocosta@gmail.com>
Date:   Tue, 7 Dec 2021 01:14:17 +0100
Message-ID: <CAC3L_eiWPvM+ycvPfRXLbu9buwuqMNC-kCuGt6ABR3WTZJ95jQ@mail.gmail.com>
Subject: CVE-2021-43400 patch potentially introduces timeout on Chrc WriteValue
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am maintaining a custom embedded Linux (v5.4) with BlueZ 5.50 and a
GATT application that runs on top of BlueZ DBus. We are interested in
applying the patch for CVE-2021-43400. Based on the original patch* I
have created another one for BlueZ 5.50, this produces a reproducible
timeout every time I write into a GATT characteristic (sometimes the
first write is successful, but all of the subsequent ones fail with
-110 error).

I tried 5.62 (where the patch is included already) and the same
behaviour happened.
I tried 5.61 without the patch and no problem with the WriteValue,
when I applied the original patch* it also showed the same timeout
behaviour.

So, my guess is that the original patch for CVE-2021-43400 is
triggering this timeout on the WriteValue.

If needed I can provide more information or get adicional results.

* https://git.kernel.org/pub/scm/bluetooth/bluez.git/patch/?id=838c0dc7641e1c991c0f3027bf94bee4606012f8

Thanks,
Ulisses Costa.
