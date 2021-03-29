Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Mar 2021 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC77261985
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Mar 2021 16:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC2Qb2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhC2Qa6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Mar 2021 12:30:58 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A53C061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 09:30:57 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id h5so4144843uaw.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfxPhxpg4b8lCmkp3iLn4etcQuwvO0zGBVZNc4LN+EM=;
        b=gGkbggNe33AgSvMTwHgphedlU4KM7rQ3ggd9E8II2NNggKS66Q55uB0eks7MAOA6Ra
         JchEKjyYvkYk5XoMa6hTF057Vg910pGr5sWUcTxWOs2ctsLTjJwbwf1dOjwN/LbSANn1
         LrMKhn5ToIUabP4pdthySmMhdqRhSH7LQcW/9TrhI5bYe0Iv8PWl7+ARzjvK2zns2D4a
         QjaaTOPghpJ6uCrS9J/DpCn/puPFePcWITvG6jnP0IGS28VLByxCoe99gKbwpxHXRkcj
         O8JUlYSYhPgawjY8U6AwiKbeShLzRy5QsAaT80F6xtnwoUl0578fhc1yd9Y18Uo73uCv
         vsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfxPhxpg4b8lCmkp3iLn4etcQuwvO0zGBVZNc4LN+EM=;
        b=TIvRV5ARdJd/83dubBS0RrhGzas05vGpuMClT8SCMdr+0Y2vvNWI5ME9TyfGk6I8lV
         +0PwnCOxbvIQwmrOJUHOQpwHjCO4WCMnSDBP9UeV3DSKywqkYhFyl6Ty3+PzL6dfD5lc
         mW4xBrkQGKLm25cqTml7zRR3MHgFR2ytVqJ/Cn0LIP8l/XoI+yjhx6Cd21ooQ1MGv6dS
         B7S3Udm5nX6IQ/OnVmpK3uRAotUemrDRC7zf/xrP2i1AsJU2oh3DzQUIVBL5L92DIpL5
         k3cqhnbRvJ968TkhJU6Y6w5lSX9k1v+skz5SDgQT7gNRCYS9qdGLvLzoHpO3KxcFlrv7
         q5bg==
X-Gm-Message-State: AOAM533rSVWxJgv1kjW1HwKUukD2yq4UOt1gEyE5pXk9LoVB6QiyxvxI
        y++aSPlBLu4nj/ygwDuXLY6K1sa4IBC4RVY/RNHCTk5alWI=
X-Google-Smtp-Source: ABdhPJyfsLMtYu1J2WIv7eCWt4CHlZHwc2c18Ln62Y++833SXnpe9EsELMR/mM8tQ7FUbt+LXcSwx7ZIcM2VcKZDE9s=
X-Received: by 2002:ab0:45e1:: with SMTP id u88mr14475627uau.25.1617035456045;
 Mon, 29 Mar 2021 09:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210324114645.v2.1.I53e6be1f7df0be198b7e55ae9fc45c7f5760132d@changeid>
 <CAP2xMbvooqbwpVUWzLOTBt55ob1R-kZ80OPd8r4K0mQVrQP7kA@mail.gmail.com>
In-Reply-To: <CAP2xMbvooqbwpVUWzLOTBt55ob1R-kZ80OPd8r4K0mQVrQP7kA@mail.gmail.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Mon, 29 Mar 2021 09:30:44 -0700
Message-ID: <CAP2xMbsObjrHoV_nzQPA4bj9wSbQCfjhxhPvb_BS99fL23ynMg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Always call advertising disable before
 setting params
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi maintainers,

Please disregard this patch. While most chipsets honor the "Disabling
advertising when it is already disabled has no effect" clause in the
spec, I discovered over the weekend that some (WP2, ThP2, for
instance) controllers will return an error status if there is no
advertising active when the disable request is submitted. This patch
regresses advertising on these platforms, so I will look into a
different approach to solve this race condition.

Best,
Daniel Winkler


