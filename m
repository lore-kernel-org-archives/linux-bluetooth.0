Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB356C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 17:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DBA60E97
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 17:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhHLRbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhHLRbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 13:31:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59394C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 10:31:19 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c5so175946ybn.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2toyRmefsbj+1mEzDHLJG0NnopBql6wtFGACDkeACU=;
        b=HpvOb+UsZEhGWC8oVsdjUO2+dnQ0Im0nRdZ8hshocirXecMdehQ7oivIHgLkwXqA0k
         722R4pfMapYWLxnSbQ8XvjjHkW1KKhbAcvKqGA/diAnX8uZRlqDDgSrVCYVyQ9WRKFW0
         x02Jf5/Yy2sYYF/C2u3Fsy9Ey6IMXtxlnNYIPqsrRgdkbCf5YswZbAfONpx9PpGJ2gqK
         KoqXF1uQ+ghTMktoPbV0YWM9xLbr0hytFZWidASEEcMG3l2hd4Zi3xLFI4TR7fS7b5C/
         A9Bpa2Ww9Ow/TW5I0ik0uev1ZhKy5FZFX8L89KuaZqIJ2892mQ2tn8w/miYVZHHBFZ1A
         0q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2toyRmefsbj+1mEzDHLJG0NnopBql6wtFGACDkeACU=;
        b=hjx9bczA2Th9E7xt0AgteaSI/KqJd2GwMX1+NMOZNSYrsgw04ktSl5+ImMsZOeMpef
         w40S5C3j0vMNLxGQi3ZR7G9cvQBnoh74VR5WfX4EdZAUPqGIJ0OedXfuxOPnxuoxRtYG
         BQaX4NbT00VVYq0z3+6HJZir123JZF5Ba/TU9TF3eea/ARccpRvTGomfpp7eRSK2OgUh
         4PdQqRlmLY1M7fGrwQRUSt6N2U17ulfoe25OVrEkgfxZ3oUlwWjjgjoYtE8zghGrg63L
         pK4xlZ2b4+y0YsTwIuUiLvmeQIc7wfLLoUEXOf6YIN8BuuZPzsxf2Hmw44130S0gaDMi
         BOtw==
X-Gm-Message-State: AOAM5306tZG0+cINjnhbxsoMT6uYG/HKCZoSJQnTa2G5cF+nHohfrwe6
        qkhtfmRiBxuPR6mLAX3ABsGytF1nomV9i9Ujo/XNF4Eg
X-Google-Smtp-Source: ABdhPJwQ58J2+7khaSZHV0HCG4oM3MfVDj6YBWbRy0QMATZgIgZ4lWLRHcJJnwlQ2WBAGvpErP0IqDWUmZqBibGXlaQ=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr5879882ybg.347.1628789478513;
 Thu, 12 Aug 2021 10:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210804173939.25496-1-kiran.k@intel.com> <CB7F6AB9-E997-4C77-B19D-D018F8044001@holtmann.org>
 <DM8PR11MB55738B15758672E2982D748AF5F39@DM8PR11MB5573.namprd11.prod.outlook.com>
 <DM8PR11MB55733AD00D7FB779732063B4F5F99@DM8PR11MB5573.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB55733AD00D7FB779732063B4F5F99@DM8PR11MB5573.namprd11.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 12 Aug 2021 10:31:07 -0700
