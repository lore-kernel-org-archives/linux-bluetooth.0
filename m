Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB780516168
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902003; cv=pass; b=hfCw1SibZV7E7kJWrd+halON4BfFWkx+vLWhe0YFDl7iSbvUJeIzWegH3SRHAwgYlSkhKXnisBvrv053gRiiH51ymfiKzx5frhy3fSIKPY9jIw8T7Ys7pUuX/5s4/aeZv6z/4bycv7//JU0CnkmOEpbdxq+1dKss9JwejszPsMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902003; c=relaxed/simple;
	bh=qb4v9ce3vW54adqKyiPtSKvN8GLywJnDxqxjs3lPL4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9wxveAqzJ89TrquQxCGR72F+Dqjjm3zBmEdtVcSyr7N4fxIuwXtEAto1TK9GX3jR09W7XMJOxxj4LVGoKfokhg7FoBi4IseWPHpe5Jc87EDklPC4LCmEzzQCPrFZNE/By27gDy6wzSuNAKnfsumOqaoyE7SWkpB6rVY0Gjltmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKl3eQmT; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKl3eQmT"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ae9bc9a2fcso39624607b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791902001; cv=none;
        d=google.com; s=arc-20260327;
        b=UDewPfovX7ZJDCQ5J6CFD2kzwuAw+haZkz1bETU82BqBUXFUuBWj2SPwBqHbhn07Iq
         xzEwtsc15HTKfIiJCLm2tay5dIOGyBY6wVqLA8AHmCu/a4oKnLmQ9Y4APXcYGIH93Hxk
         HSJSVmvoJMZee/5splcukORdvKNeYn7OUn19aM5muWLNvmq4oIEUa1CpNBZZEO1G/nAB
         nddPCEs7HVuNe/KyU/OyIZyWVS5OYNeaXenCRTAvcLCG9B+9j90PPgjIHE17fymEljqh
         R3mQs3M7GnwtUy9puNam1cw3Jofec80ehLpbwVMWULAiPX3z0WKxl9EQjhwuZzG6YBUS
         weYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Injtiv0xWANNcMbgfaK5mbJL2OVBhmX68XzHqiBufSo=;
        fh=bAf3uaujpCfZ+gfuJE9eD1gL5QYFdHZrAlQVfG7eWXo=;
        b=evN1G4M3GxK+hw65h/Lm2oY/tkzoHAGLxqCAUDjXhM1UL30QjPb3fKpeMRiRCz9Pg2
         VLc0Ebmep2DtXxwPr0/nX4qhOSeeOYFJVwDmsGgmyR79L2QRsMrKAoZerrQy+rafkxRS
         SNPZ2gcDkd96CbdPjGRKKQa0a03SvJheFrEL3pfarNbTB7eUd36+RXq6iy5gZ8LP/Sah
         w1GffvodROfE18y4Qy51A/17lbaAkBxFbWu2LY0DcC/6623hoqZtd/DlHNupSpAXISCW
         Jk6UAw4McQgJPLp9rDtrd3LouRx7gsUI5mHLzBFLIh+l88rOUtrdR7fb2BHQCI3AToPg
         N+oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902001; x=1792506801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Injtiv0xWANNcMbgfaK5mbJL2OVBhmX68XzHqiBufSo=;
        b=TKl3eQmTI7GESi+N2ttTBGwV3MkWYbPgH8FAJinNa1kS4/264PZDUYA5HiKkylUoRE
         7FMnrYZTWKi5n1T0Tj1kHfWByB9dUNfZdvJZnrEEVRjVPXPA5o8+KIcp+1cI+9GOxM/W
         ntsmglSlXXJ0VYEdw6DVD9pp01cXXSHBjI7C/FvTzp4WdytsqhdC3m/S/eHQTJXBBUu4
         fYlODQkDFoHdwFhrV4nHiOZTr7kocnWfhM5gAx2HGYgESDCTCBISuv29V3mg9cYNAhmU
         RNpkxlVeQtZVos8Qq6U3As3qPsvD5iwhO8+YJ6MT5U79zZ2TYMPd8vssKCcsqvn9IL84
         LpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902001; x=1792506801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Injtiv0xWANNcMbgfaK5mbJL2OVBhmX68XzHqiBufSo=;
        b=2sA9NAZ0mHaoDFeOqmghr0571ffvgd2HNIH5xihzGNoE+Aj5eNUUfFXyReEMEJ7a1j
         W2lZOW8zAHjMeM25NL/rrvDnyLZfT3nvG9bEXihm/UUnPeG+A3IPZd5wDf038nk0Pf3Y
         1ACK6zA9V6Ypwm4nc1eQv02jEYhYuzXatkgGoZWGRXUaQp2cv3kMXcGw7sXLdJtmHbTW
         wVY9cLZbwqbNC8K/JpblBTpumBLRdDc37NmZWmVZEAkqqxJA1RTMvil2KX6XaHoM064G
         vx5Aw+vtBtFZGWHn0Lk+EH+cq1JhFHdK1nFtFKfa0Hfcf9utvg/5wKd+DuS1q4NwWyBe
         z5kQ==
