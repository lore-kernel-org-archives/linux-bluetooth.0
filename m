Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64A387363
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136690; cv=pass; b=lCJEs9gwgxgOPGWZnETlILz/JaSmzMqmjoIzUOgWjqTGBLF6hYKaKXHwrPXeIloa4ANiTDPHoz51F9bDuOgAI1YELWzzlMJova7MR8jGd6mAZNB6ADj3BmRLX1PTIfkKvyFw9w7du9aeACo9vKN7fS+rEQf9Wzqcd9iKaGu2kHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136690; c=relaxed/simple;
	bh=lkOULuQbXuPv/kXgjumTZDY2A2U6HNDqTBg7wLDDuWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMe5OAfozQV8AghhBsrLAiyjmX0PpqWsMvSVq8tOh0llyz8WaNtET5BwsUkpU9CGrVqQhTfVVZe57ygcRk4Sp31B4riAWZ+frI6pok9fIncOT1xCTZ+vpLF8tCMOlRCInsQ1+brZWorCSZyJnIHE1sSX/mm6f7ciz2y7176qXdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpd3nf3C; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpd3nf3C"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651b4d09141so2711318d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 13:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779136688; cv=none;
        d=google.com; s=arc-20240605;
        b=NC5u2fzvt80Q7VREhHjibRVEwM8J8UYOToUnSryoTPhJRot0SzPsA645FgaI8TcQSP
         aug15FEZ+RcgdUjSeqyoTh9ZCWt9/FV4k0XdVguYECVic85fA9BzKFIMrh7xK+/4Fk22
         rYg3ACDRKSiLwCnIi4nn63JuxnprXWM+hQXrIuk09twQTImMWULsXkwDwfW7+nCoUbMD
         eCpQU4pDrnmS2N5BZjpbAIOHh8lxpkQIIlZnWdSRV2/aS2Rb8AFngRg/dNwiSNXxgsta
         QYXR4wI/zNh58y5cfsMrdmO3uI3Wwf9VMA+OEFQh9c4gbe1/MWYWsWU8wMkids6xbcmB
         ufwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pia0gWpXc6Y4Sib1fFoVK5T2yrWShp0Db9uHVgX/Xl4=;
        fh=HBYvj/8bRhg4+iZLzCWFK/F6n1asoUre0hLnyKcVpQI=;
        b=C6EdkOiAXK/k1WAm3leMpSuI1Laar6mPeTyDuHqwAtnZeVuPJwzX17dpB1EzYiLSyK
         wYzO0G5LsI0S1akBzgK8qoVf7mS/ECw/Hp1uOrlnJAPFsJoKKyADZxZy32mgHOxQK9pp
         +6Ama+fuoA8D/5YdQ4u/5HNTrMmdoLgj+VnEIgdXJv+FxQkZqj33Oq0hYDo7+hiLaRUu
         jlVfceZ2eZ8rvqcaDixvER/m4sCkA4d0GFZ7s4/H+2NSwzqm9vH36So4CYyyuPxLzAVk
         KhFZqL8CFN6V6ZUpjHSBaZTWse0osDn0Xl1jslRaSR2y6ADmudFpcDg81P8GZzPgjzNq
         Y3CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779136688; x=1779741488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pia0gWpXc6Y4Sib1fFoVK5T2yrWShp0Db9uHVgX/Xl4=;
        b=bpd3nf3Cvd2+FTkP884g4fYZXnjV3+vAluOVoF8qTO/altJdvLmTt5eHRZ0xRqRE+Z
         VbsOSgLXNpFYN4/DXnXihrBewE21uxi8vQ+sWFGIWY23I1I8uNK6Hl3r3iVXPp5hEX/n
         4zvsWIf31bB4TYGnJjfmR29IrqtNpR4CreIFg+jZlcJkHgb34Eb8He06WR3tVt9mLAMr
         P5kUQ6gsIqjcHvAZPZzLXiosDrYXLAXjL76DwJGqBz7nOwePBe/a7HQ6/o4PJwPhmo/n
         dt++u9UR36ED2swS8+HP1UeqtA6lMxjEO4uK44GV8FdWhwKjelKEqDYeSnjVQWl7tLv5
         W8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136688; x=1779741488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pia0gWpXc6Y4Sib1fFoVK5T2yrWShp0Db9uHVgX/Xl4=;
        b=A0PJKntqLhZajJ/p48AKhX9cJUplEDKElyyF4wfU4r6yI+LdYggJKTmwrn2s3ZzDZd
         1sFGTi9GnHMhXmOO4Z4OlIZ+pW5D579/CGlepvFG3hTJnIDxdzhbHTjQBWrSPR85G9qK
         vGfpK7oKEl78WDR9IU4v9pFUqLNiPd1bnrN9PIflb7AA6NsDSfRGUuLEVLqdPPbAGff2
         TV/hitI5IAT2pRLy3ORDFW39HOs1l9u4WuSn8S1Is3f9sBUf+Gz5pmUAfSUpSyUk8jzY
         rEdtPJxRmlBr3vwCdxu4T5QOh2nD2VhaQVodt9Naff8gA0LL9IPh6UuRh0n/HGdiEOSC
         Mxzw==
