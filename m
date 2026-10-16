Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331645040F
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141519; cv=none; b=lCpTjk4C55CMJZEuETYuhAkGAd368rKKJnc9A0bZOsoSa8UJ9l2KxduZ7HdhoBygvs9glu4aoI9K+4Q9FsCVlV3rYS+YYHC6OY3dIlJOu6cC7Z62yHqW7dsppf1lk3b4jR7zXmWZStg/gSPbtxzUSM1FtqYgLDzMcL1OvJe/RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141519; c=relaxed/simple;
	bh=vEGMl3vWS7YqWv+/SAK1qk8sCJ+KZP/QF7gDiUB4sjM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyb54jUxGLGBg+FBhGi4mt4pBfCmr4AQErOjNcmQqs8fnDQj6dWxUeKZpbrIrt9bnqcFur/TgI3HLmsp9dBIJWwHvW1sRKFR+Fv2LFCJc9YthtHJrK93cqf1jqSlRSSlVgi3l49vZGPTOXMQaKmYFiKzSAeGeJc7Bs9Ajc/4wGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVXfaLtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVXfaLtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076851F000C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141518;
	bh=QtJ99FtC3c5ilcolvo6lgAp0tWItLTBL1Qi4H9LrN20=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OVXfaLtxQnkjibJstFuXz85wJ6CHRh16rk1otJF7sI2diU73xtTu8PtSJTIVvwzZA
	 ntLM8c3JFRx1msFW7ogzgPfhIu+ASwsEK4oWTKUjz/avPdk5CV+59atHtVoPdV+bxO
	 +qN+vBXQH6XuEak75FWCULsu42wpQdvWkHKiB489mA+UKZTcpQPd7zhCDDhfnz/sou
	 +/geGVOVjIapMBj9KUqUz3CsnsGn+goP1A8wbKcV10PrhwRXakNSUPtGIMHWOLvUww
	 kJWt9ke0Q5Duz5Qq/iAxeUyhUSyV+peoEs7mJnD0N1D7UlOWvbEMHKeefu8s/7x4Pn
	 mKCasnKW2f59Q==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3aaf078704fso6932461fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 02:05:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzk+YVxuatydt0KNmV8tZGtqGeQoiYmBJ3HOhMOMZrkYYs0fPnUQgqcwDObUhzFtgiijxi3gjmNC4kYMvMCzvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaDd53v/Sh5Qnpw6WC6LLmPTtkj0MlTo7fspMXaYmM7P9lY4pk
	cvK4/PrhdzeKjxiLkd/nL6DAblriSZHjBMZs7RLQoWds9eqeATxkfp0dm6EvVWtJbYxRH/A2qgU
	NtEvDP6PqwMZ23CZgnIB+g0rva15aiYtHVgeux4a+Gw==
X-Received: by 2002:a05:651c:19a2:b0:3a9:829e:1def with SMTP id
 38308e7fff4ca-3ab1480f550mr5516331fa.21.1792141516715; Fri, 16 Oct 2026
 02:05:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 09:05:15 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 09:05:15 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:05:15 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mc_8kt5aU8L_qOxuKCOzVAf5iCQBT8TKG5LYjT0QwaE9Q@mail.gmail.com>
X-Gm-Features: AclHuK8rF1-rFIUpz4M37e5t7rBB3B0mWa9BGVfa4zog3QLx-x9WTle5uStpESs
Message-ID: <CAMRc=Mc_8kt5aU8L_qOxuKCOzVAf5iCQBT8TKG5LYjT0QwaE9Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Reopen port after power on for QCA2066
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 04:23:02 +0200, Shuai Zhang
<shuai.zhang@oss.qualcomm.com> said:
> QCA2066 needs the serial port reopened after the controller is powered
> on, otherwise the host and the device run into RTS/CTS synchronization
> issues.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
> Changes for V2
>  - Use a separate case for clearer logic.
>  - V1 link
>    https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/
> ---
>  drivers/bluetooth/hci_qca.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 7089e9b63..ee3ccb59e 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1867,6 +1867,19 @@ static int qca_power_on(struct hci_dev *hdev)
>  		ret = qca_regulator_init(hu);
>  		break;
>
> +	case QCA_QCA2066:
> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		if (qcadev->bt_en) {
> +			gpiod_set_value_cansleep(qcadev->bt_en, 0);
> +			msleep(50);
> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +			/* Controller needs time to bootup. */
> +			msleep(50);
> +		}
> +
> +		ret = qca_port_reopen(hu);
> +		break;
> +
>  	default:
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>  		if (qcadev->bt_en) {
> --
> 2.34.1
>
>

From sashiko:

If qca_port_reopen() fails to open the device, it returns an error but leaves
the port closed.
Does this returned error propagate back to qca_setup(), causing it to execute
its retry loop and unconditionally call serdev_device_close() again?
Looking at ttyport_close() in drivers/tty/serdev/serdev-ttyport.c, it appears
to lack idempotency checks and does not clear serport->tty after freeing it
via tty_release_struct().
If serdev_device_close() is called twice, could it cause a use-after-free or
double-free by dereferencing the freed tty pointer?
Furthermore, since serdev_device_close() unconditionally calls
pm_runtime_put(), could calling it again trigger a PM runtime usage count
underflow?

I think it's correct.

Bart
