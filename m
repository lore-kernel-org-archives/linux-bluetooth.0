Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA54A21;
	Mon, 11 Aug 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906539; cv=none; b=B6sKbQVrL7daHe1vV/9wy+UkH06FB76Ugq4Y1dRmRIMZKJPVwkiu5FACYzrJuBwciED6wiE9RPH0TGGp7rowAwqW4VlPItGNaGLZhTY/Ke91no3yVYVnXT1B5h7K6pozhixwYyYuz6FSTmC0gP/coeBDOLd55RNIGhMlQipHu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906539; c=relaxed/simple;
	bh=z9gaLA4yObW+ick9rDfAVkPEYC9i930B2fEDdGaGLTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecVAIHDO7pyAU4E+lgej+ovlhWR2ADuihYLuuVCZ3l3iquTwhYpD6UwIjk+EMGdOLOU5UMnZrVfbuHW/cW5FWEMZc+Rt0Z/PYYIYlSoHH5a/GIKvhD/YISHGO4s5ZzSa3LeAZR0eaPqaxsj5mzPg3TrDnG2BVgIIlehGGoMeYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7bb.dynamic.kabel-deutschland.de [95.90.247.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 63F1761E647BA;
	Mon, 11 Aug 2025 12:02:00 +0200 (CEST)
Message-ID: <677c56b5-8f8f-4a08-8e8f-26fba3236885@molgen.mpg.de>
Date: Mon, 11 Aug 2025 12:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Use strscpy() instead of
 strscpy_pad()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811091906.4640-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250811091906.4640-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Thorsten,


Thank you for the patch.


Am 11.08.25 um 11:19 schrieb Thorsten Blum:
> kzalloc() already zero-initializes the destination buffer 'data', making
> strscpy() sufficient for safely copying 'name'. The additional
> NUL-padding performed by strscpy_pad() is unnecessary.
> 
> Add a new local variable to store the length of 'name' and reuse it
> instead of recalculating the same length.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/bluetooth/btintel_pcie.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6e7bbbd35279..aad03f8a3e13 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2236,6 +2236,7 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
>   {
>   	struct btintel_pcie_dev_recovery *tmp, *data = NULL;
>   	const char *name = pci_name(pdev);
> +	const size_t name_len = strlen(name) + 1;
>   	struct hci_dev *hdev = to_hci_dev(dev);
>   
>   	spin_lock(&btintel_pcie_recovery_lock);
> @@ -2252,11 +2253,11 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
>   		return data;
>   	}
>   
> -	data = kzalloc(struct_size(data, name, strlen(name) + 1), GFP_ATOMIC);
> +	data = kzalloc(struct_size(data, name, name_len), GFP_ATOMIC);
>   	if (!data)
>   		return NULL;
>   
> -	strscpy_pad(data->name, name, strlen(name) + 1);
> +	strscpy(data->name, name, name_len);
>   	spin_lock(&btintel_pcie_recovery_lock);
>   	list_add_tail(&data->list, &btintel_pcie_recovery_list);
>   	spin_unlock(&btintel_pcie_recovery_lock);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
