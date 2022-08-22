Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C1FC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 06:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiHVGtj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiHVGth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 02:49:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA8186CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:49:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w19so19245856ejc.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Z3NK4KAYHLC+fQ09iPERIBIy3dzNB36KR9aAr4JmPrA=;
        b=XPJVyevazTQW9/uNdKowRPsHQZfaI6cfviMaX9DkU0+xxQ1O37n3neSwejzuJVyGgP
         RaIxJhXjsgRqW1r8vlyxofEblaA4RZIqkrT/sRAMag4Z/UH99ylGzut8tDUUbtl0HBFz
         7ZDYZaqP2CSH/U4OIyr+AQoQ1MAP8ngPp3aPp2OlT1zKWbP1AUA36vKf4IdX/v3xgxtj
         z4uPHl/0pN54iA4qbkDnPqDr67cG6N/Zd01uu3S9BEEK9d6Y8ObuocfBS3uUOVAerdgF
         1k3Rf6CqP5xfTx4Y7TW8B6Vcosfs1LAFIXqHuJXzyHMEm4m1uLGMpdcpkGZmQ1sOZBmp
         B1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Z3NK4KAYHLC+fQ09iPERIBIy3dzNB36KR9aAr4JmPrA=;
        b=mOYJXm3DozuDYWAYLP/JciI+2ee3fDm1lmRv7naIVpRQhwIBlCaehcRvG/Hwq24BoN
         Y115nvBIhUS8c3BXPCZi1zcBavPe9bV2DLETNwhYPcReSfICsM/4sEGZ0OfjanTK7WqD
         qCW7jVUeogQ9ZkFI7OCXIMWlGPHHDmW9z673PBI1JdDfTYgi2jH/234l8Wh68N4JEHtH
         +qaFg6A06R2z3OtMzg3CYsC82tlDSgRvRwiclfR+BusDU3wQOjQ2zy+Ova2GfPTATbwT
         RNZ6NiPxDAFPLC6XLeTdyaDa2HNdNAq3CX3fMrN9wOB/e0QcVwSFg0RH74TP8n+dP8/f
         ySvg==
X-Gm-Message-State: ACgBeo0XtkVyv8/emkyEcdP1Xk9JgSJeTla8lOaneciInvUctRMTyLoE
        I3FiCcyny7TWQGsJpT0/xGNVhI1Q3y8KJZQDhC1J3Q==
X-Google-Smtp-Source: AA6agR7gIHwgxHwGkibjjSUKlG9EI5Q8NDKayZZtXy4fwWefnO75LU0MMypLbq8PZH3rFKl4aUI0Itfeu1NBQqbN4so=
X-Received: by 2002:a17:906:ef90:b0:730:9af7:5702 with SMTP id
 ze16-20020a170906ef9000b007309af75702mr12150986ejb.107.1661150972793; Sun, 21
 Aug 2022 23:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
 <f9fd47a4-e5fc-5640-de71-dee1d52da2a8@molgen.mpg.de> <CAJQfnxHsRrJpQQB06bxhjc1TetK-8H20Cos366A6qH5AY9j9vw@mail.gmail.com>
 <a1f16653-e32e-4dda-a1cb-858c27ba025e@molgen.mpg.de>
In-Reply-To: <a1f16653-e32e-4dda-a1cb-858c27ba025e@molgen.mpg.de>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 22 Aug 2022 14:49:21 +0800
Message-ID: <CAJQfnxHF3CX6fohXZFGOLzj197djZsQrYrTOY6-nxShTrY-D1Q@mail.gmail.com>
Subject: Re: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT error
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Mon, 22 Aug 2022 at 14:40, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Archie,
>
>
> Am 22.08.22 um 08:33 schrieb Archie Pusaka:
>
> > On Mon, 22 Aug 2022 at 14:15, Paul Menzel <pmenzel@molgen.mpg.de> wrote=
:
>
> >> Am 22.08.22 um 06:53 schrieb Archie Pusaka:
> >>> From: Archie Pusaka <apusaka@chromium.org>
> >>
> >> I think the tag in the email subject needs to be [PATCH BlueZ] to be
> >> detected by the build bot.
> >
> > Is the bot the one who just commented about the test result? If so
> > probably it can detect this format as well.
>
> Yes, I noticed after hitting *Send*.
>
> >>> We set the pending settings flag when sending MGMT_SETTING_*
> >>> commands to the MGMT layer and clear them when receiving success
> >>> reply, but we don't clear them when receiving error reply. This
> >>> might cause a setting to be stuck in pending state.
> >>
> >> Were you able to reproduce a problem on real hardware?
> >
> > I only received some reports, but unfortunately I cannot repro on real
> > hardware. The symptom is BlueZ can't be turned off, snoop logs shows
> > that MGMT_OP_SET_POWERED fails to be sent, and we are stuck with it
> > since the next commands to toggle power are ignored.
> >>
> >>> Therefore, also clear the pending flag when receiving error.
> >>> Furthermore, this patch also postpone setting the pending flag
> >>
> >> postpone*s*
> >
> > Thanks, will fix.
> >>
> >>> until we queue the MGMT command in order to avoid setting it too
> >>> soon but we return early.
> >>
> >> Maybe add a comment, that how you tested this?
> >
> > The reporter claims the problem is no longer observable after this
> > patch. I didn't do any other intelligent way of testing,
> > unfortunately. Do I also need to document that?
>
> Is the bug report public.

No, the bug report is filed by Vendor testing unreleased devices, so
unfortunately it is not public.
>
> It=E2=80=99s not a requirement. I just thought, that the Chromium project=
 has a
> big QA setup, and runs on millions of devices, it=E2=80=99d be good to kn=
ow, for
> example, if the patch was battle proven for several months in production
> or if it=E2=80=99s verified by one person.

Chromium usually holds the "upstream first" spirit, this patch is no
exception. So, currently it is not battle proven.
Whether accepted or not, we would still merge it to the Chromium tree
though. If required, by that time I can circle back to this patch and
report any future findings.
>
>
> Kind regards,
>
> Paul
>
>
> >>
> >>> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >>>
> >>> ---
> >>>
> >>>    src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
> >>>    1 file changed, 37 insertions(+), 8 deletions(-)
> >>
> >> [=E2=80=A6]

Thanks,
Archie
