Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CECC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E835120772
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hymNKe98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCRRR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgFCRRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:17:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFEBC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:17:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v11so3297363ilh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRQkaDgCYr5WavUEwG9X+IXCuozP72lPlbUQBKEXUMg=;
        b=hymNKe98ls9MjwmBtrDlz2sJsKOEwDfP89MfthetzVwdMU/S/wIf33mLNHYkm1IGBI
         oACnNbJIJXZrnSXDR9EeIA1FWwX1EvqdO0mvMRmpl76e7KYPOECdwfA9gd29rzzbtMym
         pGiyfHyscnGjHfpQJNy2QGe02spqUd5FtgtRpKWhz7vT+cfXGBlblC+DXqJt5iN9Pwbv
         BNMykOr3atc8vhAY9p5VPtOzNYp0eiAb5oe52zBhZ1hPncWdkMuDzGEZksQUWbD+LGVt
         7tkqfdxbcM7AV2UW2EHd2NTxuwv+xTTozAahdPGfc1YQfkEXCBH6GyZRlQm+IsQ3yGiy
         MnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRQkaDgCYr5WavUEwG9X+IXCuozP72lPlbUQBKEXUMg=;
        b=kKJUoFAecMUFZjunMXPpmG4T+Qm68sq+9oE/2p3LAaeU5xNMiE3k9N7cXdh9epCaKB
         Kv6vhFAEfPYu/iVUFtDE1oMIRxgIQd2NjrXlBvPJ3c7CmSY+ymKbi+So69eUj1T/FgAn
         NBKmgud28mnst7gIftkIdcr8QBshrl7L5TffIphI53ndj+B0A/C7gOzbyCdP35WjhN6V
         NHsi1Wf/gh4MSakY1jOhBW+c6sn/IkCeVVEgtCXZKYT7gYy2q44B6WmcmyKlapaQ9D/K
         Qp82IEFgnDFTHv4fmo4ToFDqgwd4XfEFRHD8C7w+9Y2mtEkoGNoI+A2GZLcTyK+fHVR4
         5jRA==
X-Gm-Message-State: AOAM532cCSncJsIc7oVD/Inl0lUR2qwlac/K6dCaj1De+DNmcgAZuVPL
        favWK3F7MECAnooOTwJpvdK0OKl0u+QsMqg6bLU=
X-Google-Smtp-Source: ABdhPJyrclc0rEtKSTxpN40yyWBya4iODYpCamVyj/WRpdND+Y/JR0X3IzmuZ0Mae2GQVZBBZdpLi1xUsRHzoY6gEgY=
X-Received: by 2002:a92:ab04:: with SMTP id v4mr527114ilh.186.1591204634634;
 Wed, 03 Jun 2020 10:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205217.1002534-1-marcel@holtmann.org> <CANFp7mVSQEOyT7GrOa4NhAGozt5SMx3yU_ma6tav5bJ8GXJn8w@mail.gmail.com>
 <1FE78D4A-E6EC-440C-B76E-82F75D615D92@holtmann.org> <CAOVXEJ+rAJMbdqAU7mvpPbVjnZyPzMO0LhUOC6ZXOJbaZKn=rg@mail.gmail.com>
In-Reply-To: <CAOVXEJ+rAJMbdqAU7mvpPbVjnZyPzMO0LhUOC6ZXOJbaZKn=rg@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 3 Jun 2020 22:47:02 +0530
Message-ID: <CAOVXEJJwsZSXAqpns2dwgrRoWFD9XOpjNtWaeBFev7St7Sm+LA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Configure controller address resolution if available
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi marcel

On Tue, May 5, 2020 at 7:14 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi Marcel
>
> On Wed, Apr 8, 2020 at 11:46 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Abhishek,
> >
> > > This looks good to me.
> > >
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > however it is not enough, we also have to enable address resolution before calling LE Create Connection. It is actually a bit tricky to enable / disable address resolution correctly.
> When we receive directed_adv we disable the scan. which disables
> address_resolution.
> immediately I was trying to enable address resolution inside
> hci_req_add_le_create_conn
> @@ -813,6 +813,12 @@ static void hci_req_add_le_create_conn(struct
> hci_request *req,
>                         return;
>         }
>
> +       if (use_ll_privacy(hdev) &&
> +           !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
> +               __u8 enable = 0x01;
> +               hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> +       }
> +
>         if (use_ext_conn(hdev)) {
>                 struct hci_cp_le_ext_create_conn *cp;
>                 struct hci_cp_le_ext_conn_param *p;
> where this fails as the flag is not cleared yet.
> where the idea is to bool addr_resolv as below
> ->hci_req_add_le_scan_disable(req, addr_resolv)
> In which we can stop disabling addr_resolution and continue
> le_create_conn during hci_connect_le
Uploaded patch v2 please review

> >
> > Regards
> >
> > Marcel
> >
>
> Regards
> Sathish N

Regards
Sathish N
