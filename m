Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45FC388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 21:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B002421D43
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 21:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix9cJ4yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371532AbgJVVJm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898159AbgJVVJl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 17:09:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06113C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 14:09:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m128so3325748oig.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yngVcmBXrS5TEGqorBjuJL1USmoVLDTIB0DwmZju20Y=;
        b=Ix9cJ4yprmNhqPPrnDQJUOLOv97I7GfFziiUb9BJ3/6/hO9k0EwsaybnnGms+zomja
         iLMiFzetPI0X0YsSqD9bKd2Fb1nJFmF7BDz089xudL44o0Q5uPe5tbhs1h7n4hPmlaOd
         wfptdJSpHBw5HiEmnI9TXORBXRGaAsOnlrLmqKedKp4Hgf52cuutkDtEQ42XbaFstFgn
         eEaeEmndXJ8SCYyOFDF9acmzvQUIxGn2J7hwDCaTCP/E6NV+xixaxC6EGr5bEhMT20Jg
         WxfGZYu8htMui9JcHztqBER6gxiYT7kGFwLCmFqT/W55XxfFdlhOaU0P1fPmTXJHMwwQ
         EL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yngVcmBXrS5TEGqorBjuJL1USmoVLDTIB0DwmZju20Y=;
        b=h2v4JaoIDyto937lCIdeX4hUxCbth57hMC91JIWeTq7juYv6E17iUiP2R7ZenYKjkH
         dULLbeX52E+R0SXEO+rPB5s/H/vWMSYZfiD0jG0/OnhfjI53zENhBHWJb5+h1XtGWzT2
         u4skCWCkty0C8byY1Qe9a26FcdMhqJwj7I1YdBmiEzW6NnpHlVaf4bQ6ksopXEvniM0m
         OXyDD67q+fv2UG6AA0LYfcmeOSa9SA9wK28mNywLytns7QrFVl2Hb3mv7oaGRB+n6Z4r
         K7oDfyit7Ldlgkp5pBFyvX9jmDP2sVbvBQM/yaauMao397X8TpJLOqNH/cdc7kJ47cgP
         Mk4Q==
X-Gm-Message-State: AOAM532sOXPsBxCBdtSW5ITCQsq6SBQi0KgTQIdjMC//0uxeNqUreKaA
        pdeppIstSc/WMg88KarentQPmRLrRmLUd8N5ZluOHVHQHBg=
X-Google-Smtp-Source: ABdhPJydkGQW4UDHcdhTzCn7YYhtvXOY7KmZnlUDb4Mo/8OXFP9zFRhkibrj7kHFNcvdeBvbNoDNfXs0YBCnjAUuZB8=
X-Received: by 2002:aca:cdd8:: with SMTP id d207mr2700994oig.64.1603400979335;
 Thu, 22 Oct 2020 14:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
 <20201019172529.1179996-2-luiz.dentz@gmail.com> <20201022210009.GA64331@jhedberg-mac01.home>
In-Reply-To: <20201022210009.GA64331@jhedberg-mac01.home>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Oct 2020 14:09:28 -0700
Message-ID: <CABBYNZKJK+obAMiwnG+QWV4TNEdRxkajRonhwx_LPekNiH=t3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: A2MP: Fix not setting request ID
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

On Thu, Oct 22, 2020 at 2:00 PM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Luiz,
>
> On Mon, Oct 19, 2020, Luiz Augusto von Dentz wrote:
> > This fixes not resetting of the request ID when sending
> > A2MP_GETAMPASSOC_RSP.
> >
> > Fixes: Bluetooth: A2MP: Fix not initializing all members
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/a2mp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> The fix itself looks fine, but I think the "Fixes: ..." line should
> contain the commit id followed by the commit summary within parentheses,
> at least based on how I can see this style of annotation used in other
> commits in the tree.

I did not add a commit id because it did not reached the Linus tree
yet and we cannot use the one from bluetooth-next since that tree is
rebased then the commit id might change so I thought the only way to
do it is by commit message.

-- 
Luiz Augusto von Dentz
