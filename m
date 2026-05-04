Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A143E63A5
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919252; cv=pass; b=UlSR9vjmjCwTKsV3jloFnxhN68EYeWwwl1+69ZsjHgkSPfbdSa5bc8mzXKNaoqxUfnNpAdLsaXyP06bZx0ovpeBLcndwbKgQCDYoG/XveRtzmAh13gNJrR466iujLKTB/FmZrNaLAbbKxcxjGdReanCHhlRGDusRkLaAQhGPfMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919252; c=relaxed/simple;
	bh=zA669Smw0LWrNo9Er5upPzUb3uoP5hI4WOZOVk1eVRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO5E5af+7LDZ5HDIp8bs32uih8ImNbilkJHMGLI4fEyXV2tstzMPyIR/eFrCfVgAvK8SxqiqHkcammYva2DBNFYIV8XR+W/vjnVZuNenlNTc2JUDu17Cd3NFoJ7BEr/13TtJqMvjs/RcNDh2LXmfYLqUw8k/wLoeE46TTp9ldV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsjaLqPa; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsjaLqPa"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64937edbc9eso3483914d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 11:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777919249; cv=none;
        d=google.com; s=arc-20240605;
        b=eKL0qN+S/XAjkoo1sCvZeY/77BoOZEkCLYHeLADH3hhT6ZBVQD7cJeiGlmzn8Cap3K
         7cWZFW+OLksFua58C+JIrbIGKM2+emPJUcBar0fQNj196SQ6laOxIJGr3hWUuvHoe3Rp
         NmNdQMbhe7rjxW6xZ3C/EUd14Ds+fg3n9z/s0M/zkvnpSG3rP+wK/dG97tovjQoLPMmI
         CDV5kFz+mzvxMHEdsj/kLaErDGMAZStptXM7QCXCS/G/zg+zqztcItvbwC26hdMEeYT9
         9DOlZ2seV+Q+VO36vm3OzTQZCbmenYBTp9h+TWmO7D5x/lHQ1mbe397NiUDuFce3b0RE
         fQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vYOAxfp7r8WiQ/qbWEw8Ztb3RzH9lkD6X23AHtsMZS8=;
        fh=TF3uJKn9m7SVorUZdQWnC90FgRoVvulYff3o4RjI04Q=;
        b=NB3W2xUaJXsYTXPxTPefP3YJrm6uuwuOKoYF7z7mMJk3TwEFpbKnI2MLkVzt1jZ7EL
         H4j/EqhPSOFvCjHoOucZryhf8SsfciCcl3yvTXqKtbbJdZgM4jYjJJuqq9qkgG13iUkE
         oblm1zEAr96ByH0llW2BQpGvOECneqWalsnb1/6NfG3pelebt82VKykFIc2gy4nrDIbN
         WERO2pqhCSWFFHW4y9cfljYslBVIPS39tUVl8rGsbmcICtxvOFh4dVZ7gA++SAW7tHnD
         8AyOb9SHPBc/aiv4TrPFj5npcdEXIBG0FxFSk9/zo3XQPaJvYo9A4ahPM6K0UlLkfP+1
         H1WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919249; x=1778524049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYOAxfp7r8WiQ/qbWEw8Ztb3RzH9lkD6X23AHtsMZS8=;
        b=GsjaLqPa3ngtVM2b+5KnwB/GOk3P0Ujx7SIb6aE/6B+cJuYLFOT4ThNJ/8w7/NuJv7
         MusAjLRO2ACycr7wftcDZirBeAq7OQ0UTkirX86vSEggH7IkmQo9xXaKwDGp47Y9939r
         iQVxxuBZuEvu/nGsE+T8o11FpH7/TwcdoLeJV7JcfrWXodi/A68KCuJ9d0YDWQUbGpu0
         tFA0WgAy/8NWCw1JdIicKmTWkMR+kw3TGPDV2itkyrrZysNnYUz1wCyUXs6sJTdj+D92
         gnBlhbXY45iHWPqayhtd2VwfT9/XzucnaYHlmKgRtmIVwDERGVQBgVmmuqvFw1koz5iS
         +GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919249; x=1778524049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYOAxfp7r8WiQ/qbWEw8Ztb3RzH9lkD6X23AHtsMZS8=;
        b=auWcyOpyMuBhDcPj30NNRk9B/huyTG9LmPV0afgtkSBmsq4l6HbqKYQF796xnroqZ1
         2+NB3Q7ZTZN7srOwrhBbHwFz8ST4QUZKW8XZlcfVu7/uLTdofXZEqEPNSUjEZrP/NylU
         lJ6RiLFk8Lje2e/TonbJMwsP5vYtfyJk/VzkpeVPk+4srhVqyOoerNixF8sm24eG06Ic
         Kl5Do7XMMwJ5c8E7V2RnuAAhXcZ8mOmYayFGQu4AGsRZRJbVIr3Vkyg35k6vbQOqc7bU
         azphVcnZ5z/IcLV+odIelPHF99RlCkx4HI4sJ5Nsjm8NNRrUjoQt9WIguhr2770n0k7Y
         KQGg==
