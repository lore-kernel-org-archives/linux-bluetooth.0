Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C626F2A1;
	Tue,  4 Nov 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253118; cv=none; b=pmHvyMNn2eQEOthLfLjDUkgMUwCEDeCSCtRrlfJCSALmcBmiX0Ch8lH8FgPQfwbG4bkoMa4TzNy3D7nCiysSOmmaRH6HdDd8o/WlOBWwQk6V6L/5Z1OAiWmzYboXa91mlvaKZQE1WpqRnSO0M58i3MTCjpv694HFJkFEWtHlOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253118; c=relaxed/simple;
	bh=ndlnVsf4G9g0Lc90KWRgZFsU/v3CqR2+36Qec3NScsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zzbr871x4M4SIXpsoJ16iN0oNWOs/unBHRFIbtJoRcSU+RjbneB7Ikea+6hi7ea08HImqur3/WeSxVyt5R46YLvGzSsnRuz9nTK5a2dl8tgux5qUcH/h3emnD4gc/rqHoqBYIphBxwEc/HKwgezpSK7FeCrd9v3t/ywBPpGAKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 01C6961E647AB;
	Tue, 04 Nov 2025 11:44:49 +0100 (CET)
Message-ID: <faa2eeba-4af4-4ba0-845e-e2d440231614@molgen.mpg.de>
Date: Tue, 4 Nov 2025 11:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] Bluetooth: L2CAP: export l2cap_chan_hold for
 modules
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
References: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
 <79a6190fd55c2ac425450e1dac0fc7d8cd20b6c5.1762194056.git.pav@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <79a6190fd55c2ac425450e1dac0fc7d8cd20b6c5.1762194056.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for the patch.

Am 03.11.25 um 19:29 schrieb Pauli Virtanen:
> l2cap_chan_put() is exported, so export also l2cap_chan_hold() for
> modules.
> 
> l2cap_chan_hold() has use case in net/bluetooth/6lowpan.c
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>      v2:
>      - New patch for v2
>      - Used for build fix with CONFIG_BT_6LOWPAN=m
> 
>   net/bluetooth/l2cap_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d08320380ad6..35c57657bcf4 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -497,6 +497,7 @@ void l2cap_chan_hold(struct l2cap_chan *c)
>   
>   	kref_get(&c->kref);
>   }
> +EXPORT_SYMBOL_GPL(l2cap_chan_hold);
>   
>   struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c)
>   {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
