Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1AC55185
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 01:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9927C2077D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 01:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFy/YlED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDWBK5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWBK4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 21:10:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E4C03C1AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 18:10:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u15so4478264ljd.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUpx0pxfKT46eDyDZVOMdYrRNsc+UyGpu6MN5tmEiGE=;
        b=oFy/YlEDr+cm6/gIR+ysNIsdkxQ906+WyQX5MIHunJ/+C415aaOfjcvy4k+XnK1SZC
         mO0LG4hgnwFCwD0EV6YddJTF3tdn6Ap8UE7hdht0DFyL9HnZcB8OUflXa0ewWzfGndnE
         gvpktxaEkRimzmGHKYfoSmRRW3pDGOT0Ie0qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUpx0pxfKT46eDyDZVOMdYrRNsc+UyGpu6MN5tmEiGE=;
        b=NPGJ7gn2xZ/G//rn9KYug2DJnKhy/3LXXYx5tmwCdZ8rDvPV/sZX6bWCvtfU+JiKKt
         Y/VIE/w/lWXOCaVzAOP+IYYCWYSySpOpLs4oM2Q7ZzzAPlnMACPNWZWLMpuhQJQXuanU
         0bHhvHYUx4DlO93Q8HdNCXfH9SxnKjwWPQn1JqUWbRGayw++oLzwK4mlXCJAGVhGbGTU
         LuxSMnYOJkQeFUpKkZ/G8Ane3WCJOZ3FnegzSG0Vou8YxJVmTdkplfUu+x0zecIXBRn6
         Kyor/pTDHARCxisbH9gT+rGSvS9h14fnYlixU/AV6ilxl5DBr/Ux7p0Q0XfcQyDMUKv+
         OwAA==
X-Gm-Message-State: AGi0PuYqKlEspU+siiErMcfOatuRSyCBi0ZusabxTxDRNxtMh1ClIzEI
        9406UOYPFjUpCugBMS15HvT9T4f2IeWyI9sPN4VeIQ==
X-Google-Smtp-Source: APiQypJfUiG1EBdPtvCtd/hpZTrCBUNjEVAeoegG4bhTVrtyGCDiMnvFS68mxdvhR6QcEwrU8yqiQZ84W6OdJEOOe0o=
X-Received: by 2002:a2e:a37b:: with SMTP id i27mr832212ljn.36.1587604252835;
 Wed, 22 Apr 2020 18:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200421180155.BlueZ.v2.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
 <C6C04FC6-4D51-45CB-BB85-94660F6B93E5@holtmann.org>