X-Forwarded-Encrypted: i=1; AFNElJ/zjsfvnPqTUvYqrtWllPEt6lkqzlGX/rsinto7FFTJqBVu3+PBTrfM6CCwJFx2OM73MgfI2/v0DsmjBvUgr6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21NcZEY9snN7DZYjvxSNcQGNjeMVgWCA+HEhlooJxZrgphr8N
	Fxhx1TeVWFBAjIVjl6aRbXc9ygdrOW7NaxMTPst20gmVta0IAn2jDQbZT+MCpcQHBOSnwjKG7fj
	xNRcJjf02eooTAuSZA3FrhHLCJmREHSCPYw==
X-Gm-Gg: AeBDietgIEd9nVsywLxa1r6zoeN21Z88Av3oDIwS8CEJ2AxzrW8ooGZFuKRO7QeCuSp
	5doLoEDxFq7vniCi6tCh/O6lTY7P5vov4Bp8ggT2JHE3sp3i4kUkj37v8ZjtdO5MOhZ0GGNzw/2
	wWEaOg8l70ZSqNngGNu2mjG8BXaQpCHfgcY0LsAlpYKEeRDdCAvMn+7LcyiT+hgDNVIZHUnhcTW
	FninzEbINa8lacZOaW6PB3dV/UvPVjyZsSPI2eyPzF2D6ykyqYcqXXHMthkV68nS3DLuTxvr69e
	098JXSAF2yPMWDiZzUfBkNQWxkjLpGQUrMA3cTcbugF1pJJyrpPqoZCyg8gCK1KXlxEN0w4MJS5
	OBeeC
X-Received: by 2002:a53:d20d:0:b0:65c:3755:c743 with SMTP id
 956f58d0204a3-65c3db923camr8200827d50.60.1777919249232; Mon, 04 May 2026
 11:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430045522.7881-1-danilklishch@gmail.com>
In-Reply-To: <20260430045522.7881-1-danilklishch@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 May 2026 14:27:18 -0400
X-Gm-Features: AVHnY4L00wgKt27DzkRN6AkbE8Ih-1CNx7vB1AtOUwh0-mgwutsDaPtU3AVVc7k
Message-ID: <CABBYNZKEqRW-7U7y0id8EmFB3LVxaU+FUO6g4AqkuDG_-T6bOg@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: fix Set Public Address on controller in
 HCI_AUTO_OFF grace period