X-Gm-Message-State: AFq9FYIMuid+8yOjFzQH15gduNgAx3eFOEbNJa4ew6VSYWOWbRkbV4S4
	MVwiG2pSB4mGaa01FWtjufodVDOrUzXbQJDDiFZbLxhgGpa6GfaLsQnuk0kLlRzNz7TbduiM+GT
	z5jGCfx/fF1ZFSoD8wCYy+ZbeJgfbNoBUrA==
X-Gm-Gg: AYBFou2rA7xEfqspiIJ5Z2fTZC9ZY3LAtBEPR/df3dyTGhCLZUpeDI2Y8/aC7PyXoPX
	VZxvciHMUwu2Ko9RSEta1ZpxEOvnXI5I9BTGDPQRCNRhuOu+35yqrMI47NiO0ObHN5MBAucJDUf
	A9TdnNLEvkocpSrYOMIuOIzrcz2ZmJxA5yoBUyN6ASd/v+T0g+JCGttrA0I/EOm1WAgFxp6kOYn
	zg+FdLWPZMoqk1vIWnr/LFSyXN2peeRxVpgWQtNVWZlsUWhF5kcGKkDru2QtxmhZpHRNPlpfr9k
	FZHO4qdPV78TawXfHRrvoqYggC8/Sp394rno2VJTeAufAVdKsBDzYTBOjpc/YgFjWCbgQd1e25R
	m6LW/DT53SlZRTTs5NbtvGM4DIweQnUQ+IGW/AaSzfw==
X-Received: by 2002:a05:690c:4992:b0:8ae:8795:86b3 with SMTP id
 00721157ae682-8b07d3c1b1amr45850977b3.10.1791902000951; Tue, 13 Oct 2026
 07:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013033118.501182-1-cochcoder@proton.me>
In-Reply-To: <20261013033118.501182-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 10:33:09 -0400
X-Gm-Features: AclHuK-RXwkksTGff1z6MxwYz9XtMvL74zspdazrlPsiY6llIrUAQoIWCm8vD3U
Message-ID: <CABBYNZ+o5P+KhPX3ndcB28u=QB_4wpOjoJfHWk0_uu-egmx=9A@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: l2cap: honor local LE connection interval range
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Mon, Oct 12, 2026 at 11:31=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
>
> Intersect a valid peer request with the locally configured interval
> range. Reject disjoint ranges and preserve validation of the original
> request before applying local policy.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Submission review notes (not part of the commit message):
> October 12 no-intersection trial accepts [16,24] and completes 30 ms
> with STATUS 03 02 18 and normal host TX; the user hears silence. Volume
> and multi-day acoustic comparison controls are incomplete. The working
> intersection yields 20 ms. Maximum-only rejection failed in kernel 5
> and is not this proposal. Generic minimum/range policy and LL-path
> consistency remain RFC questions, not established by one renderer.

I need to check the git history but I believe we tried something
similar not long ago that created interoperability problems if we use
strict range matching like this.

>  net/bluetooth/l2cap_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 49a998804..49e201d3e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4968,6 +4968,13 @@ static inline int l2cap_conn_param_update_req(stru=
ct l2cap_conn *conn,
>         memset(&rsp, 0, sizeof(rsp));
>
>         err =3D hci_check_conn_params(min, max, latency, to_multiplier);
> +       if (!err) {
> +               /* Apply local policy only after validating the peer's re=
quest. */
> +               min =3D max_t(u16, min, hcon->le_conn_min_interval);
> +               max =3D min_t(u16, max, hcon->le_conn_max_interval);
> +               err =3D hci_check_conn_params(min, max, latency, to_multi=
plier);
> +       }
> +
>         if (err)
>                 rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
>         else
>
> base-commit: 964430c038967fd06643e866f68115664e1a1bd1
>


--=20
Luiz Augusto von Dentz
