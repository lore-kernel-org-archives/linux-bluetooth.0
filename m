Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A6C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B7F20730
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fiil9+7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDHRbw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:31:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40090 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgDHRbw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 13:31:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id q2so4824845otk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0J+Uc3K4QIzN8q8ABovJI3Th/Qfglwe5LIEnPdnRzcQ=;
        b=fiil9+7kofmUpICFlmtltyb4cut6qCnZwYtZc72cTnD7vDAByKSPC++cK/GcOaZFkM
         KxbY4nqfyt7TezCIAlA/b6ODZuRTwq6yc3AA5PyaWf6lXkRuiGIwgdB2m0YDOFT8h5K0
         we6ef0ZgkWPNwQkkA8n3JI8jLcfkCum/FFQ/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0J+Uc3K4QIzN8q8ABovJI3Th/Qfglwe5LIEnPdnRzcQ=;
        b=U7E81ly8033L7Bd1W3N65hJZ4JbPapd5Sie+0YO+PW9mG547bQc9JwlWMsAWEfGBs4
         N1obVQIAthtjaoXIxm55orz7oLHJrZLWHTtSMreA6wA4Uq7u4EIbtKi1TwHUuBT1HqcL
         aJLlpG01H5z5mPoF4r2fE3bhL5g14ZhM/jxxVOa0DR9Jm4FZNSb58P+B3Fb8NCkGb0iG
         m2XvfEWtbP27MqlJ03a1eX/XYGqS42eOw7XVeLxxS50HpRbfTuNUJJ4DlxThIC3qGZZN
         1VnkwObxYxrzcpoimTGm/gL3KexE6OVFjEWpu1Uf8i0Xe1SgRUFT6dArhgIh27kZtZL9
         mcjA==
X-Gm-Message-State: AGi0PuZnEzkx6e9avAh/+ha2fX01wDG+yR670/2brDx+3ML3zCOPJPqv
        f0pufVhizm9gxw+Hf3TCi0vvi87PMJJSn4JE7j92imtU
X-Google-Smtp-Source: APiQypLdpvwhmybuDa6m+PJMgRKbULiwBlJl9/rDjWwaIDxYM1AGAXkbMEk/tF5rM8hqOsFUbZiAfOizgRXX+oyoEl0=
X-Received: by 2002:a9d:1b6d:: with SMTP id l100mr6188288otl.70.1586367109445;
 Wed, 08 Apr 2020 10:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <DB9E4FAE-C54D-4158-ACE3-45B62C85E2CB@holtmann.org> <20200406180402.7782-1-sonnysasaka@chromium.org>
In-Reply-To: <20200406180402.7782-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 8 Apr 2020 10:31:38 -0700
Message-ID: <CAOxioN=EVTKYGyYrmiRCJUzP_oHLvRgkm9J9Qkw1BB+h8Dp9jQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Always request for user confirmation for
 Just Works (LE SC)
To:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Could you please take another look at this v2 patch based on your
suggestions? Thanks.

On Mon, Apr 6, 2020 at 11:04 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> To improve security, always give the user-space daemon a chance to
> accept or reject a Just Works pairing (LE). The daemon may decide to
> auto-accept based on the user's intent.
>
> This patch is similar to the previous patch but applies for LE Secure
> Connections (SC).
>
> Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>  net/bluetooth/smp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index d0b695ee49f6..2f48518d120b 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2202,7 +2202,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>         if (err)
>                 return SMP_UNSPECIFIED;
>
> -       if (smp->method == JUST_WORKS || smp->method == REQ_OOB) {
> +       if (smp->method == REQ_OOB) {
>                 if (hcon->out) {
>                         sc_dhkey_check(smp);
>                         SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
> @@ -2217,6 +2217,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>         confirm_hint = 0;
>
>  confirm:
> +       if (smp->method == JUST_WORKS)
> +               confirm_hint = 1;
> +
>         err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
>                                         hcon->dst_type, passkey, confirm_hint);
>         if (err)
> --
> 2.17.1
>
