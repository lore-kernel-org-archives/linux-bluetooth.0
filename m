Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0A2C11EE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033376; cv=pass; b=nZ3khxocNEKgMf04mj9DMeVof95Wk1xYa7R6IaAnfN3oSM7KB9zCAA+Uyw6Q4hXUg+2zUYzir0kAtcvUaTZKFHTQOMXFCvdMJGfO3/cY2fXP6j6+sJif8Q83fJX++brANS+IshFcWgUmUlmV/pKZMig59v6hIwrDgdAyKXlImpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033376; c=relaxed/simple;
	bh=rOr67Aqe+4hdWq3B4kvB+iDZ/2wfpLjWPShp5799jhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsYGv6uBL51zzzWE62bU+pPQ0Agjg3466PsS2/Aue1tq6YMmJN/427ocHP1ogOfQ932W1ucJUgHuS+ny6VaoKvIWNEEff23myoJt8yNgj/8uggqi3djx/EyZ3C/lTpZ7MGX34kPSx7MWsXD/cQ59kuvmIxxS8t27d4Y7FC5UiY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=canonical-com.20251104.gappssmtp.com header.i=@canonical-com.20251104.gappssmtp.com header.b=kUz/csb3; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical-com.20251104.gappssmtp.com header.i=@canonical-com.20251104.gappssmtp.com header.b="kUz/csb3"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a7858d3a20so12126151fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 20:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792033372; cv=none;
        d=google.com; s=arc-20260327;
        b=CFbAp/GgokqtVvqAjlWgm5s7dczktPrGp6sG9mXdGRseUXXetMOS6otzUDuOIcTQaV
         ywpCtRseqvNBuI8SXULReVZZVrXv7vsAcXIXU9+vStzvdhlLk0K9+ZQSGspf8AqtGuAT
         qG7Wd0+++nUg/SSyESHeKposIZG6S0oL9R6yWA9GZ1Silqc3MWya64QjHn1VmI8fXhmx
         kRem54z/seDSOzfBH4VcRpzqqiEqTCiIAcX4uNg4cGVdwnHjJUH++cRN9KzEjY/re5Xs
         1oknAwg7krTkO1c1yJH5bX8/fB2G1Vld4sZAKqfMzhevUxQYvDV6hSWu+XgK4Ux9XqIV
         YTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1s+JRYJlW95kfzYp8Dxon8PYmpI4e8W0o33GcowKMc0=;
        fh=fmQvW/6y6OVEjU9WOobMsWzt7/re5VCNlSBtea36F+0=;
        b=mtcFXP00maGoC/myhVeCThsOgN6Z9IcR4hsHy2vhrMHcCHsG+Ra2L8hDLmEzkGOyIP
         8MkBtUEtDUXv7y2oU+ZAAvbL05Ay8UAwDJ091Pf5EKNe8/5kw6E8hyJ96OQ+fBKO4wki
         nVD6tvXEWk+2kqPymB5U/Zrxrsu1z8caCG71xD4IueyCGIS7YpdGTehE3V3rXTfDDlmg
         1BFzFVzv83YMVvkyhz4leLIgtsQMEarCpwRLDPxabRbN+5KHTE1h8P/ssq+m4EfdPIjR
         GzstJyUeeTpPEVNasJt8edx2AiT75mV3pdHqnfmNj29hMhdGeM4wqg3Ef6svQAAJN5D3
         x7ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=canonical-com.20251104.gappssmtp.com; s=20251104; t=1792033372; x=1792638172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1s+JRYJlW95kfzYp8Dxon8PYmpI4e8W0o33GcowKMc0=;
        b=kUz/csb3F1Fu31iHIXptFBKIV6SCKdY0Dj/ZWP2xNZ41M3il/qsVhc6VFEb2VrGc77
         huZqems7wipkeP6y5Qg6wI4uIN43i3Glz/r2AMIW+SjmHDYW0m6bS5YDCmucrK7vfUEH
         YKivHSoNfjkHARkEu4cadTzX37auIVV1o/A98WRY+j8q97X4FO0lKh4S5H7fhcqJ7/f1
         8fjKIJIssD0CVhEws1vtUpvpN0QHAY0lHyeCR5b1BSJsuDr7IDLK4ZNg1AnwWp9eNj51
         XgRskBeYMhpY++JeqS3O2gydePLYYFoeJop7AzBf+37JzBdlnTwyvPmy/hokTAyF/Gfb
         6/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792033372; x=1792638172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1s+JRYJlW95kfzYp8Dxon8PYmpI4e8W0o33GcowKMc0=;
        b=Ae55axLQPnXZmYgT2AgeHRyvoebNvr70WLin3juEvaSSfz+BH7p2Sf9jlfBsA70iPv
         hdi/aMVd4tU1yYWMwhCuB8ZlE2ZTrcxarXhzELMPwa3qk8S7+EhjpAcoE3BxwseDN+Jo
         mOmfNNPaOpUkjp8LPjy8dRQlHlO3Syj1850uGJbcSMn3TaUt9XPrdkmTAm+ux3URd0tR
         uDZu3Xx+B9S8ixAynikNPV+BRLl4NmugSajQQ9ptX+VSiPGe4t6YrU9+Y7MXml/lm7nr
         QUBfwnAhEoBcvK/puD0I5CFfnVAV07LAM6ftLTMXtgVirGLOpZGerW6qnQyggdlo0H6F
         vrcA==
