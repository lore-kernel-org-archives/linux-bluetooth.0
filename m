Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E23C4563;
	Tue, 23 Jun 2026 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198837; cv=none; b=oT7PB/cbU6iBZrpaqCLDJHeARAYSXdcnB1ly3WPf4S4UK4gQCnmac0YnKtGkg52M1rb0vRDKap/FI8gdsi3oeyjwKvO7/sfs82hAMx7JNIS/D2eJOA7QXXUj1WOS2jalT21blhucnf/sHXyX+mM7yce3u7Ssdt+MNnUiOt97A18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198837; c=relaxed/simple;
	bh=tSPSioAYV7XsJ9hTNtURslfekXAisJVEXXcC1GZ9DZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buFIHP/n6rn+UGWJnVVDUkMxG3hKJL5xCISeMuIIdNX0AZiBQSAzBGFVSoLUEgLFqWrxhW+rrUQLx3XXmtT7zuRqePb2vU7hAi2gPHCRqbcyvycQ+9SLvXYxSWwkYlsaflGDciA5P8/YDdt/3O8Chy9HNoZb/yupepLi9UeBAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F2E0D4C2C37D46;
	Tue, 23 Jun 2026 09:13:17 +0200 (CEST)
Message-ID: <97008590-5787-4e9e-b382-c32e8d9553dc@molgen.mpg.de>
Date: Tue, 23 Jun 2026 09:13:13 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Bluetooth: btmtk: Replace magic numbers with WMT
 packet flag enum
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20260623034121.691031-1-chris.lu@mediatek.com>
 <20260623034121.691031-2-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260623034121.691031-2-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Chris,


Thank you for the patch.

Am 23.06.26 um 05:41 schrieb Chris Lu:
> Add BTMTK_WMT_PKT_* enum to represent WMT download packet sequence flags,
> improving code readability. Replace magic numbers (1, 2, 3) in
> btmtk_setup_firmware_79xx() with descriptive enum values:
> 
> - BTMTK_WMT_PKT_START (1): First packet of a sequence
> - BTMTK_WMT_PKT_CONTINUE (2): Continuation packet
> - BTMTK_WMT_PKT_END (3): Final packet of a sequence
> 
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>   drivers/bluetooth/btmtk.c | 6 +++---
>   drivers/bluetooth/btmtk.h | 6 ++++++
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..21c08ee1cdbf 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -230,12 +230,12 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>   			while (dl_size > 0) {
>   				dlen = min_t(int, 250, dl_size);
>   				if (first_block == 1) {
> -					flag = 1;
> +					flag = BTMTK_WMT_PKT_START;
>   					first_block = 0;
>   				} else if (dl_size - dlen <= 0) {
> -					flag = 3;
> +					flag = BTMTK_WMT_PKT_END;
>   				} else {
> -					flag = 2;
> +					flag = BTMTK_WMT_PKT_CONTINUE;
>   				}
>   
>   				wmt_params.flag = flag;
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..51c18dde0a80 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -66,6 +66,12 @@ enum {
>   	BTMTK_WMT_ON_PROGRESS,
>   };
>   
> +enum {
> +	BTMTK_WMT_PKT_START = 1,
> +	BTMTK_WMT_PKT_CONTINUE = 2,
> +	BTMTK_WMT_PKT_END = 3,
> +};
> +
>   struct btmtk_wmt_hdr {
>   	u8	dir;
>   	u8	op;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
