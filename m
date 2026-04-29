Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F024376BF1
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475839; cv=pass; b=u4VKTlMXyifRVcv7ukv+Jq4aTcmueK17XhF7SVobtCxf9h3G7GrL7Nw5ciuZd5UxcbsP/BU7HEjubQFuBOmU9Zu9fJRi7WjtRxv6EZiynQBzP+HoKzOnUkE0ftHX42GbxY1QPSFcvmSm0bo1cWjwapCIgBhShP1AHj7g4tSw/JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475839; c=relaxed/simple;
	bh=gesnTlu4hyV6gMLS6l+n+8XkG7Hw50kNCrHbJ3tSTGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7aMaUisEiOBol6FD9nlbpx3ULiWOc/XnB3oNmR/9xweqSyxN9wJt6bQ6PRkEQXfeFQMP98x1zrIVDVq3b06wxywLUn8jFmV5Q8aZ9x80HdJlrbGaJpVMtrHjXKnaQ9TM7+Vw2WG4pe3MVHLWA6QxNPV0if+8icsIztTWgHvSJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQUGQkI0; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQUGQkI0"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-656d749109cso3171501d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777475836; cv=none;
        d=google.com; s=arc-20240605;
        b=cZf1NPbvquCAmFrA1pQkxqJQYoWQK6956/xdSKZXwQTz7rImeBmAi2tP0QtP/UhQ/k
         SVd/jKURn8YBAIvECe9qy8eP5e5Q7YzYuc1/3QouhOFUm4rpvBnXEiW9s4gt5JysJZBi
         ZT/JApi+vYkehCFogKuOr5Um63ZPs6KDMqFYGwweWpT7zPxLAuGF7X3tAhv4dwEuI8N9
         dACt68eLBoXht/nL9yr4n2LUZzoIP0rgn/YJZ0/m/0Jyf5Ab5I6g9pQei7EUDMolSAWs
         qHElaZGGPW/0mSEM8cHZ48Fx0sg3ecEOZGx5wWMdVtOJlEVoRwk26NlfXrNqffqbCbFX
         QwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GrVlJCjs35rXK/giQ09CcK1pSolcwhKpHybH7qA5Bzg=;
        fh=gGCwoCovZgNlD1iQ4qK4wjseFL2pUVfUUM41N6iGAno=;
        b=Cxq+EDA7x9HtWos7med61rTElwY1fshbAZ0XNMxfyY1dsmJ5a132cnhTbWMgcemZeZ
         VL2GX3cFZ1+1xM9zUfR5l6DN48g5d/Yqplm82TIai/qU9thIsqYDPtqOJ4y/H/da6D9w
         XIkKQvwm97lK41qhCfjLSZ3AtgM+dnHlvM5f10FGumZgkyD1YRKui+2MCa23plv2TSyZ
         Xa8AddDtidCGvB8NIAA7CJFvn//6nPz6NjNdrVQu3N5Us3GGrI7nHuVDRES1E//LOkt8
         xQsFS13ZCHshs7+7y0n2RFlkfJvSVuS/PDH3Jo25AcuxY99fB7syJP/1wDtI97ya9ACY
         A9uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475836; x=1778080636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrVlJCjs35rXK/giQ09CcK1pSolcwhKpHybH7qA5Bzg=;
        b=GQUGQkI0zEaLhVvk7XsVMUeqdNjd0rwyRM4Qp3SCWKS/nriGZK2aoBMYYhjQOc44Yt
         Kom0EaAWZPIRcQ0Z8QknpaxoJUtfeRiNc/4CY/s3QDX1S8wnzRCn7gIwMV0qQ2T7Olwo
         lTvSbly4973S9tLCkF/ihkZST4Xe+Jm8UxFdVApDBNrmm8uCWWlcNLQhu/Au+Ev7OsYI
         F4TbhVSFwsFmpLmYmLrdqPaz6+djug+qk4MTXtF+1Jutq0QzMGZN2Xd7i9RJaqh4ccP3
         mc7IgbJ3zO/5ZT/YHLTqEJv7I5G2SoFBXD+jrSirdzd53Er4asZo0iKP+gZg1O05x1my
         Sjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475836; x=1778080636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrVlJCjs35rXK/giQ09CcK1pSolcwhKpHybH7qA5Bzg=;
        b=k7gMAkyIQ8aI8oIdleFAuc2qTknU3VZwv455VK0v7FOA4XdbIv4k+z3bEvzONmuL/i
         k7MfH0cFWiCdUWVwDla9PyoN5Ee8solfwvRUKuIPGMIokztDG81G1O30NqkFpWQNZ6B3
         DKp+bxztnNqmZsFaQ8bnC7yxrS19AUVQYvZocPfRtmYTZDYgivmccJsbmFel9z974h0J
         8JucFz1rMJTjBu/7bXk0SBAX5v8Ih5o1Rhr+k3QHH/pGrq3AhgNy+pvn3NxGXfhtN2M7
         J/ZS95UU0fYjWXthio0IkhDoB4i3p/0CbCYmpbkz/O6VcA28d6ZLzEVQLtCItoabMDju
         KHWg==
