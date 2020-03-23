Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6527C54EEB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44192074D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 17:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oac+Na4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCWR7u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:59:50 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36211 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCWR7u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 13:59:50 -0400
Received: by mail-vk1-f195.google.com with SMTP id m131so4058880vkh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1lNiHO6xPgUYO8vpSF+umT+MsS9oLeQwMA1IUK4msY=;
        b=oac+Na4QF5JdaT66BiopNbxc1KdXssKfiBlw2slQLPbJQBivpZ0EN0e6Sgvlv3MlYt
         LFkGEQSOGmkteEnbM8Sa5xhzWzDoK40s+TbvrvTQ4l0I2NLeiOBlHX3V2ZDM+gX9fHCA
         dE2zVE+twtdZnNDIfr1GiogTDw8RQHAcUZxP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1lNiHO6xPgUYO8vpSF+umT+MsS9oLeQwMA1IUK4msY=;
        b=bX20n1HL6fyly7rSSokOu09NmMwIYqGTC4heOxQUlV4s/mCSvtft0p4J3tEDw0E5MC
         mp7By9QXB5R7glIyG1sJroDjQXHjF5sbuewZfgJRD3ByLj4ssqP0LMLQTqZgKuRdRmKA
         1JpIiT51WkvCIQjSFVZ4qyQL6iDmr0hT2fCLA+HxaFJuF8YEkMI5ORO3EiYhIb5d5Ub/
         f/nlO8K7G8L5rcQtxxlSV/C9PT1PJU2YNFIMb6697HMOZhEthYLc1WVPdX/BLgF/a83u
         k/Pp0oALeiHO3X8+LJ3HiRpthgJxm9E4wUrlQtHKqpuSMQeVsA5PmS3suxX17YluWt7z
         uEYQ==
X-Gm-Message-State: ANhLgQ1oGGUvxrdyPlIRAHLyuZAet1ibc8CByV7V37PFN8Szl7pXy2gW
        DAbHs2rcCs2ioIJxXP2QEJ+SqR6kxneEpwcDgOUPBQ==
X-Google-Smtp-Source: ADFU+vuVSdd2udzk4DKElzSYL+hMRvTEKcwyCXXYbubzZcZarmIuxkLsTjU4cHyyKYLHSKOKQBZQbz5oZXm8FdykO60=
X-Received: by 2002:a1f:43:: with SMTP id 64mr15772046vka.100.1584986389210;
 Mon, 23 Mar 2020 10:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200320000713.32899-1-abhishekpandit@chromium.org> <DB1736FA-94F3-4BD7-806E-7AC2E25D7D1E@holtmann.org>
In-Reply-To: <DB1736FA-94F3-4BD7-806E-7AC2E25D7D1E@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 23 Mar 2020 10:59:37 -0700
Message-ID: <CANFp7mXaWKpsNPFZ9kNC5PVZO+LbzvjoTb4ivcb4EjzMbaKNhg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: Suspend related bugfixes
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel.

On Mon, Mar 23, 2020 at 10:50 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > After further automated testing of the upstreamed suspend patches,
> > I found two issues:
> > - A failure in PM_SUSPEND_PREPARE wasn't calling PM_POST_SUSPEND.
> >  I misread the docs and thought it would call it for all notifiers
> >  already run but it only does so for the ones that returned
> >  successfully from PM_SUSPEND_PREPARE.
> > - hci_conn_complete_evt wasn't completing on auto-connects (an else
> >  block was removed during a refactor incorrectly)
> >
> > With the following patches, I've run a suspend stress test on a couple
> > of Chromebooks for several dozen iterations (each) successfully.
> >
> > Thanks
> > Abhishek
> >
> >
> >
> > Abhishek Pandit-Subedi (2):
> >  Bluetooth: Restore running state if suspend fails
> >  Bluetooth: Fix incorrect branch in connection complete
> >
> > net/bluetooth/hci_core.c  | 39 ++++++++++++++++++++-------------------
> > net/bluetooth/hci_event.c | 17 +++++++++--------
> > 2 files changed, 29 insertions(+), 27 deletions(-)
>
> both patches have been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
