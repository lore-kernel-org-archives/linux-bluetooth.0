Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F959C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C6920684
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6xHVIHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfK0Pyk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:54:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45420 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Pyk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 10:54:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id 14so20459777oir.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3KhjYp+MLQQkLwpvQyXqJiJP/2IBRB6+9KSS7LYMzo=;
        b=c6xHVIHW1jkItdDS/hEVuEnQJS+kG8IcUcUxtqckgDdW5+wiaF+MC9NUujNxcfkpts
         InlwVsoqYOuiwp4rSjKERV4pkoG2ofHH8YKrRvGwSQI37rQnMT4qrtvgSC9JlrnbfBWf
         7IN/ocB/dhdDdl0k910shD2ZiGIRvSOgVUdaTUJzlGS0MZMmu7lBcMf5TIb5FKWCCWUV
         YQFu+wKpyP8UJv+45IaN2wLNB/kT+CBv1DO/qppJFhw4eSAMeSvuRcH8EAQL87elCz4L
         dMnhH0K/i6Zzjdfh+xF8YOskb2jo/2VCnZkffp0I6ZAkljFwfdkniw9MF6UvcBZr5NrC
         PpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3KhjYp+MLQQkLwpvQyXqJiJP/2IBRB6+9KSS7LYMzo=;
        b=MvR3m50o8CAwc9orU2i7V14S7LWFP3NTxC+bTFyZkmsyKUuJvmWmbJMu+WUURUzMwd
         nlihiJg700cthwCn9oc/kH7cVEi+nlEI5MUn0/NE5kJtd19dfgp2hDShFsxWXvNV4S5f
         ZKib9JiavTkIzr8+YWtvKgrQEptISVkWs1jVcpUj0HaKfzXVLdh/4zSH/RjecICEHc1K
         NQB5M8wsEFQwElVfFinStnIsdhKrq/8gL41ZHH9P82JE4otAI84QVn5PvNHXX7l+kbGo
         FTn3pm3oqpUejanXnoIL50uv/naRw2G4qO+zk4Ai0DOp/obSA1Nt51pxVe2Fz9vw8hLS
         kp9A==
X-Gm-Message-State: APjAAAUH13iqKHNGKFLnzga6Tgy+jW/PFYEhG6u2I/c935oATkm2cGvr
        TFuhJd/2Sh+Nd1lo8MN/7/zgoox0/fDatOB2hSI=
X-Google-Smtp-Source: APXvYqxb+Y4JHd7TOwkJZF8vMXYtZ3paxgbvan/kKFDtEutiD/PbZBYhDfAOjhfyaVyrxr57DJSniFuXYNSWZLuK+Vg=
X-Received: by 2002:aca:da06:: with SMTP id r6mr4714656oig.82.1574870078892;
 Wed, 27 Nov 2019 07:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20191126191452.23603-1-alainm@chromium.org> <7223C834-7E4C-4521-9C1E-CA7C2F26EC63@holtmann.org>
In-Reply-To: <7223C834-7E4C-4521-9C1E-CA7C2F26EC63@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Nov 2019 17:54:26 +0200
Message-ID: <CABBYNZLg5+QM_+ZDBp3mfBnLq=3w05gTxb8=oRFLiYdTyDNsYA@mail.gmail.com>
Subject: Re: [PATCH] Blocked key mgmt Api definition
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Alain,

On Wed, Nov 27, 2019 at 8:02 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > ---
> > doc/mgmt-api.txt | 33 +++++++++++++++++++++++++++++++++
> > 1 file changed, 33 insertions(+)
>
> patch has been applied.
>
> > +
> > +     This command can be used at anypoint to add to the list of blocke=
d keys.  Any connections that
> > +     are attempting to use the keys will be terminated. If a device tr=
ies to distribute the keys during
> > +     pairing, pairing will fail.
> > +
>
> However, I ended up rewording this part since it doesn=E2=80=99t sounded =
right to me. We can adjust this once we have the implementation to match ag=
ainst, but for now I kept it simple. Oh, and we need to stay within the rul=
e that it has to readable in 80 character wide terminal. So no long lines.

Will there be a follow up change to add support for this in the
daemon, I suspect we will need to have it given as a file or will the
blacklist be just hardcoded?

--=20
Luiz Augusto von Dentz
