Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D34566A;
	Sun,  5 May 2024 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714899993; cv=none; b=iOTlz5K6Wo3yVZM+rVIiP3FqsjpNjKJrantzP8HYGkAvnSk18W/D7Q9/JfYKkAcI4vvSKLpVfiMPHILvUU2rA7+8G3ZCJfCEwyCg7eT74q3mnPkwA5y1s/8lTc4/oOEhlaUTiCzrddR89QT2VQOFNzSPQmAU60q+Rnn83EHnpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714899993; c=relaxed/simple;
	bh=Oh1k6vjiKtFaFfOeSm2f1cOY0uN6C0bEQ3sYUKgAErU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hkc/6Tdob1MpIRfz+0jLPFSbn8aASH08hX3LwOEynAvcqbpF1lW2127jUoKFz5ep6ItYZkVnvL1oo0hOxHFlAIylbC/6FVdetGXDFB7eZxGIWRB/viS6EKTQw4Cu35LclkqWra/RnjRz6FMCm5CyhcanwWMSBIHF8Hs4kFFLvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=acy4RS18; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="acy4RS18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RiBDRjpnVwWZ/L4d65VWLNETY36x2v5A1qooU4xt2mw=;
  b=acy4RS18ot7FCBRUmPvjBMnII/FVeyHyf2QUT5r9M18nHfXMHVEwHh/m
   UsabrJkQOMLXkXk4h4yl2o6qkghHZj3uwiQf26WvNp5a2zGr7H0lDAd9e
   xabMgx28gWNcAR36c510ISxXurYbTaVdQTe2Et0ntP1tCzbzBD6oA2lVH
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,255,1708383600"; 
   d="scan'208";a="86396322"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 11:06:21 +0200
Date: Sun, 5 May 2024 11:06:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Marcel Holtmann <marcel@holtmann.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: qca: Use common error handling code in two
 functions
In-Reply-To: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
Message-ID: <alpine.DEB.2.22.394.2405051105000.3397@hadrien>
References: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 5 May 2024, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 May 2024 10:30:28 +0200
>
> Add a jump target so that the setting of an error code can be better reused
> at the end of these function implementations.
>
> This issue was transformed by using the Coccinelle software.

This reduces readability, and backwards jumps are rarely desirable.

julia

>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/bluetooth/btqca.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index cc61014ffbc9..1833aaa6d87b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -108,10 +108,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>  		return err;
>  	}
>
> -	if (skb->len < sizeof(*edl)) {
> -		err = -EILSEQ;
> -		goto out;
> -	}
> +	if (skb->len < sizeof(*edl))
> +		goto e_ilseq;
>
>  	edl = (struct edl_event_hdr *)(skb->data);
>
> @@ -123,17 +121,13 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>  		goto out;
>  	}
>
> -	if (skb->len < sizeof(*edl) + 1) {
> -		err = -EILSEQ;
> -		goto out;
> -	}
> +	if (skb->len < sizeof(*edl) + 1)
> +		goto e_ilseq;
>
>  	build_lbl_len = edl->data[0];
>
> -	if (skb->len < sizeof(*edl) + 1 + build_lbl_len) {
> -		err = -EILSEQ;
> -		goto out;
> -	}
> +	if (skb->len < sizeof(*edl) + 1 + build_lbl_len)
> +		goto e_ilseq;
>
>  	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
>  	if (!build_label)
> @@ -145,6 +139,10 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>  out:
>  	kfree_skb(skb);
>  	return err;
> +
> +e_ilseq:
> +	err = -EILSEQ;
> +	goto out;
>  }
>
>  static int qca_send_patch_config_cmd(struct hci_dev *hdev)
> @@ -224,8 +222,7 @@ static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
>  	edl = skb_pull_data(skb, sizeof(*edl));
>  	if (!edl) {
>  		bt_dev_err(hdev, "QCA read board ID with no header");
> -		err = -EILSEQ;
> -		goto out;
> +		goto e_ilseq;
>  	}
>
>  	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> @@ -235,10 +232,8 @@ static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
>  		goto out;
>  	}
>
> -	if (skb->len < 3) {
> -		err = -EILSEQ;
> -		goto out;
> -	}
> +	if (skb->len < 3)
> +		goto e_ilseq;
>
>  	*bid = (edl->data[1] << 8) + edl->data[2];
>  	bt_dev_dbg(hdev, "%s: bid = %x", __func__, *bid);
> @@ -246,6 +241,10 @@ static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
>  out:
>  	kfree_skb(skb);
>  	return err;
> +
> +e_ilseq:
> +	err = -EILSEQ;
> +	goto out;
>  }
>
>  int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
> --
> 2.44.0
>
>
>
