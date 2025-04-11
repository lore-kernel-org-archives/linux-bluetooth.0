Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0519004A
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392668; cv=none; b=FchIg/5sFqTRxRwk2LMkyZfjtSrzPDNots8kBLWVrcgfnLHKIJXLbo2quxfUo1RQEPBxXSwWbkXamSyvqnEowcJ5mRZGNQmOcD88JDZYPLkKDY2ckVeuWT0KY5FPEuajNI1Zpb0ZHaeorwnt7mcR3cwc2KKrMhQuDfrpswT5fEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392668; c=relaxed/simple;
	bh=7Hu3EYUC3WTzzNF9Fgo14T3kS2n8sG2NyFX8iqLZzkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBXvHFaGgZ1aX3qByWjMGLHeZhWp8i4N46nS+0pMjBwKc0ia6n37C/gQzD65cCaTKULQVlWUxNJYysBVQqCSzBWVLAgiAcxff5Z0B/GasT9LNgfUSLnL9av7BaTVg45EVkW+vgDoaNJAh3xsRkhNu2tDtifl6GDhS797a5hvPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af5Kx9Q5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af5Kx9Q5"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30613802a59so23462941fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744392664; x=1744997464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRZLlDBz3Q0hrRvWF38bDkqGxKf9ByghzgvB1auRlAM=;
        b=af5Kx9Q5pfz6ygTq1QrX70onkMVrTsYL47cfuxc3o3fH+WN0t72BQmpwVEHQ9COqFW
         BS2LsWi2R67RzBiFLUYj2ey6ikuLmqmK58lSQm79S+GwwR4WxCSq6Q+Q6Qc/IFY0e+U4
         jEAjTm4P2+/uDp8pNvJCVL/WWw7ChrmVtpqVx8CyC94tVMx/i1zzJO/OVo1BL3LRM83B
         Q+QW+x+5zqCeX2WMzWp8nIOgpZBzxe9a/Nj5Il/0D7b53d7g4UDSKiYm7CDhhY2zess3
         MjjxD2qt7/XF+PvcDRB5yBNr2pRsxf9Erl0vyaQ6Al3SlO40c4+hIM0GNXfAiDYW32wx
         nZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392664; x=1744997464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRZLlDBz3Q0hrRvWF38bDkqGxKf9ByghzgvB1auRlAM=;
        b=JsSCwEM9qGdYf8cP1y780ezO5EmR0LBximui3PfqgjoDnXC65XDysn1JD0MyRBcCIN
         Kir9GXxFi3PHtklMMoCnnpXxajfh3UCryls474CshFC2IFKcz/vfulbrCo0VmscS0oEu
         wp3bjtLTbf8pR0xCR5jJR7XjTf135KR5gZIkMsWtjTRuB+KI3mn6d3tP/DrYHaKIj4ci
         EeDkGAmw592VOfhNyM7hBAO/Y5837JNd70YIQgem3TX/FWYz77vF00IBGCVBRCEkHAwX
         UUNxLurruvG3yGwiZN/QD8UhZ2avGdUVqNW3sHfOeQ65f36b9i2ZagHax8LcLKnMyIJM
         DxqQ==
X-Gm-Message-State: AOJu0YxdNOEh7sRf9AYYZ3RcpTOJm3PQ/jJRVCSQT9AEdo2maTrYaHj4
	Vqwj352MUuAbjNVNuEPYcGqLHrf7ET+61RW/eojcHrODYehilImNWxPKBzmNpAMTkEi5soBe6AA
	ZSARcn4TJ3yz+hUMYCW60bCsaP5IEoCSi
X-Gm-Gg: ASbGnctbTwCHqPC++0opTylXnTCYyJyY/7U25BIydAwh5hqWbO7XZo3YfjjjKe+pmJ7
	AGpvmzC0VWZmFWNGyWOzI6Ft/c5eQUORqSo+2f/63tSfR7im0AEeYF9G9PxfZ3+s0ZGQrmLQ4/U
	HN+GAG0CcGc4eRGh7YYm/g
X-Google-Smtp-Source: AGHT+IFca2/sN4huPubbWdde77fAIUna/NxmwvTFH7Xcdrnv+x7jlTI6h1FhkJD3d9cHHe5GBSk5iPRG5nKgL26/Hfc=
X-Received: by 2002:a05:651c:12c8:b0:30b:ce0a:3e84 with SMTP id
 38308e7fff4ca-31049a6747emr15855351fa.32.1744392663823; Fri, 11 Apr 2025
 10:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411162908.772132-1-frederic.danis@collabora.com>
