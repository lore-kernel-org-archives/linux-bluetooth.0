Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4EC3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF0A2146E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb9dS9s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCELW1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:22:27 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41576 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCELW1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 06:22:27 -0500
Received: by mail-lj1-f170.google.com with SMTP id u26so5624020ljd.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIP5PP7DHZh08k8tnttJiquWWs3KAKIEe2/OvV9u+vY=;
        b=Nb9dS9s/3UOHhAvRhJBTZez7wCzyQNQf9zuRiiSpeMh3iFAHqxgZ9hXGoUP85x/uEe
         IVRpMq9Satamv9sg3Lt2M6pHjOEzOxZ4LvdYWNu0IQD/mV9IfySJDvzMMQTp6Pa1oRoI
         gLDGFga8GCXht/7V+aWeJMzsFQHoC5a/iCG/AeAMkTfyTVkBHWxe/HW4kDTVbM/oHC2P
         fPSySglXuZ/aysNJBD7ihFx+7rtJZ71lcVbI7ibdlmPwzQUsc9Qa2qbRxNu/9O2rDjCU
         CW5I1u+0KzXaiTxV0qWKYLaZ8/T37hI3ALuKLVeaiqXh7G1/xLrOGR7qRJgs8HCYsmOS
         Wg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIP5PP7DHZh08k8tnttJiquWWs3KAKIEe2/OvV9u+vY=;
        b=bV2r13r2LXVc9MZQXQPxXCjCsvknNWY7d5oZ2i0kMWIx7O34oK488sifr2/f6ROo6/
         DPQ+O4/G17z8mmZAk3OSP0QNfVJN59yJfBfhREtOUD1HFvUMlARpVejeTYm4FECs83SI
         mbDdhBwiwBBlWICocVflQmwGi6dRwHpoKW8HYJj09RgDFJxEFTgym9FucnlhCb1SD1f3
         UpoXielS5d2ti2zENEcX/9mXx6ZdXGppvA/RLaBp2Bflyt1X1bqkt/ERQUKrwls+6Zx8
         KxBdllZXCkYrGrgzGRMC6e7Ep6JfirNUXNy4guIq6zyvNgFndCrfCK8wbdxbBxlTKVLD
         MrhA==
X-Gm-Message-State: ANhLgQ1ApzUI0qDxOcm0CHX+xuCYZJ9lc269SkneMD6CdPkwpO3UBHMm
        FI4S1VLcovX7CvUC0KWRpBF00mQ4EfGHWXJYKiE=
X-Google-Smtp-Source: ADFU+vvVwOsn97L9ZNYV/qnnJ0ZwtaEaWeHQU3/Bmhtp0VWm3xcLDvQIr9mNk/x9YDjy1hsyaVrK1jjQkQfWGt8Vqa4=
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr3407378ljc.48.1583407345043;
 Thu, 05 Mar 2020 03:22:25 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCeQfyPu7T4mHutYwUjK04P8MyYS8NmTC8pm4sZkHQRRNA@mail.gmail.com>
 <BE6FA083-5826-4A77-8EF3-D5485D421AA9@holtmann.org>
In-Reply-To: <BE6FA083-5826-4A77-8EF3-D5485D421AA9@holtmann.org>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Thu, 5 Mar 2020 14:22:14 +0300
Message-ID: <CAE5jQCeENW2bMxDY6CBnxRYojBZx6P4vr=9E+d1Xfo7akLMPpQ@mail.gmail.com>
Subject: Re: On reporting issues with potential security implications
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Hi Anatoly,
>
> > Many projects have some private mail list or some other policies for
> > reporting issues with possible security implications. I mean some bugs
> > that the reporter cannot qualify for sure as a "safe to publicly
> > disclose" (still, they can turn out to be not security-related after
> > review).
> >
> > BlueZ, on the other hand, has a policy of "never write to them
> > [developers] directly" and no easily grep-able guidelines on reporting
> > possibly security-related issues. So, what is the preferred way for
> > reporting such things?
>
> unless they are high severity issues that are remotely exploitable to gai=
n root access, I personally have no problem if they are reporting directly =
to the public mailing list.
>
> For example we have test utilities and development utilities that don=E2=
=80=99t normally run in production systems. We will fix every issue reporte=
d, but they are just bugs and not security issues.

In my case the problem was I would want first get an advice on whether
some reproducer cannot signify "over the air" memory disclosure as
well (yes, I'm not familiar with Bluetooth internals...) and, if yes,
whether such disclosures are issues for BT stack. But, by doing this
via "writing to developers directly", I violate the project policy
that technically can be implemented as a spam filter as well :) So I
cannot know whether that letter was received and just postponed due to
low severity or was filtered out at all.

> Regards
>
> Marcel

Best regards
Anatoly
