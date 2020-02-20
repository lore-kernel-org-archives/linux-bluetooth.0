Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C9C11D87
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B522467E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEXNy0Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBTAtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:49:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33794 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgBTAtM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 19:49:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so2110552otl.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 16:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=R4M8qtpavYeF+iB2J2hl9yrDv2lt6x82ERPBheKd3gs=;
        b=OEXNy0HkDVhxvkZBATtUzHo9SedXjsoFryJMLDUpe2G1Zw9NAlfLBzMVTtHz/SAG9V
         06o1BO83sspcT6T63VWYMLTr05c16i3UFNWxQXJd7XVuJl3reiFA4m6OY6eWAWFjMRqR
         mnbWlnAyUkP0eeb/kX+/dz0AjzmGsy1CJo4VJ2TaLJX2YueZBGxbL9wgpEgHCNCjDlpK
         0+sZ0O2T7yCyOfQI7imMe4fAw0p89LplVzqE8HZQoTVwbxwB1gmN0fKyHekoq2hARn9K
         pOyyPYzNV4x6odDnW6WaQqncpbLlcCWFg+oxieTbX7ChCusiV6WFwl/dMQrf2WJB5wgZ
         ZFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=R4M8qtpavYeF+iB2J2hl9yrDv2lt6x82ERPBheKd3gs=;
        b=hn/IHDlCvd0KtAF8vg7pJBSnOmaUqPahPMrOlQDc80F9YaVMytyO5wuzN5u3I8aPc1
         oiRJbuXzAnS3hZ0qT2D3dCEtwE9hhKOr/d34iyHTt9NBuTCOEpPl+6iPnK4KUvg13Cx8
         LU9sih10DUqgiF0OV71ZiHHkB+NjOEEsqeMpi1SueYmy2zW0OKHfmus251BRUgRfm47+
         qRFdb0ILQKJkaa6n0+9ylq5XcUA+QDPIDerAPSqKNfqPB78So61budrkYpGeqZJi7lik
         n+7DUkIo0Zu4kNorDrESwPBVXQULI6nbeu2sUUNchbfyFi1Be365r7Ork55LKhc+Uq1s
         vsZQ==
X-Gm-Message-State: APjAAAVAnYaXK3uyisR9NnLDih7zcgb4r+5jJB36GN71f78nrn+jN+LD
        cAWwFdxP3DobpEKi/m1mzfi8Yb+/bwuaSmTxvkHzstKW
X-Google-Smtp-Source: APXvYqw2fhvRYFH26OIlrj+WJwspqg/F7R8zYmRjOYd9SYViJNV3kVBnYL5BnRHQASdwwC8F7qWseHE36pRTMuxM7xU=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr21706802otf.11.1582159751134;
 Wed, 19 Feb 2020 16:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20200220004801.19944-1-luiz.dentz@gmail.com>
In-Reply-To: <20200220004801.19944-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Feb 2020 16:48:59 -0800
Message-ID: <CABBYNZL+TR9-HveCua8dcEjZVQDcxmbeYEUgzPOGQV-RF45LpA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix crash when using new BT_PHY option
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Feb 19, 2020 at 4:48 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the invalid check for connected socket which causes the
> following trace due to sco_pi(sk)->conn being NULL:
>
> RIP: 0010:sco_sock_getsockopt+0x2ff/0x800 net/bluetooth/sco.c:966
>
> L2CAP has also been fixed since it has the same problem.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c | 2 +-
>  net/bluetooth/sco.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 9fb47b2b13c9..305710446e66 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -605,7 +605,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>                 break;
>
>         case BT_PHY:
> -               if (sk->sk_state == BT_CONNECTED) {
> +               if (sk->sk_state != BT_CONNECTED) {
>                         err = -ENOTCONN;
>                         break;
>                 }
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 29ab3e12fb46..c8c3d38cdc7b 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -958,7 +958,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>                 break;
>
>         case BT_PHY:
> -               if (sk->sk_state == BT_CONNECTED) {
> +               if (sk->sk_state != BT_CONNECTED) {
>                         err = -ENOTCONN;
>                         break;
>                 }
> --
> 2.21.1

Please disregard this one, it was sent by mistake.

-- 
Luiz Augusto von Dentz
