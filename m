Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B598C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FDE2076F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIedE8X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCXPRP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:17:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39902 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCXPRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 11:17:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so6920140ljn.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UfxDQOtIBQVz2Fl8OBPyJbnR6PzjT3tCQwDFhTZh+6A=;
        b=lIedE8X3fY+RKn6HwQVXKVzevEc+lMS5L757lTN6Qm08f3hwBNSl736hD3TEi5CFq9
         lh8cunYV4syT0PAEVFF/yrA0+K5PvN7WQC4B7bvFY81cOpgUXIbfhMc2JjrbqY2A7c5W
         vxxtkkEK+VsQZWYTqBN4EjYbkuZUxgbYAgS0IVfyYRzC0zPrj/rYQc1WKvjRinzT6MgT
         6LGuCRJ9QH94+XZLXHoFiTvyFkcLJFoyYr/pnHFo3d+a4FBrO9NYvlMjvZI2mqZ2Ql81
         7j06dDoNmLRMwTy+LsRp8/VA2nzLfiBL/sAKtDkQ463ZiQjYQjnkQE71dJcMx3UcvDwp
         X/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UfxDQOtIBQVz2Fl8OBPyJbnR6PzjT3tCQwDFhTZh+6A=;
        b=oLJIyzdjMLC3hido2SrBGqfpGT0Lo/wA3g+nMAGucW9vjRGhXLiot7rXvCeyTWGMJp
         c1s4fWVfBO3eCjTVOdLFvdmIWv272I7pPodMfZzUNtl7RXtVaFgrA6zGziyEV4DxuA/9
         GVzSGFzY5zqfNH8TjDCHzyH5qKgTwY11S98fayUu3LHZ95rYJO16JoAKvhOd1CO4nHbQ
         4fcx3d84YUQeRLl/JKErwZt8GWIA9cqLygV0vJ+snT2EPB6kzaJNJ1h78IBJ4tj8qiKP
         nOtHnMXfc1iWXpZIrlENOEiHtYi92WLbEYmsgKrHpW/5oWpP3l3QoRa9udHo6SyQmeab
         Y1ww==
X-Gm-Message-State: ANhLgQ3VjWmkQMAsXJo++m0aZgyIsHqE4UhZFE3F5Jo1pqviGOOnO0oD
        Scj6VZ89qs3MIghWyhqzWywbvIr6lNbiwAob0E4u9g==
X-Google-Smtp-Source: ADFU+vvL5XJcK0FdMvUZLiI356T/4y31n+kUNaNzTDqgSywsrR/WtrUpEHe1OS5G+MSYki5GyeSv1qiLUjRcEQMKotU=
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr17308594ljj.61.1585063032512;
 Tue, 24 Mar 2020 08:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200320133748.154926-1-alainm@chromium.org> <CALWDO_WSHiNw+uwcZzufJ7rjHr=zpMs6f3ry=rdLMGLz2gJZ=w@mail.gmail.com>
 <1ACCF17B-90EB-4DE1-BD8C-A927ABEC3913@holtmann.org>
