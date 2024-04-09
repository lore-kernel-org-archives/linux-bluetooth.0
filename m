Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959467172F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667499; cv=none; b=DNDBGOdMelsBFqsz9WbqYMMmTXzxPOClnQf5y4N5eKTiIRrfmANeyPZ7rI7UadeiFpx7diW2nipLAPl4vlyS3X8jRfoEbQbUDhyPVK4TabrvvEtfRuuqibvVBTA0fp0cdOwcwT2UZ0w+DkSN40Vp/kMMhhHJHCVYvcO2hu0/YXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667499; c=relaxed/simple;
	bh=7XH6RnIvFA+1+cx6w3PQJsxWbLdG3tfE2xPdfrtP8HE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=AddkRsJb6JJH+GfeThz5aBJhVTlenT93pNXzUsTuqRxscqsgOxJBSYiP8ISG6AobibmyTxCH8eWPDn6zgku26e/JmsJ0FnZ/ocycoh76xiiEXH/iFOBOcJYC5kG+zr9K1rB2tN0thdjffOE9XT82xchOERucLuBdtjPjxsy53U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m.mmlb.dev; spf=pass smtp.mailfrom=m.mmlb.dev; dkim=pass (2048-bit key) header.d=m.mmlb.dev header.i=@m.mmlb.dev header.b=mIe3/rpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdPHN+DQ; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m.mmlb.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.mmlb.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m.mmlb.dev header.i=@m.mmlb.dev header.b="mIe3/rpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdPHN+DQ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6330618000E7;
	Tue,  9 Apr 2024 08:58:15 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute1.internal (MEProxy); Tue, 09 Apr 2024 08:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.mmlb.dev; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712667494; x=1712753894; bh=QVwMhkUB1z
	jauybWUJ502opKRX0M+/lt2bhtYx7xMBs=; b=mIe3/rpH25rnD65zuP/8Pg/x54
	idcecSSJsIbrhSHGGY0IVVJkdCG1Ez0R2ONkjsOszQBrnfPbxdj4bw0U7pYgaudl
	k4a1u7Avowngbak4uh1JryKjTbFcsq4S/HLi96lsLrPwEB8wwtYOUNBkcZrQ04Uz
	jVKrULC7M2D5o/pjBOTgi6VF/+bsQY81Z+4lMj9cozplk4PLN+oLfEr2Ws1oSx3K
	ocGF0x2XiNBqTf5QgnyYBpIywNj0mvODbsVRI+HXaFWz+0lMBOK+o7mBXzl3Ihk/
	HjHgcQheASkGSTAXXewZzdHhh6Tl/m5Fa548gS3aJYil1SH7qfcoXbN0PO9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712667494; x=1712753894; bh=QVwMhkUB1zjauybWUJ502opKRX0M
	+/lt2bhtYx7xMBs=; b=GdPHN+DQLfF2Svp2D4T4+hN+ltku7dkUYXYjGJoIuoE/
	xsZXuxRqBLis/TDX9MpERaVKAAda1I+7rmYPvArB6GSeKusXOU6IEjJlJNFCNHZs
	xLg2rLdlqgUmp4kLIVpoeKOHvvHo/2dQlHrSCJMh31G+CrOfsvVX+aFIXSr6jEkB
	hkqnBH+PyJKYa3QI1bwUORMMhnKTG9/Ie/RdODlMdjjNDvmTB9PjPqcW9nh9shS/
	f/i+zREbze7xd4OfZKC8uLiQ0uPPwThrpq803THO/LiDjv7UWEe5pskFCgWt85Zp
	AZVMtE7MUbyZYFqwniDOk5uvh6qdXVxyZ4LNaV1Fzw==
X-ME-Sender: <xms:ZjsVZscJ4n0erKx6ipG1B3RU_ZP86a4QkITxaS6BrUSapO4B7HW98A>
    <xme:ZjsVZuMPcYt4K6IbhrQFIan7fU5JIMsz0wPonCFB6VKYTnfw1b_lBRqK9PXpeQxHy
    yHLzYgvmGnCobr2oU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdforghn
    uhgvlhcuofgvnhguvgiifdcuoehisehmrdhmmhhlsgdruggvvheqnecuggftrfgrthhtvg
    hrnhepieefueeftdetteefleffvdelgedvgefgvddvvedvhedutdeugedvteejuedvveel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihesmh
    drmhhmlhgsrdguvghv
