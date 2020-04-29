Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4AC8300C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 21:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF2D21927
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 21:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhHodV2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgD2V6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728156AbgD2V6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 17:58:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168EC03C1AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 14:58:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so3038669lff.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rej7ZomZW+j2nHSfwLYGe+bqrTGM3hd6ZYlHVxlWTjw=;
        b=PhHodV2JUqa7pnp3rCqAYqRJNPgfqw2xUfcWb9ivTq+zG0n6c0RZgfqYWNuHElg/Ol
         egYJnfF0IgMO1BFqRnpiIKk/KeguJktNx7EiS2Pz1f5a6pjvLtUqmtvUyXzkidF7VT+L
         kVL7P8z8AApx0JxuoQ8NqEnUqPue0q4A40Crw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rej7ZomZW+j2nHSfwLYGe+bqrTGM3hd6ZYlHVxlWTjw=;
        b=Pi8dE65J77m3hHlHw1XH8FRhD5MZtx5w6mAB13kE0G4NlMdPKsvDPdT666GWn2DWCp
         1S4MgyGFjpOgETiTSw5GyoKQzpER6qxWtXKlir7yX5ILyRuQ9Xy0PRJrHGKNTMQn2vv4
         q0hroCBBAbpTl16mx3bcGOlS8ywa4uH/JqPfchDdd0eUUtLkFftxXxxSOw9NMVCFPzsZ
         dorjT7mb3uujbzTjBRZ4fWAQOQTwvNyP6s7tnjrITJpTgPA5vBALKFKPFsJxQGz7AAzc
         5bF5o7K8wgyNNPr3lX9ZZCqlFSjDyYO/NS1wqRlvrT7rV1U9R+IUiZY3r0fmpcnWD0BS
         5rZw==
X-Gm-Message-State: AGi0PubNmfyzCW9WYFkaTEfvkAWfMszumujpSGv0aCoXRLGeH4KU8WvZ
        fIskPbd38V2Lp5go5zfWyqDMGecWyiQr48+X+0ZZXQVcnHs=
X-Google-Smtp-Source: APiQypK8FF1ly4hwDnuMLG/RCPT6k6BZadWieQTxc0q0W6gfTaLNL9p2WcQQhsPtJiT9vF6a3sTjxFTL6KMcOMwS9Nk=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr23442695lfm.144.1588197526905;
 Wed, 29 Apr 2020 14:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200428154221.BlueZ.v4.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
 <771FD3FA-5BB5-4D52-9649-3E548D0E8D83@holtmann.org>
In-Reply-To: <771FD3FA-5BB5-4D52-9649-3E548D0E8D83@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 29 Apr 2020 14:58:35 -0700
Message-ID: <CABmPvSFvgSYqcwsZb8Gck9807=Sif5CDKtefeBBuQYUE-nFiXw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4] doc: Describe the new Advertisement Monitor support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Apr 29, 2020 at 1:07 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
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
> > doc/mgmt-api.txt | 118 +++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 118 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 39f23c456..e3a115c02 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3138,6 +3138,102 @@ Read Security Information Command
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
> > +
> > +     This command is used to read the advertisement monitor features s=
upported
> > +     by the controller and stack. Supported_Features lists all related
> > +     features supported by the controller while Enabled_Features lists=
 the
> > +     ones currently used by the stack.
>
> hmmm. The enabled portion you need to explain a bit more. I don=E2=80=99t=
 see the need for it right now.