In-Reply-To: <1ACCF17B-90EB-4DE1-BD8C-A927ABEC3913@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 24 Mar 2020 11:17:01 -0400
Message-ID: <CALWDO_V=6NXLTZ=XTc+uAe3YUVkUfe88c4beWWoqWK7+vK4+8g@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel.holtmann@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sun, Mar 22, 2020 at 4:17 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> >> This change introduces a new configuration to strictly enforce key siz=
e
> >> checks.  This ensures that systems are in a secured configuration by
> >> default while allowing for a compatible posture via a Kconfig option t=
o
> >> support controllers who may not support the read encryption key size
> >> command.
> >>
> >> Signed-off-by: Alain Michaud <alainm@chromium.org>
> >> ---
> >>
> >> net/bluetooth/Kconfig     | 20 ++++++++++++++++++++
> >> net/bluetooth/hci_core.c  | 10 ++++++++++
> >> net/bluetooth/hci_event.c |  4 ++++
> >> 3 files changed, 34 insertions(+)
> >>
> >> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> >> index 165148c7c4ce..8e177d4f3f02 100644
> >> --- a/net/bluetooth/Kconfig
> >> +++ b/net/bluetooth/Kconfig
> >> @@ -128,4 +128,24 @@ config BT_DEBUGFS
> >>          Provide extensive information about internal Bluetooth states
> >>          in debugfs.
> >>
> >> +config BT_EXPERT
> >> +       bool "Expert Bluetooth options"
> >> +       depends on BT
> >> +       default n
> >> +       help
> >> +         Provides a set of expert options and configurations that sho=
uld
> >> +         only be used deliberately by BT experts.  This is considered=
 a
> >> +         global switch to ensure these advanced features or options t=
hat
> >> +         depends on BT_EXPERT are only used in expert mode.
> >> +
> >> +config BT_ENFORCE_CLASSIC_KEY_SIZES
> >> +       bool "Enforces security requirements for Bluetooth classic"
> >> +       depends on BT && BT_EXPERT
> >> +       default y
> >> +       help
> >> +         Enforces Bluetooth classic security requirements by disallow=
ing
> >> +         use of insecure Bluetooth controllers, i.e. that doesn't sup=
port
> >> +         Read Encryption Key Size command to prevent BT classic conne=
ction
> >> +         with very short encryption key.
> >> +
> >> source "drivers/bluetooth/Kconfig"
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 4e6d61a95b20..142130d4b66b 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev=
)
> >>
> >>        clear_bit(HCI_INIT, &hdev->flags);
> >>
> >> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> >> +       /* Don't allow usage of Bluetooth if the chip doesn't support =
*/
> >> +       /* Read Encryption Key Size command */
> >> +       if (!ret && !(hdev->commands[20] & 0x10)) {
> >> +               bt_dev_err(hdev,
> >> +                          "Disabling BT, Read Encryption Key Size !su=
pported");
> >> +               ret =3D -EIO;
> >> +       }
> >> +#endif
> > Just FYI, I haven't changed this bit yet.  I'll wait for your guidance
> > on where best to put this to leave the controller in the right state.
>
> while I was writing a patch to show how to use unconfigured state for con=
trollers that don=E2=80=99t support the Read Encryption Key Size command, I=
 was wonder why put this into the kernel in the first place.
>
> I was thinking that essentially userspace can just make the decision to u=
se a controller, or use it in LE only mode or not use a controller at all. =
So all we need is to collect the security information of the controller and=
 kernel and expose them to bluetoothd.
>
> +Read Security Features Command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +       Command Code:           0x0048
> +       Controller Index:       <controller id>
> +       Command Parameters:
> +       Return Parameters:      Security_Features (4 Octets)
> +
> +       This command is used to retrieve the supported security features
> +       by the controller or the kernel.
> +
> +       The Security_Features parameter is a bitmask with currently the
> +       following available bits:
> +
> +               0       Encryption Key Size enforcement (BR/EDR)
> +               1       Encryption Key Size enforcement (LE)
> +
> +       This command generates a Command Complete event on success or
> +       a Command Status event on failure.
> +
> +       Possible errors:        Invalid Parameters
> +                               Invalid Index
> +
> +
>
> I was also considering that we additionally add the ECDH Public Key valid=
ation here as supported bits. And in the future even more security related =
information that we want to enforce. However the enforcement to power on or=
 not use a controller is left to bluetoothd and its main.conf configuration=
. Thoughts?
I like the idea.  However, I feel we will still need to guard against
the Read Encryption Key Size failing.  Perhaps we can just do this
unconditionally (where it is reported as supported but fails, we
simply set the encryption key size to 0 and move on).
>
> Regards
>
> Marcel
>
