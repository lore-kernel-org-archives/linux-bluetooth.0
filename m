Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C354C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0BD23370
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 13:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fw1oYlMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgDFNmP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:42:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38688 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgDFNmO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 09:42:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so4441117lfc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4AULzYkZUr4yq6skeCFwiU8j+Y6W9mnqqa0q8nQ9iUU=;
        b=fw1oYlMDKdEjOECnyT5L9z7EKAqi8t0f2uHDRvb+0Vb8QQ6KqHSw/86xn9p5zuZbkM
         keQyCCVLWXL1FUVWCP2Huzg7UORPITgVpP776P7ukX28DrulcHH2IlRBFUkk8Rznb6PT
         UDQXK2Lw3tKFjBaezk1AIGcsiiBnfW4R7GR0e214L+c7cQ0Y7hOVbwvH9yYgaOANOK6y
         V/3EUD3+pZQtbCSL04r+E28LoBceUJmabyHIZzstYrEr3gGONYrtkfEsVyKyvDe6zF1c
         +w5B6PnNwpF08HAWcTZBvlWTyuEbkROnnaIAa9la7/787FUHBUiIndaJDrTfF2IYw94N
         Y95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4AULzYkZUr4yq6skeCFwiU8j+Y6W9mnqqa0q8nQ9iUU=;
        b=PIG6wKqjNp3j2nd+pEGjRP0tjdV5+M8qgYnDjhTB26rsfAdBUDijwDzeYKe6VYF9fD
         aworxE9DJnNWVwr+rnupwqY5w61L7tOyOwTejOSFC1SSzsuKA+dAqIL/EsCZX3P/+8wi
         M2ojyfdz0CBESjE/aEwOEOM2DLuYxgzJ4eqvY9svxBa9YdejzmkECh0n2RMFZdTe3FLX
         3pz3iq0en9mHLyIH32jOgoal0AwYXkNi5WG5GQ5Xy30eWMOSfj4uAsJ8DZVqYZ3XSU6m
         q65d9L+HzkIlzTpXmJKzm7o8wbBLmzj4zRV0mhQ0v4CP+4YnV73LWi73nykltU+N/ptT
         Dx5Q==
X-Gm-Message-State: AGi0PuYIhOXuWFFxamaHm2722SeyeEnBdXs/5JRnx74/1SxdM1GCorhF
        WuRJzWOiZH/h2p5H1U/b0o4RLNHNkoyIK1DUS7ioxKoZ
X-Google-Smtp-Source: APiQypKBFtyO0OlS57ylMIbVNz9STcd0rOSyo7zGKE8cveajvoqa+dV/2GICCTVJN0SSvUeIm0nCt4zGpL6i7rt8G6k=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr12059999lfo.69.1586180532413;
 Mon, 06 Apr 2020 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200403194407.784943-1-marcel@holtmann.org> <20200405115426.GA20858@yganon-mobl1.ger.corp.intel.com>
In-Reply-To: <20200405115426.GA20858@yganon-mobl1.ger.corp.intel.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 6 Apr 2020 09:42:01 -0400
Message-ID: <CALWDO_UrzCLehfAVD71PQCe=oa+iieJ4T36-UxPzy3RDyEQngg@mail.gmail.com>
Subject: Re: [PATCH 00/10] List of pending patches
To:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel and Johan!


On Sun, Apr 5, 2020 at 7:54 AM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Marcel,
>
> On Fri, Apr 03, 2020, Marcel Holtmann wrote:
> > This is the list of pending patches that are ready for bluetooth-next.
> >
> > Marcel Holtmann (6):
> >   Bluetooth: Move debugfs configuration above the selftests
> >   Bluetooth: btusb: Enable Intel events even if already in operational
> >     mode
> >   Bluetooth: Add support for Read Local Simple Pairing Options
> >   Bluetooth: Add support for reading security information
> >   Bluetooth: Increment management interface revision
> >   Bluetooth: Add HCI device identifier for VIRTIO devices
> >
> > Miao-chen Chou (2):
> >   Bluetooth: Add framework for Microsoft vendor extension
> >   Bluetooth: btusb: Enable MSFT extension for Intel ThunderPeak devices
> >
> > Sathish Narasimman (1):
> >   Bluetooth: btusb: handle mSBC audio over USB Endpoints
> >
> > Sathish Narsimman (1):
> >   Bluetooth: add support to notify using SCO air mode
> >
> >  drivers/bluetooth/btusb.c        | 182 +++++++++++++++++++++++--------
> >  include/net/bluetooth/hci.h      |  11 ++
> >  include/net/bluetooth/hci_core.h |  15 +++
> >  include/net/bluetooth/mgmt.h     |   7 ++
> >  net/bluetooth/Kconfig            |  23 ++--
> >  net/bluetooth/Makefile           |   1 +
> >  net/bluetooth/hci_conn.c         |  25 ++++-
> >  net/bluetooth/hci_core.c         |   9 ++
> >  net/bluetooth/hci_event.c        |  49 ++++++++-
> >  net/bluetooth/mgmt.c             |  55 +++++++++-
> >  net/bluetooth/msft.c             | 141 ++++++++++++++++++++++++
> >  net/bluetooth/msft.h             |  18 +++
> >  12 files changed, 477 insertions(+), 59 deletions(-)
> >  create mode 100644 net/bluetooth/msft.c
> >  create mode 100644 net/bluetooth/msft.h
>
> All patches in this set have been applied to bluetooth-next. Thanks.
>
> Johan
