Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE48C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 07:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFA32074B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 07:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3r4Q0IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDUHPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbgDUHPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 03:15:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7AEC061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 00:15:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w20so6562434ljj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2lV2zVviFx429eDDhLhQTtJt5drYidx2JsoYO3FjeU=;
        b=W3r4Q0INrLwOSbkoxj8LTTvdDuLbz+S4gfP23cTWYZhhRghNkw1atZ09jfebq3pyq4
         FDVc/4Xtua712bzWyEykIFvzxPNdXRXzYuk/4QE74piiy0BP+6hRXDcgTiwDsTCXwyUV
         3xetlljqfIpdus9HQjWo7nCrjOHfCB37xORrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2lV2zVviFx429eDDhLhQTtJt5drYidx2JsoYO3FjeU=;
        b=dyrnKXnjPNomkFj5/p+EIyfO/ZTdJEjGnQyaDAPFELHMEvUXmu0jQEiL/8O1MqbO+J
         GhVgqBwOhIEeu4kxXOqYyP00E9hl8sHwWjypTuwP18VkZ8U/UEmCqhxy4ECUL16u1Zhc
         kRtKwGaf2BukXDEseA4GGxOg01oMxWqGJsDAdQEj0I9vNdUKZi9wpie/6z4qmA6OAJ/S
         8tGzzLDCMORPO8IP3PGcgRQkp9sBroF+HQPVfy/G1UYj282g3g3ZcZ9MRm9F+RtBVNdb
         62sRNSSZCG0oFJ29ZPJoNUnpbWXnQcrmjrzHvS590NEQAz8hbPZZNUn0ZSyDZa27xbSO
         i7kg==
X-Gm-Message-State: AGi0PuauBip70dLYKH8lF/truLn2NZmjNoVPmLJoq+XSDbBwKbuLM6CB
        4tS7iRibbucYknLVRwdNnYclYRUhVkWwdYECp5w5x5Wu
X-Google-Smtp-Source: APiQypKRI9k0cl+idqlmCzxSL64jTZS85Y3t6U+Jfp4M+kWBb17qghTBYr3Dm3cdd/nuo6tIzvXI457aW+jG1xex/3o=
X-Received: by 2002:a2e:a37b:: with SMTP id i27mr11594870ljn.36.1587453351642;
 Tue, 21 Apr 2020 00:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200417200903.BlueZ.v1.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
 <CABBYNZ+tSNta-MjYQh51k8jExcS+vi1TqqA0cWQAxqSHd9GJkw@mail.gmail.com>