In-Reply-To: <C6C04FC6-4D51-45CB-BB85-94660F6B93E5@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 22 Apr 2020 18:10:41 -0700
Message-ID: <CABmPvSEdcAa-s+P=phqaYzAvdvvQ_qZ+RPWRsFBXta9-ZOwbJw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] doc: Describe the new Advertisement Monitor support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Apr 22, 2020 at 10:33 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This describes the following commands.
> > - Add Advertisement Patterns Monitor
> > - Remove Advertisement Monitors
> > Note that the content of a monitor can differ based on its type. For now we
> > introduce only pattern-based monitor, so you may find that unlike the
> > command of removing monitor(s), the Add command is tied to a specific type.
> > ---
> >
> > Changes in v2:
> > - Combine commands to remove one monitor and remove all monitors. The
> > refined command takes multiple handles and an extra field to indicate
> > whether to remove all monitors.
> >
> > doc/mgmt-api.txt | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 83 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 39f23c456..d5d402361 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3138,6 +3138,89 @@ Read Security Information Command
> >                               Invalid Index
> >
> >
> > +Add Advertisement Patterns Monitor Command
> > +=========================================
>
> I wonder if we do Add Advertisement Monitor Pattern or Add Advertisement Monitor With Pattern.
>
> > +
> > +     Command Code:           0x0049
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Pattern_count (1 Octets)
> > +                             Pattern1 {
> > +                                     AD_Data_Type (1 Octet)
> > +                                     Offset (1 Octet)
> > +                                     Length (1 Octet)
> > +                                     Value (variable length)
> > +                             }
> > +                             Pattern2 { }
> > +                             ...
> > +     Return Parameters:      Monitor_Handle (8 Octets)
>
> Why 8 Octets? How many do you expect? I would do 16-bit.
My thought was that the number of monitor slots may not be fixed for
different extensions, so the idea was to have one-time handles which
will not be reused once a monitor was removed. If reusing the slots is
a preferable approach, given that Android and Microsoft extensions use
uint8 for indexing filters, we can use either uint16 or uint32 as the
index. I will put uint16 for now.
>
> > +
> > +     This command is used to add an advertisement monitor whose filtering
> > +     conditions are patterns. The kernel would track the number of registered
> > +     monitors to determine whether to perform LE scanning while there is
> > +     ongoing LE scanning for other intentions, such as auto-reconnection and
> > +     discovery session. If the controller supports Microsoft HCI extension,
> > +     the kernel would offload the content filtering to the controller in
> > +     order to reduce power consumption; otherwise the kernel ignore the
> > +     content of the monitor. Note that if the there are more than one
> > +     patterns, OR logic would applied among patterns during filtering. In
> > +     other words, any advertisement matching at least one pattern in a given
> > +     monitor would be considered as a match.
> > +
> > +     A pattern contain the following fields.
> > +             AD_Data_Type    Advertising Data Type. The possible values are
> > +                             defined in Core Specification Supplement.
> > +             Offset          The start index where pattern matching shall be
> > +                             performed with in the AD data.
> > +             Length          The length of the pattern value in bytes.
> > +             Value           The value of the pattern in bytes.
> > +
> > +     Here is an example of a pattern.
> > +             {
> > +                     0x16, // Service Data - 16-bit UUID
> > +                     0x02, // Skip the UUID part.
> > +                     0x04,
> > +                     {0x11, 0x22, 0x33, 0x44},
> > +             }
> > +
> > +     Possible errors:        Failed
> > +                             Busy
> > +                             Invalid Parameters
> > +
> > +
> > +Remove Advertisement Monitors Command
> > +=====================================
>
> I would have a generic Remove Adveristement Monitor.  As requested, I will combine the remove and remove all operations by reserving 0 as a hint for removing all.
>
> > +
> > +     Command Code:           0x004A
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Remove_All (1 Octet)
>
> Skip the Remove_All. If you give Monitor_Count == 0, then it will remove all of them. This is how we have done the others.
>
> > +                             Monitor_Count (2 Octets)
> > +                             Monitor_Handle[i] (8 Octets)
> > +     Return Parameters:      Removed_Monitor_Count (2 Octets)
> > +                             Removed_Monitor_Handle[i] (8 Octets)
>
> Return values are not needed here.
>
> > +
> > +     This command is used to remove advertisement monitor(s). The kernel
> > +     would remove the monitor(s) with Monitor_Index and update the LE
> > +     scanning. If the controller supports Microsoft HCI extension and the
> > +     monitor(s) has been offloaded, the kernel would cancel the offloading;
> > +     otherwise the kernel takes no further actions other than removing the
> > +     monitor(s) from the list.
> > +
> > +     Remove_All can be the following values.
> > +             Value           Operation
> > +             -------------------------
> > +             0x00            Removes only the monitors with handles specified
> > +                             in Monitor_Handle[i], so there must be at least
> > +                             one handle.
> > +             0x01            Removes all existing monitor(s), so
> > +                             Monitor_Count must be 0, and Monitor_Handle
> > +                             must be empty.
> > +
> > +     Possible errors:        Failed
> > +                             Busy
> > +                             Invalid Index
> > +                             Invalid Parameters
> > +
> > +
> > Command Complete Event
> > ======================
>
> You are missing signals for Monitor Added and Monitor Removed.
Nice catch. I will add them in v3.
>
> And we are also missing a command for reading the basic supported features. Like we do for Advertising as well.
There was a comment made in the past discussion where we can introduce
a new setting(s) in the returned supported_settings of
MGMT_OP_READ_INFO command to indicate the features such as
MGMT_SETTING_HW_FILTERING . But given that there can be multiple
extensions, it may be preferable to have a separate command which
should be extendable.

Thanks,
Miao
