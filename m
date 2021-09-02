Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8705C6113A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbhIBSrk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbhIBSri (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 14:47:38 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468CBC061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 11:46:40 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id t26so1435724uao.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rjsQdC+6HYWIHU4HZq4nKUY8gvR8SwbnJNcdRM06csA=;
        b=UsA8fRLE2nriNuu6xN1YZIKCcqPYJQj0aOc6dFbsEsa0Kc527oX4ubfUJaD7/SVGLN
         ibEOUwtaKr7I5qfpQMv72oU7Gh4vJjQuK5L8iPUnHgC4+ukAG//rZ8BuPjhWd3nQgcF6
         GJ5uh2H94UjNPjZwgOh4+7kWXu2NFi2TYTNhniTjv/ZdIyV/U3HatvfSiJM1evkDQFF8
         FbJZtapObDGSeioZ8S6+2QDVraEomknE3zbYt8pivMxSJqeEOpLNxTA1TB6YQUmTySnt
         CBz5B0VPrV/yUte6LDClISNToP0gs89K7RSOrTc6uzO8CVGzYJd8aFN1npRxsFn37B9D
         pkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rjsQdC+6HYWIHU4HZq4nKUY8gvR8SwbnJNcdRM06csA=;
        b=nBI/w66DoBo1HiVUTj+4Siev0dddvenscdy9Vk5+CJ5mrRmvbnA4IG/frs6mhNZXT/
         G1u62IMuyF3hEQvJEMKPHCAHSN0oJNkpL5pMGVSd1SmG+RwMYjIg24njHJmXW3G23xAN
         y+E9AVvxrW60OgBSgY5S21qWfF0/bQFKu9yotJStW9rylLM4h1xrx1wpIupK/53EpsuO
         ZejLXhmlhwJbQmroOZe8d1sKhS2fIt8GFTBcrsTmW5wXh0NmluWu5QJtsRRWPwIoeG2J
         du+GQSP+A4ETxrez6msE1Pj3RD6tDvuUt5tE7GvLQaagJPKxyhCplegaZTO87L0tJh/F
         tsuA==
X-Gm-Message-State: AOAM531GhzY7kkAjkDSHoH3/Ve2p41YszqmJitEwE1fuc4ftVdHDvUMW
        uqV7bi+7vgvHOIl1IRYzyhkjiv5Y0KPPmEHvSxVQu+5wKQk=
X-Google-Smtp-Source: ABdhPJx1nQx4khAoJSI8eXWdtP4SL0KjT4S2xV2WE2HeBygI+7b+mnrhzaLtSyIaBsTo74zK95NtrtRRdPA6VJDw5dY=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr3255739uar.3.1630608399301;
 Thu, 02 Sep 2021 11:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
In-Reply-To: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Sep 2021 11:46:28 -0700
Message-ID: <CABBYNZKSJAHK-YPx=XAiq2FYLU-dOiNY9rYuOVG1a1V4pH2c-Q@mail.gmail.com>
Subject: Re: Help needed in patching CVE-2021-3640
To:     LinMa <linma@zju.edu.cn>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Li,

On Thu, Sep 2, 2021 at 5:40 AM LinMa <linma@zju.edu.cn> wrote:
>
> Hello there,
>
> There is one bug (CVE-2021-3640: https://www.openwall.com/lists/oss-secur=
ity/2021/07/22/1) that is similar to the recently fixed CVE-2021-3573.
>
> The key point here is that the sco_conn_del() function can be called when=
 syscalls like sco_sendmsg() is undergoing.
> I think the easiest fix is to hang the sco_conn_del() using lock_sock() l=
ike below.
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index d9a4e88dacbb..3da1ad441463 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -173,10 +173,10 @@ static void sco_conn_del(struct hci_conn *hcon, int=
 err)
>
>         if (sk) {
>                 sock_hold(sk);
> -               bh_lock_sock(sk);
> +               lock_sock(sk);
>                 sco_sock_clear_timer(sk);
>                 sco_chan_del(sk, err);
> -               bh_unlock_sock(sk);
> +               release_sock(sk);
>                 sco_sock_kill(sk);
>                 sock_put(sk);
>         }
>
> This can make sure the kfree() will wait for the sock held by the sco_sen=
dmsg() function. However, this patch can incur WARNING report like below. (=
I don't really know if this report is correct).
>
> [   75.147515] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   75.149955] WARNING: possible circular locking dependency detected
> [   75.150546] 5.11.11+ #58 Not tainted
> [   75.150895] ------------------------------------------------------
> [   75.151485] poc.sco/127 is trying to acquire lock:
> [   75.151947] ffff888012212120 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-=
{0:0}, at: sco_conn_del+0xf6/0x0
> [   75.152863]
> [   75.152863] but task is already holding lock:
> [   75.153420] ffffffff85b43948 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_c=
onn_hash_flush+0xb3/0x1f0
> [   75.154256]
> [   75.154256] which lock already depends on the new lock.

Im not really sure what to make it out of this, they are not the same
lock so how does it establish the relationship of hci_cb_list_lock and
sock_lock? Anyway it seems pretty obvious that sock_lock must be used
to prevent concurrent operation like these to happen, but if we can't
use sock_lock then perhaps something needs to change in the way we
acquire hci_cb_list_lock.

> P.S. find the POC code in openwall report
>
> With the lesson I learnt in last bad patch e305509e678b ("Bluetooth: use =
correct lock to prevent UAF of hdev object"). I don't really expect this as=
 the final correct patch.
>
> I then try to use the technique in e04480920d1e ("Bluetooth: defer cleanu=
p of resources in hci_unregister_dev()"). I mean, I want to defer the kfree=
 of sco_conn object. However, the sco connection/disconnection mechanism is=
 somewhat weird and I didn't really understand it by now.
>
> Let's see this __sco_sock_close() function, which will be called from sco=
_sock_release().
>
> static void __sco_sock_close(struct sock *sk)
> {
>         BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socke=
t);
>
>         switch (sk->sk_state) {
>         case BT_LISTEN:
>                 sco_sock_cleanup_listen(sk);
>                 break;
>
>         case BT_CONNECTED:
>         case BT_CONFIG:
>                 if (sco_pi(sk)->conn->hcon) {
>                         sk->sk_state =3D BT_DISCONN;
>                         sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
>                         sco_conn_lock(sco_pi(sk)->conn);
>                         hci_conn_drop(sco_pi(sk)->conn->hcon);
>                         sco_pi(sk)->conn->hcon =3D NULL;
>                         sco_conn_unlock(sco_pi(sk)->conn);
>                 } else
>                         sco_chan_del(sk, ECONNRESET);
>                 break;
>
>         case BT_CONNECT2:
>         case BT_CONNECT:
>         case BT_DISCONN:
>                 sco_chan_del(sk, ECONNRESET);
>                 break;
>
>         default:
>                 sock_set_flag(sk, SOCK_ZAPPED);
>                 break;
>         }
> }
>
> As you can see, though one socket is in BT_CONNECTED state, this function=
 will just drop the kref of sco_pi(sk)->conn->hcon but do nothing with sco_=
pi(sk)->conn object. Then how this conn object is released? Where should I =
defer the deallocation function to?
>
> I think I need help and discussion to settle down the solution for this. =
T_T
>
> Best Wishes
> Lin Ma



--=20
Luiz Augusto von Dentz
