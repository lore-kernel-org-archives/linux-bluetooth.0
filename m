Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218812;
	b=2PNXzt6VqONUiuJNzXlo9lnVnu/YEDrf5YSU83DbGqdFPKcDWy+QM02ZiAgeuCgKeqgV
	 eQIZEQB2IaKiilUX8E7OrSTPf3kyHtAJLllLBwx9Lp/wW5mUfvtmoKk4ZzLLGzU1Mje/Y
	 aSixPUHcqXv9qfPxTypVzG5fKf5rWrVlxB6vUUPQkEgHAurnAjvoJq+Z+A77+ywZof0ir
	 uxbmdaCTE69Tm6mTsKaSMUd/yfdgBdkJw3eSGgzD8hlPPmrtDsxKSUQ9YxYqrINZ/g/Un
	 8gu9ehHr9NIiE8OXcHCgwis/5QybD4oSzuBuxdOVA1x3VLqZq/Qw/qwfyyfmb/Vcaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GtYIm+rWOI2WR3mNBXOj58UxSxdzyvXp4UZh6Gfd/i4=;
	b=KQ6vPGdeP3ckeh5q18HlcG6IxdpySzPbgDpQcbK7ONwHruwo9kUhehWe9muNFbMIOBWv
	 d8ZvpVsBbs0NkUcR6ypWTTayIDlqBqEAXSLHAvgRYd2JxYL2FJcEyd5WdqwlT9afdYtJX
	 iyKYWCexHkBltnWiu0sl3Zj5RnxqR7xhjRywGjatXio/Q4wPdMswdpw89ymZlxOfbqcLN
	 YybZvm50OEBN7MKbFNhNb5fUDBYMtF9cb3MTKlZs3k5Bg3Zc2kWqyoay+CHPRP8lgQ5I6
	 oeJiLkO4Li0tIjp1huHEEWS97hs8OOAQMepMTRAdScTSJDKaLndQn+N8jgaeQEu0v3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i0ktJ/Vw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843A606A33E;
	Fri, 20 Nov 2026 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0ktJ/Vw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B51F000C6;
	Fri, 20 Nov 2026 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795218811;
	bh=GtYIm+rWOI2WR3mNBXOj58UxSxdzyvXp4UZh6Gfd/i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i0ktJ/Vwel/HRt+z7HIvQtAFgN47Ptjdc8ml1p450ILd372E5nWUqjKOfydgYqOES
	 rbjvLR1JS5+v1MJvWqf85KkjpEMzqmFKEto0Wj3uueyhM0Pr1ACfYxGTHqSrBFdM5D
	 ysQ2hPLdU0Fcsr8cjOBnMr7KPMCKJPVMYnhh2EpOMsZl4scMWWCGMoUZlDDTMZ3Xvf
	 Qo0qOYyctZp9JVuUG9cr/WNgd9pk0X8ctQtvMJ8W56byRwulu42OktYA6kdWjMkc4X
	 lVtzQsX3FpxheFSS1r80E3IPribh4poKqCBncqIYBskgvZZx11iPdmro6cO1C4xE8c
	 cCRzp0+Ink/ZA==
Date: Fri, 20 Nov 2026 15:53:30 -0800
From: Drew Fustini <fustini@kernel.org>
To: Thomas Gerner <thomas.gerner@muenchen-mail.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: disable read tx power for
 BeagleV-Ahead
Message-ID: <awDdetFNaeuxKkbp@x1>
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
 <20261020132604.90708-2-thomas.gerner@muenchen-mail.de>
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
In-Reply-To: <20261020132604.90708-2-thomas.gerner@muenchen-mail.de>

On Tue, Oct 20, 2026 at 03:26:03PM +0200, Thomas Gerner wrote:
> The bluetooth module of the Ampak AP6203BM is identified by the btbcm
> driver as BCM4362A2.
> 
> The firmware of the bluetooth module on the BeagleV-Ahead reports a
> capability of reading LE tx power. However reading fails. To get
> bluetooth working it is necessary to disable reading of LE tx power on
> the BeagleV-Ahead board. The disable is implemented in a similar way as
> for several Apple boards but uses the board compatible identification
> from the DTB as there is no DMI.

Thanks for sending this patch. Do you know if this is a problem on any
other boards with the AP6203BM?

Also, is there an error message for the failed read?

> 
> Signed-off-by: Thomas Gerner <thomas.gerner@muenchen-mail.de>
> ---
> No changes in v2
> 
>  drivers/bluetooth/btbcm.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 463d59890bef..2d02cc1863d0 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
[..]
> -static const char *btbcm_get_board_name(struct device *dev)
> +static const char *btbcm_get_board_name(struct hci_dev *hdev)
>  {
>  #ifdef CONFIG_OF
>  	struct device_node *root __free(device_node) = of_find_node_by_path("/");
>  	char *board_type;
>  	const char *tmp;
> +	const char **s;
>  
>  	if (!root)
>  		return NULL;
> @@ -550,8 +556,15 @@ static const char *btbcm_get_board_name(struct device *dev)
>  	if (of_property_read_string_index(root, "compatible", 0, &tmp))
>  		return NULL;
>  
> +	/* disable broken Read LE Min/Max Tx Power on first board found in list */
> +	for (s = board_broken_read_transmit_power; *s; s++)
> +		if (!strcmp(tmp, *s)) {
> +			hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);
> +			break;
> +		}

It seems that btbcm_get_board_name() only looks up the board name for
the firmware file so I think it could be unexpected to set a quirk here.
Maybe this would work better?

  static const char * const board_broken_read_transmit_power[] = {
          "beagle,beaglev-ahead",
          NULL
  };
 
  [..]

  if (dmi_first_match(disable_broken_read_transmit_power))
          hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);

  if (of_machine_compatible_match(board_broken_read_transmit_power))
          hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);


However, I am not very familiar with Bluetooth drivers so I am hoping
Marcel or Luiz can comment too.

Thanks,
Drew
