Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1337268D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010077; cv=none; b=OSm17z32nFCGwwqy4vX36Tqylc1+fZXf8dZBoKYHAAEYOcDtQJiqOoak6raMLjj6SSoMw9+GSBw/OOFl/Y4kvqsdFqk7aLZnMwWrT9ociodz4+YLJfdZ+wiTndpgvFv7GRK9f0cRZ6ia2+dd7bgts4rTREqRSM4cxUJuYuv3rH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010077; c=relaxed/simple;
	bh=Vh2RviUlxrG5LsT7shj8e//FgftR8XvHwcy22qa5ugM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axO4fu7jDX9x8dHA9H5R+HwmwabUHTZCmJgUbXVZNByD+6qi7bqAyw55lqOhGuN+AwXSonYOC0EPxZgwYxq+9jFPlAeAdEZ2aq1sMkF6aZ1TJuyZLHmuBjhjLA+gyPp7B/PSG8P7fCt1xndhgVl7xElnzGOkKTgF77b6xPkX1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.150] (ip5f5af120.dynamic.kabel-deutschland.de [95.90.241.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E3E14C2C37BB7;
	Tue, 14 Jul 2026 08:20:52 +0200 (CEST)
Message-ID: <b336f77f-0467-4b7f-8ecb-7a7435485e0f@molgen.mpg.de>
Date: Tue, 14 Jul 2026 08:20:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: MGMT: Add length check in confirm_name
To: caitao <294305068@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, caitao@kylinos.cn
References: <tencent_406D2B6F64B41152DB435F3A88E40205340A@qq.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <tencent_406D2B6F64B41152DB435F3A88E40205340A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear caitao,


Thank you for your patch.

Am 14.07.26 um 04:52 schrieb caitao:
> From: caitao <caitao@kylinos.cn>

Should this be spelled Cai Tao, or do you just have one name? It’d be 
great if you updated the spelling.

> The confirm_name function did not validate the length of the incoming
> data before accessing the mgmt_cp_confirm_name structure, which could
> lead to out-of-bounds reads if a short packet was sent.
> 
> Add a length check at the beginning of the function to ensure the data
> is at least sizeof(struct mgmt_cp_confirm_name). If the check fails,
> return MGMT_STATUS_INVALID_PARAMS without accessing the invalid data.

What will be logged in this case? Should an additional error be logged 
for a better user and developer experience?

> Signed-off-by: caitao <caitao@kylinos.cn>
> ---
>   net/bluetooth/mgmt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a0a491e5311e..aab8e64283aa 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6271,6 +6271,10 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
>   
>   	bt_dev_dbg(hdev, "sock %p", sk);
>   
> +	if (len < sizeof(*cp))
> +		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
> +					 MGMT_STATUS_INVALID_PARAMS, NULL, 0);
> +

gemini/gemini-3.1-pro-preview comments [1]:

> Is this length check actually reachable?
> 
> The framework dispatcher hci_mgmt_cmd() in net/bluetooth/hci_sock.c already
> enforces strict length validation before the handler is invoked. Since
> confirm_name() is registered with a fixed length and without the
> HCI_MGMT_VAR_LEN flag, the framework ensures len == sizeof(*cp) before
> confirm_name() is ever called.
> 
> Additionally, if this error path were somehow reachable, would returning a
> 0-byte payload for a Command Complete event violate the API? It looks like
> returning a NULL payload with a length of 0 instead of the expected
> struct mgmt_rp_confirm_name could cause userspace parsing errors. Should this
> instead use mgmt_cmd_status() for early parameter validation failures?


>   	hci_dev_lock(hdev);
>   
>   	if (!hci_discovery_active(hdev)) {


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/tencent_406D2B6F64B41152DB435F3A88E40205340A%40qq.com
