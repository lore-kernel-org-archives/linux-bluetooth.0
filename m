Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941233A9E8
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215155; cv=pass; b=qwtVHSFqzCP8X10zvZ+ZGFFdrBV69UzjxM6FGsp4g2hxpkQzgx5trKqKUKPwqXUHNdZEBEA9PXKMsEG/Q1AHekdMU+PZIjiVc4SnnPpQEKnpVPEqUremTaoKerX8AKvY+4DcOtiBoUGfSixUSMqzdLcdrtfVZPsb2ZgRfrr8XjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215155; c=relaxed/simple;
	bh=krRIe+SWQ9UydTxaBCAVuzteStmc8b0sHjGvDVOk5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiroJkk8I4iUsZU95mLG15qnZM1JGPvRQyZNpGqg6N/452ytEzn7y5yqYth1i/M/X2K8Uv51jG+fGWckJamfZPM0NyywOTjSTwIovwDrvnAlEKAokUcajSOWmKapHmSUNrqMOlxY85qFS3PNmQ57tyyjhl3GJNeFZrSpsiNWL/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITErD358; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITErD358"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7ca947f9b00so34923527b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215152; cv=none;
        d=google.com; s=arc-20240605;
        b=HeguXz6lSFbWBU8gmmxWaFHYPPiuPQ2Ao1Ib3/znZ2dSLENmlHCQn2NOWPfweZdXzc
         sJnjiT333wGvjx3tk7goFxCKawn42TJeGpKfvVXKqlI7flA86acYnitgQe3OHmYQu46N
         eIOlcZPgd3Rkwr1Jnqu4NfgOrL6jGYV9AsYs2b80SRomnFtPDPOedYxVzy9nGzYs8MvB
         ygCXfKAfxS5oOTiNqb0Lr0VKtki+YDIVXnjDqWqLmsOSBJdjFcUWPEk/kbcmiT+5wBWo
         BP1FJ5Lxp57LOoaaH+vZFL5Z5xUzc0vFKU21gryC0jGbfvITtoZ3kkKCeOwi3bj4PHwZ
         Aqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        fh=OkLSvJ9s2wYcck9VTwOam5iemfWW6J1LC6aU6Z7ibdI=;
        b=Dxmja2ojGH577ONsvWAvst8whmwJvVDqDePTuUHqXlg9S4mjj5DOzk2m87o9mbyC1g
         R6ZgAGk0tDvN1QCh923hlbSXA+wRE0Va3VL9zv44Xyqm6PwgMOlDiblMXic7y4UuHfkR
         vtpd3Il42d9zg0Ce4U3kmKp+VG0PmcWvzuiBYBPXQFVWBP31rX27j4JC11VBOKrrv+lW
         rmyQZdQw5ZE745bc38lKqXvLf8s1lWK2EpW4DU0CeXd7fNYkyf4uTG3x+4y/unjTASF+
         LOU1Z4uIy/1IJDrxRy5yOV6iwkHybUOWznNrutmhcRJlQItng+chrVwVHbf88G3aqu8y
         OPnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779215152; x=1779819952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        b=ITErD358uh7yiF7OORzuATGt12jzMIsnMPzOIdNjO4O1dxYtcqJqWPWN9iXQxD0BQH
         dZKrpOO9ZAXEu9AiXomerItB659YABVzgRnCQyjfKa9LuoppI4ZyWyg7yltHzXUrqA4Q
         83NaUfM6eqm+kWHnggT3ecawMCEF6yJcHqp/eg/PEb/Y11+nKMXKYJ8nLkIC592Ev1Nq
         u9cwFNlX69PPPOVDuLvYLkzkQM7DmZ7XOX6lTOduk7YJArw5Eg8us8vfxSUuerutq/HK
         99L+WiqBcAaUw2pt1ajAfnnH0Erv+FB4J39dM/Mghw7I0TrmvOolkwnvPOSe83cy/eLT
         AUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215152; x=1779819952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        b=ivkqpbiXPJIry1xxDK4c9jTSpLkCx9kVLxBlktgbgJYbN8/7FGTy1tQkk9TqDmhGpv
         gTYeOJEEx+z9j/y1TWpioJllv+be79ItxCFXFucrqiZSJSDeJmEa9I59i0oDyBo7mZS6
         lwduqdqE047/8VwiBBKSNErXytS1jNwqSxPePm87/Izv2kHIs3myZov3zQHIIvw+Lw5X
         cJxlU3uUYmFbqaL2tZPHFt4BTO5GoLkvtOoIlrhbsU5b8fbi4MPx8K/YmlEIIk71mesp
         CWWV/aALwzh7JAh4S7kEFpu/oxUBKrqoFKEXqN0ijROkU6xRfCq1nEzV3WZy7NVNDt9F
         YyVQ==
X-Gm-Message-State: AOJu0Yw2Zufzei4zr6JriJ5WnVg5vdEsYpZ0lMRt4Mi6uNF1WUveDCja
	tOAP9oeKHkYRbvg/k/QlegVTxhTwf8lguBfn7C0zPrg+W9xVIO7/fbvmlNCW8FYGyglC17YAPCz
	7bFzbbI+dKKQbeVpBSevSOupeOQ3YNYg=
