Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792946875;
	b=ZS8ZiBRkd+gy7KgrXTwgoNzDtuZolZqt8HJk6Nz63YFH8SWEImVYu5iR82znpgy267bs
	 Rnw2t53YeXcXU8NATpRCWlsAjZzKTbBDIBuK8aR3SEqJQJMcE0Non9JMGVmaPRs7p+5xB
	 2iUQuXnbhkW2bpjwshE1WIg+zLSBBKqIUXhh0LOvEkW+rgu0uBxVZtGJEzWqBTaNUwjvX
	 pUCj/KZw/UQzwVFcGqZWKN1CTuo6cqpFXkshhh1XuaON5r2khFf3i3rUeMC2UXU1Oe2LY
	 LpiNskMhlr+o5L4w89N4jXhh1Bbt7sezD4hQFD8uNetpc9Kz7ir3y/1sGW/e+VKJwNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HpJEthOBIwEPu1gSMqf8HHsHXBUHMgNP2E4z7So/mi0=;
	b=zgTzauVPhfXdaK6k3cARK/FuyJgkBNSOlJYn3ALEKxVq/Y5hOESRbPFfpObYU9/iZQoN
	 rABGJreoqw9Iig6iesUACisVgKkv4annXyrKtXmtpP4AJeRyS78AqqY9zDseO/FnvHcPA
	 6fZvUQZtnXz3OrHSHyQUemkC8Ktbfk4aZwX59DFgmEu8T6c+PKD+lVczqczmns9Q4lt4J
	 BQ3B6V0594pe4hIICxl2JAoJ5NN0DE0LBVCSnsDezTCoxr7YuHeUnoibknk6S9bSMk0d9
	 9B5dot6iEjV3xau6r7GIpCLcjuqmJ7bSZ0ncP8KIcwvpnxUz0+917ZZPoXIEaJH+REg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=okTQbRJQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8D606A31E
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 16:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF8D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=okTQbRJQ
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso17405077b3.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 09:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792946874; cv=none;
        d=google.com; s=arc-20260327;
        b=RJUocJv2ObYOBpdzjU/RfgNed7GxwJ5hPqajx/IJTYPgtFXzH4V0yamXpQVhKD/J+l
         7SP8+UmxAprMtLY0cFI+1ln1RuR1L2vTmLfFzm+7i8M9gqLfNKYDLrMM7hzgUAqhGm7s
         kipwoDn4w+bsLQlX0k+z2YvCA+FVNSYIiAt3rw+1tF9zHdRuNBIi7WaZB9mwZ70xtWUw
         XBxyqoWDO1gYthU4HWLgnd1PEXoExlEGm5IKOYIoKyRIMk5wNnNdwl/bSau7yBoYBiq+
         R//1AstE5R0P6BOluxMN+QWdUj1AOTMoeZaxEbzAUnzcLhD5ML+dsTKGt2G101837cP/
         wY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HpJEthOBIwEPu1gSMqf8HHsHXBUHMgNP2E4z7So/mi0=;
        fh=Nlx59E0rum8bKLSYlTKr14MoVIAmLNhj+mULqiFtAyI=;
        b=Lggs7UJqVke2/cYsUKvNaS0xEssYdsInIrcXqjkzaBpRHTPYcaZXTwLlyHhv5YnSwO
         c9TaGRqF8sXoaMBytvCqs82UzSY2Wmpc5Akhk8SscbSaMqw412ue5nmiwIyQ4eB3/TTK
         1DNwpTGKuNZ+21fIR6VI2lxEscaE8VRSWKxnIZ/p4T0NVxBsnYGIraXTiYSOSk3hpDBQ
         l5ujIrjcgXUHIlCaD0X0DCsKc+cBoDMkJNcOFTAKwfwPF3qAAtQt1Hs88GUPH0RqsBa6
         6BSqKsXEStzDZT4hlmM6Nvaw4Kmuf7ivaqz5B0WqStceslW1yjUE7PjE1CBCz7OvqYXc
         LKcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946874; x=1793551674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HpJEthOBIwEPu1gSMqf8HHsHXBUHMgNP2E4z7So/mi0=;
        b=okTQbRJQbLezmfJN3ccNFuzoLXEmr2ojkRHNPcf3DyPe8ey22UiUcMAsVq9vZDtSXy
         5Q9OTKIr+H5OJiWBn/auTjTG3NrHtQkEJ9BVDzMMVsjKLSe9u8VEDpmaFxXOYq2JMWfK
         zJCpwwVeudy9lvM64L/wqp3YIeUQpN7AyST0KhjUIVAUOxFwOQq9oh8T4DWTpFrkK8ED
         wGI4ZSmf3/5sMSU2mhJawHCxIovnS7f/7TBMxLXDwJgJKqqp5WUnVaJR6gM41ajUsSoU
         bpgtSwE4eOs0EBXvYOWbb8gzjrzfkd/YjotWBEPa+ICUR74UanyVp2rOHJWs2DuNZ/v5
         jOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946874; x=1793551674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpJEthOBIwEPu1gSMqf8HHsHXBUHMgNP2E4z7So/mi0=;
        b=qb/lftgszSIJpAcavIESIRxigLDm7fsxUAvYK9xRug8JDppvpr7J/HXITpDOwjIovt
         dIZAyb+28jaSVjIY7iamYEPB4FIJcRFrogWYd4vDER19pZghhEmfYELAXMYS3K1lAiF4
         RZiDqM+Gmpfcduv1RQnYMps/g1w224F0b+OfaTPi8VnhODqWWWE3G37NbF7ayyo5QTpQ
         J8pWBhhgVVSjw8ZaawMtKGk1jd+LfaxTc3H017JenyaNpXuJUj6n7JglwOZBXBB1HMg2
         Y0R4orbag58etEbssfpUz0vSBqSbHClEJRDk1hP2t6sMlF9wFlBP9/Zn6mRvio3cGBUt
         UE+A==
