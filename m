Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F03C5519F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0D424656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 00:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIw8rRyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgKQABv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgKQABv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 19:01:51 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C1C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 16:01:51 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id y3so4327674ooq.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 16:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NiMWLEJb2s/dvDOZLVQDzFbYe7xKxbCy6Esm03ot5g=;
        b=XIw8rRyBRvsQqeiOX3kjA4pwh8/QDR60g//WcGvAcIWEJeovtwY8pqMAeYdsToev8k
         31IIOgMEFdLNcNVR+aW0IINx8n4AoeuH2At4LawEBRb0wcemqMbw1k1Yha/RksbCroQr
         6zkWOhldW1iSdEVvtP1rKCfLcb6SJs8EcbF5pCngOe6zSQc0LSJzPEGa794Z5CPk86+h
         H6D9VRBf/SdW65SP0VhGdbQY4yHEz2H/LFxKwpsUGi5oDIBGLFBNulbi3Uh11IGjO0hP
         ho8R6I6QHi0yP2UNQ/kH4Re8cQIhed85QU1qjuCDgUnnK/osei+4cCM5S2R4ei458hn+
         7fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NiMWLEJb2s/dvDOZLVQDzFbYe7xKxbCy6Esm03ot5g=;
        b=PkeqsZnda4eITrCkk769MhXIDtUTn8ewJm/KX7ZqoGamKdzLBb0CEoZ9g5LWvv1+r9
         nZKsIkHlGV3VHexzMHt0tnhnpudTKy6YT49TzojrPiOCkizakrc/gskw65166Zaewv/w
         waMIHdub2jl+KpjHyL4P8aqDgJAL3PQiDN3r7ajB1PAGrSnIyx+kv2PdlsTrCKuv7+vY
         aI83xNhdjA8JPQ2mYPEFa7YhQnquE3N+pDUVTkonduAA1d6XMD1o5BjjrlGjUfxGJwsz
         GZ97MpkCNlsot7hb+aCEJAGmQGcfZCxIoSsi6kCoEaOFOCYq/eV9cV6z8r3upgLmKLRU
         /fJA==
X-Gm-Message-State: AOAM531c86JBJ8eWpOighdNLbceMhSiQ1Xbjpbh2QSAlNYEFcjvGSRnp
        7mc2sWRHLywhK0gI7BVbuiBnbY+iGPE+TFvSx/s=
X-Google-Smtp-Source: ABdhPJy7TMTj/jeX6v9tomT1Ppfx6yiJZyMiAX0AcpjV3dviGGdEJePFWTn6IBkh8hBqD9IHCb+CzWw4UBSWmRUtcuY=
X-Received: by 2002:a4a:a542:: with SMTP id s2mr1303282oom.24.1605571310809;
 Mon, 16 Nov 2020 16:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20201116155626.GA27472@jimmy-ryzen-home>
In-Reply-To: <20201116155626.GA27472@jimmy-ryzen-home>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Nov 2020 16:01:40 -0800
Message-ID: <CABBYNZJNipW9PGWGXEK_gu1r2tFDLZ14WNxkg92J7Zu4yUAmiw@mail.gmail.com>
Subject: Re: [Patch v3] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C
To:     Jimmy Wahlberg <jimmywa@spotify.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jimmy.

On Mon, Nov 16, 2020 at 8:01 AM Jimmy Wahlberg <jimmywa@spotify.com> wrote:
>
> This test case is meant to verify that multiple
> unknown options is included in the response.
>
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part A
> page 1057
>
> 'On an unknown option failure (Result=0x0003),
> the option(s) that contain anoption type field that is not
> understood by the recipient of the L2CAP_CONFIGURATION_REQ
> packet shall be included in the L2CAP_CONFIGURATION_RSP
> packet unless they are hints.'
>
> Before this patch:
>
> > ACL Data RX: Handle 11 flags 0x02 dlen 24
>       L2CAP: Configure Request (0x04) ident 18 len 16
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Unknown (0x10) [mandatory]
>         10 00 11 02 11 00 12 02 12 00
> < ACL Data TX: Handle 11 flags 0x00 dlen 17
>       L2CAP: Configure Response (0x05) ident 18 len 9
>         Source CID: 64
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         Option: Unknown (0x10) [mandatory]
>         12
>
> After this patch:
>
> > ACL Data RX: Handle 11 flags 0x02 dlen 24
>       L2CAP: Configure Request (0x04) ident 5 len 16
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Unknown (0x10) [mandatory]
>         10 00 11 02 11 00 12 02 12 00
> < ACL Data TX: Handle 11 flags 0x00 dlen 23
>       L2CAP: Configure Response (0x05) ident 5 len 15
>         Source CID: 64
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         Option: Unknown (0x10) [mandatory]
>         10 11 01 11 12 01 12
>
> Signed-off-by: Jimmy Wahlberg <jimmywa@spotify.com>

Reviewed-by: Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>

> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1ab27b90ddcb..16956f323688 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3627,7 +3627,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>                         if (hint)
>                                 break;
>                         result = L2CAP_CONF_UNKNOWN;
> -                       *((u8 *) ptr++) = type;
> +                       l2cap_add_conf_opt(&ptr, (u8)type, sizeof(u8), type, endptr - ptr);
>                         break;
>                 }
>         }
> --
> 2.25.1
>
> Updated commit message to follow this feedback from bluez.test.bot
>
> ##############################
> Test: CheckGitLint - FAIL
> Output:
> Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
> 1: T3 Title has trailing punctuation (.): "Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C."
>
>


-- 
Luiz Augusto von Dentz
