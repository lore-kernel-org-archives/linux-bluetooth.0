Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1962FCCA485
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiGUWlM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiGUWlK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 18:41:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13178589
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 15:41:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bp17so5049978lfb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5C4cxe+SIKwFqqDzcnUQnDBoYOsEdyQ06UoX6upJT20=;
        b=NP3VvhI8UbXY0390Hym9wzA1VoCG2qOz+KByR+9v/jWD6Cs8d05T2w6QwyAHj0psCg
         38Ts3bn61k8CRefFsXcRgpSeRIiLx2H8OBb7bPVLGyl6KEO1Im+ESVXWrCSGAKwv52NW
         JlaIGV0+nNqz2mfkYTdudtyenBfz3e9W0V6MpAHyCbVSUlwjzBDSUh/xqHU5xsWdJoq/
         79+9icSZo7hh2S16tgta1ziYRQgm8rGFigaYjBTZ16aHwoejxFMyvO2FZcVJHUh1bsMF
         VmunKsuwy7TiQKN8Ihup/KGzVWspKSsQFIFwpB2q6A6qkGmyTrBybOnx2AjVU/sc3jcr
         HyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C4cxe+SIKwFqqDzcnUQnDBoYOsEdyQ06UoX6upJT20=;
        b=UWhEe9Wbdo6n+9AUiqC6xtk1khTCI6eNOavCzvvx6Y8oYAInzBxW1ljDd0E93XOEJs
         wwCocgjTVDmMjuCisDq/YxM76I7Fl/hZ9+C+T5FwkaEk72cPjHYtqYs6USKH22+SIjjb
         rZfF1gVgqTqL60ONrf6akPkUmiFma+O7ez1MtiHHRV62HrXbpJob0p1mYdxc4qxAVIDw
         Zdh78aJhpbu06OXbBiCF95Fqf7At6B3+sHQspYiyt6PFOEuqc3q7lPw2aCr7Jx8ECXFO
         aU5mkFQq2lBeD0GpXFwsa6MIKfRQMfYDYOMljubRisk5I2/+/KtsI6joP1qv2JFG0Eqo
         nSCg==
X-Gm-Message-State: AJIora+J6UtMSroWgu0dWejTV/JHCNaIKPEB1Mm8REEjzmbC9NajRhZI
        ERGa5d30gDI38JhLN+5rFqMa1ejkfaJnzzvJotu7kmac3GXXNg==
X-Google-Smtp-Source: AGRyM1uHvnCGGs6K3OXGbzSEi2qdMP+pjuxSiAYNoTIRnQTC18s6YhUGyzwQaWHmfGR6tacACEuc9gM9k881txyAx4E=
X-Received: by 2002:a19:5f4d:0:b0:48a:7001:dbf8 with SMTP id
 a13-20020a195f4d000000b0048a7001dbf8mr188314lfj.251.1658443268148; Thu, 21
 Jul 2022 15:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220720233601.3648471-1-jiangzp@google.com> <20220720163548.kernel.v1.1.I4058a198aa4979ee74a219fe6e315fad1184d78d@changeid>
 <CABBYNZ+ao6r4ZHaVNGRe-Wp6077R2xmkYufOK7tN=B8rEJL1yg@mail.gmail.com>
In-Reply-To: <CABBYNZ+ao6r4ZHaVNGRe-Wp6077R2xmkYufOK7tN=B8rEJL1yg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jul 2022 15:40:56 -0700
Message-ID: <CABBYNZKhB82i12981ediTXgtOoepE9OjwK0UJQFY2wyDELKUbg@mail.gmail.com>
Subject: Re: [kernel PATCH v1 1/1] Bluetooth: Fix get clock info
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Thu, Jul 21, 2022 at 3:20 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Zhengping,
>
> On Wed, Jul 20, 2022 at 4:36 PM Zhengping Jiang <jiangzp@google.com> wrote:
> >
> > If connection exists, set the connection data before calling
> > get_clock_info_sync, so it can be verified the connection is still
> > connected, before retrieving clock info.
> >
> > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > ---
> >
> > Changes in v1:
> > - Fix input connection data
> >
> >  net/bluetooth/mgmt.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index ef8371975c4eb..947d700574c54 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -6971,11 +6971,16 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
> >         }
> >
> >         cmd = mgmt_pending_new(sk, MGMT_OP_GET_CLOCK_INFO, hdev, data, len);
> > -       if (!cmd)
> > +       if (!cmd) {
> >                 err = -ENOMEM;
> > -       else
> > +       } else {
> > +               if (conn) {
> > +                       hci_conn_hold(conn);
> > +                       cmd->user_data = hci_conn_get(conn);
> > +               }
> >                 err = hci_cmd_sync_queue(hdev, get_clock_info_sync, cmd,
> >                                          get_clock_info_complete);
> > +       }
>
> Having seconds though if this is actually the right thing to do,
> hci_cmd_sync_queue will queue the command so get_clock_info_sync
> shouldn't execute immediately if that happens that actually would be
> quite a problem since we are holding the hci_dev_lock so if the
> callback executes and blocks waiting a command that would likely cause
> a deadlock because no command can be completed while hci_dev_lock is
> being held, in fact I don't really like the idea of holding hci_conn
> reference either since we are doing a lookup by address on
> get_clock_info_sync Id probably just remove this code as it seem
> unnecessary.
>
> Btw, there are tests for this command in mgmt-tester so if this is
> actually attempting to fix a problem Id like to have a test to
> reproduce it.

Looks at the other change you submitted that has a similar code
pattern I did the following change:

https://gist.github.com/Vudentz/91cd57373d5b0116e2c34b6fb6adaa07

And mgmt-tester seems to run just fine with these changes.

>
> >         if (err < 0) {
> >                 err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
> > @@ -6984,12 +6989,8 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
> >                 if (cmd)
> >                         mgmt_pending_free(cmd);
> >
> > -       } else if (conn) {
> > -               hci_conn_hold(conn);
> > -               cmd->user_data = hci_conn_get(conn);
> >         }
> >
> > -
> >  unlock:
> >         hci_dev_unlock(hdev);
> >         return err;
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
