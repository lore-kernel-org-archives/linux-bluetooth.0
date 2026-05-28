Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDC38F925;
	Thu, 28 May 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958816; cv=none; b=ZtD7IsMepjd+VALF+ij8PCTu5DPnPaG3w59e7CwvuB84ncKqWY2eQeUHOmcGWCaOREmQ6cKeLIwb29/BBcJqcDq3y+bN3isx/97J4a+yRl31k3Ag/Oh0EHF2kZb4W/noPB7ZF8kWm7RqueBXhMTOhcHnGWLZyt7Bwtt2bKZJLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958816; c=relaxed/simple;
	bh=BEJo0rIHT9XGCwnfbKHZmLOZxHF40eb1Odu1Cf3Xmc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn15HZYAmClUHMG/QXFrizsrQysSOufP9IA9TGFAZJd6GAyBREs/n0oBbW8r+Fx9RU2Gapmn51pXs8tJNXyPRTWqo6iJcZGfq5NVPYQh77lfKxGI7NZpymdtkCQxSRkOun83byaeEecLrl8GdwRu2tigQI+AcdaemrO3TZuXfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af765.dynamic.kabel-deutschland.de [95.90.247.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D950E4C1AD77A9;
	Thu, 28 May 2026 10:59:59 +0200 (CEST)
Message-ID: <f44f9f90-e71e-4e92-8af0-9fe6f21b2989@molgen.mpg.de>
Date: Thu, 28 May 2026 10:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: MGMT: validate advertising TLV before type
 checks
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zerocling0077@gmail.com, 2045gemini@gmail.com
References: <20260528075701.3417224-1-rollkingzzc@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260528075701.3417224-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Cen,


Thank you for your patch.

Am 28.05.26 um 09:57 schrieb Zhang, Cen:
> tlv_data_is_valid() reads each advertising data field length from
> data[i], then inspects data[i + 1] for managed EIR types before
> checking that the current field still fits inside the supplied buffer.
> 
> A malformed field whose length byte is the last byte of the buffer can
> therefore make the parser read one byte past the advertising data.
> 
> Move the existing element-length check before any type-octet inspection
> so each non-empty element is proven to contain its type byte before the
> parser looks at data[i + 1].
> 
> KASAN reported an out-of-bounds read in tlv_data_is_valid(), reached
> through add_advertising() and hci_mgmt_cmd().

I’d add this after the second paragraph, and also add an excerpt, so 
people also seeing the trace can find the patch/commit more easily.

> Fixes: 2bb36870e8cb ("Bluetooth: Unify advertising instance flags check")
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> ---
> v2:
> - Drop the MGMT_OP_ADD_EXT_ADV_DATA hunk; bluetooth-next already
>    validates that command length.
> - Keep only the tlv_data_is_valid() element-ordering fix.
> - Add a Fixes tag and avoid the raw KASAN headline that triggered
>    checkpatch.
> 
>   net/bluetooth/mgmt.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index de5bd6b637b20..027b266ccc747 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -8638,6 +8638,12 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
>   		if (!cur_len)
>   			continue;
>   
> +		/* If the current field length would exceed the total data
> +		 * length, then it's invalid.
> +		 */
> +		if (i + cur_len >= len)
> +			return false;

Does Linux log something in this case?

> +
>   		if (data[i + 1] == EIR_FLAGS &&
>   		    (!is_adv_data || flags_managed(adv_flags)))
>   			return false;
> @@ -8654,12 +8660,6 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
>   		if (data[i + 1] == EIR_APPEARANCE &&
>   		    appearance_managed(adv_flags))
>   			return false;
> -
> -		/* If the current field length would exceed the total data
> -		 * length, then it's invalid.
> -		 */
> -		if (i + cur_len >= len)
> -			return false;
>   	}
>   
>   	return true;

The diff looks good. Feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
