Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24EB14A60D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006675; cv=none; b=s3Zx0k+pprOhbJCUZdRjKvX/2G5Evm3rUQsJGSyeXVRDspQvnzfabBVkq7TLcGqPyxO6ACQW9KAahGXm2akZu5ejAFcoXswKKhU6Td5YydDCge+w9hFkXm2dBARow5rbywSCMECZJt/exUV6wLFEsDbKwUU3hmHw3+Gld/V/DuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006675; c=relaxed/simple;
	bh=qUhFGZvrq+LhuCvG0B7x8ph7WRstUdG7cF1O2+otdpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHqHB4I8Y548jNOvdFylTdmoVTI/4VD/+BulXyW4FeVIgkHfirtjwDwV/5AmrI1R3MpCOg8Vl5kV71BVwfLiva+KFqmQHNL1ramIe/tGC0Dht9cRJrivj4ey1bqpm0pSa3OBIxdv5NXohQHpp+IW9stdWqLNGqyxV+MMFpLLS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4MkDdCe; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4MkDdCe"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so3781211fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752006672; x=1752611472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqqDGZHQ2aJpw9uwjBLbUmc18OAURm7PrnqdLoLrbI8=;
        b=R4MkDdCeEiNVwVa5FIN23HThbgt5om04X/TaCNbDRjG5fkXvtDnzkGmFO0FUuCsFOM
         6vjOiUk5cx2ojMczUkJKyxFb4YHSKc/CHTQECG8T9c/q2XUp5ZHFcKmoDBzJC201254o
         pJ4m6vjYMdLIVRwEVYhpyMh8y5bvRtB43RwJ6m9Q+Ylsgyg1IRivzUrDR+37no4D9QBv
         qaHgOmsHoXAm3fVwYmHe2j7hl7WWBYY7T6eG2RCmX8aSLKD58gU5MDOYHNxKBLsVpzwj
         DAuoihYcxXNXPdeyOvE7TR4PaDfH/eWkK0Z7kOdUxoWHe34KKMLZmVBnyugndzAluPE5
         hvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006672; x=1752611472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqqDGZHQ2aJpw9uwjBLbUmc18OAURm7PrnqdLoLrbI8=;
        b=UBJCsQTuQkxRKi9EhyKhFW/6oRio17wwnw1uWhUxEcnIyGWQM3L2kNymUyg12aZMA6
         fCzTAUKUyD79LYKlutw/gBpNO+kQYI4LqwXRsf5pnwLT8FymqZiC5e/ujKoFUgZM2k1L
         Ynr8ShBYQBQ1/SM58b/D0pRc8KgRXZWSIu8LyIytXIQJItz2O/nl9VpqCBUfYQ6eymUj
         cU0YLPpLf2Yi313pAT/JfY+qTQHyMYF6G1uqeWNEAokp+L9IXiKx7zWdPMCqs49E+dD/
         KtEOw8dX4sbLTDmWwi2JLcTgynf5sokCPaj2RjXccl5wmTucSGMgyP6kxK7Y4U7zCr1W
         uuwA==
X-Gm-Message-State: AOJu0Yx32RS4rLuM4F/zC/wuMUDV4qRpQMUuIbeEMU1fnFqXimMxXC6Z
	M7WLwo7aW7N/8gjl/TAfaW4iCuYKVd86v4iWgnDRsuU8Z18czf8YP55s3cqvwn7ynZgfm9HdiJW
	igzalIpBl7mFJYgZBHtqRXkBmuawae7gw4qh4
X-Gm-Gg: ASbGnctn/gZJKJt1Kn8ETfl281riqb4s/b+XeY+Q4ao78AdYkC6ABu81MJVtG4IKUTO
	8gqNoe+WMWV37JXcbsxSH8SwU8ro7GWTKMXgVAiebFh0f9BXxmiPZ0vyh4cm6YtvafEchZRsXJh
	b4pYAErB9bCJA+b9nhZ7IsDpqTNJnYMlWwCxr42xrKHgBgpdiAXpKkeuSh
X-Google-Smtp-Source: AGHT+IG9X8Vh9/2CYCp+BrjJ/Sh0XNx+Edc/ehdPzJb43WxhZLCXtVvp74j9Fwm3MQ2dRPo31zlP0t0/BDfeiBo4KHk=
X-Received: by 2002:a2e:b896:0:b0:32b:4521:73d1 with SMTP id
 38308e7fff4ca-32f3a0e43bbmr15251861fa.20.1752006671631; Tue, 08 Jul 2025
 13:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707034657.929092-1-kiran.k@intel.com> <20250707034657.929092-2-kiran.k@intel.com>
In-Reply-To: <20250707034657.929092-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 17:30:59 -0300
X-Gm-Features: Ac12FXxxBuvliIVSjrkt8RLviDichvjYvVXbM_QRLZYEK4jTtqYR2XoWisfW_nU
Message-ID: <CABBYNZKA70vQ4gpmOe23WweJUU5FY4Y9hcqTDdpMcQns-gGEUw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state handling
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Sun, Jul 6, 2025 at 11:30=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> Firmware raises alive interrpt on sending 0xfc01 command. Alive context
> maintained in driver needs to be updated before sending 0xfc01 (Intel
> Reset) or 0x03c0 (HCI Reset) to avoid the potential race condition where
> the context is also updated in threaded irq.

This should be a little more specific, like explaining what is alive
interrupt supposed to mean or if we cannot do any communication wheel
these are pending?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driv=
er and firmware")
> ---
>  drivers/bluetooth/btintel_pcie.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index f893ad6fc87a..d29103b102e4 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1988,10 +1988,6 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>                                 btintel_pcie_inject_cmd_complete(hdev, op=
code);
>                 }
>
> -               /* Firmware raises alive interrupt on HCI_OP_RESET or 0xf=
c01*/
> -               if (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D 0xfc01)
> -                       data->gp0_received =3D false;
> -
>                 hdev->stat.cmd_tx++;
>                 break;
>         case HCI_ACLDATA_PKT:
> @@ -2012,6 +2008,20 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>         memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
>                BTINTEL_PCIE_HCI_TYPE_LEN);
>
> +       if (type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT) {
> +               /* Firmware raises alive interrupt on HCI_OP_RESET or 0xf=
c01*/
> +               if (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D 0xfc01) {
> +                       data->gp0_received =3D false;

This type of flags should really be made into atomic flags so they can
be checked atomically, anyway this shouldn't block these fixes but
something I very much look forward to be changed.

> +                       old_ctxt =3D data->alive_intr_ctxt;
> +                       data->alive_intr_ctxt =3D
> +                               (opcode =3D=3D 0xfc01 ? BTINTEL_PCIE_INTE=
L_HCI_RESET1 :
> +                                       BTINTEL_PCIE_HCI_RESET);
> +                       bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x aliv=
e context changed: %s  ->  %s",
> +                                  opcode, btintel_pcie_alivectxt_state2s=
tr(old_ctxt),
> +                                  btintel_pcie_alivectxt_state2str(data-=
>alive_intr_ctxt));
> +               }
> +       }
> +
>         ret =3D btintel_pcie_send_sync(data, skb);
>         if (ret) {
>                 hdev->stat.err_tx++;
> @@ -2021,13 +2031,6 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>
>         if (type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT &&
>             (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D 0xfc01)) {
> -               old_ctxt =3D data->alive_intr_ctxt;
> -               data->alive_intr_ctxt =3D
> -                       (opcode =3D=3D 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RE=
SET1 :
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
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
