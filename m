Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC672C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 23:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbiBOXXI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:23:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiBOXXH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 18:23:07 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F23E3884
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 15:22:56 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p5so701001ybd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjRK3JBB5dDVff91wGQ1A0uc0O/tmHtJXvHtTe3mB8I=;
        b=SNEfG7F6HD47Sjig4xn6RAFU0vgDKr7QiaVWIyCZ6c7bELcSgSsYTxyy5Xxj86Xsiu
         K0WBIwFo/D+34YzKHbdbdt9MdmvjkiS7DqvH5Zd9i9meSyCo//E21vWOzUVlbaUdBGDP
         XZowaE7obqyesS3POUZ5KrjlXjuTogGlsCBWMKbhVLOH6dPtMubMCbGNBSHqnCIMTULK
         outM8XC3Phjd04i9t60pA8HsEa6yXu2sTbiYUIXb8WSWeNo5VIOV8LBTjpFpCYRPKM0B
         kDb3NkjWlIEKtme0zyj29OQjoz0BlfC6vB2F9akGAp+ehRgjM0sB75FA367O1ikEz5IP
         2xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjRK3JBB5dDVff91wGQ1A0uc0O/tmHtJXvHtTe3mB8I=;
        b=OKxHby+CcgM2lsN6uixCliEgrd/bct+lxflIAG7GdSTGnZtb3jlzTQ8UVXkVqnk4ie
         yUFZfafAlWwWpIdx5DPzCciOG5R2fpLReCR2SQiUVA1O8v47q+B9AnscdDTE/r7QDBx0
         gYGmXQnLx73NqSHjAmpSnaPUBunB0i08abvg7SIJ0L9hu7PZ94ZGpHNljdGU1dsdNhzC
         hWsGvLaOvj2ATP5KVCMFpaMHknsrmfCjtiW3PDI9wJOCAZqQxlsLikglPEzbNNXDoYk3
         hUlIsWbBfDg4wvjM1xm0CdocgkZ8oUz/hyW6jP1gQ6Zh2noRpPHHKuFoAXc8w9aaWus1
         Lh+A==
X-Gm-Message-State: AOAM533q0/V+7rpG18ytSKWVZqNpC814S5mfvpS3NiZ6fv4gpYPR5gkQ
        ICvvMGXJ5/TpT/8HLqg5JGh41j0we+MgfZg1VylGqG7H8Bs=
X-Google-Smtp-Source: ABdhPJy+Bo/AS2kiB6xuOzfEYl7fm8rXJKRytloafR1O/vAf248wmhE8REMNUH/rxh4T04a09oh+5wi7Pwln9Y00+io=
X-Received: by 2002:a25:508b:: with SMTP id e133mr1169143ybb.293.1644967375682;
 Tue, 15 Feb 2022 15:22:55 -0800 (PST)
MIME-Version: 1.0
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
In-Reply-To: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Feb 2022 15:22:44 -0800
Message-ID: <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Tue, Feb 15, 2022 at 2:22 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>
> Detailed report is here, basically can't get any event from the mouse:
> https://superuser.com/questions/1697648/lenovo-legion-m600-wireless-bluetooth-mouse-connected-and-paired-yet-not-working
>
> Have the same mouse and ready to provide any assistant to solve this.
> Any clue?
>
> (If this is a tough problem I would probably have to return the mouse to
> store, it's not cheap..)

Please collect the HCI with use of btmon.

-- 
Luiz Augusto von Dentz
