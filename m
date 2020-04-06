Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96DC2BA80
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20320731
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 19:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYMwPh61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDFTPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:15:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46165 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDFTPd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 15:15:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id q204so14063570oia.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miv5n/k+feV617mYPhfbVUPV8D5MSyOCPj4Ac3CWtMw=;
        b=MYMwPh61GsI6XsGu3waWGuBT+BFAV4nlTM+8bOVNOvORSLC9/gEEvCPUVQxfcBQJA8
         XDodjyCNKYnd13iQN3dmjxvpJuq2OMKLUKHGYphGSTT7Zwzz7GecUfFA7WsIDkc16nvg
         BdHfFTckVYMzUtMxG+9RBCpQlVZQidM84ypVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miv5n/k+feV617mYPhfbVUPV8D5MSyOCPj4Ac3CWtMw=;
        b=LPG8PTRtGbfYIVhtki/2tvznqNuz2xnS82MW573CfYYYHMfUoCIRU7UFTabeD9zY8G
         QDtISYxrwYBebOLLhmmwjzcpCrS89oSjch4rzpQO80OfaKEf9uSsJgRRC36JZxf96+y4
         ey9riDW+sc5ealJbJOuZ9hh4daxwg0viZfw7FQyQvLXaBCmKC4iZPCAmmp7MGmsFvSr2
         EYEj2VtvG29dp4qHMyuyG3lRtzcqwHXfUbBMQFSed7gBrppUteY6mgjGYnY/9yfzB4rg
         5kIznzSs7h20pwK/KT82JjkTpUBry3CflVMLKdHFsUSebtdZwhD1vCpR9j+rEFNn5C88
         vGAQ==
X-Gm-Message-State: AGi0PuZL12e/4uGsuJR88KLY8VcvZFUNR368j3pFJu32rQI5CcO3lKTC
        bfkQcknTCzU8Y4GvwjJbRcxzwfuO1krdgG7X3wEuZQ==
X-Google-Smtp-Source: APiQypJ3BCbS26CTzYSKqqpjGSJ6qpi4PpmHmXaX2aIsQQENucRJ+aKdcf/F2DLnCrFw5Bszx9oADxs91d3zg0ZKJ7A=
X-Received: by 2002:aca:dd55:: with SMTP id u82mr618185oig.27.1586200532136;
 Mon, 06 Apr 2020 12:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200403150236.74232-1-linux@roeck-us.net>
In-Reply-To: <20200403150236.74232-1-linux@roeck-us.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 6 Apr 2020 12:15:19 -0700
Message-ID: <CAOxioNm6pu+WFwDS8oTcBiLaCjHH9QZx5R6rEjUtKPZjqN26+w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify / fix return values from tk_request
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

On Fri, Apr 3, 2020 at 8:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Some static checker run by 0day reports a variableScope warning.
>
> net/bluetooth/smp.c:870:6: warning:
>         The scope of the variable 'err' can be reduced. [variableScope]
>
> There is no need for two separate variables holding return values.
> Stick with the existing variable. While at it, don't pre-initialize
> 'ret' because it is set in each code path.
>
> tk_request() is supposed to return a negative error code on errors,
> not a bluetooth return code. The calling code converts the return
> value to SMP_UNSPECIFIED if needed.
>
> Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
> Cc: Sonny Sasaka <sonnysasaka@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  net/bluetooth/smp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index d0b695ee49f6..30e8626dd553 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -854,8 +854,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
>         struct l2cap_chan *chan = conn->smp;
>         struct smp_chan *smp = chan->data;
>         u32 passkey = 0;
> -       int ret = 0;
> -       int err;
> +       int ret;
>
>         /* Initialize key for JUST WORKS */
>         memset(smp->tk, 0, sizeof(smp->tk));
> @@ -887,12 +886,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
>         /* If Just Works, Continue with Zero TK and ask user-space for
>          * confirmation */
>         if (smp->method == JUST_WORKS) {
> -               err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> +               ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
>                                                 hcon->type,
>                                                 hcon->dst_type,
>                                                 passkey, 1);
> -               if (err)
> -                       return SMP_UNSPECIFIED;
> +               if (ret)
> +                       return ret;
>                 set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
>                 return 0;
>         }
> --
> 2.17.1
>
