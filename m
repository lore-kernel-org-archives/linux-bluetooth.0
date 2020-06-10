Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A343C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7602C206F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LI/TbrwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgFJPyo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJPyo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 11:54:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4717C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:54:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so3091581ljh.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lq65p9kbuWSvMtp12vSeNxMnKQTqu+Z2+3De+NXPmJg=;
        b=LI/TbrwWXLnh147oME3dCksxn58CLDAWNGKNRXWbGEzGdp0bp05ZNfgsaBRYReud5U
         2y8jzK5rtW29nLNTNeTj9ly2Ab8t/1BPEH82dR0FGXcg1dLqJ0ab4Gr5w7gCAxCPmICB
         SqRNxwsC6ZJyDPj5/4sMJJ4oOuTV+E8hJOwRTIo4ncz8LyHzcQvUK1qaliBkMcTAKxL/
         6ugPGhjNP5B5mt+WjeYaComkUGCIo4bzC0spcl94lTjGuzV2m4/CTBNT/oRWOKEhNC7H
         wcN74sRwLkeYAg0Jaoi+7GRG1xJibqkN8PJautOYfDciYIj3d2gRTLyYbJiUBBYifb2E
         oRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lq65p9kbuWSvMtp12vSeNxMnKQTqu+Z2+3De+NXPmJg=;
        b=Ru9+ZWWo4PoKW6G4UxJWctXe7ncOkrGZPMkwBvQghk/jCfGCCYQrh8roqPj4FB9XS/
         0FalE3Jfv6uF+6PLzGRVpHkFVunZw4OZYts/8jzAjA0iTUS1eEnzNspklds7UesarUeL
         Og2dE32uofij5WvK+Z3E7H32JYA6/Pd0iZn8lNQv9lyEl/M9WGCdAE5w6WA8TbYBhtyk
         HQjtdJ7WIReEnY+Qv8MKRtGtqYWBDbge3JfH/vVPH+NIel0AlOBx4GWAVsvggBl5NgFv
         AdwFGe5heNa9h2/JDH0yDYIi78VYib8/4QY0nd2gquRjGdPVRFyzEisRrzWs/27fBr6G
         +Mlw==
X-Gm-Message-State: AOAM530iU60ifhM5CsQHz+6N2S4rWk6rJbC29PZXeb0XqhZ7RZ7A6QFc
        94PmGNP7H4xXdD77uDrjuUSUTBM5xyblHZhp8WF67Q==
X-Google-Smtp-Source: ABdhPJy5v+fLkxdRRMaGXEb4734uOX0B9N7DfAfthsgh6UBe2D3+lb6vw7akMlnecFr+Q6V/Tk91mZAcPcQkI7r0kAc=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr2165239ljj.3.1591804480928;
 Wed, 10 Jun 2020 08:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200609140351.153833-1-alainm@chromium.org> <20200609140351.153833-2-alainm@chromium.org>
 <F728221B-1F3D-421C-9164-BF6D3C9F6A41@holtmann.org>
In-Reply-To: <F728221B-1F3D-421C-9164-BF6D3C9F6A41@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 10 Jun 2020 11:54:29 -0400
Message-ID: <CALWDO_W4vnn-X-YYJ1AjvYMgoK+aDqY3gxKZOWqMw5x0C0y1Cg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mgmt: read/set system parameter definitions
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Since this has already been committed in user space, could we agree to
keep it as is?  The alternative is that we'd need to re-patch all the
userspace implementation through a seperate patch.  Up to you.

I won't have time to implement the runtime config ones in the next few
weeks, feel free to post it separately, or I can get to it in July.

Thanks,
Alain

On Wed, Jun 10, 2020 at 10:16 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This patch submits the corresponding kernel definitions to mgmt.h.
> > This is submitted before the implementation to avoid any conflicts in
> > values allocations.
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Yu Liu <yudiliu@google.com>
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > include/net/bluetooth/mgmt.h | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> >
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> > index 16e0d87bd8fa..1081e371f03d 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -702,6 +702,24 @@ struct mgmt_rp_set_exp_feature {
> >       __le32 flags;
> > } __packed;
> >
> > +#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS       0x004b
> > +
>
> I would go for MGMT_OP_READ_DEF_SYSTEM_CONFIG or MGMT_OP_READ_DEFAULT_SYSTEM_CONFIG to match the name in the mgmt-api.txt more closely.
>
> > +struct mgmt_system_parameter_tlv {
> > +     __u16 type;
> > +     __u8  length;
> > +     __u8  value[];
> > +} __packed;
> > +
>
> Can we just introduce a generic mgmt_tlv {} struct. I think we could use it more broadly. However I wonder if we need it actually since have the EIR parsing support. Maybe just extend that one.
>
> > +struct mgmt_rp_read_default_system_parameters {
> > +     __u8 parameters[0]; /* mgmt_system_parameter_tlv */
> > +} __packed;
> > +
> > +#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS        0x004c
>
> Similar to the comment above.
>
> > +
> > +struct mgmt_cp_set_default_system_parameters {
> > +     __u8 parameters[0]; /* mgmt_system_parameter_tlv */
> > +} __packed;
> > +
> > #define MGMT_EV_CMD_COMPLETE          0x0001
> > struct mgmt_ev_cmd_complete {
> >       __le16  opcode;
>
> If you have a chance, please also add MGMT_OP_{READ,SET}_DEF_RUNTIME_CONFIG as well. If not, then I am going to send out a patch for that by myself.
>
> Regards
>
> Marcel
>
