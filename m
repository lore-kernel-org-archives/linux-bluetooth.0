Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710450;
	b=wSp3MTd0SDF/lkRIdZD3iv4yGkFeD4TGhPBian6G4CthguQGonMUPjVUM5I5r6DOWc9Y
	 EtzD0/fN5BeWYzYbi9BUyDGZJDbz33nM7Nmu536PN84E/VTj2uVII1hLtbTLCL+/4a1Ba
	 1Y8AOwXqZxVXXOKMyXUzHetJLIFcTFq/lCs/lJ94vrzjObGGfP83v3Js9D2zSaLeRC0nH
	 0PgcQvqOa0gVAHAQC6Ay6/pEVEocNKfIh4mayzukJK5vw0tdhdJnr7+v6g06d3DDWj4T9
	 tVRUCgsalD1DmrfAHCXIqAeHx41HX+TwdE0qGHOJw7UxYBzkhA8teGv5s5B5cC77iJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mdo8FWWmR6eNMPC7wFF5bhdu0XNu6s5GBAO2D8FZFso=;
	b=f7HQxs+NcR9OOMEu/jWFxPycCjIpbLKVF20O6oOZtGV+manoAEpkfZHeD909CJ2XWK6Z
	 Thpd4529tUDMxciy/uT3KC9DKXNmbW2DVZWKcX/qva96mIJywhfgIilaBhYw5o+eVtJX9
	 cWE9PzVDE64Yxejf1imbyiJVvKbHAZI0E9a4fEq8vlkNHNWUdMP+69EKYWmirQ38wN0Pu
	 Cy/kJ0r/tEogjAQoffJ7wxbw/tKH8iU7zSnVvpPxpHg2ydtHh+f5YW13roFUI9+hOUt6T
	 Plv34yig3qNNPNTjf3noWBR3EuVcWxqsqLaETNb1U0BCM42XvcruA2a8ShSJ1hoQwUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H55WwvuE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CCD01606A324;
	Tue,  3 Nov 2026 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H55WwvuE
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D78951F000C1;
	Tue,  3 Nov 2026 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710449;
	bh=mdo8FWWmR6eNMPC7wFF5bhdu0XNu6s5GBAO2D8FZFso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H55WwvuEPnOihcvnn8ocXvBNHbmibVyEXXPzNOMKlpJFRTTCHAt8yynbr2U/dzJTa
	 8So+oOQqaC4WxRNjYRHxMFHcRnzO9BX/7FbEqUvL38SFSRQDb21PPQ9NezoCnXjf1S
	 AKYjoyg9t8CkyWatoPFeCAKTQFeMgMvJwpruZcg2brgrOvO8WCWaMF/PaeV+QSlhqp
	 VQvyloVW+clszxzwjfcyTZ5QXBGt6MKg51kBRyVrvvJajHquQQSmUdvpvw7/xAqB4H
	 Z2ak1/w2IAhPJ0MsKYf1QmYs3Wcu7L0zKHvFtDG4HSBuGRhuyswvFz0Ma12aveC7mF
	 fIfn32GKb0/Cw==
Date: Tue, 3 Nov 2026 13:54:06 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Stanislavs Nilovs <valorcool@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3950
Message-ID: <ezkgoc765ly6pxioyv5xh3kpwvpcsncdcuh6pyyffwugsgrh52@x7n4h2zgsfjd>
References: <20261103103414.803861-1-valorcool@gmail.com>
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
In-Reply-To: <20261103103414.803861-1-valorcool@gmail.com>

On Tue, Nov 03, 2026 at 12:34:14PM +0200, Stanislavs Nilovs wrote:
> Added WCN3950 module to the switch-case to disable SoC debug packets.
> 
> Fixes: 590deccf4c06 ("Bluetooth: hci_qca: Disable SoC debug logging for WCN3991")
> Signed-off-by: Stanislavs Nilovs <valorcool@gmail.com>
> ---
>  drivers/bluetooth/btqca.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 002307000d3c..60735b70d89a 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -943,6 +943,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	switch (soc_type) {
>  	case QCA_QCA2066:
>  	case QCA_QCA6390:
> +	case QCA_WCN3950:
>  	case QCA_WCN3991:
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
> -- 
> 2.53.0
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