Message-ID: <CABBYNZJNruwiLRZSsTzeSZzL4O2u-zpUCAOc=JgAPk0H3UHUUg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
To:     "K, Kiran" <kiran.k@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Thu, Aug 12, 2021 at 3:58 AM K, Kiran <kiran.k@intel.com> wrote:
>
> Hi Marcel,
>
> > -----Original Message-----
> > From: K, Kiran
> > Sent: Friday, August 6, 2021 8:14 PM
> > To: 'Marcel Holtmann' <marcel@holtmann.org>
> > Cc: BlueZ <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> > <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> > <chethan.tumkur.narayan@intel.com>
> > Subject: RE: [PATCH v1] Bluetooth: Fix race condition in handling NOP
> > command
> >
> > Hi Marcel,
> >
> > > -----Original Message-----
> > > From: Marcel Holtmann <marcel@holtmann.org>
> > > Sent: Thursday, August 5, 2021 6:41 PM
> > > To: K, Kiran <kiran.k@intel.com>
> > > Cc: BlueZ <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> > > <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> > > <chethan.tumkur.narayan@intel.com>
> > > Subject: Re: [PATCH v1] Bluetooth: Fix race condition in handling NOP
> > > command
> > >
> > > Hi Kiran,
> > >
> > > > For NOP command, need to cancel work scheduled on cmd_timer, on
> > > > receiving command status or commmand complete event.
> > > >
> > > > Below use case might lead to race condition multiple when NOP
> > > > commands are queued sequentially:
> > > >
> > > > hci_cmd_work() {
> > > >   if (atomic_read(&hdev->cmd_cnt) {
> > > >            .
> > > >            .
> > > >            .
> > > >      atomic_dec(&hdev->cmd_cnt);
> > > >      hci_send_frame(hdev,...);
> > > >      schedule_delayed_work(&hdev->cmd_timer,...);
> > > >   }
> > > > }
> > > >
> > > > On receiving event for first NOP, the work scheduled on
> > > > hdev->cmd_timer is not cancelled and  second NOP is dequeued and
> > > > hdev->sent
> > > to controller.
> > > >
> > > > While waiting for an event for second NOP command, work scheduled on
> > > > cmd_timer for first NOP can get scheduled, resulting in sending
> > > > third NOP command not waiting for an event for second NOP. This
> > > > might cause issues at controller side (like memory overrun,
> > > > controller going
> > > > unresponsive) resulting in hci tx timeouts, hardware errors etc.
> > > >
> > > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > > > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > > > ---
> > > > net/bluetooth/hci_event.c | 3 +--
> > > > 1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index ea7fc09478be..14dfbdc8b81b 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -3271,8 +3271,7 @@ static void hci_remote_features_evt(struct
> > > > hci_dev *hdev, static inline void handle_cmd_cnt_and_timer(struct
> > > > hci_dev
> > > *hdev,
> > > >                                       u16 opcode, u8 ncmd)
> > > > {
> > > > - if (opcode != HCI_OP_NOP)
> > > > -         cancel_delayed_work(&hdev->cmd_timer);
> > > > + cancel_delayed_work(&hdev->cmd_timer);
> > > >
> > > >   if (!test_bit(HCI_RESET, &hdev->flags)) {
> > > >           if (ncmd) {
> > >
> > > so this is conflicting with the patch introducing the ncmd timeout handling.
> > >
> > My patch specifically addresses the issue observed in case of NOP command.
> > It prevents the issue by handling NOP same as any other SIG command.
> >
> > It looks commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4 tries to
> > recover when controller goes bad.
> >
>
> Do you have any further comments here ? Waiting for your input.
>
> > > commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4
> > > Author: Manish Mandlik <mmandlik@google.com>
> > > Date:   Thu Apr 29 10:24:22 2021 -0700
> > >
> > >     Bluetooth: Add ncmd=0 recovery handling
> > >
> > >     During command status or command complete event, the controller
> > > may set
> > >     ncmd=0 indicating that it is not accepting any more commands. In such a
> > >     case, host holds off sending any more commands to the controller. If the
> > >     controller doesn't recover from such condition, host will wait forever,
> > >     until the user decides that the Bluetooth is broken and may power cycles
> > >     the Bluetooth.
> > >
> > >     This patch triggers the hardware error to reset the controller and
> > >     driver when it gets into such state as there is no other wat out.
> > >
> > > Nowhere in your commit description you are addressing why is this the
> > > right to do.
> > >
> >
> > Will fix it in the next version if you are OK with the current fix. Please let me
> > know.

Can you confirm this change doesn't break your patch above?

> >
> > > Regards
> > >
> > > Marcel
> >
> > Thanks,
> > Kiran
>
> Thanks,
> Kiran
>
>


-- 
Luiz Augusto von Dentz
