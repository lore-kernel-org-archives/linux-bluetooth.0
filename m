Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55AEC43603
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B46208C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnhtBwVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLISYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:24:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35078 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLISYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 13:24:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so16810396lja.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2019 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VvQf4Z9ugu+YSQ/If9/LsgHdJWdLsBThkwrfgTjMliE=;
        b=jnhtBwVRfcIJ6VVCmXbk3gMtesmvJ/jPljmRfdjF/CmwG2lSF74c4VZ5Mmb8Frdk73
         xvAAeb0K1QTAaLtWcj+PdU4e11TkzvCTJMOIWnrl5uU5UdQJqZ83RPgail6Di/M34+yW
         ooTPbb4M3R02AdPNWznGA8RZt1onFRBGTiz9D5xtEtwo0+R7oEvCwQr2Ija7JhvjxzlN
         3Lwa1wvmNpncmTHL6JvLahZ069M1yZXaQkR1YXns5fHLwBOnUnZdjM1pVjVStLwpItAs
         IcCEJi5+IfPfHC55csy5gLa7/SFvvOsxsz6hkjYvXRxwqeg0g7XxwEINw6VRXxvHr1cU
         k6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VvQf4Z9ugu+YSQ/If9/LsgHdJWdLsBThkwrfgTjMliE=;
        b=gUNdC8tFgQLdCQ6QYdosHDSxYI2vUWRv2x9kLtJzknePChp/H/ox51/doKW+PwZxSa
         bCfseJGK/yAXJ19AvsSwTSj8OQiGAdFXheBapRT2nqX2fK8Yr7YEj13riT/nm89hQBa3
         9oM059KKJff1/IIlEQCoTFAEfIjIF5h/5gFSCKHqkFEvH9xDSBJ/9bURxFdeKUBKGuFS
         /vdcGrYqcwMRwPOeVibY45JQLFnDmV1bIcFOGhMtwNP6hQOhnwdBCQKO+tGYKm5mZIMy
         90vPQ4TXtj7XuS4i6TpGj1XERYU2C0iejOIytDyIR+B9YcszB4wiapuLLu5moWvJGtdb
         V2Ew==
X-Gm-Message-State: APjAAAU+GVHuPu9PJDssgSLRgtdCR2rjkXUS2bbK87X/ZqRhtt4T8p+z
        vlitU4pznf7gOTeiFW1sYmRFbhVo3tUZHT62HqLWZubd
X-Google-Smtp-Source: APXvYqyUNLTgtzYplEDTADRQqD9rWSOkEBhACBs+Ka3nb4c/BYsHOkvJF/PQErIFZKb0GzuJAuKrBwpMK2PSCcyWrUw=
X-Received: by 2002:a2e:2418:: with SMTP id k24mr18466843ljk.49.1575915890791;
 Mon, 09 Dec 2019 10:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20191205182009.154769-1-alainm@chromium.org> <62BE0838-4EF4-41EE-B3D5-90FDE9871D39@holtmann.org>
In-Reply-To: <62BE0838-4EF4-41EE-B3D5-90FDE9871D39@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 9 Dec 2019 13:24:39 -0500
Message-ID: <CALWDO_WtcfETnPC-W_8o9mBihXEB48sNuhkay3YGY2NC3NYucg@mail.gmail.com>
Subject: Re: [PATCH] Fixing checkpatch noise. No functional changes.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These were all whitespace issues and were autofixed with --inline.
checkpatch is pretty noisy, so it's difficult to discern real issues
with all this noise.  Isn't it better to just fix the noise even if
not consequential for a human reader and so we can focus on the real
issues after?

On Sun, Dec 8, 2019 at 3:31 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > ---
> > include/net/bluetooth/hci_core.h | 31 +++++++------
> > include/net/bluetooth/mgmt.h     |  6 +--
> > net/bluetooth/hci_core.c         | 45 +++++++++---------
> > net/bluetooth/mgmt.c             | 49 ++++++++++++--------
> > net/bluetooth/smp.c              | 78 ++++++++++++++++----------------
> > 5 files changed, 114 insertions(+), 95 deletions(-)
>
> can you please break these down into some logical chunks and include the =
checkpatch complaint in the commit message. None of these look like fundame=
ntal style violation. I am happy to take these kind of patches, but sometim=
es we do ignore checkpatch since the code itself is perfectly fine a human =
to read.
>
> Regards
>
> Marcel
>
