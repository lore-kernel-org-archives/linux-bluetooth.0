Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1E200AC;
	Fri,  5 Jan 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RgjONDf5"
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LePzrOnjwt8aXLePzrQwGC; Fri, 05 Jan 2024 08:15:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704438900;
	bh=vTHb4fsbw49n+cHEAzUAl+mW7b7a6gshLZ8DtNPyYCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RgjONDf5Bjjrcbs7ci13Gik0ej3zZDIChqvov4AerFaov14WFKjEdPwg2x8I9O7GC
	 YSCr4ztbjySHqLveMmw7YhxzT+uXQmDNlD6uTAHWCqEuEH+Yp+v/xiQMFwmNeKYW+C
	 xbzJxFqXzzgYwBjnDzXlsfLLA8+ACz621QUPXWMF/8JMwlYioJYCbf5gZmRRtA687a
	 AQazUN/HbaRyr8AGcJycpchw60dnFfS3Fm+YbJrweCj75zV2VADH79r58fh9hfN2Gl
	 cRNB5G66ip187ZGsOl5ArjafSsoaXfljKKrC6JUdNqU1CdHllTcWcXr7E/vvFIauAb
	 aN/sMoD8pT0aQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 08:15:00 +0100
X-ME-IP: 92.140.202.140
Message-ID: <63d2b52d-8f0b-4456-896c-ecdaf835c65a@wanadoo.fr>
Date: Fri, 5 Jan 2024 08:14:59 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Avoid potential use-after-free in
 hci_error_reset
To: yinghsu@chromium.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com
References: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/01/2024 à 12:56, Ying Hsu a écrit :
> While handling the HCI_EV_HARDWARE_ERROR event, if the underlying
> BT controller is not responding, the GPIO reset mechanism would
> free the hci_dev and lead to a use-after-free in hci_error_reset.
> 
> Here's the call trace observed on a ChromeOS device with Intel AX201:
>     queue_work_on+0x3e/0x6c
>     __hci_cmd_sync_sk+0x2ee/0x4c0 [bluetooth <HASH:3b4a6>]
>     ? init_wait_entry+0x31/0x31
>     __hci_cmd_sync+0x16/0x20 [bluetooth <HASH:3b4a 6>]
>     hci_error_reset+0x4f/0xa4 [bluetooth <HASH:3b4a 6>]
>     process_one_work+0x1d8/0x33f
>     worker_thread+0x21b/0x373
>     kthread+0x13a/0x152
>     ? pr_cont_work+0x54/0x54
>     ? kthread_blkcg+0x31/0x31
>      ret_from_fork+0x1f/0x30
> 
> This patch holds the reference count on the hci_dev while processing
> a HCI_EV_HARDWARE_ERROR event to avoid potential crash.
> 
> Signed-off-by: Ying Hsu <yinghsu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Tested this commit on a chromebook with Intel BT controller.
> 
>   net/bluetooth/hci_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 65601aa52e0d..a42417926028 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1049,6 +1049,7 @@ static void hci_error_reset(struct work_struct *work)
>   {
>   	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
>   
> +	hci_dev_hold(hdev);
>   	BT_DBG("%s", hdev->name);
>   
>   	if (hdev->hw_error)
> @@ -1060,6 +1061,7 @@ static void hci_error_reset(struct work_struct *work)
>   		return;

                 ^^^^^
Should we also call hci_dev_put() if we hit this return?

CJ

>   
>   	hci_dev_do_open(hdev);
> +	hci_dev_put(hdev);
>   }
>   
>   void hci_uuids_clear(struct hci_dev *hdev)

