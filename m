Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B358145FE0;
	Thu,  6 Nov 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417258; cv=none; b=M2HmijW+fRDp8zYxn0hnt48tftZqe6mthajB0xvX9//m7VuTq+LuG18x8J539S7UVJxoBhUhDZXLsYHk4JiB+4D2fBkkidxK4lf0IZsy4RazYQbJr49g5maaRFXoG74j8WpePuxdwkjSrlUCcN5ZleQ2JncNs4HvECMT/benqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417258; c=relaxed/simple;
	bh=bzftEQMHIbrle4PpjKjVweYDTBuSFswg2bS1Elm1yNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADkNjasKUVdOFhQg2jgWv6ue2m7KLuvHupp5HXAran5KKW1hupHFkj3xGtRBY7oQevv9SZuZxiXx5PpJKtYCx5EI/YEPIzUkIYgcJCL3sGrHKWTqdlhzioWJmAsNjLBsX8UzUhPY2iHGrsRED7Zeusk1NztWl+YnhGE3V23kb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af781.dynamic.kabel-deutschland.de [95.90.247.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3978A61CC3FED;
	Thu, 06 Nov 2025 09:20:42 +0100 (CET)
Message-ID: <f756b92a-272e-4d33-9126-0ce891df6ac0@molgen.mpg.de>
Date: Thu, 6 Nov 2025 09:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: iso: Fix UAF on iso_sock_disconn
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106-kernel_panic-v2-1-f4ee57845eec@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251106-kernel_panic-v2-1-f4ee57845eec@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Yang,


Thank you for the patch.

Am 06.11.25 um 03:40 schrieb Yang Li via B4 Relay:
> From: Yang Li <yang.li@amlogic.com>
> 
> When the phone stops audio sharing, it terminates the BIG first
> and then sends BASS modify and remove operation codes to clear
> the shared BIG. If a BIG sync lost event occurs at the same time,
> the BIG connection may already be deleted. Releasing the socket
> in this case can lead to a NULL connection pointer.
> 
> kernel panic: Unable to handle kernel read from unreadable
> memory at virtual address 00000000000003d8
> Call trace:
>   iso_sock_disconn+0x110/0x1c8
>   __iso_sock_close+0x50/0x164
>   iso_sock_release+0x48/0xf0
>   __sock_release+0x40/0xb4
>   sock_close+0x18/0x28
>   __fput+0xd8/0x28c
>   __fput_sync+0x50/0x5c
>   __arm64_sys_close+0x38/0x7c
>   invoke_syscall+0x48/0x118
>   el0_svc_common.constprop.0+0x40/0xe0
>   do_el0_svc_compat+0x1c/0x34
>   el0_svc_compat+0x30/0x88
>   el0t_32_sync_handler+0x90/0x140
>   el0t_32_sync+0x198/0x19c
> 
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Add description about this problem
> - Link to v1: https://lore.kernel.org/r/20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com
> ---
>   net/bluetooth/iso.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 74ec7d125c88..89c7700ceb81 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -838,14 +838,14 @@ static void __iso_sock_close(struct sock *sk)
>   	case BT_CONNECT:
>   	case BT_CONNECTED:
>   	case BT_CONFIG:
> -		if (iso_pi(sk)->conn->hcon)
> +		if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon)
>   			iso_sock_disconn(sk);
>   		else
>   			iso_chan_del(sk, ECONNRESET);
>   		break;
>   
>   	case BT_CONNECT2:
> -		if (iso_pi(sk)->conn->hcon &&
> +		if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon &&
>   		    (test_bit(HCI_CONN_PA_SYNC, &iso_pi(sk)->conn->hcon->flags) ||
>   		    test_bit(HCI_CONN_PA_SYNC_FAILED, &iso_pi(sk)->conn->hcon->flags)))
>   			iso_sock_disconn(sk);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
