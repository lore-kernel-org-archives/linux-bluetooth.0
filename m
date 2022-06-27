Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66473C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jun 2022 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbiF0WVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiF0WVj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jun 2022 18:21:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7427642
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 15:21:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z21so18974769lfb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xu1JabfQktiq3T8ewN1VpCN6WZC8dJYUy/VoQzZK1eQ=;
        b=V5Hj4guq+lWQNWkK+vd3iNxzGS75AZYC/fKAe2tmyGycnAnRo3xmd3eqdMP2ARJ8ml
         0+xSK1jSjhlYnSJa3QzXcNWDZ8GLR9MVUK4hfCtSA9OLyYeJC5P2f32BFQ3CXGEPwHdw
         FuA3eXZzx1qbDrOmLLtbDskwsuV2bE68e9xtDC5rXu0Y7N/lNdCVt6NHmVBmuvrOZuD7
         qrSJYHuvqk9nC7kJ4hN+C4f7BnIa6Sf408utjjaFZ6ZtdTsH4UW6meWuIWh3PE8pDpWK
         yew2/z6+DZfpOxeet5alvV4DUoQh7+oiarbFhamhXqIkAk+/FJbmBrrhK+lgGO8irj9c
         Di/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xu1JabfQktiq3T8ewN1VpCN6WZC8dJYUy/VoQzZK1eQ=;
        b=Kmyxn30DwiDtJEU5KLBrTfSpijmglD7jrmysMizdFbimeuxDe8U4oito/e50HKqUhg
         Gp9R4+xwfnqeIZCDLghBlW/kJuIEquCYnoLURgNIptpcErfyG7u7gC7lX03JrxEUa4QO
         qX1XnLryOrk2yeoQTLzDlYkj0BL6pLmyX3kfxFgEcJqssJkEs0yNZtSlm9axqJ0k8kGb
         B6oI0wuu8k1ifSBjIsBY5h7zvYbjGRN1LG5IecnuADWUMDi+Mt2ip52dCUuKxmTV145t
         bDn0ps/hmtNCvHIHaeveHqrfpjUMrP0mqJC3fJDjNzeFrFrTRzPeKyqA0pfcQVNTA3vY
         aaiQ==
X-Gm-Message-State: AJIora/HjmIYpIkbRKQ1BsrE8gLn47ZiGUKGMOQaovF4tpOnAkN0aTHF
        HVqp0796PdJJKpOQhmXX2g6CjCX7ut5LNDnyKwM=
X-Google-Smtp-Source: AGRyM1sYAUDnRwraWkXDXgp2CfdnTIkD7EsHg0SlMohg381Uv3GQDEpooenvnJYt0lzf/jeJdsSmuP8cnn+H/YAqnh0=
X-Received: by 2002:a05:6512:2392:b0:47f:b8f8:5052 with SMTP id
 c18-20020a056512239200b0047fb8f85052mr9125270lfv.106.1656368496360; Mon, 27
 Jun 2022 15:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <GV0P278MB0129C9B8851F33EE8C3BA54095B99@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GV0P278MB0129C9B8851F33EE8C3BA54095B99@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Jun 2022 15:21:25 -0700
Message-ID: <CABBYNZLtL=MTCDka3xhMfhxfEHpzaY=bSn_Zat_=HD54=JhRVg@mail.gmail.com>
Subject: Re: BlueZ bluetooth qualification
To:     Isak Westin <karl.westin@loytec.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Isak,

On Mon, Jun 27, 2022 at 5:32 AM Isak Westin <karl.westin@loytec.com> wrote:
>
> Hi,
>
> My company wants to release a product where the BlueZ daemons are running as a host subsystem (both bluetoothd and bluetooth-meshd). So the product needs to be qualified.
> I have looked on the web-page and searched in the archive of this mailing list but didn't really find any up-to-date information about this. So I wanted to ask if you have some new information that could help.
> What are the general guidelines to qualify a product that is using the BlueZ stack? Is there a version that is already qualified that can be referred to? Or is the best way to qualify it ourselves using PTS testing?

Upstream don't qualify BlueZ by itself, usually it is the individual
companies that qualify it based on the kernel and userspace version
they intend to use. That said we do want to properly support the likes
of auto-pts with BlueZ to automate the process of qualifying with PTS,
and perhaps in the future even use it with our CI if we managed to
emulate the PTS environment inside github.

@Tedd Ho-Jeong An can you update Isak where we stand regarding using
auto-pts with BlueZ?

-- 
Luiz Augusto von Dentz
