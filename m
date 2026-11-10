Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318699;
	b=4ByRcj0JJVUZmsEL53uVuJ6ku9XvjVNmzFFUbSvsLVhJvaJ4317GroFWDPZfJIvTw+T0
	 FIscErEMedcXIBTObp00XBPAibJ+PWNv/94iIBlWpPMaCFyBudueRHZRNW0z0KlZKLkV2
	 n5PbSnSR505LYrUgFWqAR5RFx/3zb+EnuDouDG38sckDEWHJtWceiKZSCA/iYy/Z7nrkr
	 SgihJhdsKs01A6Stp8xH12W0mFyoTjG1nGq088ZBBrAjRMMF7xh0OIYKHEHuuOp+AC0Gn
	 +UYB7/i7YGElkhbLypp/VvwQL9Qo+Lt50XR+KSl3iSasisDg+cejICGhRAg9n+VG8sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318699;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vop0o7XhfC7s72LnewtmksOVYasvrXJcPu72I8jKGtk=;
	b=fmHmE3pL57k+6dpGHw+5JarHtuD1qOv4Xiv7/jkHOovaba22uhQFjyjgSMydbypcs7sv
	 bqFc4S3M/4l/ougN87OusbT4z/LOqn4tHzWA1yWAuHKkzzEAZVMj+bT2f1rEl1XaysMxw
	 ddfoGS+Ucfx45KcXSN4mqxqS/nGGLtd//912f3DtSRm6y+Tt3JzRrBn0omtjoMq8+jeSo
	 WIhALfRcZ+4ak3SQY8cI3oD9//SzWoKuQiSYOrJx7QKUvO9AvDSYcCLIa/pGuFje9wYSF
	 IeAvLU3vJZRxWZEIdOQMXTfLq9jnaespZP/pbviebMxWU96w3f4cYg/4jnCRJ+VYpkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CFG/nHkZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1F812606A31C;
	Tue, 10 Nov 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFG/nHkZ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B1C201F0089F;
	Tue, 10 Nov 2026 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318698;
	bh=vop0o7XhfC7s72LnewtmksOVYasvrXJcPu72I8jKGtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CFG/nHkZejdArO15+T5tCQ8lqy0kgE9JMSAgO4g1doQqYdfLeBUAhXnxVT22/Rnj8
	 A53a7ruByd3C+yvpeuThUvWLzn+rxUjp6W05jyx8Vn31dqOTkwgrEQNRJI65P5LHON
	 B1pvr9JQ8JrlDMIjnsOAmSF5MD2NoRaYqPiXM7QECTsOzKRbrw/Yq/+z0hlXwrzsWX
	 qm6QVjOgGN+hjfTJpogLYjE95I5XR0OflOXRjrX0ZNhLutAU0EvdzNoP/tGwQI2SCC
	 htnYQW27+Vhv19QZ+OM+39qbtDwAWBq8kqNY27RGEuKwZMc2ge5HWMf/8EPHCuNzxw
	 VQ35BobS8ADSA==
Date: Tue, 10 Nov 2026 14:51:34 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Subject: Re: [PATCH v4 0/2] Bluetooth: hci_qca: Reopen the UART after
 enabling QCA2066
Message-ID: <yoohpncycrbpxufelwjsa3le5sha5um2jhajprv5qjwbfolz2d@kqdywa5qlivb>
References: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
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
In-Reply-To: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>

On Tue, Nov 10, 2026 at 05:29:27PM +0800, Shuai Zhang wrote:
> QCA2066 does not reopen the UART after the controller is enabled, which
> causes RX/TX out-of-sync errors. The UART has to be reopened once the
> controller is powered on.
> 
> qca_regulator_init() already enables the controller and then reopens the
> UART, but QCA2066 does not go through it. QCA2066 was added with its own
> SoC type and handled in the default case.
> 
> Let QCA2066 go through qca_regulator_init() as well, and handle it in the
> other places that check the SoC type in the same way.
> 
> Patch 1 reopens the UART after enabling QCA2066.
> 
> Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
> port which failed to reopen is not closed or flushed again.
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> 
