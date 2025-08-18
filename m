Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9F31CA6E;
	Mon, 18 Aug 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522825; cv=none; b=YcxttFJjDdAhTP1JHhqmt/bBnr+qpwZthjUnRK/PYzEsk4OsN7SS27oSRrCqAT8BwTbAy3cAopl2E/wGwR+Psf/f3pRKe1SK7SCxlt2pgS6KzxhKKrJH9aeqA4gyZcYAdphTInMdAR6sPjGnez7JNyTF8OHKEAjZiSX0A2Zlr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522825; c=relaxed/simple;
	bh=bHXamoYbn4iRYbHyS4qmXEWpEMHvJ8sBxGn2lLdPu5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ejB/TUXiFsjzQHQZy9yU77UIBLDc6SRgVaIV/LBNIVryr7vA+TU6Sz0QJafFw5gt94v/FGoSfTjIersZrKvIsZ7xg4m/Z1upQfP+QlmLg4lDlQWq+RbLWDE3WXtyN0Z+5AP5dqORNEBNL5/ZQG9EyZ2j7n/2Yyuv9T8tut22eLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4A8BC60213AD0;
	Mon, 18 Aug 2025 15:13:36 +0200 (CEST)
Message-ID: <17f959be-7270-4cc1-85bf-ec2516b8e3d0@molgen.mpg.de>
Date: Mon, 18 Aug 2025 15:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Remove redundant 0 value
 initialization
To: Liao Yuanhong <liaoyuanhong@vivo.com>
References: <20250818123638.635566-1-liaoyuanhong@vivo.com>
Content-Language: en-US
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250818123638.635566-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Liao,


Thank you for the patch.

Am 18.08.25 um 14:36 schrieb Liao Yuanhong:
> The hci_uart struct is already zeroed by kzalloc(). It's redundant to
> initialize hu->padding to 0.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   drivers/bluetooth/hci_ldisc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index d0adae3267b4..e7a55c2e63f1 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -508,7 +508,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>   
>   	/* disable alignment support by default */
>   	hu->alignment = 1;
> -	hu->padding = 0;
>   
>   	/* Use serial port speed as oper_speed */
>   	hu->oper_speed = tty->termios.c_ospeed;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
