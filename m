Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA451C636C8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC33613D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 23:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhGOXY0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhGOXYZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jul 2021 19:24:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C44C06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 16:21:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g8so6997689lfh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VSEKCobMbtjNb8XksVgMiVHdPjSsWlTSX5dUQvJdEBY=;
        b=O7BDOvByueQF2w8sK384ImF7tZ6SWpn2llrSz7aAXjSIInry6CsAGxsEDQmE0NONnm
         aiRMy5kyBxOmnOXSIN1/WyRF8sewK7A5ptA6AKcHmlYUGmfNyO8X3WgeP3+3fYuoyepv
         zZhT+EE/TKHREmbW8LXTwnGmZT8THp1DMqhQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VSEKCobMbtjNb8XksVgMiVHdPjSsWlTSX5dUQvJdEBY=;
        b=O4i0ha86J9XnVTUET4fztwyCN/WgHVWZFqZoPLZsgEmnz+O/keMG6JsP6VA58J5pRp
         k8C+wS+d2ieS0IydBGP0N/ReRyZZJzvj5MUSwIo2/yl/GnqOmpXeHvbYIn7WTDlZhewx
         UA3NmF9zbz75fE2m/N1bRKLIPxl+l4z/5cQ1Mx5W+Pf15mK8JDtgAJyHv3gcM2H7HNhD
         eqtUxyhGp9xKr1xl3pvwNBeaiGFe86MWl4HqiTiWA5g256Y74HpmyrPRzX94C13JUCmD
         zTDPpt5dCuhJNQXXDNR786eav6uretcb7qm+oSL6Z8kQCTu/4vrlwNe1+7AddCLrcqqM
         qBMg==
X-Gm-Message-State: AOAM530EeOZSXDgBirklphdYQCHYJ0iKtd2P10kn81r0tTzX3/MaiNIY
        6XTRjaNB1BGZahapSJ/Tqk4UPhi7Qow5LCpey3AOlw==
X-Google-Smtp-Source: ABdhPJx4q56dLvULb+v9sNcqs90a8SaRfdgqabYwJLCAqaAmQ6BWNZp1U6A4QmmJSVK28mfe994CGyHuvPn66YitN2M=
X-Received: by 2002:a19:5e02:: with SMTP id s2mr5261375lfb.265.1626391289168;
 Thu, 15 Jul 2021 16:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210626052152.2543526-1-mcchou@chromium.org> <20210625222111.BlueZ.v2.1.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
 <086ED9D7-96E6-46AB-88B6-F2E71ACD1B15@holtmann.org> <CABmPvSHyt0LfMRJeaWzEMUZZNGnnNnZTnw_0iU4CyxQMd8jy1w@mail.gmail.com>
 <CABBYNZJgK_vo2QyvA7Sy+8Hd3uUh59Dz6gBQYLjVL6y6tvSo8A@mail.gmail.com>
