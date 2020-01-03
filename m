Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53BC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378E2215A4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+8ZbV9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgACRp3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:45:29 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41774 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgACRp3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jan 2020 12:45:29 -0500
Received: by mail-ot1-f54.google.com with SMTP id r27so62016560otc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jan 2020 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHjMmXyc4cvw4XaLUeQiTc8j+wHyKH0uomFcACv8DzI=;
        b=Y+8ZbV9S9mWaW++a2r/RJN5H7FC/Uq8kbqJFXT511HfDMK2XtYRB4Hw3bcae1OvLLP
         q7NEaDGsZvd0dSg4AlxFyKaFJaoo61NnOcQGjuHcTJrLZlUvmf6eJV7IpWn+tXCrN4v2
         S1LeRWLgURMaTu0J57x2q8tAFnxIrWYFyv99ACKJ3djP2/m1cGSwM7dybwNMWYYF1sXu
         EDnsqh+bD3EdloMIpej5Sk4D5qn2+u7xZ8pmUd2oC40RqwCCgFjn7VfJ9WUE7iVDd1bw
         uLUSXyliaR4D9JJpOAwXVvQHK8C1WtZRwQ1Uc1rzyC/Yf1MpgfaRYELH3mbulOhYHZ+O
         JIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHjMmXyc4cvw4XaLUeQiTc8j+wHyKH0uomFcACv8DzI=;
        b=dXg1ceNWxXt28kP9Ok5UWPBv0v7104U0gsu8dKSjq0GozB47D1izxQuz1/3altV5ie
         zAYMbcfu8gz1FCUZNCbxthngUlah8YeH4DYToCNTlqRfP32QylG5SNt/8hmBhRaBxi32
         Dt2Ggy/IV5Y4M64yV+vkzCjoojwIzu/1ITN8KFbRZGx7wOHAM1wFfh3IqHGniJQm2AD8
         n/cEuzAQLXi9Z5OGt+kYnONcJt4Dc8DoqhfaIUx6au7V89XF1lwlav1fckJWwCc1rwma
         uSjYzDRgYx22w7UPFncFqyhj5AH12J451KOQdzsqgUMdVju6BXo5JddVcJ7urtqLelmB
         CTMg==
X-Gm-Message-State: APjAAAXgp+TwDs8aImlfYY2KgyBJ0rI/Zwv5AsN63v0zSNAvbAbGJVUG
        XhNUx+3rRCgF63HgPMOWqo0oYKh7D4IYkdyZWN+E28SY
X-Google-Smtp-Source: APXvYqxV0ryec8vti5uouzKyoILWZIc8AwuuVXdlMOQxjbQz06t9T1M5BF56ptZ4lhNYUGBGTPVtLyKf/epJXxBV698=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr101988587otp.28.1578073528262;
 Fri, 03 Jan 2020 09:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20200102172447.18574-1-luiz.dentz@gmail.com> <20200102172447.18574-2-luiz.dentz@gmail.com>
 <DM5PR14MB1385EC175428FE2F702258FEE6230@DM5PR14MB1385.namprd14.prod.outlook.com>
In-Reply-To: <DM5PR14MB1385EC175428FE2F702258FEE6230@DM5PR14MB1385.namprd14.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Jan 2020 09:45:15 -0800
Message-ID: <CABBYNZ+3A7qf6X6oLgV3FXOQbDYo5H52V6Ui_0R+WEM0sktGqw@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jamie,

On Thu, Jan 2, 2020 at 11:22 PM Jamie Mccrae
<Jamie.Mccrae@lairdconnect.com> wrote:
>
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index e42bb8e03c09..69c0e7eb26d9 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -121,6 +121,23 @@ struct bt_voice {
> >
> >  #define BT_SNDMTU              12
> >  #define BT_RCVMTU              13
> > +#define BT_PHYS                        14
> > +
> > +#define BT_PHY_BR_1M_1SLOT     0x00000001
> > +#define BT_PHY_BR_1M_3SLOT     0x00000002
> > +#define BT_PHY_BR_1M_5SLOT     0x00000004
> > +#define BT_PHY_EDR_2M_1SLOT    0x00000008
> > +#define BT_PHY_EDR_2M_3SLOT    0x00000010
> > +#define BT_PHY_EDR_2M_5SLOT    0x00000020
> > +#define BT_PHY_EDR_3M_1SLOT    0x00000040
> > +#define BT_PHY_EDR_3M_3SLOT    0x00000080
> > +#define BT_PHY_EDR_3M_5SLOT    0x00000100
> > +#define BT_PHY_LE_1M_TX                0x00000200
> > +#define BT_PHY_LE_1M_RX                0x00000400
> > +#define BT_PHY_LE_2M_TX                0x00000800
> > +#define BT_PHY_LE_2M_RX                0x00001000
> > +#define BT_PHY_LE_CODED_TX     0x00002000
> > +#define BT_PHY_LE_CODED_RX     0x00004000
>
> My query about this is there is an option for LE Coded, but LE coded can have a data rate of 125Kbps or 500Kbps, is there no need to differentiate between the two rates in applications?

I guess you referring to L=2 and L=8 payloads, those are unfortunately
not exposed over HCI, they seem to be tied to LL power control and not
with the PHY selection so Im not sure how we would be able to infer
what payload is in use. Btw, I've the PHY bit fields to match what we
use in the management socket,


-- 
Luiz Augusto von Dentz
