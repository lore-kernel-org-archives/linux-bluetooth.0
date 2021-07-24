Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1E4C4320A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 12:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EF960E98
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 12:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhGXLmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 07:42:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:53465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbhGXLly (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 07:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627129344;
        bh=93pczZ/TrPgKDCMWQvii3munN+eykEYdV1vWI5tNV6E=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DV7utWnuj6pUqJRfpUqPq9GGrIHQPjiUqaMsNNAgD/mrN2dL3b2lUtrzf0REXdNwD
         YKEUQKTxn6kMdoVRatta6uCoaTQxrwlFQJ5calEmFjZEXYZ82syHOJuYsQ/lvWossP
         QIZfubWwX5bxUSIGK0nza2lESABkBm/8D1/cyh9Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1lvTt43vp7-00CPhb; Sat, 24
 Jul 2021 14:22:24 +0200
Date:   Sat, 24 Jul 2021 14:22:21 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Adam Sampson <ats@offog.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drivers/bluetooth: Remove all strcpy() uses
Message-ID: <20210724112139.GC4709@titan>
References: <20210718153626.18382-1-len.baker@gmx.com>
 <y2awnpnfvnc.fsf@offog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2awnpnfvnc.fsf@offog.org>
X-Provags-ID: V03:K1:ydVGEqIMa6taHulJ5X8IxGd16Qcx4W/RSiaUkXIKSJ1yWPZ1s/+
 scbvgai6zJXARlLtQEymAiNlZ90BsVDxkmWllgbA/tesQqEU9dkwS0gi9XGDLyS4iR5MWbM
 v1KyoH6YX5HB4iDSpJIp2WShcnYWyXnS1fN9lVg5cugfpqyQLRueu4mGTQTeHAjMqmMD/SC
 V6AVOMfGPrtjUl5FK5i4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JK6Vv9Z4NjE=:PnZZZ7PGYLk7TF+E1Er85G
 Ve146W1MrrTbC/32ZYq0plgoMZds10cV+ZkR4JoSJQfrdBC4Xv+nC2l0G4eTkdza7B/ZiNtjq
 sdTjDwXIuYgP3qly0VMsjh5ixbSxQjCyTMaEXYGP/0kh62Y35Jr3LoHAhjHTQqHhfpLqXQx1u
 M9UWpAWcGoTAODVttWdwogf6lawSeekabHO91ImcPpMIqh/pTdnctLCTXXxWOZh3cnYTHXWOQ
 B2FClPO2CfdxwIAWfbkXjPm4o+V2osCc/oq2KBkcmGOl6zq1d0V3+OOKk/Lrno8mobe5efAZT
 1Y8ASbaSdx2j1GW0wBAO/yAv0L0LBLiPQyiUfe18F26x+7j4h0bku5apLl8+DEO7KQjlpfKzT
 o66rXLsV9KlU5+t2zo46orH3Fws4h1oQ+v49bGS9PzJA9OlJwxpGfdJNq5Z85PjAW4fSBKhTv
 rS0ExHbXv6MtRT0pwdrjE+BFEiarMyTnKd45MyBAkDaE39IQAbumdw888os/6nbzZQde8ijA2
 Jxk73Y1wTP3yLrlmBaN9kEYzeBShlLpB7qqxx5LRLAG4/k2xvz2H4ABJ10L4yhNpdVbR79Si2
 2IfqdlZfvIEI8f/wioTV2EGWnFDKzpnPVUGzBxGda6Zj5f8gMn8ke9d9FYpwCGKmM+1KTnGdy
 n0m0ZzPah0QvY/AaVQeFFkcFkV7BRGwvBsJtNP12tQ5gb15KOvsBXmSQwfWMe6yxcgEHUnYRH
 iTdrhKfzLfNjp7oXZdl+vnOB02owfDVibQDswA+EfCPRNbwLHTsJoXkPCcGMWUtR0vpQa+4CH
 2j52wLiefWzKYt/OxooayxrGYMoto4oVaKKUSFp/RPiHUQN9Tb1A0J3vMDnbn32XE1hPMtPjl
 MlYb4DQg8qgNnjHMBnfCeok2YYWihpUX1Lyp+E9PsoojGeRaDyw+6gipWXH0N7VFVb2lwhch9
 fj4+7e+nVh6UT39l764P8bRG2VXA+1SfOZuFdM6GGghnYEPCfDy4Q0QPAXaCiMITRqJXbxgaN
 t/tlpuduFxK0zz30d1FDexhyLgzjW4T+l6tuEcQsgLR4apiUj0JlxHxg6y3G9BnLnMcEDJWn6
 /KxB67SI1KV5Y9P3dvYCREL1xxDUWjvC4WJ
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sun, Jul 18, 2021 at 05:12:55PM +0100, Adam Sampson wrote:
> Len Baker <len.baker@gmx.com> writes:
>
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy() but in
> > this case it is better to use the scnprintf to simplify the arithmetic=
.
> >
> > This is a previous step in the path to remove the strcpy() function
> > entirely from the kernel.
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> > ---
> >  drivers/bluetooth/btmrvl_sdio.c | 27 +++++++++++++--------------
> >  1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrv=
l_sdio.c
> > index cddd350beba3..d6674b367e05 100644
> > --- a/drivers/bluetooth/btmrvl_sdio.c
> > +++ b/drivers/bluetooth/btmrvl_sdio.c
> > @@ -1350,6 +1350,7 @@ static void btmrvl_sdio_coredump(struct device *=
dev)
> >  	u8 *dbg_ptr, *end_ptr, *fw_dump_data, *fw_dump_ptr;
> [...]
> > +			size +=3D scnprintf(fw_dump_ptr + size,
> > +					  sizeof(fw_dump_ptr) - size,
> [...]
> > +			size +=3D scnprintf(fw_dump_ptr + size,
> > +					  sizeof(fw_dump_ptr) - size,
>
> sizeof(fw_dump_ptr) there looks wrong -- you want the size of the buffer
> it points to (fw_dump_len + 1)?

Apologies. I will work on it and I will send a new version for review.
Thanks for the feedback.

>
> Thanks,
>
> --
> Adam Sampson <ats@offog.org>                         <http://offog.org/>

Regards,
Len
