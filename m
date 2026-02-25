Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E9344DB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016225; cv=none; b=ba1QDLWjHqMGBrlaaA1bZy9+fTg5BTgIFqx94dz0UvPHUuOdvgK2IU8dCx8rUqiVcgMkmATL6j4bak6/iMvkRsIKyI7LGru8ZHNaE02Uz4+yz8SMUGldXlGoDuUl9+sTT63d+qlyfRTI7eZXtvXfa2kgyPTm89tbMh3n3jSp6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016225; c=relaxed/simple;
	bh=+eLYqVD9t2SH88Vw58ox6H9Dl1Ud8/+NKzepuwwwO+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=c0v0M17FJbuRjwXCDMY0mgx/TcSbbuLMhdcLAg/BZSPTWoaCYY7qewOhfHh7xAiOK2ccjshlwQ6lvoHrquRQbg4nWnR3gDtR5FFlBjCrXtSvz6Dd1dVVa+D0IPoLvo+RP9IwEOYgnUr/YdfgZlh2/vFBDIZjR0IHCwSGDAPy1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.249.96] (ip-185-104-138-144.ptr.icomera.net [185.104.138.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0A25A4C443009E;
	Wed, 25 Feb 2026 11:37:51 +0100 (CET)
Message-ID: <044a30df-8cfb-477c-ba81-d76a044d73ef@molgen.mpg.de>
Date: Wed, 25 Feb 2026 11:37:50 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Increase LE connection timeout for industrial
 sensors
To: Dajid Morel <dajid.morel@volvo.com>
References: <AM7PR05MB679030C679B87FCDEF903CAAEC75A@AM7PR05MB6790.eurprd05.prod.outlook.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <AM7PR05MB679030C679B87FCDEF903CAAEC75A@AM7PR05MB6790.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dajid,


Thank you for your patch.

Am 25.02.26 um 10:07 schrieb Dajid Morel:
>  From 7945e077525b9ddcbbfd2d4f7251c6f669f7cccb Mon Sep 17 00:00:00 2001
> 
> From: Dajid Morel <dajid.morel@volvo.com>
> 
> Date: Tue, 24 Feb 2026 22:10:35 +0100
> 
> Subject: [PATCH] Bluetooth: Increase LE connection timeout for industrial
> 
>   sensors

Note, that your patch was mangled. Please use `git send-email` or b4 to 
submit the patch.


Please add an elaborate commit message body (`git commit --amend`) 
giving the motivation/reasoning for the change, and ideally also a test 
case.

> Signed-off-by: Dajid Morel <dajid.morel@volvo.com>
> 
> ---
> 
>   net/bluetooth/hci_conn.c | 4 ++--
> 
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> 
> index d177b7f49..8aeed0962 100644
> 
> --- a/net/bluetooth/hci_conn.c
> 
> +++ b/net/bluetooth/hci_conn.c
> 
> @@ -1131,7 +1131,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 
> 
> 
>    conn->dst_type = dst_type;
> 
>    conn->sec_level = BT_SECURITY_LOW;
> 
> - conn->conn_timeout = conn_timeout;
> 
> + conn->conn_timeout = msecs_to_jiffies(20000);

Please mention in the commit message, why 20 s is the right value, and 
why not use less or mor.

[…]


Kind regards,

Paul