X-Gm-Message-State: AFq9FYKD7kTz4IDya/dH0Gh7Q3aWiPbUIKkh5jXwAJi+uchmakwKZnqq
	7YZBdWsZsl1uryakQKx71FaiNMbwWoWyfycqhXe2QPY2fVTyikKjD/HJVIn7lbETHEeAyS+vBll
	3sZcEC37omJo2r0ncWyfOV1Y1jjjl8Co=
X-Gm-Gg: AYBFou0u3T6gkaeiyEORpQS1v5fpsFc7yrGxvf9tSfw4PgcZtGsMy6I0LT8bf3gmary
	pZHFy3tMjcUNZMjs0+rhrtyGgcZjh5l7hrXASYTwrG88Z/hXjfadcIJSq0ypzC0r1YJi+wmZGyU
	AvQ3vNPVxfgagxOaLv835qSFGUq7+aeRyo95zSERqlB+fDhnOyfx0FlwWqu9Ue1cVbTO9AY9LSc
	N7OppvINWQr0wu5GJDYQjKiLBblvSqULVvLYHBvuQ0dCpQikJW8awr4qhZE8hxmvprOZ/y6ADNV
	4ee2uGEIoj+N064SXg0E9AOEvhJBb1QWwfNkZ75Fk+siFmZRToP44H0V2GqJOiRfoAqprZ94FIZ
	TEdftNaIX9xRACuIMgwxvJ82zjtEPLzFS+XLXnsoQh2Kqisgj0FE9w5aUUmxMNAVLfsijzYw8/P
	11uOb4TTVMgypWghBVnHiiBQ==
X-Received: by 2002:a05:690c:d8f:b0:8a8:7fda:15ee with SMTP id
 00721157ae682-8b166c614e3mr33096377b3.50.1792946874322; Sun, 25 Oct 2026
 09:47:54 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024112435.247650-1-turbine.bmw@gmail.com> <20261024112435.247650-3-turbine.bmw@gmail.com>
