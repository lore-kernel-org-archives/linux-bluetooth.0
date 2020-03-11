Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C5C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C824D206BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 15:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6tcEUVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgCKPOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 11:14:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43079 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKPOR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 11:14:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so2740776ljp.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=krAgbRabOgtfR/aAQP/KeWe680h4V6v8gUCm8Dd7Mio=;
        b=Q6tcEUVkOSG6FFKeOLpdOT7nHn033vAuS09pdlR6uVXwWO9h3IFYR1mhgrwH+oR4f1
         4RxW6I/niIBJJgVF5SkfM/5FHmO0mKaGhmUFmiSqVNQkjgBgclvEe54DmnraYGGCv7h9
         T1KPlRzV4s5IFQsmXb4N5pBEOOzjuSaHdng3Qu6Ds0H2xT5t/FDaD+sXCxkiE1idjNv7
         aktBynqBizRAVDlU6+gMq+r3t0tIc1UZ3oeBBCy0GMwy94qzbWpzHDOWGVBe2LrDDwY8
         wXU3xqiSgYFhfKgPchzBqKlNo4IUmc2nON40znDipdJge2m1thQbHk/mxWimisQjtjsv
         JLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=krAgbRabOgtfR/aAQP/KeWe680h4V6v8gUCm8Dd7Mio=;
        b=KdF/YkEVt0ycIIu7mk5RARO/jNA6A391wj3iaBT5vEflLuwDlg6td5qE0c4/JbVddj
         h7re+qfUBVlSLlGYVqyL+Oi1Kj4R+jAnI+50iFbDDG++mx0qKDhbSJzyfwI966zlpP6I
         BotTbruyjvv5jzTD8+EG4AJpmn0RM+KQ8LcW9JvgSpme9xBe/glp/hW7Dtz9qEvbLctw
         PIaht5u17qSbxC2SJ+8mmiUy+AIE8pjnNtQsYFULDwehSQKt+eioAxaLw/xgX8BV8eNh
         3Lr+lKzzS/PtOwfQCuk/1Kk5PLClYVWtTKYKZ2afspUklDGK3vH8TXVbCSnDsRDhSUHj
         RKzw==
X-Gm-Message-State: ANhLgQ0H8Y6fl7RE8/R1wDFG/9RZRyio4T1h5TH0gzbhhalMfDjMkHjp
        m8hA3GBqAvBVzHOl8NQcwOZW1CiB5EM33+mr3mKA7Q==
X-Google-Smtp-Source: ADFU+vsumf4DCgLD11c3+JR0j+q9WB/JJs/oOIo78CjpnYRI5b3Cxn49R/TODz3LhRzmjCewXGKSEKYMWPDGWRhqAwo=
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr2411012ljk.186.1583939655109;
 Wed, 11 Mar 2020 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200310151100.134881-1-alainm@chromium.org> <4C7539C9-2AEB-4B1A-93CD-23B468C49B2F@holtmann.org>
 <CALWDO_Xpj8vD=9_KK=P=XWhVV7N5wb80duFw=tsP=0k58ct55A@mail.gmail.com> <BA6ED066-6024-4184-A097-557308840445@holtmann.org>
