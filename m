Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9033E35C;
	Fri, 10 Apr 2026 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813935; cv=none; b=as41KcKfcFrChms17JCwrwUp8m+l/G4Ah2Mz2T/uCZwz7rOvwT0FN9zgDFiPtVuJTmekgE67KIsVmoRP6IHlLmkMrOkCLw9grCyojB+d9jAYp8dBDzchzVNCNNNVoyZpVR16JTkJFHfDVyoQR0j4a0a6vmjGiGrx+rn/9XglG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813935; c=relaxed/simple;
	bh=T8ucRSUDq6n1hOQGDTpOxxU7VWHcjLCoQYqtuaRhBy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZLkDYw2GsWgEob1Tv7sZ2L+Sov3/eDPMYUgrPVqMCQireZRgwDhkI6xbvr+M1uyZ5pqQKKNUDZSKUdIp5wm5DnR6pEa7FaQDpQ6ZJwdXP5ZOcHvTGxgchgYCEzzcU6pDOw0huK9aqZbbtdhVCiOMyzHVlkRFvuydkQpFpOTfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A3E604C2C37D60;
	Fri, 10 Apr 2026 11:38:31 +0200 (CEST)
Message-ID: <489d33f4-16a1-430c-9ec6-7f13a8f2f995@molgen.mpg.de>
Date: Fri, 10 Apr 2026 11:38:30 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] Bluetooth: qca: Fix delayed hw_error handling due to
 missing wakeup during SSR
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Shuai,


Thank you for your patch. Just some last style things. It’d be great if 
you could re-flow the commit message to 75 characters per line. This 
would save some lines.

Am 10.04.26 um 10:52 schrieb Shuai Zhang:
> When Bluetooth controller encounters a coredump, it triggers
> the Subsystem Restart (SSR) mechanism. The controller first
> reports the coredump data, and once the data upload is complete,
> it sends a hw_error event. The host relies on this event to
> proceed with subsequent recovery actions.
> 
> If the host has not finished processing the coredump data
> when the hw_error event is received,
> it sets a timer to wait until either the data processing is complete
> or the timeout expires before handling the event.

Maybe mention the timer value?

> The current implementation lacks a wakeup trigger. As a result,
> even if the coredump data has already been processed, the host
> continues to wait until the timer expires, causing unnecessary
> delays in handling the hw_error event.
> 
> To fix this issue, adds a `wake_up_bit()` call after the host finishes

s/adds/add/

Now that you use `clear_and_wake_up_bit()`, this might confuse readers. 
Maybe:

To fix this issue, also wake up the other thread by using 
`clear_and_wake_up_bit()`.

Feel free to ignore though.

> processing the coredump data. This ensures that the waiting thread is
> promptly notified and can proceed to handle the hw_error event without
> waiting for the timeout.
> 
> Test case:
> - Trigger controller coredump using the command: `hcitool cmd 0x3f 0c 26`.

It’d be great if you mentioned one affected controller.

> - Use `btmon` to capture HCI logs.
> - Observe the time interval between receiving the hw_error event
> and the execution of the power-off sequence in the HCI log.

Please paste the logs.

> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
> Changes v6:
> - Replace wake_up_bit with clear_and_wake_up_bit
> - Link to v5
>    https://lore.kernel.org/all/20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com/
> 
> Changes v5:
> - Replace clear_and_wake_up_bit with wake_up_bit
> - Link to v4
>    https://lore.kernel.org/all/20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com/
> 
> Changes v4:
> - add Acked-by signoff
> - Link to v3
>    https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
> 
> Changes v3:
> - add Fixes tag
> - Link to v2
>    https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
> 
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>    https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
> ---
>   drivers/bluetooth/hci_qca.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c17a462ae..228a754a9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1108,7 +1108,7 @@ static void qca_controller_memdump(struct work_struct *work)
>   				qca->qca_memdump = NULL;
>   				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
>   				cancel_delayed_work(&qca->ctrl_memdump_timeout);
> -				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +				clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>   				clear_bit(QCA_IBS_DISABLED, &qca->flags);
>   				mutex_unlock(&qca->hci_memdump_lock);
>   				return;
> @@ -1186,7 +1186,7 @@ static void qca_controller_memdump(struct work_struct *work)
>   			kfree(qca->qca_memdump);
>   			qca->qca_memdump = NULL;
>   			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
> -			clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +			clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>   		}
>   
>   		mutex_unlock(&qca->hci_memdump_lock);

With the comments above addressed:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: gemini/gemini-3.1-pro-preview has some unrelated(?) comments [1]. 
It’d be great if Qualcomm could look into this.


[1]: 
https://sashiko.dev/#/patchset/20260410085202.4128000-1-shuai.zhang%40oss.qualcomm.com
