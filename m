Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCCE207DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKP31evN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHUUSI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUSH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 16:18:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E66C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 13:18:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l204so2594131oib.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6+9BOhrR5CBMlphNNJg78sYIPRCwjEjB32dZ4UOiP8=;
        b=sKP31evNtzPaZ5YQ7YoXYtGf+tqmE9Y8cYqFQEJgVhJj2crmM8mYDMZ5cmK53BMaz6
         I2JphjG3ymla+TsHSGOq6YYjJdicJ+EH2dlotPFg0qidBKEt2NrpE5IKx2Na/dxoBx0E
         cqejfOYkzFljIDQO4ZjSmewT66fbDV94gh327LWBYW2TZxFlD8Wupjm6JZr2h7O6XEXr
         +QH3vAJyo9LpTqs6iKoYEVBcSlZSaoJLsVzXKNBe3yRaebzC5bTdn1Te3oJjx0iFwHut
         mWrdiJuYBRXrbOOx6crBi+8sotHYdxfuS7Mrm+rYsjoE/PMmsMRwArd5865NcNJSDDen
         C21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6+9BOhrR5CBMlphNNJg78sYIPRCwjEjB32dZ4UOiP8=;
        b=od1xT0A4eOWj7vBfRG6q+vNEpwAzufbxKg1TQ23WIfw+HY1QfZ17EW9JVHkgaMsaI7
         H4RNPCJ892qtLIt0uuBMxnkzgJ8h7DxwSumhj9nCLen9oWjnG5M/DTdVhfjSuO/Aoh0x
         +k64IcWzLUTbqxNgsDNXQle6HvUyHKwuUCIweyt+2rlEzwnPZ0Rgsk/dcrc6v+QPV4Kr
         oAkMPxSG51RD+WmqnkLkxbwJxZ2Y5rYLFaRkPF656FyJ7a0/KSslmghv9y/EFcRxdABx
         14mHHR9eJ9BQW7Oma69bil8lF08NbK0jbwVbDiUP8GFakOPX7T0z1VE6pStJiLKYq2yT
         Si9A==
X-Gm-Message-State: AOAM533uEqM8eUey0crJS77xkC4Cg/qn11C7r/G/3EfDHEAncN0Yawjq
        krxh+hbWSybxGcUu5CNq2NehaprDAcKwM5h+q4q6tBZd
X-Google-Smtp-Source: ABdhPJxFXkA5hU/UTBAJZYDTTlUfJ7tyLK0PYuiMWApkiDzs3j77K3ZUOIvJ3UcFqp20xm9E/I/2cC+uwLKvo+3Ox9U=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr2767021oig.152.1598041086759;
 Fri, 21 Aug 2020 13:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200821175838.20761-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821175838.20761-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 13:17:56 -0700
Message-ID: <CABBYNZJvBmCnNWAoLaCuv25iuda-2146U_VDYn8BQpVABSDaMA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] adapter: Fix crash in discovery_disconnect
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 11:00 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> discovery_disconnect crashed because the adapter pointer has been freed
> before. This patch makes sure that discovery list is cleaned up before
> adapter pointer is freed.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>
> ---
>  src/adapter.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..1435e2bd7 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5316,12 +5316,26 @@ static void free_service_auth(gpointer data, gpointer user_data)
>         g_free(auth);
>  }
>
> +static void remove_discovery_list(struct btd_adapter *adapter)
> +{
> +       g_slist_free_full(adapter->set_filter_list, discovery_free);
> +       adapter->set_filter_list = NULL;
> +
> +       g_slist_free_full(adapter->discovery_list, discovery_free);
> +       adapter->discovery_list = NULL;
> +}
> +
>  static void adapter_free(gpointer user_data)
>  {
>         struct btd_adapter *adapter = user_data;
>
>         DBG("%p", adapter);
>
> +       /* Make sure the adapter's discovery list is cleaned up before freeing
> +        * the adapter.
> +        */
> +       remove_discovery_list(adapter);
> +
>         if (adapter->pairable_timeout_id > 0) {
>                 g_source_remove(adapter->pairable_timeout_id);
>                 adapter->pairable_timeout_id = 0;
> @@ -6846,11 +6860,7 @@ static void adapter_stop(struct btd_adapter *adapter)
>
>         cancel_passive_scanning(adapter);
>
> -       g_slist_free_full(adapter->set_filter_list, discovery_free);
> -       adapter->set_filter_list = NULL;
> -
> -       g_slist_free_full(adapter->discovery_list, discovery_free);
> -       adapter->discovery_list = NULL;
> +       remove_discovery_list(adapter);
>
>         discovery_cleanup(adapter, 0);
>
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
