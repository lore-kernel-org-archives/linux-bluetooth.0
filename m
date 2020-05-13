Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8572065C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsHyEs2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbgEMSwG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 14:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMSwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 14:52:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08789C061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 11:52:06 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l3so201371edq.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iy5elEnJud6iWeyuwRZvnMMJ+uGwrkCKLP22Y5Ook0=;
        b=SsHyEs2lLMu5vD+Ko1JJMJWGlefIHjpc9VaDQuAlUoHrNSV8VQOFVpaRJTpJUKD5UA
         felfB0LfqEQx+K0eMXXZX8qCwdYjAr/vJMqfedLTTJyTcKK6ZJu7/VKJo6NbjGdzOipZ
         oOq/WzSK5ambxuPNIhMcZ5pPeSWpG45MUhClM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iy5elEnJud6iWeyuwRZvnMMJ+uGwrkCKLP22Y5Ook0=;
        b=b3BI4OlbnJp8nrdqtalNaajez9WNY/eM+LXA3iblO252e9g7vAvgl2J2Hu3NQ4BHbw
         iY7P51oFxo875VPLne79ZgmZ7Z+sH05PxaAxnVYrZo4dvzmRYGJVyAJIBuYXuq4lhK6o
         LsWbm1W00X+SqTjJHLzW3PYrLpU4BgPR9uDh3Uf5IpEVhcMBnnkwLIObPqoOpGzI3km4
         uH+Jdi4KdIPmth1JImcY2aIMBBIQEniW5nteMO+p7IYA4OMG0y93h7hKRZ/ORcvzJGMn
         L9zbg0C4a736rqjuyCmu19r+d/Fess5qRX0lPV/LRvorTBHE5D9Se0f7FgER3t9uWodi
         aPBw==
X-Gm-Message-State: AOAM530MgvQgHvxJveuFFHY4MrE7eskkV8fM806rPktMY20yyazOLIyl
        gDUCQS8R5A87X5XQvclHJqZsuOXD6d0=
X-Google-Smtp-Source: ABdhPJxa+/39F+JQbtf+cFfYCVIngPGPk9S6jOIliRO73f87cN6eRovhZWplmdKaIM6JSuIInraPJw==
X-Received: by 2002:a50:fa87:: with SMTP id w7mr1061320edr.0.1589395924380;
        Wed, 13 May 2020 11:52:04 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id g16sm12229edy.6.2020.05.13.11.52.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:52:03 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id l17so774331wrr.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 11:52:03 -0700 (PDT)
X-Received: by 2002:adf:eacb:: with SMTP id o11mr767238wrn.253.1589395922826;
 Wed, 13 May 2020 11:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org>
 <20200506195503.5837-1-sonnysasaka@chromium.org> <933B812E-E805-4D2A-A758-D09235BB4030@holtmann.org>
In-Reply-To: <933B812E-E805-4D2A-A758-D09235BB4030@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 13 May 2020 11:51:50 -0700
X-Gmail-Original-Message-ID: <CAO271mkR6Rz-hqkWraF00KsM2RP8AcmUfhu_7244_4Ky5UjQtg@mail.gmail.com>
Message-ID: <CAO271mkR6Rz-hqkWraF00KsM2RP8AcmUfhu_7244_4Ky5UjQtg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks, Marcel!


On Wed, May 13, 2020 at 12:35 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > After sending Inquiry Cancel command to the controller, it is possible
> > that Inquiry Complete event comes before Inquiry Cancel command complete
> > event. In this case the Inquiry Cancel command will have status of
> > Command Disallowed since there is no Inquiry session to be cancelled.
> > This case should not be treated as error, otherwise we can reach an
> > inconsistent state.
> >
> > Example of a btmon trace when this happened:
> >
> > < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> >> HCI Event: Inquiry Complete (0x01) plen 1
> >        Status: Success (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4
> >      Inquiry Cancel (0x01|0x0002) ncmd 1
> >        Status: Command Disallowed (0x0c)
> > ---
> > net/bluetooth/hci_event.c | 20 ++++++++++++++++++--
> > 1 file changed, 18 insertions(+), 2 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
