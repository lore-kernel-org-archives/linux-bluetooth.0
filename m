Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE0372EF9
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702632; cv=none; b=Le9AIFdpssMQLA0s50DqTMtve4aqxSzMH/xm7T5wSop+B3m6zyoAUx8fgsSpIUadP8H9GzXfkqBIOtIE7LFV6xxQUF6GuGu0ZcmLv0aeXN2MCfR61F3GNOVTCaETdrs8a5CUSdyfc+rqQBhwfaHSmJSyKpX560LZVvcfw8kf5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702632; c=relaxed/simple;
	bh=TmXvaLaBOF5AtDjI+0yNhSp7Yux2wCZPs31OyQIwSUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZWC1fHc8msrqx4bq66SoxvJG6AXHDvZ6LRZ2a/qHVGjz/OR3RAxG9+46PTXhWKOdmb6/RaY9A1hYrWH3oVndSO3+vUpaTYvj95/npu0Xs8/Dg7hAHi4qoCubof6C/QnUe8WO2BBhPxgCJgWPdqUbt1LPdJ4sIPLtmq708R8dkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af127.dynamic.kabel-deutschland.de [95.90.241.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 893DB4C2C37D55;
	Tue, 17 Mar 2026 00:10:24 +0100 (CET)
Message-ID: <91b51019-b4b1-4e2e-8846-8e9686676812@molgen.mpg.de>
Date: Tue, 17 Mar 2026 00:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: MGMT: Fix dangling pointer on
 mgmt_add_adv_patterns_monitor_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260316190957.8433-1-luiz.dentz@gmail.com>
 <20260316190957.8433-2-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260316190957.8433-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 16.03.26 um 20:09 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the condition checking so mgmt_pending_valid is executed
> whenever status != -ECANCELED otherwise Calling mgmt_pending_free(cmd)

s/Calling/calling/

> would kfree(cmd) without unlinking it from the list first, leaving a
> dangling pointer. Any subsequent list traversal (e.g.,
> mgmt_pending_foreach during __mgmt_power_off, or another
> mgmt_pending_valid call) would dereference freed memory.
> 
> Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/mgmt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index d52238ce6a9a..e5f9287fb826 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5355,7 +5355,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
>   	 * hci_adv_monitors_clear is about to be called which will take care of
>   	 * freeing the adv_monitor instances.
>   	 */
> -	if (status == -ECANCELED && !mgmt_pending_valid(hdev, cmd))
> +	if (status == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>   		return;
>   
>   	monitor = cmd->user_data;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