In-Reply-To: <20261024112435.247650-3-turbine.bmw@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 25 Oct 2026 12:47:43 -0400
X-Gm-Features: AclHuK_TqzE8mkoJOPsB4246SAmXP0WMWait7YWx2jD9DnZw3qYk-XWvevJj1Xs
Message-ID: <CABBYNZKc1C=q_p3=f+jAVPUZd90=p4o=y2n22e6GoVX6YUq2nA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: SMP: distribute the identity address when bonding
To: Brandon Williams <turbine.bmw@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brandon,

On Sat, Oct 24, 2026 at 7:25=E2=80=AFAM Brandon Williams <turbine.bmw@gmail=
.com> wrote:
>
> build_pairing_cmd() only offers our Identity Information and Identity
> Address Information when privacy is enabled. Without privacy the peer
> never learns our identity address, and bonds without it.
>
> Some peripherals need it. The Microsoft Surface Slim Pen 2 only
> advertises to reconnect, after a button press, if the host it bonded
> with distributed its identity, as Windows does. Paired by Linux, the pen
> stays silent. Enabling privacy is no workaround: the host then scans and
> connects from a resolvable private address, while the pen directs its
> advertisements at the host's public address.
>
> Offer the identity key whenever we bond over LE. Without privacy,
> hdev->irk is all zeros, which "indicates that a device does not have a
> valid resolvable private address" (Core Specification, Vol 3, Part H,
> 3.6.4), so the peer receives our public or static identity address and
> no usable IRK; the previous patch makes Linux ignore such an IRK. The
> peer still decides: the Pairing Response masks the distribution down to
> what it accepts. Cross-transport key derivation over BR/EDR is
> unchanged.

Well, can't this then create a regression with devices that don't
interpret the all-zeros IRK properly? And to be honest I think the
device in question is just plain broken; distributing the identity
address isn't mandatory, and it never has been without privacy.

Regarding privacy, I think that would be a more acceptable approach
since it brings better security. That said, we must ensure adapters
work properly with privacy so we can start default to it in main.conf.
This difference is likely where Windows diverges from Linux, which
probably explains why the Pen never even considered connecting without
an identity address field. Actually, it's not that it doesn't know the
identity address; it just doesn't interpret a public address as the
identity address as it should so it expects another address to be
distributed alongside, which makes no sense when privacy is not
enabled.

> Tested on a Microsoft Surface Pro 11 (X1E80100, WCN7850): the Slim Pen 2
> now accepts our identity key, and reconnects on a single click, double
> click and press-and-hold after it has dropped the link. The Surface Pro
> Flex Keyboard also accepts our identity key over its out-of-band pairing
> and still reconnects.
>
> Assisted-by: LLM
> Signed-off-by: Brandon Williams <turbine.bmw@gmail.com>
> ---
>  net/bluetooth/smp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index fc75cf568471..8ce5f92d7ee5 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -636,7 +636,13 @@ static void build_pairing_cmd(struct l2cap_conn *con=
n,
>         u8 local_dist =3D 0, remote_dist =3D 0, oob_flag =3D SMP_OOB_NOT_=
PRESENT;
>
>         if (hci_dev_test_flag(hdev, HCI_BONDABLE)) {
> -               local_dist =3D SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
> +               /* Always distribute our identity address when bonding, s=
o the
> +                * peer can tell who it is bonded with. Without privacy t=
he IRK
> +                * sent along with it is all zeros, which the specificati=
on
> +                * defines as having no resolvable private address. Some
> +                * peripherals only reconnect to hosts that did this.
> +                */
> +               local_dist =3D SMP_DIST_ENC_KEY | SMP_DIST_SIGN | SMP_DIS=
T_ID_KEY;
>                 remote_dist =3D SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
>                 authreq |=3D SMP_AUTH_BONDING;
>         } else {
> --
> 2.56.0
>


--=20
Luiz Augusto von Dentz
