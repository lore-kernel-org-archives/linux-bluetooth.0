Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8AC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 20:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39E8206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 20:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH0iKhsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39E8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeLDUG3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:06:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35016 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDUG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 15:06:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so16438249otj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpMmF0yN9BYp/Oh8lZdwXmxa5dWk/CymbKDnRgTE7wk=;
        b=tH0iKhsxMjFTIKjJiaoUmqyJzsnA/pFygkxNAkBeZVQznxsLHsgsSfTYYSOZWN+UB/
         tF1EEQ0msSaHIY43B9I3OMGORI/UYGfy645N9Ljg0XAp5wtiPHstMS2N9RhdvkWzgDwm
         /SjeuQUXNM0JgbLpkONftG3e0ePAOXvJJz0ohM5+FHej4UJpYB/0pV3EfYXYKeyxi3k6
         J1AuSpyBOIC6fE1sRI44cTNnxpnAbKjDiEK5jvGHSNjDB9htBYDJs/G19gfTCrX3BIzW
         WAHEWfsW89RBrdgj3rRxEeFNYDiZoTH6maYgB9I+4+c7d81cHai3Z2eWINoqBL5/Xnoq
         cHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpMmF0yN9BYp/Oh8lZdwXmxa5dWk/CymbKDnRgTE7wk=;
        b=o45K13PoqYbFu7AxtG7dEGYTMFe5LVXICwGGRwpDjrOHDJgBfDOXR+HJagM9avBiU+
         q3dvkpMNevwE1Z6oqJTDgnCZFE7xA4LojFaTVViH0VSNIEUO7xCEhUvgVkW8S8fWI/aA
         4/wE14iGOP2V1wWz/ZSUETD1UlWM9ftNoFiRBUM5VtorjXer9zTpFltvQnph5MqPHD1W
         NX4p+F/fIUG3i5+rNbtqHQlSVLG/fjTIK4y1Wmqd1q2xVfJJOiCxJ7Vt/ZJ7QYPYHcc9
         CPvD7DFmGTdiI2DNLqinpnmljwjqqNiyPH03DqY6kPDzSP1ckDKgKvqbLqbJFmlxb0Um
         PbsQ==
X-Gm-Message-State: AA+aEWYQnls52t1oX/s0/zyi700KfGGGmFpPCA9Tc5iH9nERM7ESR3W2
        rPI4ExmulNxq9YWg317F7P+n7LbU3pJZWduiC7txXXV0
X-Google-Smtp-Source: AFSGD/U9RhH61tV1vJ62S95Vy+9kD0dbEqajqpO5fdNUs6ynXQQtzb9zvSnp4ZyC45VYrSOZzmsRJo7s1uG9cQA+mCU=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr13181741otp.254.1543953987558;
 Tue, 04 Dec 2018 12:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20181129232426.5027-1-tedd.an@intel.com>
In-Reply-To: <20181129232426.5027-1-tedd.an@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Dec 2018 22:06:15 +0200
Message-ID: <CABBYNZ+zM7gSrwLCB_dDijH=KQabRbLg5xNjtfc1YQCxnDQ=pA@mail.gmail.com>
Subject: Re: [PATCH] tools/btpclient: Fix compile warning with strncpy
To:     "An, Tedd" <tedd.an@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>,
        ruslan.mstoi@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,
On Fri, Nov 30, 2018 at 1:26 AM Tedd Ho-Jeong An <tedd.an@intel.com> wrote:
>
> This patch fixes the boundry warning-to-error in GCC 8.1.1 with strncpy.
> ---
>  tools/btpclient.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index b217df58f..e77720ed1 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -376,8 +376,8 @@ static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
>                 goto failed;
>         }
>
> -       strncpy((char *) rp.name, str, sizeof(rp.name));
> -       strncpy((char *) rp.short_name, str, sizeof(rp.short_name));
> +       snprintf((char *)rp.name, sizeof(rp.name), "%s", str);
> +       snprintf((char *)rp.short_name, sizeof(rp.short_name), "%s", str);
>         rp.supported_settings = L_CPU_TO_LE32(adapter->supported_settings);
>         rp.current_settings = L_CPU_TO_LE32(adapter->current_settings);
>
> --
> 2.17.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
