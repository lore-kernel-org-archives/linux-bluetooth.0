Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9DCA90AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6292065C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W639ORXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbgEMOX1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbgEMOX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 10:23:27 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA156C061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 07:23:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u4so13779467lfm.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTkRQaRdMDvHHeWyoQWTj1/wF8v8INOq5fKOuHAuP40=;
        b=W639ORXhF6dLUrgqs64BIzz7FomrmD21VLVohVPIWRwgVekg6p4IK9bRFSQihp6Ovk
         uj0179csptRa/8A/g7XyMFPk5KKlsG1j7HWCYBYk3v1YUFkfZcBIZ2CMKTB59wYdPJDI
         x5cCFeMWO6RBIxL8GliYQMRiT0R0iJH8OThW6P6acYHuLHYFD+xCIg22kr8JzmwrMY+W
         6fC/+VUcli3uC2koIO3i0yTWBi0aT4aFhTPttgbiWHiUaUZcPBoXw0rjAY7QXh4Vp171
         +rz1bITUpNoDNMjc7eu0LF7qHclVG+MYql+6KatnnFXBAgdU1v6IiK9qqwGPcw1rsIY7
         Qv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTkRQaRdMDvHHeWyoQWTj1/wF8v8INOq5fKOuHAuP40=;
        b=c/sUwc3iuLn2eeOFlbRRh3BXaRyAmalajvGvNQew4IZ33z0SpsJHo86mZVmENIXJ4I
         yTFo9mQ7TqGseR9W2k3DNimXrXy0iz7ISHwaqZrIV1RKylKi3bAFoqwEckgY9fa2lq49
         VXO5bJrSSnS9AdqGrE4VY8UynNM8AfZcxkT0e50sAkvQBHrGArzFkV7HBHMmJzbr4cCz
         zKU8Tol8iQ2+xIHeqVj2XP4Zk4j9WAr5I/QNBtE+BIQovcBEexeKq0fg/58G9HYdLb9C
         Kj7oHQtk1oD1my+TihRjncakCgsyiovNwy3Hgmx8zL7mCnyZZ6JCzsOFuOl124B05Csi
         4pbQ==
X-Gm-Message-State: AOAM530YhCYS8U41JlKGgtsjIuZWb04ui2p+DuAun9U0urSOprnwHmrs
        iD/F6BZSdHQmoXQWEdxu/ELi0OrKjQaLXLDRQNz3ew==
X-Google-Smtp-Source: ABdhPJyJzHDpDDQX8bot3hDBjPLXeYl0pN+bLVLojsl7C5efd9JGmTCByAyRL3TI+oIR5qM/plZJ2QHsCW8l2nwvVJc=
X-Received: by 2002:ac2:5496:: with SMTP id t22mr18383488lfk.0.1589379804786;
 Wed, 13 May 2020 07:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200504142625.213143-1-alainm@chromium.org> <7610937E-424D-4968-B8D9-378E44773088@holtmann.org>
 <CALWDO_UPC5UnbEigTBz0Go-mtyXqCm8GNTyew+M4Eu-P2s-Dyw@mail.gmail.com> <4EAD51F7-D123-4489-9327-1B5E9CC52DF8@holtmann.org>