X-Forwarded-Encrypted: i=1; AFNElJ/LQy+ZdVFFu4Hcs4d4kf3mYvTj++WJhtWkgj/I+IHJk3du1whhvmB4USJXsIIhsgZF9v+IxT3o7oyVWIPvjyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmK+jo6MLWEOFV1jaYTBL3cx0P8CUdEKLm1KGNQt0tPcdPKP1
	qBjGxB7pGdakzoQpNyxyKVN9NEToM22iN62luJp+bE5QakeibY4NLywiVCikTigfZR7oBH1YYcA
	f+c4bzww/Zj+KWJAdSx88cujXGBSfBcxdhpKA2VE=
X-Gm-Gg: AeBDievdNZQxpolsn6WAeg45oQJ0/ztLTrWXcDGK5RHNjPgVoJQsQj1UmRa/WQ3c+w4
	/6yTb6E7N7msaOb7ki5sl5Ny8mQ34z9jNCCZzoz4h8yZcjSm82vaaQgmllZ+veMp3OU+dd3YYGi
	HYKnymI8++LRv2PmQQVlsF3h7QXtNF/0zSKEIpeJ5XdxaBrISi/MIUd7nkQOuP0HbCi2UJi513M
	eEap/RnpY0CMyZyYmMCoBLkRROakiUZDHf171p+ChvBa3dweb/A6uBpUCvyhQrJntPdIrlmad53
	VwrAzxuCggx8EPv2GWwH5sU1VHVRqvE+A7h9P/eCE7tlB2GW3Lx86l2oylaREfFohHu/S823oHd
	yhutevVg86wilWMc=
X-Received: by 2002:a53:bc8e:0:b0:653:11d9:b0c5 with SMTP id
 956f58d0204a3-65beee816c1mr5399415d50.46.1777475836382; Wed, 29 Apr 2026
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 29 Apr 2026 11:17:04 -0400
X-Gm-Features: AVHnY4LLCGwmWY5t5Yl8gvjRfu55DEoQrqy5OttPVCrNQjYv-xFl1m6ozfxW-Zc
Message-ID: <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Wed, Apr 29, 2026 at 8:12=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> The Bluetooth host decides whether to download firmware by reading the
> controller firmware download completion flag and firmware version
> information.
>
> If a USB error occurs during the firmware download process (for example
> due to a USB disconnect), the download is aborted immediately. An
> incomplete firmware transfer does not cause the controller to set the
> download completion flag, but the firmware version information may be
> updated at an early stage of the download process.

Hold on, if the download has been aborted then the version should be
reverted, or rather just update once the firmware loading is complete,
so this indicates there is a bug somewhere that needs fixing, not
worked around.

> In this case, after USB reconnection, the host attempts to re-download
> the firmware because the download completion flag is not set. However,
> since the controller reports the same firmware version as the target
> firmware, the download is skipped. This ultimately results in the
> firmware not being properly updated on the controller.
>
> This change removes the restriction that skips firmware download when
> the versions are equal. It covers scenarios where the USB connection
> can be disconnected at any time and ensures that firmware download can
> be retriggered after USB reconnection, allowing the Bluetooth firmware
> to be correctly and completely updated.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
> Changes v2:
> - Update code comments and commit message to reflect the correct logic.
> - Align the commit title with upstream conventions.
> - Link v1
>   https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.qu=
alcomm.com/
> ---
>  drivers/bluetooth/btusb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 572091e60..70abbabea 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3550,7 +3550,13 @@ static int btusb_setup_qca_load_rampatch(struct hc=
i_dev *hdev,
>                     "firmware rome 0x%x build 0x%x",
>                     rver_rom, rver_patch, ver_rom, ver_patch);
>
> -       if (rver_rom !=3D ver_rom || rver_patch <=3D ver_patch) {
> +       /* Allow rampatch when the patch version equals the firmware vers=
ion.
> +        * A firmware download may be aborted by a transient USB error (e=
.g.
> +        * disconnect) after the controller updates version info but befo=
re
> +        * completion.
> +        * Allowing equal versions enables re-flashing during recovery.
> +        */
> +       if (rver_rom !=3D ver_rom || rver_patch < ver_patch) {

As I said above, this sounds more like a workaround. That said, I
wonder why it would print an error if the version matches, it sounds
to be that if the version matches it should just skip and consider it
has been loaded already in case the actual problem is fixed by setting
the new version only when loading has been completed.

>                 bt_dev_err(hdev, "rampatch file version did not match wit=
h firmware");
>                 err =3D -EINVAL;
>                 goto done;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
