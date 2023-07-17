Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832F0EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 02:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGQCxl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Jul 2023 22:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCxl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Jul 2023 22:53:41 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2687107
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jul 2023 19:53:39 -0700 (PDT)
Date:   Mon, 17 Jul 2023 02:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689562417; x=1689821617;
        bh=Lm1hC9x8ZQ00YPQk0nFR4Er9obaeamtJGoQRzDp8/bg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=oBlHHA+gu/1eN9XQJMjtpCI3eoMAEctw+VvgKJrXHfu5B9Nq+EcHiFvUrWelSfPFU
         EXgKZ3zXjv8gENs+ny5o7KgwjOgTRG8PxSQnPZX4HOVw05B0WJSe/V5lROu4YBtRV6
         /Mc4qdpaMzKM7euRMvXIzkbQDeXdA48pBdQyZ3pbHvrZu2ShZJpFlapgxiwNl8/2E6
         436Pn0fG9BlUvo5sEoEvx0eCFOgcL9sMUASVZb5aSyORekz3x3s3rUYRW6yYwD/uis
         l0TgdVOStQ0/3JBg6B3CovffmVhOTEgvYSR6FLmf+x/OcrqM7Ccl7XYiNxwgB+C9EU
         vV/Kn4tyCpDBg==
To:     Pauli Virtanen <pav@iki.fi>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: kernel NULL pointer dereference in hci_send_sco()
Message-ID: <k5qpp03yvZD9ab1IO2soENsqFqfAxLlOwhLxvF0-goDYaBdZv2DQXkoXX6V_p-zE2c_r9BUjFI8159s7JxRAkICRApI54o2DP5q_jW2bi5Q=@protonmail.com>
In-Reply-To: <GA10KgIDqqUNFO-YfBh4OPbYtNt9zMUeqgQ73fCU2ptnNwVagJYbzg_5h43e0QwBREdrzflftwpfS-YedtCV2zZ6CjjRMKGhed6THanGpj0=@protonmail.com>
References: <HwByr9Ffw_HVVE5pnMu6CTIrQjKwBJpJcSskM0xOP0S-4XiIdmGFTLYAcgKJsOkrxt62je88hFJ1vkHzYtCgwsEATe0KFq3E4YX8LeN5Fdo=@protonmail.com> <K1uGCKZsw3ZP_ygn9btfq5S3EUFCmo0bye7Ew5PG54tNa7_DOiGQ1B3lchlJf_AEZeICj7lGaeSY2tCIJXvgjQOEz0rzD8uoSBw4Ir-Gisc=@protonmail.com> <eb5a46bb08053fc2c6108f0fe45e00fa0b0692d7.camel@iki.fi> <GA10KgIDqqUNFO-YfBh4OPbYtNt9zMUeqgQ73fCU2ptnNwVagJYbzg_5h43e0QwBREdrzflftwpfS-YedtCV2zZ6CjjRMKGhed6THanGpj0=@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

2023. j=C3=BAlius 12., szerda 0:21 keltez=C3=A9ssel, Barnab=C3=A1s P=C5=
=91cze <pobrn@protonmail.com> =C3=ADrta:

> [...]
> >
> > Those generally should be harmless, as the hci_conn may be destroyed
> > earlier than when controller stops sending SCO packets for it.
> >
> > It's not clear those should be printed as errors, same also for the
> > "corrupted SCO packet" messages which are also printed when the
> > hci_conn has been already destroyed. You get lots of that spam during
> > normal SCO operation.
> >
> > For this crash, maybe you can try apply the following patches:
> >
> > https://lore.kernel.org/linux-bluetooth/490b5c6a0e13047fd1bea42d3184b46=
623adc359.1689003801.git.pav@iki.fi/
> >
> > https://lore.kernel.org/linux-bluetooth/20230711131353.40500-1-code@sid=
dh.me/
> >
> > Basically the ISO sockets had similar crashes before, which are now
> > fixed and SCO seems to need similar fixes.
>=20
> Thanks. I will try them. Any idea as to how I could trigger the issue? I =
haven't
> noticed any pattern yet... Seemingly `hci_send_sco()` is only hit when I =
set
> the profile to HSP/HFP, however, every time this issue was triggered, the=
 device
> was in the A2DP profile (at least as far as I can tell).
> [...]

I have not seen the oops since applying those two patches on 2023-07-12,
so hopefully the issue is fixed.


Regards,
Barnab=C3=A1s P=C5=91cze