In-Reply-To: <CABBYNZJgK_vo2QyvA7Sy+8Hd3uUh59Dz6gBQYLjVL6y6tvSo8A@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 15 Jul 2021 16:21:17 -0700
Message-ID: <CABmPvSFmHeB0Z4-VZDNmF2ffLo6xZb=rhx+OjzC9Op8LnjTm+A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/3] error: BR/EDR and LE connection failure reasons
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, Jul 14, 2021 at 3:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Wed, Jul 14, 2021 at 2:13 PM Miao-chen Chou <mcchou@chromium.org> wrot=
e:
> >
> > On Fri, Jun 25, 2021 at 10:39 PM Marcel Holtmann <marcel@holtmann.org> =
wrote:
> > >
> > > Hi Miao-chen,
> > >
> > > > The source of Connect() failures can be divided into the following
> > > > three.
> > > > - bluetoothd's device interface state transition and profile state
> > > >  transition
> > > > - Kernel's L2CAP layer state transition
> > > > - Potential HCI error codes returned by the remote device
> > > >
> > > > This also added error-code.txt to describe these error codes.
> > > >
> > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > Reviewed-by: Howard Chung <howardchung@google.com>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add error-code.txt
> > > > - Remove BtdError from return string
> > > >
> > > > doc/error-code.txt | 266 ++++++++++++++++++++++++++++++++++++++++++=
+++
> > > > src/error.c        | 111 +++++++++++++++++++
> > > > src/error.h        |  52 +++++++++
> > > > 3 files changed, 429 insertions(+)
> > > > create mode 100644 doc/error-code.txt
> > >
> > > please split documentation and code changes into separate patches.
> > >
> > >
> > > >
> > > > diff --git a/doc/error-code.txt b/doc/error-code.txt
> > > > new file mode 100644
> > > > index 000000000..e91324855
> > > > --- /dev/null
> > > > +++ b/doc/error-code.txt
> > > > @@ -0,0 +1,266 @@
> > > > +D-Bus Method Return Error Codes
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +The motivation of having detailed error codes is to provide contex=
t-based
> > > > +failure reasons along with D-Bus method return so that D-Bus clien=
ts can
> > > > +build metrics and optimize their application based on these failur=
e reasons.
> > > > +For instance, a client can build retry mechanism for a connection =
failure or
> > > > +improve the bottleneck of use scenario based on actionable metrics=
.
> > > > +
> > > > +These error codes are context-based but not necessarily tied to in=
terface or
> > > > +method calls. For instance, if a pairing request failed due to con=
nection
> > > > +failure, connection error would be attached to the method return o=
f Pair().
> > > > +
> > > > +BR/EDR connection already connected
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0001
> > > > +     errno:  EALREADY, EISCONN
> > >
> > > I would rather see connnection-already-connected instead of 0x0001 in=
 the D-Bus error message.
