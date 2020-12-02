Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C7C6369E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9834206F9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 23:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLBXZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgLBXZy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 18:25:54 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B80C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 15:25:13 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id g20so674681ejb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDGD7H8j9OtIJQe2B6BsMocW2lGnqD8boMCvyT7by5U=;
        b=BDTU1QfuTXzH1oLBAb7DHJnBKIfUKB546XzlzfMCNFY/HdMCCOzpzR5AYBw4ID9pe3
         H1zoauzo7MZROrlN+Av4zWwi6L0zEsnQZxxK3WWWr/9chSs+avjZ5KJ7s5bsTaCofL1p
         w5d67x+laHyYXaSkN04W3sYlkOgUA9mwxD4e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDGD7H8j9OtIJQe2B6BsMocW2lGnqD8boMCvyT7by5U=;
        b=k251dPNgXSVMjFAJBZddL9Fpq/PiYyrKFh052rZLyM2/0RS7jTjSJMl2TPZYr5XDJa
         W81FuG8V2o7TPDXjrq1F+bFkzrpoHQZIVWSPbI8eXuvDkbKyhkHrsXMLXuIImHTuE6HZ
         WboIyMIsqDrZ953DdbvpoXZtZ7oCrP4rlVj6eGe7VO8sSGxFDRx25IBRtUYR7uTxna7f
         Gy98dpfDoJJFgZjgEw7d1fovdujrcwqKBhztd4gQzjAE4bJissv9WljzpJLMgA6noXod
         1b1UP8fma9mKbUAHTpQzwI+sk97VAK/sIRL959lS5OHJ9/u3CRAsxZbHvE3uovYYVQNq
         Ks5w==
X-Gm-Message-State: AOAM533/wON9JIRQzXIkPq8UPyZ5zdBtDJPWADoPlkj7UojZ7E/mx5Km
        myfNj4X4lthWPjIg2SwXWWU3EKkcVP6+BQ==
X-Google-Smtp-Source: ABdhPJxNZocX/6dJbH6wzUC1Yb77TMTyr+lJ+FNawL8xCQd8wCR9bdgjjJv4qiZ4vFdqDjsIIBVYWA==
X-Received: by 2002:a17:906:ec9:: with SMTP id u9mr142239eji.400.1606951511898;
        Wed, 02 Dec 2020 15:25:11 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id d22sm72918eja.72.2020.12.02.15.25.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 15:25:10 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id v14so862007wml.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 15:25:10 -0800 (PST)
X-Received: by 2002:a1c:bdc1:: with SMTP id n184mr261026wmf.125.1606951510013;
 Wed, 02 Dec 2020 15:25:10 -0800 (PST)
MIME-Version: 1.0
References: <20201124010906.340433-1-sonnysasaka@chromium.org>
 <92C0EFAB-EDF1-4EDB-ADE7-FF734928C8AE@holtmann.org> <CAO271m=geLEUjtPhFETfqsYTsxDQoe+=c3WeYPbDuNjwc+4idA@mail.gmail.com>
In-Reply-To: <CAO271m=geLEUjtPhFETfqsYTsxDQoe+=c3WeYPbDuNjwc+4idA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 2 Dec 2020 15:24:58 -0800
X-Gmail-Original-Message-ID: <CAO271m=E1=+JYzYmOugMGGxByTs+k-EhuCLwsoc6n67mEhpbmg@mail.gmail.com>
Message-ID: <CAO271m=E1=+JYzYmOugMGGxByTs+k-EhuCLwsoc6n67mEhpbmg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Cancel Inquiry before Create Connection
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Friendly ping on this patch. Thanks.

On Wed, Nov 25, 2020 at 4:00 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Marcel,
>
>
> On Wed, Nov 25, 2020 at 6:43 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Sonny,
> >
> > > Many controllers do not allow HCI Create Connection while it is doing
> > > Inquiry. This patch adds Inquiry Cancel before Create Connection in this
> > > case to allow the controller to do Create Connection. User space will be
> > > aware of this Inquiry cancellation and they may issue another discovery
> > > request afterwards.
> > >
> > > Sample Command Disallowed response of HCI Create Connection:
> > > < HCI Command: Inquiry (0x01|0x0001) plen 5
> > >        Access code: 0x9e8b33 (General Inquiry)
> > >        Length: 10.24s (0x08)
> > >        Num responses: 0
> > >> HCI Event: Command Status (0x0f) plen 4
> > >      Inquiry (0x01|0x0001) ncmd 2
> > >        Status: Success (0x00)
> > > < HCI Command: Create Connection (0x01|0x0005) plen 13
> > >        Address: XX:XX:XX:XX:XX:XX
> > >        Packet type: 0xcc18
> > >        Page scan repetition mode: R2 (0x02)
> > >        Page scan mode: Mandatory (0x00)
> > >        Clock offset: 0x0000
> > >        Role switch: Allow slave (0x01)
> > >> HCI Event: Command Status (0x0f) plen 4
> > >      Create Connection (0x01|0x0005) ncmd 1
> > >        Status: Success (0x00)
> > >> HCI Event: Connect Complete (0x03) plen 11
> > >        Status: Command Disallowed (0x0c)
> > >        Handle: 65535
> > >        Address: XX:XX:XX:XX:XX:XX
> > >        Link type: ACL (0x01)
> > >        Encryption: Disabled (0x00)
> > >
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > >
> > > ---
> > > net/bluetooth/hci_conn.c | 11 +++++++++++
> > > 1 file changed, 11 insertions(+)
> > >
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index 4f1cd8063e720..b41ad08f8d411 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -233,6 +233,17 @@ static void hci_acl_create_connection(struct hci_conn *conn)
> > >       else
> > >               cp.role_switch = 0x00;
> > >
> > > +     /* Many controllers disallow HCI Create Connection while it is doing
> > > +      * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
> > > +      * Connection. This may cause the MGMT discovering state to become false
> > > +      * without user space's request but it is okay since the MGMT Discovery
> > > +      * APIs do not promise that discovery should be done forever. Instead,
> > > +      * the user space monitors the status of MGMT discovering and it may
> > > +      * request for discovery again when this flag becomes false.
> > > +      */
> > > +     if (test_bit(HCI_INQUIRY, &hdev->flags))
> > > +             hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> > > +
> >
> > while this seems acceptable, what happens when we have interleaved discovery where we toggle between BR/EDR inquiry and LE scanning. Are you sure we not better cancel the mgmt discovery completely.
> Only Inquiry is preventing Create Connection, so we don't need to
> overcomplicate it by stopping the mgmt discovery completely. In the
> case of interleaved discovery, the LE discovery will linger for a
> little bit before eventually being disabled and the situation restarts
> at a good state. Not perfect but simple, clean, and fixes the issue.
>
> >
> > Regards
> >
> > Marcel
> >
