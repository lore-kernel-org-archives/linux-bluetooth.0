Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352591;
	b=AWx0znTt6ECc6Taqn/AvWPYznAu2/cuRjJyt7Rtis4187rnitfdpG6xVp/Wuny+fPnTK
	 t4Qbtj7ZiHuzbwy/Q1AnKiIWG/9Bn6JdqohceaYLJM+GzuBK2ewbNnCwkoosZdW4QkLVG
	 R3csd4Xq54rQ9YHeAhpeDm8y0fvrmg2SCw/JNL8dnZ492nSd5Vd4W69INx+sR/NPuJIFf
	 BZ8i7+YRgeimtDyNEiyQnE1B/4G9LPQpv3BhVkoIkuUORl5taucl6dBzVR4fUsAf3BcX9
	 vYgLOpol+OiOLwSgzBDvEqfdOROyvSJzokwn8E+qtOqfcpVR6i6wqCgtdHAA0YlNoJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352591;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AUW/VefxPVhSKqc9QwRcesaDMHJU1FaYetMkH8pU5n0=;
	b=3u5cXovfwkRKlHiJIJip4SsZPFV11NZ9rvQDohNATwAsaAganhTIElDgTQZW6ObJXNVb
	 MRVraUnN93w+OUnAwaynfN/ERuFZYXYHZgG9qGViiSXUxlEC46DnyjiDsSpkp8UyuOyle
	 k1jhR00h4wEjlttCug3hU9QKAV7NwwfRA0D1vApAu6caF7S/SRRVWtRxuRr0Lkh+oidOS
	 UyxcMos/zxUCjjERNIhkp42tl66WWR/UdJHVKjjwZ0Cl7tEfvoRKdWYvfyGsu3T9uwNMC
	 olAxtyTtBCgi7rxXDnLfi/paU8LsVAWmencr2BC4grm6gC/z0XY6DOa6IXmX2QeXTYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMNCQR25;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34673606A31E;
	Fri, 30 Oct 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMNCQR25
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEF71F000C1;
	Fri, 30 Oct 2026 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793352590;
	bh=AUW/VefxPVhSKqc9QwRcesaDMHJU1FaYetMkH8pU5n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fMNCQR25otJ8OHxoM4l3W/R3uJxbKp7btHDNJ18HY/kk3aiKkE+E/ii9IAtLA9lAX
	 pQJ1+60uScGX9IP6qEmxA5zWjgLOL25FjV7RR5nko+n7a5BJjLo9NDSKjsFCJ/Bxuj
	 7Emq//dbCIZPCI/gzfdG8jj+tRqUFAeCDlzb1Fd6wjSXusn2XHqlVjD4maiL2WAPDq
	 DG23/Zw2vJYDDLJ/CWnpcQL+D8WiNlS10Opk4dbWyqWlipvua/3PbIFIJYdp+nG+dp
	 tVCW2LL9fijHPpqcpzYXGtgFOvC5O1O/7ZYC8EiFQQ00aAzJU4WebX6WgsY5munY21
	 gZ91vWDAZN0LQ==
Date: Fri, 30 Oct 2026 10:29:44 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] Bluetooth: hci_qca: Reopen port after power on
 for QCA2066
Message-ID: <ygy2hd47c3tb4vr2joiiy4bbg7rd4pn66x3co7iifv65cvnrf7@g36i65agh6p3>
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>

On Wed, Oct 28, 2026 at 07:18:37PM +0800, Shuai Zhang wrote:
> QCA2066 needs the serial port reopened after the controller is powered
> on, otherwise the host and the controller run into RTS/CTS
> synchronization issues.
> 
> Patch 1 reopens the port in qca_power_on() for QCA2066, as in v2.
> 
> Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
> port which failed to reopen is not closed or flushed again.
> 
> Changes in v3:
>  - Patch 1 is unchanged from v2.
>  - Add patch 2. If serdev_device_open() fails during the reopen, the
>    port stays closed but HCI_UART_PROTO_READY stays set, so the later
>    serdev_device_close() and hci_uart_flush() use a closed port. Keep
>    the flag in sync with the port state and skip the port flush when
>    the port is not open.
>  - Link to v2:
>    https://lore.kernel.org/all/20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com/
> 
> Changes in v2:
>  - Use a separate case for clearer logic.
>  - Link to v1:
>    https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/
> 
> Shuai Zhang (2):
>   Bluetooth: hci_qca: Reopen port after power on for QCA2066
>   Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
> 
>  drivers/bluetooth/hci_qca.c    | 46 +++++++++++++++++++++++++++++-----
>  drivers/bluetooth/hci_serdev.c |  6 +++--
>  2 files changed, 44 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