On Thu, Mar 25, 2021 at 10:27 AM Daniel Winkler
<danielwinkler@google.com> wrote:
>
> Hi all,
>
> It looks like my change breaks the expectations of one mgmt-tester
> test, which uses an Adv Enable (True) as a test condition. It is
> surprised to first see an Adv Enable (False) in the HCI traffic, and
> fails. I think my suggested approach here is the simplest and most
> robust to solve this race condition, so if the maintainers are happy
> with it, I can look into changing the test expectations to suit the
> new scenario. Please advise.
>
> Thanks in advance,
> Daniel
>
> On Wed, Mar 24, 2021 at 11:47 AM Daniel Winkler
> <danielwinkler@google.com> wrote:
> >
> > In __hci_req_enable_advertising, the HCI_LE_ADV hdev flag is temporarily
> > cleared to allow the random address to be set, which exposes a race
> > condition when an advertisement is configured immediately (<10ms) after
> > software rotation starts to refresh an advertisement.
> >
> > In normal operation, the HCI_LE_ADV flag is updated as follows:
> >
> > 1. adv_timeout_expire is called, HCI_LE_ADV gets cleared in
> >    __hci_req_enable_advertising, but hci_req configures an enable
> >    request
> > 2. hci_req is run, enable callback re-sets HCI_LE_ADV flag
> >
> > However, in this race condition, the following occurs:
> >
> > 1. adv_timeout_expire is called, HCI_LE_ADV gets cleared in
> >    __hci_req_enable_advertising, but hci_req configures an enable
> >    request
> > 2. add_advertising is called, which also calls
> >    __hci_req_enable_advertising. Because HCI_LE_ADV was cleared in Step
> >    1, no "disable" command is queued.
> > 3. hci_req for adv_timeout_expire is run, which enables advertising and
> >    re-sets HCI_LE_ADV
> > 4. hci_req for add_advertising is run, but because no "disable" command
> >    was queued, we try to set advertising parameters while advertising is
> >    active, causing a Command Disallowed error, failing the registration.
> >
> > To resolve the issue, this patch removes the check for the HCI_LE_ADV
> > flag, and always queues the "disable" request, since HCI_LE_ADV could be
> > very temporarily out-of-sync. According to the spec, there is no harm in
> > calling "disable" when advertising is not active.
> >
> > An example trace showing the HCI error in setting advertising parameters
> > is included below, with some notes annotating the states I mentioned
> > above:
> >
> > @ MGMT Command: Add Ext Adv.. (0x0055) plen 35  {0x0001} [hci0]04:05.884
> >         Instance: 3
> >         Advertising data length: 24
> >         16-bit Service UUIDs (complete): 2 entries
> >           Location and Navigation (0x1819)
> >           Phone Alert Status Service (0x180e)
> >         Company: not assigned (65283)
> >           Data: 3a3b3c3d3e
> >         Service Data (UUID 0x9993): 3132333435
> >         Scan response length: 0
> > @ MGMT Event: Advertising Ad.. (0x0023) plen 1  {0x0005} [hci0]04:05.885
> >         Instance: 3
> >
> > === adv_timeout_expire request starts running. This request was created
> > before our add advertising request
> > > HCI Event: Command Complete (0x0e) plen 4         #220 [hci0]04:05.993
> >       LE Set Advertising Data (0x08|0x0008) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Set Scan.. (0x08|0x0009) plen 32  #221 [hci0]04:05.993
> >         Length: 24
> >         Service Data (UUID 0xabcd): 161718191a1b1c1d1e1f2021222324252627
> > > HCI Event: Command Complete (0x0e) plen 4         #222 [hci0]04:05.995
> >       LE Set Scan Response Data (0x08|0x0009) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Set Adver.. (0x08|0x000a) plen 1  #223 [hci0]04:05.995
> >         Advertising: Disabled (0x00)
> > > HCI Event: Command Complete (0x0e) plen 4         #224 [hci0]04:05.997
> >       LE Set Advertise Enable (0x08|0x000a) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Set Adve.. (0x08|0x0006) plen 15  #225 [hci0]04:05.997
> >         Min advertising interval: 200.000 msec (0x0140)
> >         Max advertising interval: 200.000 msec (0x0140)
> >         Type: Connectable undirected - ADV_IND (0x00)
> >         Own address type: Public (0x00)
> >         Direct address type: Public (0x00)
> >         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
> >         Channel map: 37, 38, 39 (0x07)
> >         Filter policy: Allow Scan Request, Connect from Any (0x00)
> > > HCI Event: Command Complete (0x0e) plen 4         #226 [hci0]04:05.998
> >       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Set Adver.. (0x08|0x000a) plen 1  #227 [hci0]04:05.999
> >         Advertising: Enabled (0x01)
> > > HCI Event: Command Complete (0x0e) plen 4         #228 [hci0]04:06.000
> >       LE Set Advertise Enable (0x08|0x000a) ncmd 1
> >         Status: Success (0x00)
> >
> > === Our new add_advertising request starts running
> > < HCI Command: Read Local N.. (0x03|0x0014) plen 0  #229 [hci0]04:06.001
> > > HCI Event: Command Complete (0x0e) plen 252       #230 [hci0]04:06.005
> >       Read Local Name (0x03|0x0014) ncmd 1
> >         Status: Success (0x00)
> >         Name: Chromebook_FB3D
> >
> > === Although the controller is advertising, no disable command is sent
> > < HCI Command: LE Set Adve.. (0x08|0x0006) plen 15  #231 [hci0]04:06.005
> >         Min advertising interval: 200.000 msec (0x0140)
> >         Max advertising interval: 200.000 msec (0x0140)
> >         Type: Connectable undirected - ADV_IND (0x00)
> >         Own address type: Public (0x00)
> >         Direct address type: Public (0x00)
> >         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
> >         Channel map: 37, 38, 39 (0x07)
> >         Filter policy: Allow Scan Request, Connect from Any (0x00)
> > > HCI Event: Command Complete (0x0e) plen 4         #232 [hci0]04:06.005
> >       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
> >         Status: Command Disallowed (0x0c)
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Daniel Winkler <danielwinkler@google.com>
> > ---
> >
> > Changes in v2:
> > - Added btmon snippet showing HCI command failure
> >
> >  net/bluetooth/hci_request.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 8ace5d34b01efe..2b4b99f4cedf21 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1547,8 +1547,10 @@ void __hci_req_enable_advertising(struct hci_request *req)
> >         if (!is_advertising_allowed(hdev, connectable))
> >                 return;
> >
> > -       if (hci_dev_test_flag(hdev, HCI_LE_ADV))
> > -               __hci_req_disable_advertising(req);
> > +       /* Request that the controller stop advertising. This can be called
> > +        * whether or not there is an active advertisement.
> > +        */
> > +       __hci_req_disable_advertising(req);
> >
> >         /* Clear the HCI_LE_ADV bit temporarily so that the
> >          * hci_update_random_address knows that it's safe to go ahead
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >
