Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30DBC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE72077C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmFbH7mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAPQSK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:18:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38916 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 11:18:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so15911165lfb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxsJo8JkMMajkwllHDAiGXdiDt62alvnYc0Ua+eAqyI=;
        b=pmFbH7mj7OeaedV/yGck35+mBGTg9q1Zi2jDo6xOalt2YtnuHJdUM2/zG5QiHNKcRU
         69/fXxajTayBSUMiXy93NoQ4vXsMKPdG6l6TBxP18BaTL4CIo0wcLrX1RGAVLK4i799v
         0OnACkmhFhhT034lPiUVWzBRX6PHLvMAR+bPqg5OC3JxW71rJ5ul1xiz3M6X7UQybTA6
         j9w5lAfjHoEgBK0A+r92vuyzGfmrLZfEjaegzID6TZ81762GhFLfQc+PIUkkIaa/2noZ
         uqg6DfMyDt/8PHUGcrKCkcVjspEMJ7Erhwt6mOa57fKZ9ZNGrerQZKx6CQo7bQl6GlV0
         VYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxsJo8JkMMajkwllHDAiGXdiDt62alvnYc0Ua+eAqyI=;
        b=Iic5e5/V6xOCLUHBamaJCqixWgATKF9Epg3KisssI1xZq8YT2fp5i67402DSIEAHBJ
         qlwc1AquszNBA68+joQh+pt4voN3bXEBmqBWw0l/qRwyidrUPJlK9KYSH50LulQenhee
         CQSFOEe/IJ33G4IklSFK/yNS0MXYSttw+F21PbVkQoc4P4+wzDF+qenl1XXoUBSF4dcc
         5avbMyV9QUqHk3O+whEjmgtaYbjR3WZ7Yr4NStjl4irUPt9Sn0Wzh1nsRTWQ2ImzlAsp
         xkOMXES5BGC7rFKvlle/BjjWdT0iuMffEHmmOl2tIFyMIMMwiwKPVd8bFsviNCAwqjb1
         Wlog==
X-Gm-Message-State: APjAAAVWY3jNjf42CT4khq7WQJdY5WldgEH3gqPR4w0RZzpx8JH6AixT
        KzY0Ux8YsMYBs9KRrqXPipuSuHc+BWCpLxzMOPv+jIObfZY=
X-Google-Smtp-Source: APXvYqxxEPaibYYBGh6e+ZmvJ8N1MjWU7NqeTgLyIfQ1JiDyM6nMKXPjI2+dJtCSZJF6rdveZdBJTB8+w+f8HcdduT0=
X-Received: by 2002:ac2:51de:: with SMTP id u30mr2896918lfm.69.1579191487210;
 Thu, 16 Jan 2020 08:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20200107004317.152792-1-alainm@chromium.org> <20200107004317.152792-2-alainm@chromium.org>
 <B37E9643-C00C-4F8E-80CA-27D64D998F88@holtmann.org>
In-Reply-To: <B37E9643-C00C-4F8E-80CA-27D64D998F88@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 16 Jan 2020 08:17:56 -0800
Message-ID: <CALWDO_WWC_0_iPg=QLc=wSxGGb6vNUK=hOH84N7Y-0JgLJYbVg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel!

On Wed, Jan 15, 2020 at 12:37 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > MGMT command is added to receive the list of blocked keys from
> > user-space.
> >
> > The list is used to:
> > 1) Block keys from being distributed by the device during
> >   the ke distribution phase of SMP.
> > 2) Filter out any keys that were previously saved so
> >   they are no longer used.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > include/net/bluetooth/hci_core.h | 10 ++++
> > include/net/bluetooth/mgmt.h     | 17 +++++++
> > net/bluetooth/hci_core.c         | 85 +++++++++++++++++++++++++++++---
> > net/bluetooth/hci_debugfs.c      | 17 +++++++
> > net/bluetooth/mgmt.c             | 76 ++++++++++++++++++++++++++++
> > net/bluetooth/smp.c              | 18 +++++++
> > 6 files changed, 215 insertions(+), 8 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
