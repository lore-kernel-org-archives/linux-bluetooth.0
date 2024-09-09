Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158A1B375C;
	Mon,  9 Sep 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885630; cv=none; b=UBoTkCiTY0uCxfPhYWQA/5C/qdiLvFB2Aq4GmbFDAp8QH5QzI2z4L9VRgXgNzN7fhnvrQS1gyI63/4ncPM7pBEZTZBIbsMKxFkHhY4lOscoFZzEkDC6Rzgtw65xvpYcxSie7LZo3by0L7aIHd7Rr89l8CrIt6LfYq0QCU3r55H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885630; c=relaxed/simple;
	bh=avLcO7PKE2LaQ9TnVodcfdEGPe+Kj9ffz1kmZQ3Rn6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qp5Qn6Sv2Bp4EQ1SbdgiWJP0RApBxiiyv9sSXvkxLLSDy6Wsf/kVbh32WfJuj1y8m6SbUqAAUsc9FgN4G+9zWl5iPiKVGEpQ6mlnoZtVAXt0ms7FzOz6dzsGavtwHspC04iR2MHwEiDV/MALKXAkhDggC0UAKVr3qp5+n/ioIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.16.9.194] (hh-wlan-01.rz-berlin.mpg.de [141.14.51.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8492661E64862;
	Mon,  9 Sep 2024 14:40:10 +0200 (CEST)
Message-ID: <6a993f00-ee3a-41fe-89f4-eeb604c3c880@molgen.mpg.de>
Date: Mon, 9 Sep 2024 14:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: mgmt: Verify cmd pending status before
 removing it
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240909030906.26375-1-quic_jiaymao@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240909030906.26375-1-quic_jiaymao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jiayang,


Thank you for your patch.

Am 09.09.24 um 05:09 schrieb Jiayang Mao:
> From: jiaymao <quic_jiaymao@quicinc.com>

Please use your full name:

     $ git config --global user.name "Jiayang Mao"
     $ git commit -s --amend --author="Jiayang Mao 
<quic_jiaymao@quicinc.com>"

> Add a verification step to ensure that a command is still in the pending
> list before attempting to remove it. A crash may occur during the boot
> process when Bluetooth is enabled and then immediately disabled. In a
> race condition, mgmt_index_removed() might free the pending command
> before mgmt_add_adv_patterns_monitor_complete() is called, leading to a
> double free scenario.
> 
> Part of the crash call trace:
> 0x0000053D: __list_del_entry_valid_or_report+0x98/0xdc
> 0x0000053D: mgmt_pending_remove+0x18/0x58 [bluetooth]
> 0x0000053E: mgmt_remove_adv_monitor_complete+0x80/0x108 [bluetooth]
> 0x0000053E: hci_cmd_sync_work+0xbc/0x164 [bluetooth]

What is your test environment? Please document it.

> Signed-off-by: jiaymao <quic_jiaymao@quicinc.com>

Ditto.

> ---
>   net/bluetooth/mgmt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25979f4283a6..9d019db92043 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5428,6 +5428,9 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
>   
>   	hci_dev_lock(hdev);
>   
> +	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +		goto done;
> +
>   	rp.monitor_handle = cp->monitor_handle;
>   
>   	if (!status)
> @@ -5437,6 +5440,7 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
>   			  mgmt_status(status), &rp, sizeof(rp));
>   	mgmt_pending_remove(cmd);
>   
> +done:
>   	hci_dev_unlock(hdev);
>   	bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
>   		   rp.monitor_handle, status);


Kind regards,

Paul
