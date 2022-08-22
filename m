Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB36C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 06:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiHVGdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiHVGdp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 02:33:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2041EBF76
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:33:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi31so12696414ejc.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PDsAXXb1G3Kq7+/mrPkqVdRRmqJVAsQ2L5qvxuquj2c=;
        b=Dglx+iExc1Cw6YPHHiPc7AY3azPiFZCkc8sW4UC/CH2tpmQaVusGOGFRuaV4F70J4l
         tR5p3WYN3GApi6PBB9A+fdHvVenPMHqr5I7u15w7AwoVVMqYASTXjpQL/fzngBhQajUu
         jEvxY3i6PqlvZtMddIG9z8ElmCYfqshrWPKambYIoGqbhwxjbYWLK9WA4ZMjFrN/75w/
         M1t8+U1YtrDz7ZZjCH4urp6PUrtuzNks9p/M5WRlgn2vvtET2V4XZ7/1Iqy6BXbg1NTg
         B7wSmEHJ1pg7YUss0b+lpNh9MC5SngBMhSZHfZt97Em42gU9CRZeq8GSup6beg8SJXTG
         XAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PDsAXXb1G3Kq7+/mrPkqVdRRmqJVAsQ2L5qvxuquj2c=;
        b=8BfRbiFeV7RfK2VHXAN/0Jl4Lduc3o11vuOHMhGHFYlgEt80tJf5zdz/pyH2kwY7Hr
         asmO+5/zKrqs1UVL1mhw9qDTTYvOyggDtD3yReBHX+Kz8UorjHAHIMYF530dVDjgsviM
         /C3BW444qtEdbAjO0DqaI0bzjFxMtHsxoT8MOSsVRSUYRm1W1DELq92OTt1lLEUaSzZQ
         boXBU+zFl1+pEPHPoOrJ4VstIP/IG6j2GN94N1GaiTZ6cE3lht5XDYIYd+cmBeh1UsTf
         em2PKKeKMPe1EIDHB0GbW5zvHYQgaUap2pFpPn2a7Hen4aorIishZiO9bBqHrMwmW2mj
         7nOA==
X-Gm-Message-State: ACgBeo3cvH7jPFKNuDE6bZh2uWN3pP6sBLy+JvIas3x2ysc84vSc8qaq
        C07MB0AQFc2dzkmpZxOx7HKI6b1bOLhxhVDME+9mWg==
X-Google-Smtp-Source: AA6agR4NOuthgGhBwjwLH00Q4JRjV7vcRQk32JW81ji5uj8Olh6TQ9+dgnqcAeuQt0pQXu3krFOcyw56oq+NLzyhS3M=
X-Received: by 2002:a17:906:ef90:b0:730:9af7:5702 with SMTP id
 ze16-20020a170906ef9000b007309af75702mr12117411ejb.107.1661150022431; Sun, 21
 Aug 2022 23:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
 <f9fd47a4-e5fc-5640-de71-dee1d52da2a8@molgen.mpg.de>
In-Reply-To: <f9fd47a4-e5fc-5640-de71-dee1d52da2a8@molgen.mpg.de>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 22 Aug 2022 14:33:31 +0800
Message-ID: <CAJQfnxHsRrJpQQB06bxhjc1TetK-8H20Cos366A6qH5AY9j9vw@mail.gmail.com>
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

On Mon, 22 Aug 2022 at 14:15, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Archie,
>
>
> Thank you for the patch.
>
>
> Am 22.08.22 um 06:53 schrieb Archie Pusaka:
> > From: Archie Pusaka <apusaka@chromium.org>
>
> I think the tag in the email subject needs to be [PATCH BlueZ] to be
> detected by the build bot.

Is the bot the one who just commented about the test result? If so
probably it can detect this format as well.
>
> > We set the pending settings flag when sending MGMT_SETTING_*
> > commands to the MGMT layer and clear them when receiving success
> > reply, but we don't clear them when receiving error reply. This
> > might cause a setting to be stuck in pending state.
>
> Were you able to reproduce a problem on real hardware?

I only received some reports, but unfortunately I cannot repro on real
hardware. The symptom is BlueZ can't be turned off, snoop logs shows
that MGMT_OP_SET_POWERED fails to be sent, and we are stuck with it
since the next commands to toggle power are ignored.
>
> > Therefore, also clear the pending flag when receiving error.
> > Furthermore, this patch also postpone setting the pending flag
>
> postpone*s*

Thanks, will fix.
>
> > until we queue the MGMT command in order to avoid setting it too
> > soon but we return early.
>
> Maybe add a comment, that how you tested this?

The reporter claims the problem is no longer observable after this
patch. I didn't do any other intelligent way of testing,
unfortunately. Do I also need to document that?
>
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >
> > ---
> >
> >   src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 37 insertions(+), 8 deletions(-)
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul
