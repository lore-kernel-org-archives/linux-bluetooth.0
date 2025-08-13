Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCA188715
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120523; cv=none; b=SG+bR7z67yApD9TBCW60RmtvTjd/+/1Hgfl3OeGf/xNaOvMave2TOAFMxQQ7tYi7Upib4QvojlO5x7qec+s1aIkrfCMf5CYpvvU6im3JfXy35MhfzyyiiGjcf0WCv3a8BzbNYDY/rooJqQ3FOt6Al6zAQFOmm2MZlAXiOWyaLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120523; c=relaxed/simple;
	bh=9wl2qlZEzhJcu216uHbejzJ5fnIXChGZImZk+rjyXRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZZhsx67ZPN5o/6gRRjEDLBtae0xGZTljn9N6r1cjE/DCYJpi7Z6+9TOOCPMFYnmevr61Tmbgz2+mGhWT8QLy0PsuBv6KIeCLOZRvYcAunFCR4NT5IZZdkP1/7lDdpQUdCMIta+WkPffbW2s63Ho4lxga2rzvX5j3hCY7rSzMOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c8.dynamic.kabel-deutschland.de [95.90.247.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 438AE61E647BA;
	Wed, 13 Aug 2025 23:28:35 +0200 (CEST)
Message-ID: <ba9252cc-ea44-4c47-a463-cf771d3113d7@molgen.mpg.de>
Date: Wed, 13 Aug 2025 23:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] Bluetooth: ISO: Don't initiate CIS connections if
 there are no buffers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250813211511.90866-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 13.08.25 um 23:15 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the controller has no buffers left return -ENOBUFF to indicate that
> iso_cnt might be out of sync.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/iso.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 5ce823ca3aaf..dff3fc4917d6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
>   		goto unlock;
>   	}
>   
> +	/* Check if there are available buffers for output/TX. */
> +	if (iso_pi(sk)->qos.ucast.out.sdu && !hci_conn_num(hdev, CIS_LINK) &&
> +	    (hdev->iso_pkts && !hdev->iso_cnt)) {
> +		err = -ENOBUFS;
> +		goto unlock;
> +	}
> +
>   	/* Just bind if DEFER_SETUP has been set */
>   	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
>   		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
