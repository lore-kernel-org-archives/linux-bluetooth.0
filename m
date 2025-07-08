Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA27464
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007888; cv=none; b=rBAGMC1PHdOKHIFOdwetR753HSUmd8zZRwtFqS93uXqn47YUPelk68qzj+oKXcY5LLLGf3tAS+6/2HwRZthv4UdXORJsBXdojMKHXx1G57zc8L82SeP4EDj/Kh04wgO79jSn/y120p3sEiLyrJI1msunRrOhpQhiXgqzIe3eCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007888; c=relaxed/simple;
	bh=fHeFBr9tW3T6Lins+5h2uibHbjo7hD2BbifBb+JAEpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sX5KbgMRcSMLWnHBUqitYiPRlzC+dTIloLwZvfEqkdUE61MoNle5Nzz3GHlFk82dHwLqR7q+CiiOeXjyics6kEEwnKSTPaEyYBZ+P036e79wfAN4Qs2CiOpH8ZMghkqlimvsxovjJP1/7THcZse7bxbFs9MJBHy8gwBSbFSvJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCp3DOpZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCp3DOpZ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso54928781fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752007885; x=1752612685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxdQ5/EL7z+YsYMLu9hU3/jCkSuh8yJLj1DUssh8zu4=;
        b=fCp3DOpZUY0LUms9WpeLASCe7Yrvc+WXkAFI6tIs8hqYcB4SYPveCzeVb22p7dvwVd
         QHkqwBDqlkFD8ERB2zTFVb4EIejS71vQiVN4NCoVGxfivpG0a746mDp80ITW561vcJ8e
         lfW1wWIp1tJ9PZoSh1hs6sMtdgQ9JT+dZDfGmswDPkg9L9e205UijdaiAoMUvB0O74bS
         u9ae+y53AcZHxF/Ah0gT09zxGik9uPPt6nBMWbfSm2Fb4j5fPrvU+M2Bqr5vKGe6feBk
         PPlYWPs9Px66sklp66D46WFSVhSXtaQOlHIot7QV7ehOl6eI/DzNMAT8VSW5m0Rnddkc
         Zs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752007885; x=1752612685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxdQ5/EL7z+YsYMLu9hU3/jCkSuh8yJLj1DUssh8zu4=;
        b=c1R9CcEpcMN5cJ2HmhSglHSQjTGL8r3XE5bxCkh3lBLyiYhQRJUrNngtVwgKmUoPhx
         4zjXZ5Cg3t/ujPbGpn53m0rUeZQcYCIs9Asz28jFPNk9JjYGrncRGspclz2r7/WW7UII
         r1hfjA9JyvoMqrmkfdnCPVhz4/j0hZb7wm4ozkz4t1ugfhx7xbyIdrrm4+RASwo27bxS
         2op1V8MwWCSlRULRtN5FtkWeKOtb5AKkjSiPSxz6mhO5Tn65sgc0banNhzfIuXiRy12H
         b5Uh4y8zkePSrqSKFN+v81UEf5gXD/N18eqQhPqm40SNoiWXLr3DrP8FoyzmFX/K/JMX
         cfsg==
X-Gm-Message-State: AOJu0YxycgfDx2Eu+xyMTfGlzSmSInI0KgYLPZQKxCQ951NPjxlXUJ3K
	e4i1turAB+DWqvvFwoSgj7Gnc1/+jdwUiNidMmZW5xNDWZCkQk4IN/lDLCAYCxd0DqOKwwzO9bM
	YIYfumVzNuOlwbgjFxycETdMjkH6hhV1DeGs3mCg=
X-Gm-Gg: ASbGncsUOgsb/4ETHlWSMr9ndjmr/Xd6GHG9ac0p5u964IttRQWrECAG1Tfp9fwATMe
	9HRNYHh5XBI3FDoA95wtxM7r0Jq4eT8H/0KtUgL2C7Am7b/+CM6YazZgcnRrXxF6QuHXN33Unz4
	9VSHw24F0BeacdFMVRNi1XmQbYHTZaWb6TZ2P5RtKAXbgvPw==
X-Google-Smtp-Source: AGHT+IHzkmWB38gywHtaAyAKUtWlhmJXVNrnsByUvZ7eFfTMXEuCIW9O3gZERtgGpDMWJhfiLrY20V8jukYGLmC+bV8=
X-Received: by 2002:a2e:8a95:0:b0:32b:93fa:2c0b with SMTP id
 38308e7fff4ca-32f42d33d09mr2687671fa.11.1752007884391; Tue, 08 Jul 2025
 13:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707034657.929092-1-kiran.k@intel.com>
