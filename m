Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 16:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5569F2065E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 16:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq5rXNPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgGPQkj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGPQki (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 12:40:38 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8147BC061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 09:40:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so4717387otk.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n3KBdXZLcYlTUDBbE+qyjqRLHqOsDbgzV4YLQ8w2+0=;
        b=oq5rXNPRcEaYasZkNUw3ngnZoR9HzeD+FCN7okAQDzU+h196n1oS70+htHPWe7LCZi
         Yqiohq9SSYtAGxSVgmA/ZOt4aX6pCXTztr8LXRSyzAyTBpxgRnAxP0avE+j+GoefX9WR
         SMweOs8MPGgDfyzwz7/qCjUBuNBqRvN/Z+9S4a5XvS40kQKrHRk0aFWZKOl/uNovbN8X
         6/h8oq41ifjDUtZ3CS0EvnyfiVG/zd3K7n1ZVYvYs3DKRJw8LK7UMG6YylodgQcNEtyn
         TBPCFTEbvIVhAmzTEvFVVvr/cD0pLuZStp8in/YMX6HooXVQ8fVKy/unovprFRhwUZk+
         b+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n3KBdXZLcYlTUDBbE+qyjqRLHqOsDbgzV4YLQ8w2+0=;
        b=VRTh2CwzhOs4vb/n3LZfVteBwXCV4r3K5sl2Jo3FtBAF7nA+Hre1oFnVQgpNkvFYbt
         9dW32/9Y5sqVCdeEeasU2BFx37aSCMMcbFpDHfWjRxKtvBsw4CpSL8q1q5U26PU/Lb6P
         U04SIszsGEBInNw/t+uVGuA2TOFh8bftqYXU/xqBdrgYWdo19vsEBP3033ArwX6z7Lq3
         dCt6rg1rWvAaG8fA/oOXz5q0OehXUEaU4d9Sn1XqqwUEvSarXmdKNM2HGJk3+Ohc9lnV
         VVRBiMg1XahiIzzu2kcuabPzBqzTtntrGSIDK2RVTJaTBeMe5QjjXXlCPGU7cF/kBYIj
         7TqA==
X-Gm-Message-State: AOAM532P5PI070d8+Zf8bDDXNjqB+1bX0KQrjj5rzBSRy0q77QZsoDS+
        mlDuouWoDcRiC2lGPra4utqzat6uzWUNUN2TgO0=
X-Google-Smtp-Source: ABdhPJyzPGmRhheXOVHTR45ypL8x9J8N936GfjuoEEooR1QUYMo1tb3x1OCV0iNo+mckNfTPeG3db0U740dIuD51nkk=
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr5130252otq.362.1594917636464;
 Thu, 16 Jul 2020 09:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200715204635.755599-1-luiz.dentz@gmail.com> <bb693f5768e9d36f19000c0e303dbc8e9c9273d1.camel@hadess.net>
In-Reply-To: <bb693f5768e9d36f19000c0e303dbc8e9c9273d1.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Jul 2020 09:40:25 -0700
Message-ID: <CABBYNZ+-qG7uULxP0Spdp0rJQ+9-b1g+ASzKrGkEQm630EBuAQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Add timer for removing temporary devices
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jul 15, 2020 at 2:03 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2020-07-15 at 13:46 -0700, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds a timer for how long to keep temporary devices, it is
> > updated
> > everytime the device is seen so devices will be removed even during
> > an
> > active discovery session which means the discovering for a long
> > period
> > will no longer just grow without removing devices that disappeared.
>
> Both patches look good to me.

Pushed.

-- 
Luiz Augusto von Dentz
