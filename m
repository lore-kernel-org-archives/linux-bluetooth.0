Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F232BCF4A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692246; cv=none; b=rtDN7SeNBl0BgOBeOIEOp4WtQGGgqvw8j/loJjQ/XFKHHhkI8d0o6mapiQw5PqoUoGe2+oHRYG2RKUz/cmkmXRu63xfuZ5XuEtXr/iKJhJkfHiLKPIjLfdIUoOjW0nJmbwMNagLpqvQ8DGLnV4zDcbryUFEklR0xyZW24ppP7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692246; c=relaxed/simple;
	bh=l4rsDP3SBu6mg7fveEOckTZN+Bd8ckVmg1PRdpuBohQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZ7tdAM4N32g28u9rCLN9ZUuh2QgwvyWTYydV46XNanQTZwPybcrjL2cRkqwmehJqgEHMWSjBHuW3gaNHsW8nB2cvhQgNPVGMDb5ZqwAgqRj5kI4l/c+SXo9kxpMfokRgZEqqqbljESxzzCdM9asm28OwhYfumct7QaYPXnvv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvNFhY6D; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvNFhY6D"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32e14ce168eso2031621fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752692243; x=1753297043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDDwN2i8EkcbLLdqh19wdU/WYsXtKuBrFSOoJSOzBw4=;
        b=SvNFhY6DmI6rwaYLbtwqIUNpj3nAjiJ0xP7p+Anl67O98ueOyKYEJrWq4/qAiJIjAv
         6SBl1voVV6nGSnrF0AYof9w9XuRmzJYuV1lv+fmUTARvrdRk3MSI0tQgCu/JZqI7bW/6
         +e85BuTtqHOzObKS8hUuihpIPtQr/BYw3VhpavJUwLNFmxEkvnwxg0kU3maf5PJL9gyN
         hEOwb6gWKrxizpkWbbmWx0On4Ug6TXNmAlfMlcxAvo3jaiJwp26YITWKgZjt1qwkyF62
         S+AkcABLKFN7AHZIZkovPf+GcaKXH7yX+gboN/m4n4l1S3YMtkfZIfwRzfEHAD7ULAkK
         sxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752692243; x=1753297043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDDwN2i8EkcbLLdqh19wdU/WYsXtKuBrFSOoJSOzBw4=;
        b=v/iOL7NKqUqUw3pI6WO4bNSnTwbANAge7OgmYfuRRJjcrkjTv50UjxBtNz7g2nLsbY
         Gk/b8TRx2cDoQgTV04ggKcW8fP2GcF0mwdPXQnrX07q+IpW1GvtQy83kJwDgMGS8c5ft
         8omYcV+52SOnp/gPguw6kNQTKZZZbUm8NUGwtwQ5xaepo+19maR+lMNBtOJSaviPbpY+
         0kfW/KTYfaG1s0/2FQRtiEOXDFWvlI1Ms3sjwc5v1CMxG4qMV5vQEzL7hTskqB/ioGZo
         68bkt+hOBNF0RbRWyRsCAc8k4TR8t527L7t7t7UPpA8jIny3idtoMvjqvEWvEXVFNmtf
         01EA==
X-Gm-Message-State: AOJu0Yx4ESBbcAz5Xf4VInDBd99Ss4YLTeFaxKhF6WJRR0I2JnHIBIu7
	0NbBYlurO/K/JIMlZDgmPE+EeYTIuuVzFj44O3toce4lrcyXl/Mcg7PaUJFA3UHSAT1rTU+/nsI
	BsfQHpvTfQy452H1UWNS0Z3nSziGA/S7RwCyq
X-Gm-Gg: ASbGnct3/ETqreqEs3MQo6aJzw7jyJhTsguPP5lVewnOeA36nWwSqVTurTCZX4+ZgJf
	cs49mIe5SvWUBYUidArW05BkWcAdZb4Ap6rgjjePpK/Y5ZfsIheu1sQu+719yIrguwMp22+sk/Y
	xK8gu8fpM/BEUh7g0O/vLqTNvZFortINz4YURr0T8GhATDDMNU6gra2tGmUgRbtD2+G4//3qkQ4
	RhPw3y5/ryNOlpf
X-Google-Smtp-Source: AGHT+IHMVsejgNtNZsCuqIelMhagfKxAS7LsJX++3BbwhviM5BvBy5ED3psLW1nyuSn2BnuEtjv/psvr1sPiKid1yNA=
X-Received: by 2002:a05:651c:4012:b0:32b:8778:6f0f with SMTP id
 38308e7fff4ca-3308f646fd0mr9635341fa.34.1752692242403; Wed, 16 Jul 2025
 11:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715025217.1005089-1-kiran.k@intel.com> <20250715025217.1005089-2-kiran.k@intel.com>
