Return-Path: <SRS0=CsyS=YW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F6CA9EAE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F1F20856
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVM+eRIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbfJ2NQo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:16:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36692 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbfJ2NQo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Oct 2019 09:16:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so9701817otm.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2019 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ecq5l3NGTkSNMMtdvtGS8c5Oc1a8hh41Azf6zC4hq04=;
        b=RVM+eRIAVbrIfLi2NPuJ6Lm5RXXve66zj+8YhcUBxbB7RFinn6OCx9OQ5bmpJrLN3H
         hWi7Wx6QR/cy+YFkP7yXhr2aah/MWEAv5ZVdnWZU3fcpeZBHdTtfgdmaaIRVNFGCWtNO
         gAk5Q9tplHV+i6d4NCRXRPFa7trGE2xFJEtwG0/P6517uSIDHI0/HXAHvIHz3pEcwAhi
         32259jLlVXPFiX8sCTzTkI2wIgoseiLWkkDpsYwWE9n5cLwEhaNSvYZqsuOxTaiCzKy2
         VDMW0ToobApis3jCGRAHT3J/Sq6fCZ+Pa5ymPSMZV//rH4Z4SLjgIV3OPls6U2gUCsJC
         YTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ecq5l3NGTkSNMMtdvtGS8c5Oc1a8hh41Azf6zC4hq04=;
        b=aHti47sFM5VxGaI27aDoq8nbpXf3x2imxnxOQLtA18ULy6QRYLLdobtGMT6PCkcF5+
         nQ5I6r5dbEXwnozxfV7uffnft4pKw71Zpz7kx/wO6GaBvXvwqZbm6IV+67aQ0RhWn/rT
         2f/0x41qjKwBUpbXg9WIWW6feqfMCZ3ZQQc3X5mRL491qq/O17ZW3uY2GjMnUuwBdsjU
         VUYjVARFFIilBXBBNVpcIK2K132VtrHtUSA15DmL9aGawX2/bTIeviKVi0TPG6r+FrN4
         zdG3VvFjaVyebnBxav0zyCptE9QFLBun42sD4lu4LRjyQUxIVKvYM0Vct5KiNUsCZlEQ
         rRrg==
X-Gm-Message-State: APjAAAXVEJctC2MMgE9qduBpQ42KGBXc3BgfpyhqMbviBncuZrFAXhry
        nOuKU0j87j3IKRRGk3b1gmlbjFLMH4qAwjTAPxWDR+igfes=
X-Google-Smtp-Source: APXvYqwrYMQTDVe5giGjn9fF0lcdFJdXdyox54UbL40aKEI2/OE085gTU/PeuIxFdefirmHnLEY6zu11F+8shtKovk8=
X-Received: by 2002:a9d:620c:: with SMTP id g12mr8384234otj.11.1572355003359;
 Tue, 29 Oct 2019 06:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com>
 <585F2A10-B16E-46BD-8EF6-4FD904A485AC@holtmann.org> <CAJzH+bqLK1aohAE3f5-4Xfhz1Gq05URFgZf9yFPAeBF2ekfmQw@mail.gmail.com>
 <368BD38D-6FFB-412D-A6A9-364B3B5374F0@holtmann.org> <CAJzH+brQ6vu-o6a7iAmpBT+cbrdGHP3XNfUk61UPyS2D6bwGDQ@mail.gmail.com>
In-Reply-To: <CAJzH+brQ6vu-o6a7iAmpBT+cbrdGHP3XNfUk61UPyS2D6bwGDQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Oct 2019 15:16:30 +0200
Message-ID: <CABBYNZ+3XKTzvwKRVK3YP2m+4rFUHBYmeD4zyFtZ25af8aAwOQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Always set scannable for Adv instance 0
To:     Jaganath K <jaganath.k.os@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jaganath,

On Mon, Oct 28, 2019 at 6:50 PM Jaganath K <jaganath.k.os@gmail.com> wrote:
>
> Hi Marcel,
>
> On Sat, Oct 26, 2019 at 11:02 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Jaganath,
> >
> > >>> By default for instance 0, local name will be added for scan rsp
> > >>> data, but currently the property is set as non scannable and hence
> > >>> Set Adv parameter fails with Invalid parameter.
> > >>
> > >> can you be a bit more specific why this is the correct behavior. We must have documented in mgmt-api.txt somewhere, right? Or is this something that used to be correct, but we broke it with adding extended advertising?
> > >
> > > It seems to be functionally broken in legacy adv as well as we set scan rsp
> > > for instance 0 always but Adv Properties is set to non connectable (if
> > > connectable
> > > is not set). Even we need to fix mgmt-api.txt as well as you pointed out.
> > >
> > > But in legacy case commands do not fail as  scan rsp can be set even before
> > > Set Adv Param where as in extended case Adv param for an Adv set has to be set
> > > first before sending Scan rsp and other commands for that particular Adv set.
> >
> > how does this intersect with the patches that Luiz was sending earlier?
> >
> I think Luiz patches covers both the issues.

Yep, my patches were actually targeting the same issues, though you
had a better description, anyway it is a fix nevertheless.


-- 
Luiz Augusto von Dentz
