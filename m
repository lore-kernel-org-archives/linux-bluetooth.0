Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000D489865
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536325; cv=none; b=CD56bbfQ/v+8MgExC/q5TeIG36fMgnv3HgnAAmLsYd1jQbPQLK9myRfejlPOWOfUn6RAumM6u4aEii9kFH/6qEclOCMgZE3/xzSpjqlxjCyabWU/QaTaGDTvmpig9MKj8x0Ms8mnpPe7wW0/SwqjW/wnXMwB/5ihCBQttHB5TIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536325; c=relaxed/simple;
	bh=wNxgKlfQohjascZeRKtDRyDb/IBpavaErjy2jQnRt3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfPWeJJWL384WUBb3IzruNsUPwGelg2RWNgypySPMqSn9GscHBnclV/eWppDXVBZxGB4qhN1VDJY72wOsgl715wmTfvrk2T1gGPxsdIncdRAJJtAlT3lu5+BMRG25+TJlhj+yemdf5t+G2CvTus9adYm7lwfSzf4N57GrA5JPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9LKCz4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9LKCz4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E41F00AC4;
	Fri, 31 Jul 2026 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536324;
	bh=DQcuWvZKcRiidbPByypueggbr1rRjC9s/jCQ5Z8d2iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a9LKCz4x41ewoY84/GX3XG9Y2+ll8yr8mRSograu1gqOgspiiXxtlQyjNLKJ/dpJ4
	 G2UX3KuhXobIcQfYFggl/Ggr6QRMgdFju/aQJWGPyrvAWRGyfyP2u++EoBm1pih+Jj
	 GYIEU/IthcR89g5FMWKvJgDlk2e7ZK0WJN708d8nIRBe/ftFNU3e7FVl9x1XwLez97
	 j9tXe3xiCcT6X0BAtJ07RsYTZYCRDkmpaqGi59AJbM9yPRsMx2wkNEHMmBfiNc/j9e
	 im0CF1N34LyFt13yAzmh9l7WNiFf9swUS6hHwSRjcjkdi2tR4MYBGIW3Hk5HPEBjqD
	 xpGEuK5OAVMgQ==
Date: Fri, 31 Jul 2026 15:18:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: add conditional locking annotations
Message-ID: <20260731221840.GA4066390@ax162>
References: <528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>

On Sat, Jul 25, 2026 at 01:02:36PM +0300, Pauli Virtanen wrote:
> Add context analysis annotations to functions doing conditional locking,
> to suppress analysis warnings.
> 
> Fixes: a3ad01d51d4b ("Bluetooth: hci_sync: Fix advertising data UAFs")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

It would be nice if this could be applied, as this breaks recent clang
builds due to context analysis being on by default and -Werror enabled
by default with many configurations now:

  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/30660246388

> ---
>  net/bluetooth/hci_sync.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d5554fbf3129..f5545f270f09 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1255,6 +1255,7 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, u8 instance,
>  }
>  
>  static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +	__context_unsafe(/* conditional locking */)
>  {
>  	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
>  		    HCI_MAX_EXT_AD_LENGTH);
> @@ -1343,6 +1344,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
>  }
>  
>  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
> +	__context_unsafe(/* conditional locking */)
>  {
>  	struct hci_cp_le_set_ext_adv_params cp;
>  	struct hci_rp_le_set_ext_adv_params rp;
> @@ -1499,6 +1501,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>  }
>  
>  static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
> +	__context_unsafe(/* conditional locking */)
>  {
>  	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
>  		    HCI_MAX_EXT_AD_LENGTH);
> @@ -1552,6 +1555,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
>  }
>  
>  static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
> +	__context_unsafe(/* conditional locking */)
>  {
>  	struct hci_cp_le_set_scan_rsp_data cp;
>  	u8 len;
> @@ -1693,6 +1697,7 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
>  }
>  
>  static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +	__context_unsafe(/* conditional locking */)
>  {
>  	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
>  		    HCI_MAX_PER_AD_LENGTH);
> -- 
> 2.55.0
> 

-- 
Cheers,
Nathan
