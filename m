Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A6C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 08:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967D2087C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 08:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9m/i6+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfBYIEa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:04:30 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55110 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYIEa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 03:04:30 -0500
Received: by mail-wm1-f43.google.com with SMTP id a62so7066687wmh.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 00:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HwNDSNjmmq03PJwqZNaNtzkOGzdenpTz3QUZEsJl7Lc=;
        b=U9m/i6+ItD+5rQ7inbvuBMCXA9Tf+Oj65svXIfe+ZQwe65TXfOHYPGmDKkaqHqFutW
         VHyaQU40n+Ivc3lQFt1Md7Z0TAqk7ncKsH7ORHg6Nl0j+KyvXgxhjZSyAMnd0YidA5S0
         RF+6sOIq8c8X3n0HEukRbYSiNnCKP1PrM0IfdB/nPSsii8YBiauDDbfMFoMPGoEwZQ0O
         c7VGDtTNl60EbVnWRqiSQt1EWy6taLGq092AEcm23Cl0zckGdQoJO6m/ksHnbyZtZwE0
         peQEsGMu4Tk1cgaNU04JSuD7CidWBNiwLPbdmZy91x6cF2nJkna820larg42iPbSSQuU
         NCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HwNDSNjmmq03PJwqZNaNtzkOGzdenpTz3QUZEsJl7Lc=;
        b=I45GWTXul/Q54Asma8GI4GThiAeixDkHKObTwQW+qtPlfAwM1rKa7s5jjXSlCXe1Lp
         Kcci9TfoaEbQTOZRT9vBf+ENXTcqxw9m39ivV9INaXtwfIY0RgeR12CEP5OA6ssC68AS
         gwXepQMSdE0pKZPljCZpsLsXa/c1qrdw2E6LlaZJf+W9oNXc1Bzmat4K8EVxSSkU6+L2
         0UWLi37xY6P/Rnyl/AL34VmVYnoFekEVwpL5J7EOllp87qkYFhRNqyrm0uMtYdOpkZgC
         8urmf3mcq5LRryKMkUOoFRVDYxE69LPkuKEXGe8jo2I+i46XJJWddGlMV6YJHm3vkjKG
         h3DA==
X-Gm-Message-State: AHQUAuZGoQz3bzbBtWRxjCOTFBHg0djfcYNuosUJjvjJCaVdqpJEHWQi
        oQ1wWv0/NL4KQ6L5h8GFxYZWe+HusDCuHM+wIhJGliiR
X-Google-Smtp-Source: AHgI3IZ4uFRJ6W690Mv/cM1oQ/Yvh3U7rAW3tPsWspFcNHj+4/aJ/IjZHaG/1c7PZVeQHBRT941pbUq0LM3NWiDtVWA=
X-Received: by 2002:a7b:c457:: with SMTP id l23mr9498061wmi.2.1551081868225;
 Mon, 25 Feb 2019 00:04:28 -0800 (PST)
MIME-Version: 1.0
From:   Edward Jo <challenge.jo@gmail.com>
Date:   Mon, 25 Feb 2019 17:04:17 +0900
Message-ID: <CALGdn=JFB0yCgWmmo9iMF740wpUapZ-6rU0OKcF73mM+Xw7XbQ@mail.gmail.com>
Subject: Does BlueZ support the LE only controller which does not have BR/EDR?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I use CSR chip that support dual mode as LE mode by setting
'ControllerMode' in main.conf to 'le'. I'd like to use LE only chip
which does not have BR/EDR.

Does BlueZ support the LE only controller which does not have BR/EDR?


Thank you!