In-Reply-To: <CABBYNZ+tSNta-MjYQh51k8jExcS+vi1TqqA0cWQAxqSHd9GJkw@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 21 Apr 2020 00:15:40 -0700
Message-ID: <CABmPvSHTGsWEWxG6BHS0197_XFGsbRt4VzMS+ow=qd_6SYvhDg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc: Describe the new Advertisement Monitor support
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Apr 20, 2020 at 3:53 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Fri, Apr 17, 2020 at 8:13 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This describes the following commands.
> > - Add Advertisement Patterns Monitor
> > - Remove Advertisement Monitor
> > - Remove All Advertisement Monitors
> > Note that the content of a monitor can differ based on its type. For now we
> > introduce only pattern-based monitor, so you may find that unlike commands
> > for removing monitor(s), the Add command is tied to a specific type.
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
>
> For userspace we don't require signed-of-by line.
Ack, it was added by patman tool, I will remove it before sending.
>
> > ---
> >
> >  doc/mgmt-api.txt | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 39f23c456..fcd281a35 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3138,6 +3138,74 @@ Read Security Information Command
> >                                 Invalid Index
> >
> >
> > +Add Advertisement Patterns Monitor Command
> > +=========================================
> > +
> > +       Command Code:           0x0049
> > +       Controller Index:       <controller id>
> > +       Command Parameters:     Pattern_count (1 Octets)
> > +                               Pattern1 {
> > +                                       AD_Data_Type (1 Octet)
> > +                                       Index (1 Octet)
>
> What is this index for, it is not very clear why would we need it here
> since we are going to return a index already.
This is the starting position of the given pattern. For instance, if
we'd like to look for the pattern within a Manufacturer Data field
with value {0x01, 0x02, 0x03} starting from index 2. Given the
Manufacturer Data field is {0x00, 0xFF, 0x01, 0x02, 0x03, 0x04}, the
matching would start from octet 0x01, and the result would be a match.
Perhaps I should rename "Index" to "Start_Position" or rename
"Monitor_index" to "Monitor_handle" to avoid confusion.
>
> > +                                       Length (1 Octet)
> > +                                       Value (variable length)
> > +                               }
> > +                               Pattern2 { }
> > +                               ...
> > +       Return Parameters:      Monitor_Index (8 Octets)
>
> I guess we could call this a handle if the is assigned by the
> controller not the host stack, also it might be more a good idea to
> put some example on how to build the parameter list, etc, to make it
> easier to visualize how these parameters are put together.
"Monitor_Handle" sounds good to me. I will add some examples.
>
> > +
> > +       This command is used to add an advertisement monitor whose filtering
> > +       conditions are patterns. The kernel would track the number of registered
> > +       monitors to determine whether to perform LE scanning while there is
> > +       ongoing LE scanning for other intentions, such as auto-reconnection and
> > +       discovery session. If the controller supports Microsoft HCI extension,
> > +       the kernel would offload the content filtering to the controller in
> > +       order to reduce power consumption; otherwise the kernel ignore the
> > +       content of the monitor.
> > +
> > +       Possible errors:        Failed
> > +                               Busy
> > +                               Invalid Parameters
> > +
> > +
> > +Remove Advertisement Monitor Command
> > +====================================
> > +
> > +       Command Code:           0x004A
> > +       Controller Index:       <controller id>
> > +       Command Parameters:     Monitor_Index (8 Octets)
> > +       Return Parameters:      Monitor_Index (8 Octets)
> > +
> > +       This command is used to remove an advertisement monitor. The kernel
> > +       would remove the monitor with Monitor_Index and update the LE scanning.
> > +       If the controller supports Microsoft HCI extension and the monitor has
> > +       been offloaded, the kernel would cancel the offloading; otherwise the
> > +       kernel takes no further actions other than removing it from the list.
> > +
> > +       Possible errors:        Failed
> > +                               Busy
> > +                               Invalid Index
> > +
> > +
> > +Remove All Advertisement Monitors Command
> > +=========================================
> > +
> > +       Command Code:           0x004B
> > +       Controller Index:       <controller id>
> > +       Command Parameters:
> > +       Return Parameters:      Num_removed_Monitors (2 Octets)
> > +                               Monitor_Index[i] (2 Octets)
> > +
> > +       This command is used to remove all advertisement monitors. The kernel
> > +       would remove all monitors and update the LE scanning if needed. If the
> > +       controller supports Microsoft HCI extension the monitors have been
> > +       offloaded, the kernel would cancel all offloadings; otherwise the kernel
> > +       takes no further actions other than removing all monitors from the list.
> > +
> > +       Possible errors:        Failed
> > +                               Busy
>
> I wonder if we could keep this simple and just have a special value
> passed to Remove that would be consider remove all e.g.
> 0x0000000000000000, that way we don't have to allocate yet another
> opcode for removing all, though Im not sure how the values are managed
> in that namespace so it may not be possible allocate one for use with
> remote all logic, the other option would be to have a num_monitors and
> then in case none is provided do the remove all, that actually might
> be useful since if there are multiple application/monitors we can
> remove all monitors from one application without afting the others
> leaving remove all logic just for when bluetoothd is restarted which
> is basically a cleanup.
The intention of this command is indeed to handle the restart of
bluetoothd. It's a good point that we may want to remove all monitors
of an application. Let me try to combine remove and remove all
commands in my next patch.

Thanks,
Miao
