Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A2C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A97206F8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkQOENVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDFSH1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:07:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44870 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFSH1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:07:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id a49so257456otc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wK+1gIiyDKmLLcFpz7LAVfiP8BXFg0q5zYtqqUOuI38=;
        b=gkQOENVsUzlEu9fKxGRp/wkVwNB/yBa4wvjmXm5EvyX2w1v3yBT7cOtc0XPQkXevZU
         1jNceoE12iZXT7EUNnTpJgpZD7FF5CTI8zNN6jdkI3+KkHbORHmB+iH09kR866GDhoxs
         kdRGsRsPDwZr+AS1tWmLb4W7RHeNQsyfXluHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wK+1gIiyDKmLLcFpz7LAVfiP8BXFg0q5zYtqqUOuI38=;
        b=A/0ukTTJoD0OcAibrloQxk4yw7I/ExRX7MLKadNLlDsYPv19/RljPhdMy/2obWeUlN
         e8tL8xCI5wjR7aWyNSWtHzDF8Zl6RgT3vlX0nNfrurFX+QiSCAtEiTeKH+D4HP3SSf0w
         0f2YaFexqIR2B0Bd7hb9lQAoeDo3MaMii7k0CS4wFaYn1saxz6/6lkBbW5c9cMogg4h0
         u0IufaALRWq26ecyTNlCH9wqs13bz1vI1kM43EY7L3nqTMZO2FSvQjTEfedEF6tfO1zE
         OTRzs4KoCwe0ArILWNdHHhVL8V7Ob5MMMHulh4z8IbHZzGYgUkLFMo0EwWB4yATi33ED
         5TKA==
X-Gm-Message-State: AGi0PuYdY78En6shn6X2zpNAiqWG29saDDpvoAK77vbiUlrtkO68OBQy
        Y8RfubIlGwJQviRYMSX+0I+zaV48WNxfGuxgcsoqUPfS
X-Google-Smtp-Source: APiQypK0jaWPxOv8fyCLyNu3GgzYQnqKVhFinB14MxTF+ne+/v/qlm5wGqOpRSPKr+4BUdupdp+NXgNXfxEMWGfWGAo=
X-Received: by 2002:a4a:9813:: with SMTP id y19mr361820ooi.56.1586196445739;
 Mon, 06 Apr 2020 11:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <DB9E4FAE-C54D-4158-ACE3-45B62C85E2CB@holtmann.org> <20200406180402.7782-1-sonnysasaka@chromium.org>
In-Reply-To: <20200406180402.7782-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 6 Apr 2020 11:07:14 -0700
Message-ID: <CAOxioNm5gmX1m=kERDtb9jPKLpnQ-nq+G1HwaoK75LTm_wKChQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Always request for user confirmation for
 Just Works (LE SC)
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for the suggestion. I have sent an updated patch based on your
suggestion with a little modification. Let me know if this looks good.
Thanks!

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