In-Reply-To: <20250715025217.1005089-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Jul 2025 14:57:09 -0400
X-Gm-Features: Ac12FXy6jmHhJT4MkIX6We8N1rzLyBbzfbsiq73iN_RTRT0VtJz3NPkyb6hLzRI
Message-ID: <CABBYNZKy0b0wBSrty2RqX-ArDv8eU2nrp9Z8opiDO+d7EokDsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fix Alive Context State Handling
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, Jul 14, 2025 at 10:36=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> The firmware raises an alive interrupt upon sending the HCI_RESET or
> BTINTEL_HCI_OP_RESET command. As part of handling the reset command,
> firmware initializes the hardware and data path and raises the alive
> interrupt. Upon receiving the alive interrupt, the driver must enable
> the data path and grant RX buffers to the firmware before sending any
> commands.
>
> The alive context maintained in the driver must be updated before
> sending BTINTEL_HCI_OP_RESET or HCI_OP_RESET to prevent a potential race
> condition where the context is also updated in the threaded IRQ.
>
> The issue was observed in a stress reboot usecase (1/25) using "sudo
> reboot" command where the firmware download was failing as the driver
> was not granting RX buffer to firmware due to race condition.
>
> Bluetooth: hci0: API lock is disabled
> Bluetooth: hci0: Debug lock is disabled
> Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> Bluetooth: hci0: Bootloader timestamp 2023.43 buildtype 1 build 11631
> Bluetooth: hci0: Found device firmware: intel/ibt-00a0-00a1-iml.sfi
> Bluetooth: hci0: Boot Address: 0xb0301000
> Bluetooth: hci0: Firmware Version: 167-12.25
> Bluetooth: hci0: Waiting for firmware download to complete
> Bluetooth: hci0: Firmware loaded in 99902 usecs
> Bluetooth: hci0: Alive context: fw_dl old_boot_stage: 0xa0db0003
>            new_boot_stage: 0xa0db0003
> Bluetooth: hci0: sent cmd: 0xfc01 alive context changed:
>            fw_dl  ->  intel_reset1
> Bluetooth: hci0: Waiting for device to boot
> Bluetooth: hci0: Device boot timeout
> Bluetooth: hci0: Firmware download retry count: 1
>
> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driv=
er and firmware")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index a17c438784ae..6680ef3207ed 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1988,12 +1988,6 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>                                 btintel_pcie_inject_cmd_complete(hdev, op=
code);
>                 }
>
> -               /* Firmware raises alive interrupt on HCI_OP_RESET or
> -                * BTINTEL_HCI_OP_RESET
> -                */
> -               if (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D BTINTEL_H=
CI_OP_RESET)
> -                       data->gp0_received =3D false;
> -
>                 hdev->stat.cmd_tx++;
>                 break;
>         case HCI_ACLDATA_PKT:
> @@ -2014,6 +2008,21 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>         memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
>                BTINTEL_PCIE_HCI_TYPE_LEN);
>
> +       if (type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT &&
> +           (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D BTINTEL_HCI_OP_R=
ESET)) {
> +               /* Firmware raises alive interrupt on HCI_OP_RESET or
> +                * BTINTEL_HCI_OP_RESET
> +                */
> +               data->gp0_received =3D false;
> +               old_ctxt =3D data->alive_intr_ctxt;
> +               data->alive_intr_ctxt =3D
> +                       (opcode =3D=3D 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RE=
SET1 :
> +                                       BTINTEL_PCIE_HCI_RESET);
> +               bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x alive contex=
t changed: %s -> %s",
> +                               opcode, btintel_pcie_alivectxt_state2str(=
old_ctxt),
> +                               btintel_pcie_alivectxt_state2str(data->al=
ive_intr_ctxt));
> +       }
> +
>         ret =3D btintel_pcie_send_sync(data, skb);
>         if (ret) {
>                 hdev->stat.err_tx++;
> @@ -2023,13 +2032,6 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>
>         if (type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT &&
>             (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D BTINTEL_HCI_OP_R=
ESET)) {
> -               old_ctxt =3D data->alive_intr_ctxt;
> -               data->alive_intr_ctxt =3D
> -                       (opcode =3D=3D BTINTEL_HCI_OP_RESET ? BTINTEL_PCI=
E_INTEL_HCI_RESET1 :
> -                               BTINTEL_PCIE_HCI_RESET);
> -               bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context c=
hanged: %s  ->  %s",
> -                          opcode, btintel_pcie_alivectxt_state2str(old_c=
txt),
> -                          btintel_pcie_alivectxt_state2str(data->alive_i=
ntr_ctxt));
>                 ret =3D wait_event_timeout(data->gp0_wait_q,
>                                          data->gp0_received,
>                                          msecs_to_jiffies(BTINTEL_DEFAULT=
_INTR_TIMEOUT_MS));

Looks like the comment about moving every wait_event_timeout into
btintel_pcie_send_sync has not been addressed, or there is a valid
reason why we are handling this as post processing of
btintel_pcie_send_sync?

> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
