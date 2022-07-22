Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9052C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiGVSZK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiGVSZJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 14:25:09 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37162235
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:25:05 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id w22so2151228uau.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vU+Bqfjo11RM8x8DZvLAsq6rgXc7xY0MqjAnVs4ra+A=;
        b=Qch6JxXpBVBc9a5l42d7o46lUVYCb8yjmtI75RofIFTIr+5sXJ464PNZLisufGzml9
         Ja+WbJvYAaWcOTOH0gYzvemH2k3w7xzxioRq+tjNsZXJWtMPrNdQV5m2QaU7EF9djt2C
         Nn6LreQ4hV8ymTJcqYBTCKH/aU1QhZIg/uqXjo+YTdtyuo1CAnAVDmgyMrL92PoOeNfp
         7hOXLPiQxHWIvJKvyBczUiSFRFyYvM6Ak4kuvF2X+WnpqAMF0W1hQHnbaHooz8sFUu6e
         18flrqFLhl4hFXfO+3Jx9FCFqNjGZ588i6vIg0ESRB0PNC4ALULLOHNwcNKx/8DYQHCK
         JEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vU+Bqfjo11RM8x8DZvLAsq6rgXc7xY0MqjAnVs4ra+A=;
        b=fefDlhjOmDXdbax6gOdUSIhF/7wsFVG1UnxduVT22UcQm0yGVtsvzAJGmqW7q3MdU7
         opC0TFzO1OepQ1iPcfRkCcsg7G5fpuS2rCCXEQ71GJpPp8VNOI9YNV1zH749EkLGu1xt
         imSuwjx7P0uSijrVwguQiV3FBCDz4n9dMQmfO2z58X0mhMMXlHcBm3On6NBLnfUfnUUX
         KiKYsbMINAxE0OYVzf/W6ygXkQciIADlyhJ7vee3LKXDYk2ioiz+8k/MCRmwPor9b6pE
         EEE8iMwSp7qjSfxh9znWjtRfhUA1DK/AD2gn88WKDrNmtldLVXJzHZT2EViPh6yLD2cu
         QnIQ==
X-Gm-Message-State: AJIora/mU9WFYarvjnXif3MSY1Qir5wivrlZbU6oZkOAXSUtWCZF2R+6
        CWjIkzeYSXHha9kT7aPkbhFGkqzn818AjZMHi595qw==
X-Google-Smtp-Source: AGRyM1ultCmD+q1Wi5c/cCad3sr2X0k6rIiiTCepqju76Q0ZELGLpH0ksyFZSm0sbI6ezl1nZ5DOBXkYUC07hPz4xAU=
X-Received: by 2002:ab0:56c2:0:b0:374:67bd:fe1 with SMTP id
 c2-20020ab056c2000000b0037467bd0fe1mr516515uab.10.1658514304212; Fri, 22 Jul
 2022 11:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220720233601.3648471-1-jiangzp@google.com> <20220720163548.kernel.v1.1.I4058a198aa4979ee74a219fe6e315fad1184d78d@changeid>
 <CABBYNZ+ao6r4ZHaVNGRe-Wp6077R2xmkYufOK7tN=B8rEJL1yg@mail.gmail.com> <CABBYNZKhB82i12981ediTXgtOoepE9OjwK0UJQFY2wyDELKUbg@mail.gmail.com>
In-Reply-To: <CABBYNZKhB82i12981ediTXgtOoepE9OjwK0UJQFY2wyDELKUbg@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Fri, 22 Jul 2022 11:24:50 -0700
Message-ID: <CAB4PzUo5q9BdSYTYGn1zAMy5BpUSwUp36MrxKXWHk8=S_vos0Q@mail.gmail.com>
Subject: Re: [kernel PATCH v1 1/1] Bluetooth: Fix get clock info
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the rework. This patch looks good. The function to get
connection info was causing test regression in some hardware
platforms, but not always. We don't currently have a test for getting
clock info here. I was submitting the patch because it is using the
same pattern as getting conn info.
I tested the new patch and it is working well, so we can abandon my patch.

Best,
Zhengping

On Thu, Jul 21, 2022 at 3:41 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Zhengping,
>
> On Thu, Jul 21, 2022 at 3:20 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Zhengping,
> >
> > On Wed, Jul 20, 2022 at 4:36 PM Zhengping Jiang <jiangzp@google.com> wrote:
> > >
> > > If connection exists, set the connection data before calling
> > > get_clock_info_sync, so it can be verified the connection is still
> > > connected, before retrieving clock info.
> > >
> > > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > > ---
> > >
> > > Changes in v1:
> > > - Fix input connection data
> > >
> > >  net/bluetooth/mgmt.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > > index ef8371975c4eb..947d700574c54 100644
> > > --- a/net/bluetooth/mgmt.c
> > > +++ b/net/bluetooth/mgmt.c
> > > @@ -6971,11 +6971,16 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
> > >         }
> > >
> > >         cmd = mgmt_pending_new(sk, MGMT_OP_GET_CLOCK_INFO, hdev, data, len);
> > > -       if (!cmd)
> > > +       if (!cmd) {
> > >                 err = -ENOMEM;
> > > -       else
> > > +       } else {
> > > +               if (conn) {
> > > +                       hci_conn_hold(conn);
> > > +                       cmd->user_data = hci_conn_get(conn);
> > > +               }
> > >                 err = hci_cmd_sync_queue(hdev, get_clock_info_sync, cmd,
> > >                                          get_clock_info_complete);
> > > +       }
> >
> > Having seconds though if this is actually the right thing to do,
> > hci_cmd_sync_queue will queue the command so get_clock_info_sync
> > shouldn't execute immediately if that happens that actually would be
> > quite a problem since we are holding the hci_dev_lock so if the
> > callback executes and blocks waiting a command that would likely cause
> > a deadlock because no command can be completed while hci_dev_lock is
> > being held, in fact I don't really like the idea of holding hci_conn
> > reference either since we are doing a lookup by address on
> > get_clock_info_sync Id probably just remove this code as it seem
> > unnecessary.
> >
> > Btw, there are tests for this command in mgmt-tester so if this is
> > actually attempting to fix a problem Id like to have a test to
> > reproduce it.
>
> Looks at the other change you submitted that has a similar code
> pattern I did the following change:
>
> https://gist.github.com/Vudentz/91cd57373d5b0116e2c34b6fb6adaa07
>
> And mgmt-tester seems to run just fine with these changes.
>
> >
> > >         if (err < 0) {
> > >                 err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
> > > @@ -6984,12 +6989,8 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
> > >                 if (cmd)
> > >                         mgmt_pending_free(cmd);
> > >
> > > -       } else if (conn) {
> > > -               hci_conn_hold(conn);
> > > -               cmd->user_data = hci_conn_get(conn);
> > >         }
> > >
> > > -
> > >  unlock:
> > >         hci_dev_unlock(hdev);
> > >         return err;
> > > --
> > > 2.37.0.170.g444d1eabd0-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
