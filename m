Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 13:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiCNNQD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiCNNQC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 09:16:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE0D2AE12
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 06:14:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g7so6382184qtg.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rdm6WcHd2UZKtrYNzZbFzqUQd4NUiFFh3tDX3bGnuk=;
        b=ZJbPZTWCQpkBMpm4c7zzdBjLhFwYV5Mmfc7nb2sDKttaMgwlrxtZrnxy7dovr/2v0/
         R7bc9A/ZRWtKh+gulNgN0ahSlBP+/lSl74r26+9jiJ6zzV/p8bcMpLKK26YHSt0RfN4S
         wu90+G9FCm3YHHET0U9Q7ETPkMKtiQpTi48B4WOl0G0TagY82uK5UBvDGZvuAPE0EJmd
         nVmbJsp2oip/LD617ON0rPerhIk0rezkoUgc4XuehAnq433rX9zgk33HSVwpX6+6RjUU
         NnMCrfyYEMaornZoM7r/L5ZSursaVNYEoozJjvVCZpzCgUea7X12b3TmelNJ8s2QUzSN
         fkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rdm6WcHd2UZKtrYNzZbFzqUQd4NUiFFh3tDX3bGnuk=;
        b=v2BbxDAVmz1/MkYAvN8GtrChL4zcu/peDRZkMLqdhX5VWi7+UAeUlJ1pKJ346nqQb3
         QSI/PT3D26euvbiZ8Jg7LFo+ba7UwxGLVH62pJMryoTvWzbAebUfhyxtrjCBKSP3vYb/
         sBdJpFZu9wtEI7Ui56gbqGYe/7lfcaXTy0IEXdnDah9XL3Qwt4+jV8bmS6GlnH+deQXe
         r4oS34uOXyx102PNlYeS5ARzxnR0IQkVK9Ke5TxSueMHNKVTwG+PKChcj99smNyo0jUP
         wXI0FbO66CsLao7ednqpOMt6dOqDolOcAb1twoNkmzV/j8JeACc9JH3T4QRXja+XLEIC
         IiBw==
X-Gm-Message-State: AOAM531XgxGLxxYSlKpFJvf/6tsZrDLGLArI8JsUk2ikCKsMvwyp0qpy
        tK4WJ5euzWP/A9N4Co8/2Afxll3W/vcZikRi19Lf+w==
X-Google-Smtp-Source: ABdhPJzp+LJ7N9PBedtu0a94sxgYSVBoqLsNOYckDzrN4CCHX0/wxVuma4fRc3DM1r30N8emwMq+4JHJz0Tl2LgVavY=
X-Received: by 2002:ac8:5a84:0:b0:2e1:4f1d:36fb with SMTP id
 c4-20020ac85a84000000b002e14f1d36fbmr18471370qtc.54.1647263691295; Mon, 14
 Mar 2022 06:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211201000215.1134831-13-luiz.dentz@gmail.com>
 <20220125144639.2226-1-mike@fireburn.co.uk> <CAHbf0-FEVZZYg7U__YXqPmS=XETb2pObB-8CX+vh8=-HivppJA@mail.gmail.com>
 <20220312144512.GQ3315@kadam>
In-Reply-To: <20220312144512.GQ3315@kadam>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 14 Mar 2022 13:14:40 +0000
Message-ID: <CAHbf0-GTexadb=Ypk+gn8_KfUHjHZW-Vtzh1V_M08Tv=nd0Xrw@mail.gmail.com>
Subject: Re: [PATCH 12/15] Bluetooth: hci_event: Use of a function table to
 handle HCI events
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     luiz.dentz@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, 12 Mar 2022 at 14:45, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> It seems reasonable enought to remove a spammy error message.
>
> Can you resend your patch in the proper format with a proper subject,
> commit message and signed-off-by line?
>
> regards,
> dan carpenter
>

I've done that, but I'm not sure if I need to do anything else

The patch was based against 5.17-rc7, but just let me know if I need
to rebase it to a different tree

Cheers

Mike
