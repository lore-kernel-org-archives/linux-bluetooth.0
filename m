Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74FDC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E33420731
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CH/N4hN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGVVn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVVm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 17:21:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C5DC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 14:21:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f11so7976379ljp.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=saUw1xZOVnaFYj9ZmUI+Z5XRbhgX9YzQ6aunpD7v5rw=;
        b=CH/N4hN549/Z+UpYQUsXu/kN6Loo8xOD3SlwBl9fLHm/tmATghKEZzKfOPWVjaURJV
         LLQnn3hIXKlg+kU9pnssfeTiBTW+S4IwcM9IOQ79FS1VGsqW6Fd5pIdDyb9d/gDE+RPS
         /O/tfvi+yyiEcr/hXCBcyCjCVv2LFy0euVt7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=saUw1xZOVnaFYj9ZmUI+Z5XRbhgX9YzQ6aunpD7v5rw=;
        b=jksv37TdxLDQ3ztpF/bMyphV7ejJECS2q84dhcs8Zjoi3I29tL6o19sY+3vtyLhA1M
         WF8RGl7HB5PV1jQd6MywD5UI2sIyCGpwedH2WlYUOyTCjhh1NPbq2V0YMB+glepxjeiM
         nX9UZeMs/nwggv46dFlYhp6PytdmhcLl5rA45ppeEi4KkiLUc52oMs0GoZeM2nocUkQx
         ffg50OdoGyd+wscbZ5yuUWF2PBFeQo7bbesOnoXe3N+x6RTWWBUhCw3OqzgFUhEkcftx
         RuvD3x4HgXdHzWaO4E/DkSWj1cXo+vDWUW8LpZjGGTUsdUf8aiK2yDL+Hyoa4l/y0/Ur
         L8FQ==
X-Gm-Message-State: AGi0PuZGPLaB/rvm9iukEdL3AJGU4TD2YEe6HUNtl1qvwkRIVN1tmfc3
        Dv/hzDsjynDSfcSkps8urY1RMl1fVDhIw65PqZlqjg==
X-Google-Smtp-Source: APiQypJ/cYjC75C1PFbl/Kkfom+mfI1zwZdWFxv3TC36Z1FC4LfCcPhIdb5Cfc3EJ05uVqwp+sWeRQ+eiJdXfJNV8XU=
X-Received: by 2002:a2e:5746:: with SMTP id r6mr9396453ljd.15.1588886500657;
 Thu, 07 May 2020 14:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200429203031.BlueZ.v5.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
 <6FD8666C-39AD-4D41-9BBF-7E1371FDFFA6@holtmann.org>
In-Reply-To: <6FD8666C-39AD-4D41-9BBF-7E1371FDFFA6@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 7 May 2020 14:21:29 -0700
Message-ID: <CABmPvSF_HVxDJPh7hdFtDAK4HTH-EYkYGwtCaaFLuQzpBB+R=g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5] doc: Describe the new Advertisement Monitor support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yoni Shavit <yshavit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 6, 2020 at 4:05 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This describes the following commands and event.
> > - Read Advertisement Monitor Features command
> > - Add Advertisement Patterns Monitor command
> > - Remove Advertisement Monitor command
> > - Advertisement Monitor Added event
> > - Advertisement Monitor Removed event
> > Note that the content of a monitor can differ based on its type. For no=
w we
> > introduce only pattern-based monitor, so you may find that unlike the
> > command of removing monitor(s), the Add command is tied to a specific t=
ype.
> > ---
> >
> > Changes in v5:
> > - Add more fields in the return value of Read Advertisement Monitor
> > Features command.
> > - Refine the description of commands and events.
> >
> > Changes in v4:
> > - In Read Advertisement Monitor Features command, rename
> > Adopted_Features to Enabled_Features.
> >
> > Changes in v3:
> > - Remove Advertisement Monitor can perform the removal of one monitor
> > or all monitors.
> > - Add Read Advertisement Monitor Features command.
> > - Add Advertisement Monitor Added event and dvertisement Monitor Remove=
d
> > event.
> >
> > Changes in v2:
> > - Combine commands to remove one monitor and remove all monitors. The
> > refined command takes multiple handles and an extra field to indicate
> > whether to remove all monitors.
> >
> > doc/mgmt-api.txt | 147 +++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 147 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 39f23c456..4aa755c45 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3138,6 +3138,125 @@ Read Security Information Command
> >                               Invalid Index
> >
> >
> > +Read Advertisement Monitor Features Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x0049
> > +     Controller Index:       <controller id>
> > +     Command Parameters:
> > +     Return Parameters:      Supported_Features (4 octets)
> > +                             Enabled_Features (4 octets)
> > +                             Max_Num_Handles (2 octets)
> > +                             Max_Num_Patterns (1 octet)
> > +                             Num_Handles (2 octets)
> > +                             Handle1 (2 octets)
> > +                             Handle2 (2 octets)
> > +                             ...
>
>                                 Handle[i] (2 Octets)
>
> And we have been using Octet(s) and not octet(s). The document should be =
pretty much consistent with its style. If you see mistakes, please send pat=
ches to correct it.
I will correct these in v6.
>
> > +
> > +     This command is used to read the advertisement monitor features
> > +     supported by the controller and stack. Supported_Features lists a=
ll
> > +     related features supported by the controller while Enabled_Featur=
es
> > +     lists the ones currently used by the kernel.
> > +
> > +     Supported_Features and Enabled_Features are bitmasks with current=
ly
> > +     the following available bits:
> > +
> > +             1       Advertisement content monitoring based on Microso=
ft
> > +                     HCI extension.
>
> Advertising content monitoring based on pattern. Lets leave Microsoft out=
 of it.
