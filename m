Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656163AA
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jan 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae9df.dynamic.kabel-deutschland.de [95.90.233.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CFE461E5FE01;
	Sat,  6 Jan 2024 10:50:41 +0100 (CET)
Message-ID: <353ffa04-f131-4215-a941-f98ae5d22d29@molgen.mpg.de>
Date: Sat, 6 Jan 2024 10:50:40 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix accept_list when attempting
 to suspend
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240105161042.4179775-1-luiz.dentz@gmail.com>
Cc: Clancy Shang <clancy.shang@quectel.com>, linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240105161042.4179775-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for your patch.

Am 05.01.24 um 17:10 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> During suspend, only wakeable devices can be in acceptlist, so if the
> device was previously added it needs to be removed otherwise the can end

… the *device* can?

> up waking up the system prematurely.
> 
> Fixes: 3b42055388c3 ("Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan")
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_sync.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index b3141e3f9cf6..5716345a26df 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2206,8 +2206,11 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
>   
>   	/* During suspend, only wakeable devices can be in acceptlist */
>   	if (hdev->suspended &&
> -	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
> +	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) {
> +		hci_le_del_accept_list_sync(hdev, &params->addr,
> +					    params->addr_type);
>   		return 0;
> +	}
>   
>   	/* Select filter policy to accept all advertising */
>   	if (*num_entries >= hdev->le_accept_list_size)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
