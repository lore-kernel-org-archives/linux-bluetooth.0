Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0BC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64992073E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbyJlN6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZVIt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:08:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44673 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZVIt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 17:08:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id a49so7494940otc.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFE/HAB2akvcU4T57ray72e6x/1LD3tlEDMESjCphHI=;
        b=sbyJlN6LY73n7uJDVNKdwTPHL3BrGBD22JCDWMOxGxrjIWeZluGojcHEGmbNTJBJiO
         afIeM1QgwJy6JOs0cmNUHykK/TWhrDFuZineuxj0rOC4nqlvHpg0YqxWaAoB4TPMJvWu
         Utg55ZSaO5vj82Mxw4MmrQqQydm6MYxOUVho4d5IYaUSC7cllF7MHvSzX4ZW6RRczysG
         K20YyNsndktwS7IDRdMFALN2ETcNdP6q9NUBq8EJDnSdHEXxhaJ812Q8OofG7GrVIlfv
         r8pJQcan+xP4URF06YN492dtLfu9an1cN9UvRadkh2AcJIUbZzqEINQydptzoCOjDr1f
         RliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFE/HAB2akvcU4T57ray72e6x/1LD3tlEDMESjCphHI=;
        b=HjSDg0M//WsB/OQp24z6fLgk102wKLzH7n4lR/AiCu4MFeSTdGJGIwf8SCxMz8znPj
         tEDPxxTbnGJtEhmdu7pvIRDM+6h6WLWdB2qxQVhBLpQjH0P+LaeRlqkGAbP2J/or1fr8
         b9l6r+pkUKDBu2SxvkYOCS7g4uU0HhaC+poSq+DMiodCWrJoLNBGECL3cRHub7VURv7W
         59/1ai3sjoAXo0oAtpiRPJKFUlq0pZfAKyzLEELr6rfaVYKdlig59QDGiePzBA2mlK7v
         Na2CRWjfBQmfCmN9QfGI0DjX5btJXDDuNDLcUOoH6WFio5msaheEwhYd17GIjZ7mUyXL
         d9xA==
X-Gm-Message-State: ANhLgQ1aBPWQHeJdGKvD+eiG8xzhKHhsTZGlCYJEoRn87Lb9u7VrWP3O
        2umWKd1vZz/MxBpiPG6nHUX1i7RBABW7F4CHEmQ=
X-Google-Smtp-Source: ADFU+vuEbDaW0Adu3b+Cd6sjY1fsHxhl2obJcWFhBVlIZPqU/yDMu+bYVKblU/na5sUrSkE0hDWlOnrNegJj2TKOaGM=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr8451064otp.79.1585256927961;
 Thu, 26 Mar 2020 14:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200326161415.Bluez.v1.1.Ieaecd20492214a9bdb962417481330ff73240527@changeid>
In-Reply-To: <20200326161415.Bluez.v1.1.Ieaecd20492214a9bdb962417481330ff73240527@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Mar 2020 14:08:36 -0700
Message-ID: <CABBYNZLL85ghDDSR_ziBE9_bs7uorS+kj9ERuoTHf9crAhuvpQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] tools/btmgmt: Fix missing setting string in btmgmt
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Mar 26, 2020 at 1:16 AM Howard Chung <howardchung@google.com> wrote:
>
> Both PHY configuration and wide band speech are not set in
> btmgmt.c.
> ---
>
>  tools/btmgmt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index f631de4aa..b1820b41c 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -353,6 +353,8 @@ static const char *settings_str[] = {
>                                 "privacy",
>                                 "configuration",
>                                 "static-addr",
> +                               "phy-configuration",
> +                               "wide-band-speech",
>  };
>
>  static const char *settings2str(uint32_t settings)
> --
> 2.25.1.696.g5e7596f4ac-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