To: Dan Klishch <danilklishch@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, Apr 30, 2026 at 12:55=E2=80=AFAM Dan Klishch <danilklishch@gmail.co=
m> wrote:
>
> When mgmt's Set Public Address command (and Set External Configuration)
> stages a configuration change, set_public_address() sets HCI_CONFIG and
> HCI_AUTO_OFF on the device and queues hci_power_on. The intent is for
> the queued power_on to run hci_dev_init_sync() -- which detects
> HCI_CONFIG and calls hdev->set_bdaddr() to program the new address into
> the firmware -- and then re-emit Index Added with the controller back in
> the boot-init grace period (HCI_UP=3D1, HCI_AUTO_OFF=3D1) so userspace ca=
n
> re-push pending config commands and drive a fresh Set Powered 1 cycle.
>
> The bug bites when the command is issued while the controller is in
> that same grace period itself -- the normal post-boot state, before
> bluetoothd has claimed the controller via Set Powered 1. In that state
> HCI_UP=3D1 and HCI_AUTO_OFF=3D1, so hdev_is_powered() is false (the comma=
nd
> is accepted) but hci_power_on()'s "already up" early-return condition
> HCI_UP && HCI_MGMT && HCI_AUTO_OFF is true. The early-return path runs
> hci_powered_update_sync() -- which is the wrong thing for this case:
> neither hci_dev_init_sync() nor mgmt_index_added() runs. The result:
>
>   - hdev->public_addr is recorded but never reaches the firmware via
>     hdev->set_bdaddr(),
>   - userspace sees Index Removed (from set_public_address) but no
>     Index Added, leaving the controller invisible to mgmt clients;
>     it is not in the configured, unconfigured or extended index list
>     yet remains registered in the kernel.
>
> The other two starting states are fine: HCI_UP=3D0 falls through to the
> full hci_dev_do_open() path (correct); HCI_UP=3D1 with HCI_AUTO_OFF=3D0
> makes hdev_is_powered() true, so set_public_address() rejects with
> MGMT_STATUS_REJECTED before queueing power_on at all.
>
> Fix: at the top of hci_power_on(), if HCI_CONFIG is pending and we are
> in the affected grace-period state (HCI_UP, HCI_MGMT, !HCI_RFKILLED),
> close the device first. The early-return condition then fails and we
> fall through to hci_dev_do_open() -> hci_dev_init_sync(), which honors
> HCI_CONFIG by invoking hdev->set_bdaddr(); the post-open block then
> re-emits Index Added via the existing HCI_CONFIG branch.
>
> hci_dev_close_sync() clears HCI_AUTO_OFF as a side effect of going
> through the regular power-down path, but set_public_address() had set
> it deliberately so the post-reopen state matches the boot-init grace
> period that mgmt clients expect ("treat as new one" per the protocol
> contract). Several mgmt commands -- Set Privacy, Set Wideband Speech,
> Set LE, Set BR/EDR, etc. -- gate on !hdev_is_powered(), and bluetoothd
> expects to push them during this window before issuing Set Powered 1
> itself. Restore HCI_AUTO_OFF after the close so hdev_is_powered() =3D=3D
> false again.
>
> This matches the documented behavior for Set Public Address on a
> fully-configured controller ("Once the address has been successfully
> changed an Index Added event will be sent.")
>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Dan Klishch <danilklishch@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -948,6 +948,14 @@ static void hci_power_on(struct work_struct *work)
>
>         BT_DBG("%s", hdev->name);
>
> +       if (hci_dev_test_flag(hdev, HCI_CONFIG) &&
> +           hci_dev_test_flag(hdev, HCI_MGMT) &&
> +           !hci_dev_test_flag(hdev, HCI_RFKILLED) &&
> +           test_bit(HCI_UP, &hdev->flags)) {
> +               hci_dev_do_close(hdev);
> +               hci_dev_set_flag(hdev, HCI_AUTO_OFF);
> +       }
> +
>         if (test_bit(HCI_UP, &hdev->flags) &&
>             hci_dev_test_flag(hdev, HCI_MGMT) &&
>             hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
>
> ---
>
> Claude was able to fully convince me that the patch and the explanation
> are correct. Moreover, this indeed fixed a problem I had with a custom
> patched bluetoothd that happened to override public-addr in the 2
> second post-boot window. However, both the patch and commit description
> are fully AI-generated.

This doesn't inspire much confidence, though. Have you at least tried
it yourself? Perhaps we need to ask Claude to first add a test to
mgmt-tester to ensure it actually fixes something rather than just
hallucinating. Most models are not actually very critical of their
proposals if there is nothing to validate their claims with.

--=20
Luiz Augusto von Dentz