> > Having a code attached instead of a string description makes it easier
> > for a D-Bus client to interpret and map to corresponding handlers IMO.
> > For instead, a client can simplily use the code in a switch case to
> > perform retry or error reporting.
>
> Well you first need to decode it since the error message is still a
> string, but I would have to agree that doing things like strcmp for
> the error message might be more error prone than extracting the error
> code since the former is more likely to change, the weird thing is
> that D-Bus seems to allow passing more than just a error message
> (https://dbus.freedesktop.org/doc/dbus-specification.html):
>
>  'Errors
>
>  Messages of type ERROR are most commonly replies to a METHOD_CALL,
> but may be returned in reply to any kind of message. The message bus
> for example will return an ERROR in reply to a signal emission if the
> bus does not have enough memory to send the signal.
>
>  An ERROR may have any arguments, but if the first argument is a
> STRING, it must be an error message. The error message may be logged
> or shown to the user in some way.'
>
> But it looks like libdbus does expect only a string:
>
> https://dbus.freedesktop.org/doc/api/html/group__DBusMessage.html#ga2ab89=
6965aec97fb21293affeed36232
>
> Well perhaps it needs to constructed manually with the use of
> dbus_message_new_method_return if you want to pass parameters other
> than error_name and error_message so we could include a third one e.g.
> error_code.
It's good to learn that D-Bus allows other types to be attached in
error return. My only concern around introducing new types to the
error return is that it changes how the D-Bus client interprets the
error return. What do you think?
>
> > >
> > > > +
> > > > +Either the profile is already connected or ACL connection is in pl=
ace.
> > > > +
> > > > +BR/EDR connection page timeout
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0002
> > > > +     errno:  EHOSTDOWN
> > > > +
> > > > +Failed due to page timeout.
> > > > +
> > > > +BR/EDR connection profile unavailable
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0003
> > > > +     errno:  ENOPROTOOPT
> > > > +
> > > > +Failed to find connectable services or the target service.
> > > > +
> > > > +BR/EDR connection SDP search
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0004
> > > > +     errno:  none
> > > > +
> > > > +Failed to complete the SDP search.
> > > > +
> > > > +BR/EDR connection create socket
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0005
> > > > +     errno:  EIO
> > > > +
> > > > +Failed to create or connect to BT IO socket. This can also indicat=
e hardware
> > > > +failure in the controller.
> > > > +
> > > > +BR/EDR connection invalid arguments
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0006
> > > > +     errno:  EHOSTUNREACH
> > > > +
> > > > +Failed due to invalid arguments.
> > > > +
> > > > +BR/EDR connection not powered
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0007
> > > > +     errno:  EHOSTUNREACH
> > > > +
> > > > +Failed due to adapter not powered.
> > > > +
> > > > +BR/EDR connection not supported
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0008
> > > > +     errno:  EOPNOTSUPP, EPROTONOSUPPORT
> > > > +
> > > > +Failed due to unsupported state transition of L2CAP channel or oth=
er features
> > > > +either by the local host or the remote.
> > > > +
> > > > +BR/EDR connection bad socket
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0009
> > > > +     errno:  EBADFD
> > > > +
> > > > +Failed due to the socket is in bad state.
> > > > +
> > > > +BR/EDR connection memory allocation
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x000A
> > > > +     errno:  EBADFD
> > > > +
> > > > +Failed to allocate memory in either host stack or controller.
> > >
> > > If this happens, then the code is wrong. Should be an ENOMEM.
> > My mistake, this should be ENOMEM. Corrected in v3.
> > >
> > > > +
> > > > +BR/EDR connection busy
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x000B
> > > > +     errno:  EBUSY
> > > > +
> > > > +Failed due to other ongoing operations, such as pairing, busy L2CA=
P channel or
> > > > +the operation disallowed by the controller.
> > > > +
> > > > +BR/EDR connection concurrent connection limit
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x000C
> > > > +     errno:  EMLINK
> > > > +
> > > > +Failed due to reaching the concurrent connection limit to a device=
.
> > > > +
> > > > +BR/EDR connection timeout
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > +     code:   0x000D
> > > > +     errno:  ETIMEDOUT
> > > > +
> > > > +Failed due to connection timeout
> > > > +
> > > > +BR/EDR connection refused
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > +     code:   0x000E
> > > > +     errno:  ECONNREFUSED
> > > > +
> > > > +Refused by the remote device due to limited resource, security rea=
son or
> > > > +unacceptable address type.
> > > > +
> > > > +BR/EDR connection aborted by remote
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x000F
> > > > +     errno:  ECONNRESET
> > > > +
> > > > +Terminated by the remote device due to limited resource or power o=
ff.
> > > > +
> > > > +BR/EDR connection aborted by local
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0010
> > > > +     errno:  ECONNABORTED
> > > > +
> > > > +Aborted by the local host.
> > > > +
> > > > +BR/EDR connection protocol error
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0011
> > > > +     errno:  EPROTO
> > > > +
> > > > +Failed due to LMP protocol error.
> > > > +
> > > > +BR/EDR connection canceled
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > +     code:   0x0012
> > > > +     errno:  none
> > > > +
> > > > +Failed due to cancellation caused by adapter drop, unexpected devi=
ce drop, or
> > > > +incoming disconnection request before connection request is comple=
ted.
> > > > +
> > > > +BR/EDR connection unknown error
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0013
> > > > +     errno:  ENOSYS
> > > > +
> > > > +Failed due to unknown reason.
> > > > +
> > > > +LE connection invalid arguments
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0101
> > > > +     errno:  EINVAL
> > > > +
> > > > +Failed due to invalid arguments.
> > > > +
> > > > +LE connection not powered
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > +     code:   0x0102
> > > > +     errno:  EHOSTUNREACH
> > > > +
> > > > +Failed due to adapter not powered.
> > > > +
> > > > +LE connection not supported
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +     code:   0x0103
> > > > +     errno:  EOPNOTSUPP, EPROTONOSUPPORT
> > > > +
> > > > +Failed due to unsupported state transition of L2CAP channel or oth=
er features
> > > > +(e.g. LE features) either by the local host or the remote.
> > > > +
> > > > +LE connection already connected
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0104
> > > > +     errno: EALREADY, EISCONN
> > > > +
> > > > +Either the BT IO is already connected or LE link connection in pla=
ce.
> > > > +
> > > > +LE connection bad socket
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > +     code:   0x0105
> > > > +     errno: EBADFD
> > > > +
> > > > +Failed due to the socket is in bad state.
> > > > +
> > > > +LE connection memory allocation
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0106
> > > > +     errno: ENOMEM
> > > > +
> > > > +Failed to allocate memory in either host stack or controller.
> > > > +
> > > > +LE connection busy
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0107
> > > > +     errno:  EBUSY
> > > > +
> > > > +Failed due to other ongoing operations, such as pairing, connectin=
g, busy
> > > > +L2CAP channel or the operation disallowed by the controller.
> > > > +
> > > > +LE connection refused
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x0108
> > > > +     errno:  ECONNREFUSED
> > > > +
> > > > +Failed due to that LE is not enabled or the attempt is refused by =
the remote
> > > > +device due to limited resource, security reason or unacceptable ad=
dress type.
> > > > +
> > > > +LE connection create socket
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +     code:   0x0109
> > > > +     errno:  EIO
> > > > +
> > > > +Failed to create or connect to BT IO socket. This can also indicat=
e hardware
> > > > +failure in the controller.
> > > > +
> > > > +LE connection timeout
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x010A
> > > > +     errno:  ETIMEDOUT
> > > > +
> > > > +Failed due to connection timeout
> > > > +
> > > > +LE connection concurrent connection limit
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x010B
> > > > +     errno:  EMLINK
> > > > +
> > > > +Failed due to reaching the synchronous connection limit to a devic=
e.
> > > > +
> > > > +LE connection abort by remote
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x010C
> > > > +     errno:  ECONNRESET
> > > > +
> > > > +Aborted by the remote device due to limited resource or power off.
> > > > +
> > > > +LE connection abort by local
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x010D
> > > > +     errno:  ECONNABORTED
> > > > +
> > > > +Aborted by the local host.
> > > > +
> > > > +LE connection link layer protocol error
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +     code:   0x010E
> > > > +     errno:  EPROTO
> > > > +
> > > > +Failed due to link layer protocol error.
> > > > +
> > > > +LE connection GATT browsing
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +     code:   0x010F
> > > > +     errno:  none
> > > > +
> > > > +Failed to complete the GATT browsing.
> > > > +
> > > > +LE connection unknown error
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +     code:   0x0110
> > > > +     errno:  ENOSYS
> > > > +
> > > > + Failed due to unknown reason.
> > > > diff --git a/src/error.c b/src/error.c
> > > > index 89517075e..73602c4bf 100644
> > > > --- a/src/error.c
> > > > +++ b/src/error.c
> > > > @@ -27,6 +27,7 @@
> > > > #include <config.h>
> > > > #endif
> > > >
> > > > +#include <stdio.h>
> > > > #include "gdbus/gdbus.h"
> > > >
> > > > #include "error.h"
> > > > @@ -43,6 +44,12 @@ DBusMessage *btd_error_invalid_args_str(DBusMess=
age *msg, const char *str)
> > > >                                       "%s", str);
> > > > }
> > > >
> > > > +DBusMessage *btd_error_invalid_args_err(DBusMessage *msg, uint16_t=
 err)