X-ME-Proxy: <xmx:ZjsVZtgNDmpoo1ifAPDaOQBeP8uoglszgssbTkxdEMU3GH7b1ho8zg>
    <xmx:ZjsVZh9hbyAP1RVqJTLa85R72aRpzMGnxnn8I4wRLjgp3ZcN5mUiMQ>
    <xmx:ZjsVZov4hYcJU1wVJLGlsGdXuKI0US7IpBG4KyQnX664w2tOUo5IUQ>
    <xmx:ZjsVZoFRYjxKdtHQT5CEk4H3pu7OaR07aetxdMA1h1uuWRjcTRAxRQ>
    <xmx:ZjsVZlXRf8Gf-fyI1Xb_gdPnYXIfkaRyGpIX_ypLFEftC3y4B-7jMz26>
Feedback-ID: i04914473:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 86B3D2340080; Tue,  9 Apr 2024 08:58:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <605eca59-b875-4e8a-8266-3282c5c8a545@app.fastmail.com>
In-Reply-To: <20240401193515.2525201-1-luiz.dentz@gmail.com>
References: <20240401193515.2525201-1-luiz.dentz@gmail.com>
Date: Tue, 09 Apr 2024 08:56:54 -0400
From: "Manuel Mendez" <i@m.mmlb.dev>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: btintel: Attempt to reset if Read Version fail
 during setup
Content-Type: text/plain

On Mon, Apr 1, 2024, at 3:35 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> During setup callback the code would attempt to send Read Version which
> sometimes can fail due to ncmd being set to 0 which would block any
> command from being send which is why INTEL_BROKEN_INITIAL_NCMD was
> introduced.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 47 +++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a19ebe47bd95..c2ebdd2b2462 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -655,9 +655,6 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
>  	struct sk_buff *skb;
>  	const u8 param[1] = { 0xFF };
> 
> -	if (!version)
> -		return -EINVAL;
> -
>  	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
>  	if (IS_ERR(skb)) {
>  		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
> @@ -672,12 +669,38 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
>  		return -EIO;
>  	}
> 
> -	btintel_parse_version_tlv(hdev, version, skb);
> +	if (version)
> +		btintel_parse_version_tlv(hdev, version, skb);
> 
>  	kfree_skb(skb);
>  	return 0;
>  }
> 
> +static int btintel_read_version_setup(struct hci_dev *hdev)
> +{
> +	int err;
> +	struct sk_buff *skb;
> +
> +	err = btintel_read_version_tlv(hdev, NULL);
> +	if (!err)
> +		return 0;
> +
> +	/* Attempt to reset if the command times out since this could be
> +	 * because the ncmd is set to 0 therefore no command will be able to be
> +	 * sent.
> +	 */
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "sending initial HCI reset failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return btintel_read_version_tlv(hdev, NULL);
> +}
> +
>  /* ------- REGMAP IBT SUPPORT ------- */
> 
>  #define IBT_REG_MODE_8BIT  0x00
> @@ -2821,7 +2844,6 @@ static void btintel_print_fseq_info(struct hci_dev *hdev)
> 
>  static int btintel_setup_combined(struct hci_dev *hdev)
>  {
> -	const u8 param[1] = { 0xFF };
>  	struct intel_version ver;
>  	struct intel_version_tlv ver_tlv;
>  	struct sk_buff *skb;
> @@ -2862,18 +2884,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>  	 * command has a parameter and returns a correct version information.
>  	 * So, it uses new format to support both legacy and new format.
>  	 */
> -	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> -	if (IS_ERR(skb)) {
> -		bt_dev_err(hdev, "Reading Intel version command failed (%ld)",
> -			   PTR_ERR(skb));
> -		return PTR_ERR(skb);
> -	}
> -
> -	/* Check the status */
> -	if (skb->data[0]) {
> -		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> -			   skb->data[0]);
> -		err = -EIO;
> +	err = btintel_read_version_setup(hdev);
> +	if (err) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%d)", err);
>  		goto exit_error;
>  	}
...
After applying this patch skb is left as null here and I later get a null dereference oops on line 2753:
  if (skb->len == sizeof(ver) && skb->data[1] == 0x37) { 
...
> 
> -- 
> 2.44.0