In the case where we allow bluetoothd to configure the use of
controller-based features, Enabled_Features can reflect the ones being
used. For instance, if we find a serious regression with
controller-based features, we can opt-in to disable the use of certain
features (a new command would be needed in this case.), and this would
reflect the use of controller-based features. Another case that I can
think of is that there may be more extensions whose features may
overlap, and we may want to allow bluetoothd to choose which one to
adopt, so Enabled_Features would reflect the ones being used.
I will keep Enabled_Features in v5 and continue the discussion.
>
> Similar to the Read Advertising Features, I would at least add the Num_Ha=
ndles and a Handle list so that you know what handles you have.
Nice catch, I will add them in v5.
>
> I do wonder if you should do a Max_Handles or Max_Pattern information her=
e as well.
As discussed, given that an extension, such as Microsoft extension,
does not have a fixed number of allowed monitors and fixed number of
allowed patterns. Any number would be a wrong one. Internally in the
kernel, we may want to set a max to secure the use of memory, but I am
not sure about exposing those internal numbers so that there may be
requests to expose that number to D-Bus clients. But I can see the
benefits of exposing the max where BlueZ can avoid sending MGMT
commands which are sure to be rejected by the kernel. I will add
Max_Handles with value 32 and Max_Patterns with value 8. Please let me
know if you have better values in mind for these two fields (I am
working on MGMT command handlers).
>
> > +
> > +     Supported_Features and Enabled_Features are bitmasks with current=
ly the
> > +     following available bits:
> > +
> > +             1       Advertisement content monitoring based on Microso=
ft HCI
> > +                     extension.
>
> Lets say =E2=80=9Cbased on pattern matching=E2=80=9D. I would try to avoi=
d Microsoft HCI extension as explicit mentioning in the API description if =
possible.
Ack. Please refer to my reply above around Enabled_Features. I was
thinking that we may want to allow bluetoothd to configure the use of
extensions, so I explicitly put Microsoft here.
>
> > +
> > +
> > +Add Advertisement Patterns Monitor Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x004A
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
> > +     Return Parameters:      Monitor_Handle (4 Octets)
>
> Unless our Advertising or Connection Handle in the Bluetooth Core spec ar=
e 32-bit, I would like to stay with a 16-bit value here.
Ack.
>
> > +
> > +     This command is used to add an advertisement monitor whose filter=
ing
> > +     conditions are patterns. The kernel would track the number of reg=
istered
> > +     monitors to determine whether to perform LE scanning while there =
is
> > +     ongoing LE scanning for other intentions, such as auto-reconnecti=
on and
>
> This sentence doesn=E2=80=99t really parse.
>
> Lets keep this simple, if there is at least one monitor enabled, then the=
 kernel will trigger scanning.
Ack.
>
> > +     discovery session. If the controller supports advertisement filte=
ring,
> > +     the kernel would offload the content filtering to the controller =
in
> > +     order to reduce power consumption; otherwise the kernel ignore th=
e
> > +     content of the monitor. Note that if the there are more than one
> > +     patterns, OR logic would applied among patterns during filtering.=
 In
> > +     other words, any advertisement matching at least one pattern in a=
 given
> > +     monitor would be considered as a match.
> > +
> > +     A pattern contain the following fields.
> > +             AD_Data_Type    Advertising Data Type. The possible value=
s are
> > +                             defined in Core Specification Supplement.
> > +             Offset          The start index where pattern matching sh=
all be
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
> > +Remove Advertisement Monitor Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x004B
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Monitor_Handle (4 Octets)
> > +     Return Parameters:
> > +
> > +     This command is used to remove advertisement monitor(s). The kern=
el
> > +     would remove the monitor(s) with Monitor_Index and update the LE
> > +     scanning. If the controller supports advertisement filtering and =
the
> > +     monitor(s) has been offloaded, the kernel would cancel the offloa=
ding;
> > +     otherwise the kernel takes no further actions other than removing=
 the
> > +     monitor(s) from the list.
>
> When the Monitor_Handle is set to zero, then all previously handles are r=
emoved. Make this similar to Remove Advertisement.
>
> We also should not that in case of pattern monitor, all patterns associat=
ed with a monitor handle will be removed.
Ack.
>
> > +
> > +     Monitor_Handle can be the following values.
> > +             Value           Operation
> > +             -------------------------
> > +             0x00000000              Removes all existing monitor(s)
> > +             0x00000001 or greater   Removes the monitor with that han=
dle
> > +
> > +     Possible errors:        Failed
> > +                             Busy
> > +                             Invalid Index
> > +
> > +
> > Command Complete Event
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -4020,3 +4116,25 @@ PHY Configuration Changed Event
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
> > +     Event Parameters:       Monitor_Handle (4 Octets)
> > +
> > +     This event indicates that an advertisement monitor has been added=
 using
> > +     the Add Advertisement Monitor command.
> > +
> > +
> > +Advertisement Monitor Removed Event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Event Code:             0x0028
> > +     Controller Index:       <controller id>
> > +     Event Parameters:       Monitor_Handle (4 Octets)
> > +
> > +     This event indicates that an advertisement monitor has been remov=
ed
> > +     using the Remove Advertisement Monitor command.
> > --
> > 2.24.1
>
> Besides these minor details, I think this look good.

Thanks,
Miao