X-Forwarded-Encrypted: i=1; AKwUvBxU9yD4hddVsQfUw+IWvSH965ODzrLuA38L31c1euLjiol+AeM23lETVDqKJKaLdhg0BgcDdETFB8zKyxpUTSo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG30TIb/a7RlIYusl4nCMwBW6lwdLA4hBVznsMtNLpxednBW81
	Gq/Qed9mqa2RI1KZRQr8oytgqjKiAGNLxRH9jEroMWJeRNrezBONfhNXBlYwXiakzXjdrZBRnqM
	QZrvcJrtcM1Zdrr2nDq8SCyJ8CR5Dn4aWOMRmu5o=
X-Gm-Gg: AYBFou18K1bBHFLETft+ESoeow2jMOftRKbcnb/sMpHhFkuTQDbyiEhCpq8o9vrSAFR
	S19gzmKjdbUnKJF/64dVKXMNKfQBH+teWFJ6X3U63E4m6QMsRPQUPrgQJ8CCgs1i+QGbp3FP6b5
	NyjFrqSVofC1ZIMOW9KEcvlxqpnTZNACc2oBJVFrzL2lUJg1+b4HVM1wCmhuck81jcTM6T54fy1
	3JXZjEBDAinlrrc0LVhozDU0J9tfvUyk+TVjnTOF85Bkt8LAxOUy2hZvMNrbRQ/QLPjScuMpCrZ
	HL8HMp+iMYHdchZ2QgSOdYZAYZjtaMFLZY2yekJ6qtIjxsvCHoA5X79D
X-Received: by 2002:a2e:b8cb:0:b0:3a9:c04d:40c3 with SMTP id
 38308e7fff4ca-3a9c4ebaa9amr41258241fa.1.1792033372300; Wed, 14 Oct 2026
 20:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013233548.3864360-1-acelan.kao@canonical.com>
In-Reply-To: <20261013233548.3864360-1-acelan.kao@canonical.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 15 Oct 2026 11:02:41 +0800
X-Gm-Features: AclHuK_4-OuzJXOQLGSY_1JPZsUhgch8UxUe-3-qX-PwO8ap9i-6EyBQdWcjUaA
Message-ID: <CAMz9Wg-JDHfN0iRs3LYOu803DVCHak8UFenJC=VTKbntM8R=1g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Fix NULL hdev dereference in
 debug register dump
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kiran K <kiran.k@intel.com>, 
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chia-Lin Kao (AceLan) <acelan.kao@canonical.com> =E6=96=BC 2026=E5=B9=B410=
=E6=9C=8814=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=887:35=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> The MSI-X interrupts are set up in btintel_pcie_config_pcie() and the
> controller is brought out of reset in btintel_pcie_enable_bt(), both
> long before btintel_pcie_setup_hdev() allocates the hci_dev.  On top of
> that, data->hdev is only published after hci_register_dev() succeeds.
> Until then, any interrupt that reaches an error path sees a NULL
> data->hdev.
>
> btintel_pcie_dump_debug_registers() is called from those error paths
> with data->hdev and dereferences it immediately via hci_get_drvdata().
> If the controller raises such an interrupt during probe, the IRQ thread
> oopses.  The bt_dev_*() logging helpers are fine with a NULL hdev (they
> print "null" as the device name), so the crash is only in the register
> dump.
>
> This was seen on an HP ZBook X G2i (8086:e376) with v7.3-rc7, where the
> GP1 mailbox interrupt was handled right after the device was enabled:
>
>   btintel_pcie 0000:00:14.7: enabling device (0000 -> 0002)
>   Bluetooth: null: Received gp1 mailbox interrupt
>   Oops: general protection fault, kernel NULL pointer dereference 0xda0
>   CPU: 11 UID: 0 PID: 671 Comm: irq/213-btintel
>   RIP: 0010:btintel_pcie_dump_debug_registers+0x20/0x910 [btintel_pcie]
>   Call Trace:
>    btintel_pcie_irq_msix_handler+0x1ca/0x6b0 [btintel_pcie]
>    irq_thread_fn+0x26/0x70
>    irq_thread+0x1b1/0x300
>
> The IRQ thread then dies in do_exit() and the module load and the
> following power off block behind it.  The GP1 handler no longer calls
> the dump helper in current linux-next, but the GP0 handler still does
> for the "Controller in error state" and "Controller in lockdown state"
> cases, which have the same exposure during probe.
>
> Return early from btintel_pcie_dump_debug_registers() when there is no
> hci_dev yet.  The register dump is delivered through hci_recv_diag(),
> so there is nowhere to send it without an hdev anyway; the preceding
> bt_dev_err() has already reported the event.
>
> Fixes: 190377500fde ("Bluetooth: btintel_pcie: Dump debug registers on er=
ror")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 3a555aa50c87..fcdea1302cf7 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -433,12 +433,21 @@ static void btintel_pcie_prepare_tx(struct txq *txq=
, u16 tfd_index,
>
>  static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hde=
v)
>  {
> -       struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> +       struct btintel_pcie_data *data;
>         u16 cr_hia, cr_tia;
>         u32 reg, mbox_reg;
>         struct sk_buff *skb;
>         u8 buf[80];
>
> +       /* The interrupts are enabled before the hci_dev is allocated and
> +        * data->hdev is published only after hci_register_dev() succeeds=
, so
> +        * an interrupt handler can get here with a NULL hdev.
> +        */
> +       if (!hdev)
> +               return;
> +
> +       data =3D hci_get_drvdata(hdev);
> +
>         skb =3D alloc_skb(1024, GFP_ATOMIC);
>         if (!skb)
>                 return;
> --
> 2.53.0
>

Sorry, this one is duplicated with
https://lore.kernel.org/lkml/20261013125241.1230408-1-an.wu@canonical.com/
Please ignore this one, and continue with the one ChunAn submitted.

--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