In-Reply-To: <20250411162908.772132-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Apr 2025 13:30:51 -0400
X-Gm-Features: ATxdqUH65CsnSCYl0Bv5GQJpZ0N6Q2EWDYL0EPPEaCIfnf7Qym6cZW68JLM1ARE
Message-ID: <CABBYNZKp7fK4R4h3oqLR5e7hxYiyyfPrynnC8mYkZdXQaOw2+w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: Process valid commands in too long frame
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Apr 11, 2025 at 12:29=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This is required for passing PTS test cases:
> - L2CAP/COS/CED/BI-14-C
>   Multiple Signaling Command in one PDU, Data Truncated, BR/EDR,
>   Connection Request
> - L2CAP/COS/CED/BI-15-C
>   Multiple Signaling Command in one PDU, Data Truncated, BR/EDR,
>   Disconnection Request
>
> The test procedure defined in L2CAP.TS.p39 for both tests is:
> 1. The Lower Tester sends a C-frame to the IUT with PDU Length set
>    to 8 and Channel ID set to the correct signaling channel for the
>    logical link. The Information payload contains one L2CAP_ECHO_REQ
>    packet with Data Length set to 0 with 0 octets of echo data and
>    one command packet and Data Length set as specified in Table 4.6
>    and the correct command data.
> 2. The IUT sends an L2CAP_ECHO_RSP PDU to the Lower Tester.
> 3. Perform alternative 3A, 3B, 3C, or 3D depending on the IUT=E2=80=99s
>    response.
>    Alternative 3A (IUT terminates the link):
>      3A.1 The IUT terminates the link.
>      3A.2 The test ends with a Pass verdict.
>    Alternative 3B (IUT discards the frame):
>      3B.1 The IUT does not send a reply to the Lower Tester.
>    Alternative 3C (IUT rejects PDU):
>      3C.1 The IUT sends an L2CAP_COMMAND_REJECT_RSP PDU to the
>           Lower Tester.
>    Alternative 3D (Any other IUT response):
>      3D.1 The Upper Tester issues a warning and the test ends.
> 4. The Lower Tester sends a C-frame to the IUT with PDU Length set
>    to 4 and Channel ID set to the correct signaling channel for the
>    logical link. The Information payload contains Data Length set to
>    0 with an L2CAP_ECHO_REQ packet with 0 octets of echo data.
> 5. The IUT sends an L2CAP_ECHO_RSP PDU to the Lower Tester.
>
> With expected outcome:
>   In Steps 2 and 5, the IUT responds with an L2CAP_ECHO_RSP.
>   In Step 3A.1, the IUT terminates the link.
>   In Step 3B.1, the IUT does not send a reply to the Lower Tester.
>   In Step 3C.1, the IUT rejects the PDU.
>   In Step 3D.1, the IUT sends any valid response.
>
> Currently PTS fails with the following logs:
>   Failed to receive ECHO RESPONSE.
>
> And HCI logs:
> > ACL Data RX: Handle 11 flags 0x02 dlen 20
>       L2CAP: Information Response (0x0b) ident 2 len 12
>         Type: Fixed channels supported (0x0003)
>         Result: Success (0x0000)
>         Channels: 0x000000000000002e
>           L2CAP Signaling (BR/EDR)
>           Connectionless reception
>           AMP Manager Protocol
>           L2CAP Signaling (LE)
> > ACL Data RX: Handle 11 flags 0x02 dlen 13
>         frame too long
>         08 01 00 00 08 02 01 00 aa                       .........
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  net/bluetooth/l2cap_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f1c4b8bd7a8b..46b2884170fa 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7539,6 +7539,11 @@ void l2cap_recv_acldata(struct hci_conn *hcon, str=
uct sk_buff *skb, u16 flags)
>                 if (skb->len > len) {
>                         BT_ERR("Frame is too long (len %u, expected len %=
d)",
>                                skb->len, len);
> +                       /* Process valid commands from the PDU before
> +                        * setting the socket unreliable
> +                        */

You should probably quote the test cases here to explain that data
needs to be truncated, which I assume is why you are doing skb->len =3D
len bellow.

> +                       skb->len =3D len;
> +                       l2cap_recv_frame(conn, skb);
>                         l2cap_conn_unreliable(conn, ECOMM);
>                         goto drop;
>                 }
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
