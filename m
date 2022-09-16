Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19280ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 20:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIPUYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiIPUYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 16:24:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CB5F6E
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 13:24:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f9so36617515lfr.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=accFD8bKbv7R4zhQHJGSrfMkuu0HRSyeNpZlE+zGuZs=;
        b=NiCfVNg53WhSMoE1IwKLhfBxKubJ1H3k3TImTBPlOWb75om/YSXpe9WVa2PUTiRWIS
         glIeiS6DO4TMw86D97xt9C3hCBMtuW3MhS8x/4UgMM/IRSDP4vHkOylrKxQUUOTCbWU7
         L/8gtqORXVEyeawu7JcmZSpn5kuVe0Mo8tK/jMbCECe1FjLvA6Hou572/p4zjRvVKlV9
         hNU3xm8DQVBrqf/ywz1lUjkQJlXuJehiNa7vFPsE2TFPo8wmOrliKH0QBzWsCH8+TOt3
         yXUMvcJrN/sjEW38KRyljZb66RzNnuHy+ZP8N3Oa0rHd6rrQb4ccZcvv3UlG0kMJ026f
         d7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=accFD8bKbv7R4zhQHJGSrfMkuu0HRSyeNpZlE+zGuZs=;
        b=Ks0rS24HRt+w5UKWQS/oflaiKqJsekaubCYY2cgvpAlElxdlwxzXweHs/Th+wKkZzL
         aiRCP1CbzvIF7iM2eGbt+81B5lLwZoALoallhap/Pgt0731NQ+5KtMv287Qh+F91kmlc
         STXzBrlyrIKFhR1tvbKQ+IhmKewUsGg1ExsZD31OmRHo2LH8P/VtAOy+nYxT8P1+dkep
         CysA9G3jmIcZYx0aekWDVQ0+P+nUV1TkfIZZ5Wc7Si4atP72vfvCY0f7LP6sTEdocgq/
         LlfRA2mVaVodHfmWq4GQ8k9ePECPHtXtnMV8HJm7TkF8RyN9dPjS9XpfFXmdlQQo8/DR
         j44A==
X-Gm-Message-State: ACrzQf1UcMTlJWGsq+CySHj3NNAXPD8lz+UbCjYsy+q8zYfHY2SEWkVj
        Lbxm4nRaivuSyUA6SPTtNoOe/MdZIEWTTWgp7Tyw5sDBtVs=
X-Google-Smtp-Source: AMsMyM4NHlA7BHzWE5TXkLHPVXVbVrRJOC5PbI16IWyTwIUtvZUA3/Jyj3jbYwR8GVV0ktehHeQg9wsWKcHFunXkgfs=
X-Received: by 2002:a05:6512:3612:b0:499:aea7:8bed with SMTP id
 f18-20020a056512361200b00499aea78bedmr2097939lfs.26.1663359870448; Fri, 16
 Sep 2022 13:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHe0yEYV49DT8RSgYVjA_kui_Hh1GxR-35kw-aBP0ccwS+psYA@mail.gmail.com>
In-Reply-To: <CAHe0yEYV49DT8RSgYVjA_kui_Hh1GxR-35kw-aBP0ccwS+psYA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 16 Sep 2022 13:24:18 -0700
Message-ID: <CABBYNZJgm0-SnXXT6dn1veR0yW1oer10qbkUH3tNtXrU_Fd3GA@mail.gmail.com>
Subject: Re: How does btmon know that type 9 is "Apple TV"?
To:     Jake Rue <jakerue222@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jake,

On Fri, Sep 16, 2022 at 1:15 PM Jake Rue <jakerue222@gmail.com> wrote:
>
> In an advertisement like this:
>
> > HCI Event: LE Meta Event (0x3e) plen 27                                                                                                                                                              #86 [hci0] 44.156857
>       LE Advertising Report (0x02)
>         Num reports: 1
>         Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
>         Address type: Random (0x01)
>         Address: 0D:07:B9:9A:33:0F (Non-Resolvable)
>         Data length: 15
>         Flags: 0x1a
>           LE General Discoverable Mode
>           Simultaneous LE and BR/EDR (Controller)
>           Simultaneous LE and BR/EDR (Host)
>         Company: Apple, Inc. (76)
>           Type: Apple TV (9)
>           Data: 0376c0a801f5
>         RSSI: -80 dBm (0xb0)
>
> Where does the mapping of Type 9 to "Apple TV" come from in the code?
> When I search the bluez github repository for "Apple TV"
> (https://github.com/bluez/bluez/search?q=%22Apple+TV%22), I don't get
> any hits. (In contrast I can find the switch statement that encodes 76
> == "Apple, Inc." fine.) I'd like to see what table encodes that
> information so I can use it in my code as well (and what all it knows
> about other types.)

git grep "Apple TV"
monitor/packet.c:                       str = "Apple TV";



-- 
Luiz Augusto von Dentz