In-Reply-To: <20250707034657.929092-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 17:51:11 -0300
X-Gm-Features: Ac12FXzNPOalFnqPVMzWfcah_6otCaSB5e4NV_0qYP5eKYfZ5drEa9JUK61Fr5U
Message-ID: <CABBYNZLukco6ShSh_9NP4GgpukY7wuYcAX4Xhg00AdkTwOySEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Sun, Jul 6, 2025 at 11:30=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> Firmware raises an alive interrupt upon receiving the 0xfc01 (Intel
> reset) command. This change fixes the driver to properly wait for the
> alive interrupt.
>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driv=
er and firmware")
> ---
>  drivers/bluetooth/btintel_pcie.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 1113a6310bd0..f893ad6fc87a 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -947,11 +947,13 @@ static void btintel_pcie_msix_gp0_handler(struct bt=
intel_pcie_data *data)
>         case BTINTEL_PCIE_INTEL_HCI_RESET1:
>                 if (btintel_pcie_in_op(data)) {
>                         submit_rx =3D true;
> +                       signal_waitq =3D true;
>                         break;
>                 }
>
>                 if (btintel_pcie_in_iml(data)) {
>                         submit_rx =3D true;
> +                       signal_waitq =3D true;
>                         data->alive_intr_ctxt =3D BTINTEL_PCIE_FW_DL;
>                         break;
>                 }
> @@ -1985,8 +1987,9 @@ static int btintel_pcie_send_frame(struct hci_dev *=
hdev,
>                         if (opcode =3D=3D 0xfc01)
>                                 btintel_pcie_inject_cmd_complete(hdev, op=
code);
>                 }
> -               /* Firmware raises alive interrupt on HCI_OP_RESET */
> -               if (opcode =3D=3D HCI_OP_RESET)
> +
> +               /* Firmware raises alive interrupt on HCI_OP_RESET or 0xf=
c01*/
> +               if (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D 0xfc01)
>                         data->gp0_received =3D false;
>
>                 hdev->stat.cmd_tx++;
> @@ -2025,17 +2028,15 @@ static int btintel_pcie_send_frame(struct hci_dev=
 *hdev,
>                 bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context c=
hanged: %s  ->  %s",
>                            opcode, btintel_pcie_alivectxt_state2str(old_c=
txt),
>                            btintel_pcie_alivectxt_state2str(data->alive_i=
ntr_ctxt));
> -               if (opcode =3D=3D HCI_OP_RESET) {
> -                       ret =3D wait_event_timeout(data->gp0_wait_q,
> -                                                data->gp0_received,
> -                                                msecs_to_jiffies(BTINTEL=
_DEFAULT_INTR_TIMEOUT_MS));
> -                       if (!ret) {
> -                               hdev->stat.err_tx++;
> -                               bt_dev_err(hdev, "No alive interrupt rece=
ived for %s",
> -                                          btintel_pcie_alivectxt_state2s=
tr(data->alive_intr_ctxt));
> -                               ret =3D -ETIME;
> -                               goto exit_error;
> -                       }
> +               ret =3D wait_event_timeout(data->gp0_wait_q,
> +                                        data->gp0_received,
> +                                        msecs_to_jiffies(BTINTEL_DEFAULT=
_INTR_TIMEOUT_MS));
> +               if (!ret) {
> +                       hdev->stat.err_tx++;
> +                       bt_dev_err(hdev, "No alive interrupt received for=
 %s",
> +                                  btintel_pcie_alivectxt_state2str(data-=
>alive_intr_ctxt));
> +                       ret =3D -ETIME;
> +                       goto exit_error;

This should probably go into btintel_pcie_send_sync instead of doing a
post handling as above, also if I read this right then we have to wait
on 2 interrupts when it comes to HCI_Reset and 0xfc01?
btintel_pcie_send_sync already waits on URBD0 this also adds GP0,
having 2 interrupts means proper ordering needs to be enforced,
otherwise if GP0 happens before URBD0 this will probably timeout, if
this is done on purpose let document why we think it is ok to do it.

>                 }
>         }
>         hdev->stat.byte_tx +=3D skb->len;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
