Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956646;
	b=nUWk168hrUHwWF6g0x3+PY7vFRAm78Y5RKWbTPI+R8MroOLO0+KxQDMbsWrEJ4qd2/mY
	 Hb0JFgk2iTk/to11I0WkPj7I+Pk6sDUOkAnPEdJzDIpIvK2C4mLSVoac+/8zAItnIxH2t
	 IOjGU+WgS/XHveMcxgkhDOE3BBtakYw9PZd7KPnnrcJFU6S+OHnWxJpyIpANtonSPrhx2
	 uDkEzdULw4Yfjz+M8iKyhLml4rp38xOuk6/MKaBovl1nA+Co3RCUQi+12vOx5ba4671iY
	 ifR0PM4fm2wve/kPKLBl3t2kHJ1ynQNS6Az4ttFCQ/r6ymTudhN894xTLuF+SkjPMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956646;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yEVp37i69SPx0A8xxOmCh9bos4m6h1XKQfU0jHzhz9E=;
	b=aI0UM83gT95G1vUvc9Hqms0Qr2VOYhpo1IXRFk/sZCF5kD6Bh3Gck3zgXg+QwQd0oZ6y
	 nSquLRG9iAzjvT8xmCNDCaHlyOxR4HfzU/nNyR/Qy4YWTg8aOB/4I0xrr2LI/v/uVfx1m
	 8md14NnREpabx2fyGqVZlKB6YH9JGxh54lqMmbAo5ETxb+wl/G19CY394xSxCsmVuTYWo
	 viJ+vYkVunMgizqx70tW6RFBhIt0D+GkvrsHfYXbdyo2XDZjavpKv7WhSpMlZjGWGLcXj
	 4Li/OGT3MSV4jMkglKJrzdjcM3zTP2Ug55peghnrkeofISsBKR4tyBhla3hL5xWyPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WC0tVPPP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A4D69606A328;
	Fri,  6 Nov 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WC0tVPPP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 580271F008AB;
	Fri,  6 Nov 2026 09:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956645;
	bh=yEVp37i69SPx0A8xxOmCh9bos4m6h1XKQfU0jHzhz9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WC0tVPPPCLrd9vTUIiXJrIgS5ZmVwrplOlt3IBzOWu+NACoXKqTjCNDU8G/hVcQJw
	 JBZ+2kZQmjjqBkO+FRTQlm9eWaAaBuadqi/m6DQc9sQ0RRn7Kw6dR1U+Pd0da+SAr6
	 SSQLvemskYGrUs7TaGVkvT2ttusdc6G8EADeXNa7i1fPRsqwVx6iuke2/QHf1VbsvD
	 dL8QX0JBvIZ0OxKFfBsepyrsN3w/JsbHG+/r2gNAV9KoNS3O5ZUm3Tmin23Ymy8f9X
	 mFMIQQjkOJhImFlci6mGbksEPmwq5y/kXWg94WoLMAs6wPZ3cRxQUjPeQuoOomGl4b
	 cYz4wzD4wyzDg==
Date: Fri, 6 Nov 2026 10:17:17 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] Bluetooth: hci_qca: Reopen port after power on
 for QCA2066
Message-ID: <62qrp73oyhaismnbnb7q57z2loovfpwsut4t4bwy6vda2vaewc@sbifauqgi4jx>
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
 <ygy2hd47c3tb4vr2joiiy4bbg7rd4pn66x3co7iifv65cvnrf7@g36i65agh6p3>
 <561c0f8c-3252-4802-9d2c-ca1f93c65247@oss.qualcomm.com>
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
In-Reply-To: <561c0f8c-3252-4802-9d2c-ca1f93c65247@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 02:35:25PM +0800, Shuai Zhang wrote:
> Hi Bartosz
> 
> On 10/30/2026 5:29 PM, Bartosz Golaszewski wrote:
> > On Wed, Oct 28, 2026 at 07:18:37PM +0800, Shuai Zhang wrote:
> > > QCA2066 needs the serial port reopened after the controller is powered
> > > on, otherwise the host and the controller run into RTS/CTS
> > > synchronization issues.
> > > 
> > > Patch 1 reopens the port in qca_power_on() for QCA2066, as in v2.
> > > 
> > > Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
> > > port which failed to reopen is not closed or flushed again.
> > > 
> > > Changes in v3:
> > >   - Patch 1 is unchanged from v2.
> > >   - Add patch 2. If serdev_device_open() fails during the reopen, the
> > >     port stays closed but HCI_UART_PROTO_READY stays set, so the later
> > >     serdev_device_close() and hci_uart_flush() use a closed port. Keep
> > >     the flag in sync with the port state and skip the port flush when
> > >     the port is not open.
> > >   - Link to v2:
> > >     https://lore.kernel.org/all/20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com/
> > > 
> > > Changes in v2:
> > >   - Use a separate case for clearer logic.
> > >   - Link to v1:
> > >     https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/
> > > 
> > > Shuai Zhang (2):
> > >    Bluetooth: hci_qca: Reopen port after power on for QCA2066
> > >    Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
> > > 
> > >   drivers/bluetooth/hci_qca.c    | 46 +++++++++++++++++++++++++++++-----
> > >   drivers/bluetooth/hci_serdev.c |  6 +++--
> > >   2 files changed, 44 insertions(+), 8 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> Just want to confirm if there's anything else I need to do before applying
> it.
>

Luiz uses patchwork, I'm pretty sure the patch won't get lost.

Bart