In-Reply-To: <BA6ED066-6024-4184-A097-557308840445@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 11 Mar 2020 11:14:02 -0400
Message-ID: <CALWDO_XLD332TJErSNsr_Rk_Xf+3D37-dYTovD2+3pBTnb6a7A@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth: Enforce classic key size verification.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 11, 2020 at 11:06 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> >>> This change introduces a new configuration to strictly enforce key si=
ze
> >>> checks.  This ensures that systems are in a secured configuration by
> >>> default while allowing for a compatible posture via a Kconfig option =
to
> >>> support controllers who may not support the read encryption key size
> >>> command.
> >>>
> >>> Signed-off-by: Alain Michaud <alainm@chromium.org>
> >>> ---
> >>>
> >>> net/bluetooth/Kconfig     | 10 ++++++++++
> >>> net/bluetooth/hci_core.c  | 10 ++++++++++
> >>> net/bluetooth/hci_event.c |  5 +++++
> >>> 3 files changed, 25 insertions(+)
> >>>
> >>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> >>> index 165148c7c4ce..6a155b7b6fb2 100644
> >>> --- a/net/bluetooth/Kconfig
> >>> +++ b/net/bluetooth/Kconfig
> >>> @@ -128,4 +128,14 @@ config BT_DEBUGFS
> >>>        Provide extensive information about internal Bluetooth states
> >>>        in debugfs.
> >>>
> >>> +config BT_ENFORCE_CLASSIC_KEY_SIZES
> >>> +     bool "Enforces security requirements for Bluetooth classic"
> >>> +     depends on BT
> >>> +     default y
> >>> +     help
> >>> +       Enforces Bluetooth classic security requirements by disallowi=
ng use of
> >>> +       insecure Bluetooth chips, i.e. that doesn't support Read Encr=
yption
> >>> +       Key Size command to prevent BT classic connection with very s=
hort
> >>> +       encryption key.
> >>> +
> >>
> >> I would drop the CLASSIC part here since it doesn=E2=80=99t really mat=
ter that we can enforce this in the host for LE. In general we require the =
hardware to give us all basics. So I would just do
> >>
> >>        config BT_ENFORCE_ENC_KEY_SIZE
> >>
> >> I addition, I think that I want to put this behind BT_EXPERT option an=
d actually have this default to n. Distributions or products should be cons=
cious about enabling this. Otherwise I am fine doing this.
> > ACK.
> >
> >>
> >>> source "drivers/bluetooth/Kconfig"
> >>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >>> index 4e6d61a95b20..142130d4b66b 100644
> >>> --- a/net/bluetooth/hci_core.c
> >>> +++ b/net/bluetooth/hci_core.c
> >>> @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hde=
v)
> >>>
> >>>      clear_bit(HCI_INIT, &hdev->flags);
> >>>
> >>> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> >>> +     /* Don't allow usage of Bluetooth if the chip doesn't support *=
/
> >>> +     /* Read Encryption Key Size command */
> >>> +     if (!ret && !(hdev->commands[20] & 0x10)) {
> >>> +             bt_dev_err(hdev,
> >>> +                        "Disabling BT, Read Encryption Key Size !sup=
ported");
> >>> +             ret =3D -EIO;
> >>> +     }
> >>> +#endif
> >>> +
> >>
> >> I do not need to check if this is best place. So actually I would like=
 to keep the controller in unconfigured state if a command is missing. It w=
ould stay in unconfigured state forever since there is no way to undo it.
> > I may need some more guidance on how to leave it in an unconfigured
> > state the right way.
>
> I will look into this, but it will take me a bit since I need to my brain=
 back into the right mind to grok the init procedure.
Ack, I'll wait for some guidance on this before making progress.

>
> >> --- a/doc/mgmt-api.txt
> >> +++ b/doc/mgmt-api.txt
> >> @@ -2172,6 +2172,7 @@ Read Controller Configuration Information Comman=
d
> >>
> >>                0       External configuration
> >>                1       Bluetooth public address configuration
> >> +               2       Encryption Key Size enforcement
> >>
> >>        It is valid to call this command on controllers that do not
> >>        require any configuration. It is possible that a fully configur=
ed
> >>
> >> So if the Read Encryption Key Size command is supported, I would like =
to set the Supported_Options bit. And the Missing_Options bit would be set =
depending on this new Kconfig option.
> >>
> >> The real advantage with doing it like this is that when a controller i=
s unconfigured, it is easy to detect and can be skipped for systems that ha=
ve multiple controllers attached.
> >>
> >> One fun part of course is that you could disable BR/EDR and enable LE =
and this option could become allowed again. I would have to check if we can=
 do that with existing mgmt commands and it would flip the Missing_Options =
bit.
> > Ack.
>
> If this way of exposing this, then I might have to give this a spin and t=
est it with the emulator.
Ack.  This and the other bit error will likely force me to learn to
use the emulator.

>
> >>>      if (!ret) {
> >>>              hci_dev_hold(hdev);
> >>>              hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> >>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>> index a40ed31f6eb8..6605da7ec72e 100644
> >>> --- a/net/bluetooth/hci_event.c
> >>> +++ b/net/bluetooth/hci_event.c
> >>> @@ -2902,7 +2902,12 @@ static void read_enc_key_size_complete(struct =
hci_dev *hdev, u8 status,
> >>>      if (rp->status) {
> >>>              bt_dev_err(hdev, "failed to read key size for handle %u"=
,
> >>>                         handle);
> >>> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> >>> +             hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
> >>> +             hci_conn_drop(conn);
> >>> +#else
> >>>              conn->enc_key_size =3D HCI_LINK_KEY_SIZE;
> >>> +#endif
> >>
> >>>      } else {
> >>>              conn->enc_key_size =3D rp->key_size;
> >>>      }
> >>
> >> This change is not needed at all if you can not bring up a controller =
that missing the command.
> > This change is different as it deals with the command failing for any
> > reasons.  In that case it would be wrong to assume the key size is 16.
>
> Good point actually. However just forcing disconnect is not going to work=
 then. Wouldn=E2=80=99t it be enough to set the conn->enc_key_size to 0. Th=
e existing code should take care of gracefully rejecting the L2CAP connecti=
on. It should be the same as when the Read Encryption Key Size command retu=
rns a value lower than the required key size.
Indeed, setting it to 0 would also work.  I'll make this change.
>
> Regards
>
> Marcel
>
