Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6FCC34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0C321D56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 17:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAAEidVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRRsT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:48:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39973 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBRRsT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 12:48:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so11296170pgk.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hvwSCkX9pxo1KclHmLRqkXi0GkIvTorMMfGsTl4G64=;
        b=VAAEidVXRRVDkWgdL8SLHMdW/a6i0JY1vrRlufLUFPlN1Z6SYM8X5VTqDZBAPUedND
         4ruzfRGdb8pLQaWgxu7UontmEXbaTH0VaZl0Q5euy/y/2WFA7zMujwbE+oQG8w+rPV9i
         UG+fkuMyecHK4BosrQTxYG2AO1fumayZrwr0u4AKL/Ue2tzY7KR5hlZrktzCpMifDApO
         W1LfGeaeHeYksPMrG5TYec7IsLnKGplTSboPTNBoc7N2iqd2YpjstOVSA9WeyTZk7lpY
         zn4OTiCfti6FMEJrncqSRCq9SeniKXfLGLgxPyoaSA1YrMBxxAg/WNUMrQXYiAz56UpD
         VvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hvwSCkX9pxo1KclHmLRqkXi0GkIvTorMMfGsTl4G64=;
        b=fvzvJs5vqFpmOUQM1DvT8fs8dHcPsfzA/cp9w/g1YMkgBt6jTNcO8z4HGTyggjTOgA
         ZQJsrdvuOoix+/ghLs7yDrsRpWfJBZcdePDNkkDfC69Nh7W6ZadUDELd88ez/XSyhZiM
         fKG6Y2ttA2QfGL0lzpvU/dHbH+99h/nsPyrKmevgI3LRwQOqr4QHevuFGf2Z7FHEQlh4
         w6zwGhRd/2IqzJU9M8VO+kQHqyp6P1xL99t4I3JoVWRQkhWekYaNa7Yz0E7XOSdAQPrB
         5VpTgowOvdQZb5oIzBPAokCeZOq+ErE52A1xkgx3uQJfRpYQFeqt12KEz/0L5ul15iO1
         rBnA==
X-Gm-Message-State: APjAAAUXtyX/dz6apYTjqCjCmP7Pn9vjjeRiyXGjgVE0lwfGhkJWmDE8
        Lg0pHlxZmoiUiBfoWxrYeklZTYe0FToDozpAZSLT/w==
X-Google-Smtp-Source: APXvYqyHwGTvTHxmWk1k9pViQpHjUGTIZX/AtqGWeQUl8A2fAwEAndE5x9tTwDhlw2346g6yq01Nqi+VvI65dhFEdfw=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr23276938pgk.381.1582048098676;
 Tue, 18 Feb 2020 09:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20200218190509.Bluez.v1.1.I04681c6e295c27088c0b4ed7bb9b187d1bb4ed19@changeid>
In-Reply-To: <20200218190509.Bluez.v1.1.I04681c6e295c27088c0b4ed7bb9b187d1bb4ed19@changeid>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Feb 2020 09:48:07 -0800
Message-ID: <CAKwvOd=SD0AMwoxRovnPfAV70D7W4LPWtLHbui26A92ycUic=w@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] bluetooth: fix passkey uninitialized when used
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Feb 18, 2020 at 3:05 AM 'Howard Chung' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> From: "howardchung@google.com" <howardchung@google.com>
>
> This issue cause a warning here
> https://groups.google.com/forum/#!topic/clang-built-linux/kyRKCjRsGoU
>
> Signed-off-by: Howard Chung <howardchung@google.com>

Reported-by: kbuild test robot <lkp@intel.com>

Thanks for the fix. No comment on whether or not the value 0 is
ignored here, but this should fix the warning.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  net/bluetooth/smp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 50e0ac692ec4..fa40de69e487 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2179,10 +2179,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>                  */
>                 if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
>                                  hcon->role)) {
> +                       /* Set passkey to 0. The value can be any number since
> +                        * it'll be ignored anyway.
> +                        */
>                         err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
>                                                         hcon->type,
> -                                                       hcon->dst_type,
> -                                                       passkey, 1);
> +                                                       hcon->dst_type, 0, 1);
>                         if (err)
>                                 return SMP_UNSPECIFIED;
>                         set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
> --

-- 
Thanks,
~Nick Desaulniers