X-Gm-Message-State: AOJu0Yx5UROl6Wfj6vvO/j6NJTB56Mwn69+VocEYXBf54sJWOOHEk+2l
	CnrcFwlE5RVC40A8IL7zEG1Siiiqv/WqClu4+Ct67pDOV0A+MDZdnxBZ53jhvcldMTMkFsjJSQa
	eLqPeAY5mLhQZRI05UcZYNiSMXTKRQcQ=
X-Gm-Gg: Acq92OEFEij3jum0HFzRPeQoxxi/Uz+H8EWB4Q33fHnxw+L1OfKSNDiXP7hA0JcFZo2
	7OTBEh5fO66oOl8Gri47f0t65Mi4Q9tFVR1f3oYL2QeDxyfmHVsabCTCzrBVSctOiVpzANzpwGN
	UlEvlzcsGb8AC7W96EygMnw1Uwe8ufL2swXA9GLFI9FSlStlY9/X3dA0bRrXv+3mzFyukddfdN0
	J5f8D57C4limbaqL9t5666Zo0fkIKqMuwfiJYF+CVSpQbv8PzEb17EKHLd7JFsuA327OJ4Gp2Pe
	iOmgaS8paj/h1jXDTHJkfMIXsZ6ubOBAP6PHGaqs16visa+u953ViT7POfnnbITBXkTOo0PIeLZ
	gFw==
X-Received: by 2002:a05:690e:1444:b0:65c:27dc:4a64 with SMTP id
 956f58d0204a3-65e0afea987mr17033770d50.3.1779136687833; Mon, 18 May 2026
 13:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517145417.31910-1-meatuni001@gmail.com>
In-Reply-To: <20260517145417.31910-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 16:37:56 -0400
X-Gm-Features: AVHnY4KGFMjZR3VGGye6YVkW1CljH3DfkRbzH2PUROr47mgV_JlPleT-b4haKFg
Message-ID: <CABBYNZLcs4zagQ289T8HmCoFRJc2KYt2naU9PeZFirWAiYhsBA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, johan.hedberg@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad,

On Sun, May 17, 2026 at 10:55=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> smp_cmd_keypress_notify() accesses the received payload as
> struct smp_cmd_keypress_notify without verifying that skb->len
> contains enough data.
>
> smp_sig_channel() removes the opcode byte before dispatching to
> command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
> payload leaves skb->len equal to zero on entry to the handler,
> causing a 1-byte out-of-bounds read from the heap.
>
> Add a length check before accessing the payload and return
> SMP_INVALID_PARAMS when the packet is too short, matching the
> pattern used by other SMP command handlers.
>
> Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress not=
ification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/smp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 98f1da4f5..4c98e2a3a 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2932,6 +2932,9 @@ static int smp_cmd_keypress_notify(struct l2cap_con=
n *conn,
>  {
>         struct smp_cmd_keypress_notify *kp =3D (void *) skb->data;

Perhaps we should stop assigning it directly and instead just use
`skb_pull_data`, which performs bounds checks on its own.

> +       if (skb->len < sizeof(*kp))
> +               return SMP_INVALID_PARAMS;

I suggested we add a bt_dev_warn_ratelimit with something like "Too
small packet: skb->len %u < %u" to make debugging easier.

> +
>         bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
>
>         return 0;
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