> > > > +{
> > > > +     return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArgu=
ments",
> > > > +                                     "0x%04X", err);
> > > > +}
> > > > +
> > > > DBusMessage *btd_error_busy(DBusMessage *msg)
> > > > {
> > > >       return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress"=
,
> > > > @@ -79,12 +86,24 @@ DBusMessage *btd_error_in_progress(DBusMessage =
*msg)
> > > >                                       "In Progress");
> > > > }
> > > >
> > > > +DBusMessage *btd_error_in_progress_err(DBusMessage *msg, uint16_t =
err)
> > > > +{
> > > > +     return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress"=
, "0x%04X",
> > > > +                                     err);
> > > > +}
> > > > +
> > > > DBusMessage *btd_error_not_available(DBusMessage *msg)
> > > > {
> > > >       return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailabl=
e",
> > > >                                       "Operation currently not avai=
lable");
> > > > }
> > > >
> > > > +DBusMessage *btd_error_not_available_err(DBusMessage *msg, uint16_=
t err)
> > > > +{
> > > > +     return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailabl=
e",
> > > > +                                     "0x%04X", err);
> > > > +}
> > > > +
> > > > DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
> > > > {
> > > >       return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExis=
t",
> > > > @@ -121,8 +140,100 @@ DBusMessage *btd_error_not_ready(DBusMessage =
*msg)
> > > >                                       "Resource Not Ready");
> > > > }
> > > >
> > > > +DBusMessage *btd_error_not_ready_err(DBusMessage *msg, uint16_t er=
r)
> > > > +{
> > > > +     return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady", =
"0x%04X",
> > > > +                                     err);
> > > > +}
> > > > +
> > > > DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
> > > > {
> > > >       return g_dbus_create_error(msg, ERROR_INTERFACE
> > > >                                       ".Failed", "%s", str);
> > > > }
> > > > +
> > > > +DBusMessage *btd_error_failed_err(DBusMessage *msg, uint16_t err)
> > > > +{
> > > > +     return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "0=
x%04X",
> > > > +                                     err);
> > > > +}
> > > > +
> > > > +uint16_t btd_error_bredr_conn_from_errno(int errno_code)
> > > > +{
> > > > +     switch (-errno_code) {
> > > > +     case EALREADY:
> > > > +     case EISCONN: // Fall through
> > >
> > > Don=E2=80=99t do this Fall through. It is actually not a fall through=
 per se. This is just a statement with two case labels. That is perfectly n=
ormal and no compiler should complain. And frankly no C-programmer should b=
e confused if this was intentional or not.
> > Corrected in v3.
> > >
> > > > +             return BTD_ERR_BREDR_CONN_ALREADY_CONNECTED;
> > > > +     case EHOSTDOWN:
> > > > +             return BTD_ERR_BREDR_CONN_PAGE_TIMEOUT;
> > > > +     case ENOPROTOOPT:
> > > > +             return BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE;
> > > > +     case EIO:
> > > > +             return BTD_ERR_BREDR_CONN_CREATE_SOCKET;
> > > > +     case EINVAL:
> > > > +             return BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS;
> > > > +     case EHOSTUNREACH:
> > > > +             return BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED;
> > > > +     case EOPNOTSUPP:
> > > > +     case EPROTONOSUPPORT: // Fall through
> > > > +             return BTD_ERR_BREDR_CONN_NOT_SUPPORTED;
> > > > +     case EBADFD:
> > > > +             return BTD_ERR_BREDR_CONN_BAD_SOCKET;
> > > > +     case ENOMEM:
> > > > +             return BTD_ERR_BREDR_CONN_MEMORY_ALLOC;
> > > > +     case EBUSY:
> > > > +             return BTD_ERR_BREDR_CONN_BUSY;
> > > > +     case EMLINK:
> > > > +             return BTD_ERR_BREDR_CONN_CNCR_CONNECT_LIMIT;
> > > > +     case ETIMEDOUT:
> > > > +             return BTD_ERR_BREDR_CONN_TIMEOUT;
> > > > +     case ECONNREFUSED:
> > > > +             return BTD_ERR_BREDR_CONN_REFUSED;
> > > > +     case ECONNRESET:
> > > > +             return BTD_ERR_BREDR_CONN_ABORT_BY_REMOTE;
> > > > +     case ECONNABORTED:
> > > > +             return BTD_ERR_BREDR_CONN_ABORT_BY_LOCAL;
> > > > +     case EPROTO:
> > > > +             return BTD_ERR_BREDR_CONN_PROTO_ERROR;
> > > > +     default:
> > > > +             return BTD_ERR_BREDR_CONN_UNKNOWN;
> > > > +     }
> > > > +}
> > > > +
> > > > +uint16_t btd_error_le_conn_from_errno(int errno_code)
> > > > +{
> > > > +     switch (-errno_code) {
> > > > +     case EINVAL:
> > > > +             return BTD_ERR_LE_CONN_INVALID_ARGUMENTS;
> > > > +     case EHOSTUNREACH:
> > > > +             return BTD_ERR_LE_CONN_ADAPTER_NOT_POWERED;
> > > > +     case EOPNOTSUPP:
> > > > +     case EPROTONOSUPPORT: // Fall through
> > > > +             return BTD_ERR_LE_CONN_NOT_SUPPORTED;
> > > > +     case EALREADY:
> > > > +     case EISCONN: // Fall through
> > > > +             return BTD_ERR_LE_CONN_ALREADY_CONNECTED;
> > > > +     case EBADFD:
> > > > +             return BTD_ERR_LE_CONN_BAD_SOCKET;
> > > > +     case ENOMEM:
> > > > +             return BTD_ERR_LE_CONN_MEMORY_ALLOC;
> > > > +     case EBUSY:
> > > > +             return BTD_ERR_LE_CONN_BUSY;
> > > > +     case ECONNREFUSED:
> > > > +             return BTD_ERR_LE_CONN_REFUSED;
> > > > +     case EIO:
> > > > +             return BTD_ERR_LE_CONN_CREATE_SOCKET;
> > > > +     case ETIMEDOUT:
> > > > +             return BTD_ERR_LE_CONN_TIMEOUT;
> > > > +     case EMLINK:
> > > > +             return BTD_ERR_LE_CONN_SYNC_CONNECT_LIMIT;
> > > > +     case ECONNRESET:
> > > > +             return BTD_ERR_LE_CONN_ABORT_BY_REMOTE;
> > > > +     case ECONNABORTED:
> > > > +             return BTD_ERR_LE_CONN_ABORT_BY_LOCAL;
> > > > +     case EPROTO:
> > > > +             return BTD_ERR_LE_CONN_PROTO_ERROR;
> > > > +     default:
> > > > +             return BTD_ERR_LE_CONN_UNKNOWN;
> > > > +     }
> > > > +}
> > > > diff --git a/src/error.h b/src/error.h
> > > > index 7c8cad066..74d433aca 100644
> > > > --- a/src/error.h
> > > > +++ b/src/error.h
> > > > @@ -24,22 +24,74 @@
> > > >  */
> > > >
> > > > #include <dbus/dbus.h>
> > > > +#include <stdint.h>
> > > >
> > > > #define ERROR_INTERFACE "org.bluez.Error"
> > > >
> > > > +/* BR/EDR connection failure reasons
> > > > + * BT_ERR_* should be used as one of the parameters to btd_error_*=
_err().
> > > > + */
> > > > +#define BTD_ERR_BREDR_CONN_ALREADY_CONNECTED 0x0001
> > > > +#define BTD_ERR_BREDR_CONN_PAGE_TIMEOUT              0x0002
> > > > +#define BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE       0x0003
> > > > +#define BTD_ERR_BREDR_CONN_SDP_SEARCH                0x0004
> > > > +#define BTD_ERR_BREDR_CONN_CREATE_SOCKET     0x0005
> > > > +#define BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS 0x0006
> > > > +#define BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED       0x0007
> > > > +#define BTD_ERR_BREDR_CONN_NOT_SUPPORTED     0x0008
> > > > +#define BTD_ERR_BREDR_CONN_BAD_SOCKET                0x0009
> > > > +#define BTD_ERR_BREDR_CONN_MEMORY_ALLOC              0x000A
> > > > +#define BTD_ERR_BREDR_CONN_BUSY                      0x000B
> > > > +#define BTD_ERR_BREDR_CONN_CNCR_CONNECT_LIMIT        0x000C
> > > > +#define BTD_ERR_BREDR_CONN_TIMEOUT           0x000D
> > > > +#define BTD_ERR_BREDR_CONN_REFUSED           0x000E
> > > > +#define BTD_ERR_BREDR_CONN_ABORT_BY_REMOTE   0x000F
> > > > +#define BTD_ERR_BREDR_CONN_ABORT_BY_LOCAL    0x0010
> > > > +#define BTD_ERR_BREDR_CONN_PROTO_ERROR               0x0011
> > > > +#define BTD_ERR_BREDR_CONN_CANCELED          0x0012
> > > > +#define BTD_ERR_BREDR_CONN_UNKNOWN           0x0013
> > > > +
> > > > +/* LE connection failure reasons
> > > > + * BT_ERR_* should be used as one of the parameters to btd_error_*=
_err().
> > > > + */
> > > > +#define BTD_ERR_LE_CONN_INVALID_ARGUMENTS    0x0101
> > > > +#define BTD_ERR_LE_CONN_ADAPTER_NOT_POWERED  0x0102
> > > > +#define BTD_ERR_LE_CONN_NOT_SUPPORTED                0x0103
> > > > +#define BTD_ERR_LE_CONN_ALREADY_CONNECTED    0x0104
> > > > +#define BTD_ERR_LE_CONN_BAD_SOCKET           0x0105
> > > > +#define BTD_ERR_LE_CONN_MEMORY_ALLOC         0x0106
> > > > +#define BTD_ERR_LE_CONN_BUSY                 0x0107
> > > > +#define BTD_ERR_LE_CONN_REFUSED                      0x0108
> > > > +#define BTD_ERR_LE_CONN_CREATE_SOCKET                0x0109
> > > > +#define BTD_ERR_LE_CONN_TIMEOUT                      0x010A
> > > > +#define BTD_ERR_LE_CONN_SYNC_CONNECT_LIMIT   0x010B
> > > > +#define BTD_ERR_LE_CONN_ABORT_BY_REMOTE              0x010C
> > > > +#define BTD_ERR_LE_CONN_ABORT_BY_LOCAL               0x010D
> > > > +#define BTD_ERR_LE_CONN_PROTO_ERROR          0x010E
> > > > +#define BTD_ERR_LE_CONN_GATT_BROWSE          0x010F
> > > > +#define BTD_ERR_LE_CONN_UNKNOWN                      0x0110
> > > > +
> > >
> > > What is the intention to split BR/EDR and LE here. You do know up-fro=
nt what connection type you are. Trying to figure out from the error code w=
hat connection you have been trying to establish is plain wrong.
> > In fact the up-front connection type is not necessarily known. In the
> > case of dual-mode devices, such as Bose QC35, a D-Bus client can issue
> > Connect(), and it depends on the timing of connection request (adv
> > usually arrive first compared to inquiry result), it can be either
> > BR/EDR or LE link being established. Another aspect of this is the
> > metrics collection, where knowing transport can be handy. For
> > instance, we can associate the certain error to particular use cases
> > at application layer, and that can help targeting the bottleneck to
> > tackle.
> > >
> > > The description is that you want to know exactly where the connection=
 failed. And I think that can be established independent from the transport=
.
> > Indeed the intention is to know where it failed exactly. However, as
> > mentioned above, transport information is also an important piece of
> > information to know.
> > >
> > > In addition, I don=E2=80=99t like the 0x00?? vs 0x01?? reservation of=
 any number. That always goes bad at some point in the future.
> > As replied above, having a code attached instead of a string
> > description makes it easier for a D-Bus client to interpret and map to
> > corresponding handlers, but I am happy to explore other options as
> > well.
> > >
> > > Regards
> > >
> > > Marcel
> > >
> > Thanks,
> > Miao
>
>
>
> --
> Luiz Augusto von Dentz
Regards,
Miao