Ack.
>
> > +
> > +     Max_Num_Handles indicates the maximum number of supported
> > +     advertisement monitors. Note that the actual number of supported
> > +     ones might be less depending on the limitation of the controller.
> > +
> > +     Max_Num_Pattern indicates the maximum number of supported pattern=
s
> > +     in an advertisement patterns monitor. Note that the actual number
> > +     of supported ones might be less depending on the limitation of th=
e
> > +     controller.
> > +
> > +     Num_Handles indicates the number of added advertisement monitors,
> > +     and it is followed by a list of handles.
> > +
> > +     This command can be used when the controller is not powered.
> > +
> > +
> > +Add Advertisement Patterns Monitor Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x004A
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Pattern_count (1 Octets)
>
> Pattern_Count please.
>
> > +                             Pattern1 {
> > +                                     AD_Data_Type (1 Octet)
>
> Just call it Type and explain in the description that it is the AD Type.
>
> > +                                     Offset (1 Octet)
> > +                                     Length (1 Octet)
> > +                                     Value (variable length)
>
> We normally give a range and not =E2=80=9Cvariable length=E2=80=9D. I won=
der if we should just use a fixed size field here.
Sounds good to me.
>
> > +                             }
> > +                             Pattern2 { }
> > +                             ...
> > +     Return Parameters:      Monitor_Handle (2 Octets)
> > +
> > +     This command is used to add an advertisement monitor whose
> > +     filtering conditions are patterns. The kernel will trigger scanni=
ng
> > +     if there is at least one monitor added. If the controller support=
s
> > +     advertisement filtering, the kernel would offload the content
> > +     filtering to the controller in order to reduce power consumption;
> > +     otherwise the kernel ignores the content of the monitor. Note tha=
t
> > +     if the there are more than one patterns, OR logic would applied
> > +     among patterns during filtering. In other words, any advertisemen=
t
> > +     matching at least one pattern in a given monitor would be
> > +     considered as a match.
> > +
> > +     A pattern contains the following fields.
> > +             AD_Data_Type    Advertising Data Type. The possible value=
s
> > +                             are defined in Core Specification
> > +                             Supplement.
> > +             Offset          The start index where pattern matching
> > +                             shall be performed with in the AD data.
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
> > +     This command can be used when the controller is not powered and
> > +     all settings will be programmed once powered.
> > +
> > +     Possible errors:        Failed
> > +                             Busy
> > +                             No Resources
> > +                             Invalid Parameters
> > +
> > +
> > +Remove Advertisement Monitor Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x004B
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Monitor_Handle (2 Octets)
> > +     Return Parameters:
>
> Include Monitor_Handle in the return value. The events are not send to th=
e caller and so the caller somehow needs to be able to map that response if=
 they have to.
>
I will add it in v6.
> > +
> > +     This command is used to remove advertisement monitor(s). The kern=
el
> > +     would remove the monitor(s) with Monitor_Handle and update the LE
> > +     scanning.
> > +
> > +     When the Monitor_Handle is set to zero, then all previously added
> > +     handles will be removed.
> > +
> > +     Removing a monitor while it is being added will be ignored.
> > +
> > +     This command can be used when the controller is not powered and
> > +     all settings will be programmed once powered.
> > +
> > +     Possible errors:        Failed
> > +                             Busy
> > +                             Invalid Index
> > +
> > +
> > Command Complete Event
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -4020,3 +4139,31 @@ PHY Configuration Changed Event
> >       one through which the change was triggered.
> >
> >       Refer Get PHY Configuration command for PHYs parameter.
> > +
> > +
> > +Advertisement Monitor Added Event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Event Code:             0x0027
> > +     Controller Index:       <controller id>
> > +     Event Parameters:       Monitor_Handle (2 Octets)
> > +
> > +     This event indicates that an advertisement monitor has been added
> > +     using the Add Advertisement Monitor command.
> > +
> > +     The event will only be sent to management sockets other than the
> > +     one through which the command was sent.
> > +
> > +
> > +Advertisement Monitor Removed Event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Event Code:             0x0028
> > +     Controller Index:       <controller id>
> > +     Event Parameters:       Monitor_Handle (2 Octets)
> > +
> > +     This event indicates that an advertisement monitor has been remov=
ed
> > +     using the Remove Advertisement Monitor command.
> > +
> > +     The event will only be sent to management sockets other than the
> > +     one through which the command was sent.

Thanks,
Miao