X-Gm-Gg: Acq92OEDBT4cGPhoB0MCWWlY3uPixPTYa+UAN0u9C+5W/cZIWwjt9oyVh6Q822nbL3g
	Q1EaBv358h98aVEis023J083XX86ZqmT/55pmzTfVnHSo1S2ArpCMT2yHw329ekivcokmHGxcfe
	34h18ffccxZJ03czd22X0Lu+JYOyyktSTogfSHvO4oq6A9DVnEmQ7Uj+ANtnQ7x3MH18iWRdVmf
	SFFXtIslCbtOHKr2sqSPamKt/WJUMEzw5DXpAnR1Nx21HOB17sa97lC1DeoAuETKv0gfWrkhrWQ
	FnWg4AgeQJFSsnSPA0RCeTA53/QqzzHIRlLgH/d/kjqaEtNvL6QvUl0isO1acKCKKLPTdg==
X-Received: by 2002:a05:690e:1913:b0:65e:3bde:1bc4 with SMTP id
 956f58d0204a3-65e3bde3490mr14311058d50.46.1779215152099; Tue, 19 May 2026
 11:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519042017.29564-1-meatuni001@gmail.com> <20260519181749.15746-1-meatuni001@gmail.com>
In-Reply-To: <20260519181749.15746-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 14:25:41 -0400
X-Gm-Features: AVHnY4I7-gjlkVDjFs7yHIvtQGGx6X0cwJO5cT0tfa1y3yINopyHlcyV6aiZJ10
Message-ID: <CABBYNZKFZpUh-nb-8wLQ_fy1U04BAwUdjQikbuzfrzCcMe=VPw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad,

On Tue, May 19, 2026 at 2:18=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
> immediately dereferences hdr->addr and hdr->ctrl without first
> validating that skb->len is large enough to hold the header. A
> remote device can send a crafted short RFCOMM frame over L2CAP to
> trigger an out-of-bounds read before any session state is checked.
>
> The FCS trimming code that follows compounds the problem:
>
>         skb->len--; skb->tail--;
>
> If skb->len is already zero the decrement wraps to UINT_MAX, causing
> skb_tail_pointer() to return a pointer far outside the skb and
> producing a second out-of-bounds read when the FCS byte is consumed.
>
> Replace the open-coded cast with skb_pull_data() which validates
> skb->len against sizeof(*hdr) and advances skb->data atomically.
> Save the original skb->data as frame_start before the pull so that
> __check_fcs() receives the header bytes as required by the RFCOMM
> FCS specification. Guard against a missing FCS byte with an explicit
> skb->len < 1 check. Replace the unsafe skb->tail decrement and
> skb_tail_pointer() call with a direct end-of-data index and skb_trim().
>
> Note: SeungJu Cheon posted a related patch that adds equivalent
> length checks inside the individual MCC sub-handlers
> (rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
> rfcomm_recv_mcc). That fix and this one are complementary and
> independent; neither subsumes the other.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
>
> ---
> v3:
>  - Replace open-coded cast with skb_pull_data() per Luiz's review
>  - Save frame_start before skb_pull_data(); pass it to __check_fcs()
>    to preserve correct FCS validation over the header bytes
>  - Replace skb->tail decrement with skb_trim() per Luiz's review
> v2:
>  - Fix GitLint B3: replace tab with spaces in commit body
>  - Add Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/rfcomm/core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..66eee8a86 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1741,23 +1741,29 @@ static int rfcomm_recv_data(struct rfcomm_session=
 *s, u8 dlci, int pf, struct sk
>  static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s=
,
>                                                 struct sk_buff *skb)
>  {
> -       struct rfcomm_hdr *hdr =3D (void *) skb->data;
> +       struct rfcomm_hdr *hdr;
> +       u8 *frame_start;
>         u8 type, dlci, fcs;
>
>         if (!s) {
> -               /* no session, so free socket data */

Doesn't seem relevant to remove this comment.

>                 kfree_skb(skb);
>                 return s;
>         }
>
> +       frame_start =3D skb->data;
> +       hdr =3D skb_pull_data(skb, sizeof(*hdr));
> +       if (!hdr || skb->len < 1) {
> +               kfree_skb(skb);
> +               return s;
> +       }

Add a empty line after if blocks.

>         dlci =3D __get_dlci(hdr->addr);
>         type =3D __get_type(hdr->ctrl);
>
>         /* Trim FCS */
> -       skb->len--; skb->tail--;
> -       fcs =3D *(u8 *)skb_tail_pointer(skb);
> +       fcs =3D skb->data[skb->len - 1];
> +       skb_trim(skb, skb->len - 1);
>
> -       if (__check_fcs(skb->data, type, fcs)) {
> +       if (__check_fcs(frame_start, type, fcs)) {
>                 BT_ERR("bad checksum in packet");
>                 kfree_skb(skb);
>                 return s;
> --
> 2.54.0

Other than that looks good.


--=20
Luiz Augusto von Dentz
