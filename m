Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DA565127
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhCPSIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhCPSHV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 14:07:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB6C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:07:21 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so7335274otk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ix3DMj0wnR8fHsTcp+3g/uiSpEorFQ4dXAiWxlG70U8=;
        b=oSxytHqyMnaDAnT7TDo/Ml5ikEydcuFwk1xa1HiFJoy4tLnN/JBH4/te99H09KfX4m
         /tZbesM3+cErPpsLliPNchgsg1c9fctMFpjt4bPZwS00lJJ22BZYNU8V7yll3SUho7+s
         SlkWX5XsCsLpU2PoXdVXcXsjGWW7uFvIk/FzH3pKbitotwRzmUkPSuPEYZ5yyc1Pashm
         KlrZqyJAu2A5DiozUzHxOOh1m8mx3MWzrh/lF78bR8METkNAL8tr+UMc92xxLj9qNyRz
         KJBWos9bD6dRry8RGg/ifsxfxhvxM105XKJZi5kEdyOPU0P3vDP8DU0oEaA3nufIXg2j
         vTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ix3DMj0wnR8fHsTcp+3g/uiSpEorFQ4dXAiWxlG70U8=;
        b=sKVr5TSzuClNRoZfBSfAvlyX/g6I6vZxNOAKcNKyULEm8zmGu/kNhEib3Sqb+fh2At
         vI7Ifh3P+iuuUszI5xu6gwgJ7Z6DvXf99w0XDgjG1uUQS3/b6avEXmtc/5hGrOQxePqf
         9U1T6ynRLo8pT8DlAr3wpBBzi89SPOvReRRSeKxwygPMgkaDqh1PIshO+AkPwIgBhsWw
         XagpPU4xlHqbCZ8UrW4miH8jqUh3DeskbSPjHaWsswgOTTmR5tU+RPu39xceJhR2NliO
         l/2uWSBlGA47Ia6Mb0mmHezuB45D7SvcZrbuysPJKhPgA5KdfGnrdl+mUNPPrRnvouWB
         JnEw==
X-Gm-Message-State: AOAM532WAS4hts69heVa0M8GlNIFRqun96ZdNxycMYvB/G9wFj0gKn7t
        DZKmP4Bl5G8D/gz8EU56KW/zPI/X2/9M3adwj4s=
X-Google-Smtp-Source: ABdhPJyhctYx1F9ho/KpST1Z/k2P2qKrG/OUw3GfWavKjChqdhsxnYrgraHbVB0o6KFaFV1yMnJi/HI2C0uvqLpgJKg=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr54660otp.44.1615918040746;
 Tue, 16 Mar 2021 11:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210316105746epcas5p49f71a18f26a567ed3f7e0b1445c1fda5@epcas5p4.samsung.com>
 <20210316105738.11560-1-ayush.garg@samsung.com>
In-Reply-To: <20210316105738.11560-1-ayush.garg@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Mar 2021 11:07:09 -0700
Message-ID: <CABBYNZ+=H4h+AaAoNATKCw_F=46Y8RWZN2rertj3-9SHx3wtRw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btmgmt: Fix typo in printing Set PHY Configuration
 command error
To:     Ayush Garg <ayush.garg@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Anupam Roy <anupam.r@samsung.com>, nitin.j@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ayush,

On Tue, Mar 16, 2021 at 8:37 AM Ayush Garg <ayush.garg@samsung.com> wrote:
>
> Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
> ---
>  tools/btmgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index f4eb541fa..647c696f8 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -4725,7 +4725,7 @@ static void cmd_phy(int argc, char **argv)
>         if (mgmt_send(mgmt, MGMT_OP_SET_PHY_CONFIGURATION, index, sizeof(cp),
>                                         &cp, set_phy_rsp, NULL, NULL) == 0) {
>                 error("Unable to send %s cmd",
> -                               mgmt_opstr(MGMT_OP_GET_PHY_CONFIGURATION));
> +                               mgmt_opstr(MGMT_OP_SET_PHY_CONFIGURATION));
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>  }
> --
> 2.17.1

Applied, note that I changed the commit message a little bit and
removed the Signed-off-by since we don't use that in userspace.

-- 
Luiz Augusto von Dentz
