Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2064DC47247
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12102073B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gimnspfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEENoe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728912AbgEENoe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 09:44:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA212C061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 06:44:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w11so1399433iov.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2020 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nx5Dsj+fjg1uB6ZpgPoWcwXG6hef6r/91ODJ1zBIyPg=;
        b=Gimnspfs1oOoIfFZPpYpWBGbIjWcVzgB44dLn9FalAqUE77GqJEpxZUx4DtAgi/5wj
         Pug9GJnI/WTRtHa9q8FYhxl+pFt47botasjQ6isUEylqK9sl2++rmrK74kpSs9GZ2fso
         SV43UEba8s+UqzCcYRepi+M5KlWZ67Q7/xTS6H8mlsamB9IDIsPt8duCNtbp6X9f/qVL
         UJEZl5O7eHNGUXnnIC5vFCygQwVtm8PwZdWwskBvTgfwDpKIFtt12wg7izoEAv1QNbMm
         1VR/3IAtYCcbzLhwOhUW4bDL/cp0r2yR9NPf2nZpfZqCLDewSg43ghaaOt+SJkZfCTew
         H5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx5Dsj+fjg1uB6ZpgPoWcwXG6hef6r/91ODJ1zBIyPg=;
        b=NnmGbykg7f/EvuIRPeWnP9MULwiRkANbl7v6Kp4fhxG+T0M2YbuPdA+FaKWchXR1jo
         /rdakwuNsWtIYEl2bdrhEYDDOvJ/lExMm9IxjyC7FHCvwofW92s3KX9fCrRMUAklj3ti
         ldiXdx1IzqsuJ2mws8lhwCy2Qc/D4UZoo9mIX3/P7VHPO/+FAcrU7kZpsz4Wm9IlBkH9
         nL7W2cZS+EAuoY5SI+WD/iYN1Q1i9sShhfJS/qjCaQvpdEf2pZMECKBqK1V2nbp8VYzR
         wkoMfGx6Ks+RA+2NuW2cTKBBMiWq6L/rmX2KQq+uump1NLoG2ZpssBbFVErgVm8mDcgq
         i78g==
X-Gm-Message-State: AGi0PuZoMWPiXIon/v9nqr0q12wQX0nzq7gBEsdgfkdfqGcZ7ey051IB
        EAT1I/VRVVGnmOuMXUmQ/+Z4wFkrGh/pat7q4gw=
X-Google-Smtp-Source: APiQypIPWN7qVvJLtA2TZyL9V8OTk3QkNiWU4PPYmjs75wucg3z88y+FLlz796KAYafsz2OVC6Nlm0zImJDj7Xt3llo=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr3389325ion.1.1588686273227;
 Tue, 05 May 2020 06:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205217.1002534-1-marcel@holtmann.org> <CANFp7mVSQEOyT7GrOa4NhAGozt5SMx3yU_ma6tav5bJ8GXJn8w@mail.gmail.com>
 <1FE78D4A-E6EC-440C-B76E-82F75D615D92@holtmann.org>
In-Reply-To: <1FE78D4A-E6EC-440C-B76E-82F75D615D92@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Tue, 5 May 2020 19:14:21 +0530
Message-ID: <CAOVXEJ+rAJMbdqAU7mvpPbVjnZyPzMO0LhUOC6ZXOJbaZKn=rg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Configure controller address resolution if available
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Wed, Apr 8, 2020 at 11:46 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > This looks good to me.
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> however it is not enough, we also have to enable address resolution before calling LE Create Connection. It is actually a bit tricky to enable / disable address resolution correctly.
When we receive directed_adv we disable the scan. which disables
address_resolution.
immediately I was trying to enable address resolution inside
hci_req_add_le_create_conn
@@ -813,6 +813,12 @@ static void hci_req_add_le_create_conn(struct
hci_request *req,
                        return;
        }

+       if (use_ll_privacy(hdev) &&
+           !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+               __u8 enable = 0x01;
+               hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+       }
+
        if (use_ext_conn(hdev)) {
                struct hci_cp_le_ext_create_conn *cp;
                struct hci_cp_le_ext_conn_param *p;
where this fails as the flag is not cleared yet.
where the idea is to bool addr_resolv as below
->hci_req_add_le_scan_disable(req, addr_resolv)
In which we can stop disabling addr_resolution and continue
le_create_conn during hci_connect_le
>
> Regards
>
> Marcel
>

Regards
Sathish N