In-Reply-To: <4EAD51F7-D123-4489-9327-1B5E9CC52DF8@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 13 May 2020 10:23:12 -0400
Message-ID: <CALWDO_W=S9nF=vcH75kY8sXHKLYp5Zgwhqr-q_kYajWARdYTgA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc:adding definitions for load default params
 mgmt op
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 13, 2020 at 3:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> >>> This change adds the definition for the load default parameter command.
> >>> In particular, this command is used to load default parameters for
> >>> various operations in the kernel. This mechanism is also expandable to
> >>> future knobs that may be necessary.
> >>>
> >>> This will allow bluetoothd to load parameters from a conf file that may
> >>> be customized for the specific requirements of each platforms.
> >>>
> >>> ---
> >>>
> >>> doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>> 1 file changed, 59 insertions(+)
> >>>
> >>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> >>> index 39f23c456..71d528706 100644
> >>> --- a/doc/mgmt-api.txt
> >>> +++ b/doc/mgmt-api.txt
> >>> @@ -3137,6 +3137,65 @@ Read Security Information Command
> >>>      Possible errors:        Invalid Parameters
> >>>                              Invalid Index
> >>>
> >>> +Load Default Parameter Command
> >>> +=============================
> >>
> >> I think that Load Controller Default Parameters is a better name.
> > I wanted to avoid using "controller" in the name as some of these are
> > not really "controller" parameters but instead just general
> > parameters.
>
> fair enough. Now the question is if we might want to split between controller defaults and host defaults.
>
> >>> +
> >>> +     Command Code:           0x0049
> >>> +     Controller Index:       <controller id>
> >>> +     Command Parameters:     Parameter_Count (2 Octets)
> >>> +                             Parameter1 {
> >>> +                                     Parameter_Type (2 Octet)
> >>> +                                     Value_Length (1 Octet)
> >>> +                                     Value (0-255 Octets)
> >>> +                             }
> >>> +                             Parameter2 { }
> >>> +                             ...
> >>> +     Return Parameters:
> >>> +
> >>> +     This command is used to feed the kernel a list of default parameters.
> >>> +
> >>> +     Currently defined Parameter_Type values are:
> >>> +
> >>> +                     0x0000  BR/EDR Page Scan Type
> >>> +                     0x0001  BR/EDR Page Scan Interval
> >>> +                     0x0002  BR/EDR Page Scan Window
> >>> +                     0x0003  BR/EDR Inquiry Scan Type
> >>> +                     0x0004  BR/EDR Inquiry Scan Interval
> >>> +                     0x0005  BR/EDR Inquiry Scan Window
> >>> +                     0x0006  BR/EDR Link Supervision Timeout
> >>> +                     0x0007  BR/EDR Page Timeout
> >>> +                     0x0008  BR/EDR Min Sniff Interval
> >>> +                     0x0009  BR/EDR Max Sniff Interval
> >>> +                     0x0080  LE Advertisement Min Interval
> >>> +                     0x0081  LE Advertisement Max Interval
> >>> +                     0x0082  LE Multi Advertisement Rotation Interval
> >>> +                     0x0083  LE Scanning Interval for auto connect
> >>> +                     0x0084  LE Scanning Window for auto connect
> >>> +                     0x0085  LE Scanning Interval for HID only
> >>> +                     0x0086  LE Scanning Window for HID only
> >>> +                     0x0087  LE Scanning Interval for wake scenarios
> >>> +                     0x0088  LE Scanning Window for wake scenarios
> >>> +                     0x0089  LE Scanning Interval for discovery
> >>> +                     0x008a  LE Scanning Window for discovery
> >>> +                     0x008b  LE Scanning Interval for adv monitoring
> >>> +                     0x008c  LE Scanning Window for adv monitoring
> >>> +                     0x008d  LE Scanning Interval for connect
> >>> +                     0x008e  LE Scanning Window for connect
> >>> +                     0x008f  LE Min Connection Interval
> >>> +                     0x0090  LE Max Connection Interval
> >>> +                     0x0091  LE Connection Connection Latency
> >>> +                     0x0092  LE Connection Supervision Timeout
> >>
> >> I would just enumerate these and not try to split between 0x000 and 0x008 for BR/EDR and LE. Also I would just start with a few values that we currently want to change.
> > The goal was to try to keep BR and LE parameters together, but if you
> > prefer, I don't mind collapsing them.  Note that we intend to use all
> > of these, so I'd prefer not break this into a smaller subset.
>
> My OCD wants to do that as well, but my experience has been that this never actually works out. And we will have parameters that apply to both transports. Like for example the minimum encryption key size.
>
> >>> +
> >>> +     This command can be used any time, but will not take effect until the
> >>> +     next activity requiring the parameters.  In the case the parameters are
> >>> +     used during initialization of the adapter, it is expected that the
> >>> +     parameters be set before the adapter is powered.
> >>
> >> Hmmm. This one, I might want to limit this controllers powered down. Otherwise you get into the conflict case that we would expect parameters taking affect and I think that is just too complicated.
> > Things like connection intervals and scan defaults actually apply the
> > next time the activity is started.  We need to be able to change these
> > without completely powering down the controller and tearing down all
> > connections etc.  Things that are obviously only used during
> > initialization, then I would expect they would require a power cycles.
>
> Now we might actually better split this into a command for system default parameters and one for runtime default parameters. I think it would make the code a lot simpler since we can have clear error codes. Thoughts?

That's a good idea.  Any recommendation on naming for the runtime
ones?  I guess it would also need to carry the name "update" of some
sort.
>
>
> Regards
>
> Marcel
>
