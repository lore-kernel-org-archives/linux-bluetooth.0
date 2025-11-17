Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851120322
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409570; cv=none; b=M/LnoxzSOZyb2vmhvnMNmZEOm5+Ze0sb0um8fObsvDU95PGXtjRn3gJqINdi/VrneSDo6NOQO68N8Z4C/t/DWhKSu8K6esBzy4jCPSyeoe1XMHYtCoIxg2rCi2VeKZ0au+Gx6OFVv1snQtYSevqL3xyZ37L+7NTsy3CQcvI8pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409570; c=relaxed/simple;
	bh=6QmBViCBeMj0ZnkLVxiwTjNxMkUtPQQbf9/j/6YiH7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPyB7VQ7E0VA34uo6rAIYmFlKR+HK4QjSmCBJuffCFpMsV6mkA/K5HScLVQZIlSJJPN4/+IiCwFK3pBZJz7tLXvLTI/JC21Er68lFz5vIvu4/LTiLIWKelg0EGVogNltngcRchCAk5OyGCR7jMslPGED/+6IHGaJ1S71tfyUuf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDBK6Kqu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDBK6Kqu"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a415a22ecso38975381fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409567; x=1764014367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtyUocQYdTmQdUW0BZchQWwtAm1os8O++9wgs8wo/pg=;
        b=BDBK6KqujpQQ8dSThsZv9bf7GYbkZ7HNjzQXHsLKdCvOq6ocVhbYFKYGN9gAofxXHj
         RdmBJqajdDHbMEMNJChTgrxC6j9nE5PwBKrjfl4xus1KZWmDBVOo6r2laIj18J1KK3zJ
         9wm5ky37YnKis1Ge8q3ohCgBtAbF+w69JwrXdOOs0dzcuhrZvLXoxeIFiiepyaO5y76e
         P/XEPLPfQ9k3PH1bzG9P1yBKUxzrUKU9QUmKYGp+vsXp7Hjt3rq4FSfXS9NmEMoY/Noh
         f9VLYcA9u3Bpzk/hkxlrO57LvGPKVJrpPD/rf574yMSpLFWZEFcYlBq87wp9EXO/biNw
         oVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409567; x=1764014367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YtyUocQYdTmQdUW0BZchQWwtAm1os8O++9wgs8wo/pg=;
        b=mYIxiAbJU7BlYIqz3hlmdRFpmKa2FvQgzaVzl57dnRKd/i7+vqUmbsY1am0MBLNsV8
         ml53trA1I5OzVHe0kf6FothNgLzDDhI5FuH2ONiRlf6MqkLqsS5TdOIKOVhq2xERu7gl
         YHX5V3p9A467tNLdq9qNQpZizrDDOKYm7LmK4KcYoDzccmdGwcgAu15UhmJ9I2nWxdx5
         UgR1s0qQWQHLKN5dX4v5VdFDaCzZXTJ2utH+rJ+KrBfM4bMFNayPmldI3W20Ua1zKTJJ
         RWD7GyChL6oZDeDzC2OjO/PHC9mAwzcbSf1Y6KHh3OFTNjqnonMgodJjJAUPjJaJUp4P
         G1AQ==
X-Gm-Message-State: AOJu0YyjoX0KEBuXJQ0rAHEVGVacA/dNy2RbSyws4R+Bl1vk37hiK6jf
	eUtB/4DhEuq4nwLzYt5TxdygI3sbWOLsYREJz7+i608pDLWPk0zpspKv0CHr9iTdPMXBnV73Ilj
	f5tzYmoNI602cASr20IV7j3EOXy6KfOo=
X-Gm-Gg: ASbGncteDyLzqMosn9oz9DNoouQsIL+gdQB1OmDzO9iI1Nss0+tbkJzZDNvWqhqF6QD
	rlrKwtmL17qLjVnhG3ZEppwINgS6ijoOmS41MJdV95ECk3Ne1zer18oxrkd8vOuhPbFREWE3pg0
	V3obgX+2cieMi1IMNp93HX+Vh/YpV47Fj47MFjZysl4VckRCXzPCuf9I/zQ8X8bN1w1ViP0EZek
	CWDlElqhmeHwNKwROzQ89pgDBHTdSB5ihcYA+g468C7rt4GKkDVntsmB/ggpsjUR1wMFQ==
X-Google-Smtp-Source: AGHT+IGkO/J9+yCy5llzWOhOA/LSCJ3nnaN23CX9RGdNLZMdRfGu0hv2uZSQkiiW8W7DqYNvvoVzgEY+ecz7NEujmds=
X-Received: by 2002:a2e:ae1a:0:b0:37a:3d66:8047 with SMTP id
 38308e7fff4ca-37bc817593emr1473921fa.13.1763409566902; Mon, 17 Nov 2025
 11:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d6e3b719f6dc3922d653795869ed7bcbcf086f7.1763212292.git.pav@iki.fi>
In-Reply-To: <8d6e3b719f6dc3922d653795869ed7bcbcf086f7.1763212292.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Nov 2025 14:59:14 -0500
X-Gm-Features: AWmQ_bm_-w0E8HLk17EujdgBm3b6tFBUAGmC7BATUOKL3rADSNWpSn3FT3P7KZw
Message-ID: <CABBYNZJNpk5z5kb-G_kEpApzj4wxQBqLJzBWR7GLKX7hihoZGg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: fix accessing consumed skb
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Nov 15, 2025 at 8:12=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Access to skb after giving it to the driver causes a crash in
> hci_cmd_work().
>
> Do all checks before giving skb to the driver.
>
> Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer for =
HCI_OP_NOP")
> Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D25e9c406cbd26c66c417
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

We might want to fixup the original change.

> ---
>  net/bluetooth/hci_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9f686e5903a1..36612b4c098c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4162,16 +4162,20 @@ static void hci_cmd_work(struct work_struct *work=
)
>
>         /* Send queued commands */
>         if (atomic_read(&hdev->cmd_cnt)) {
> +               bool is_nop;
> +
>                 skb =3D skb_dequeue(&hdev->cmd_q);
>                 if (!skb)
>                         return;
>
> +               is_nop =3D (hci_skb_opcode(skb) =3D=3D HCI_OP_NOP);
> +
>                 hci_send_cmd_sync(hdev, skb);

Ouch, not sure why it didn't trigger anything on the CI side though,
anyway I think we might want to integrate this directly into
hci_send_cmd_sync and then have it return if the skb was submitted or
not.

>
>                 /* Don't trigger cmd_timer in case of HCI_OP_NOP since th=
ere is
>                  * no command pending.
>                  */
> -               if (hci_skb_opcode(skb) =3D=3D HCI_OP_NOP)
> +               if (is_nop)
>                         return;
>
>                 rcu_read_lock();
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
