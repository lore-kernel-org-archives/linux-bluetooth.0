Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF85360
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351575; cv=none; b=Luc675UTZY+hkgC5HEfaN8sdGzc7bO3qK4jidMEwxnTB695JUD0t0XFPNvs7Di83EHTAA4OmSvWeL8+j8oYNr0iTroYD2OkiAkML1568ip1O4iKrGX7G8H6+rwKpmWPnBIpK6WVACF4ECd30DJeINfnMqbLy1LR2fdewADyXGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351575; c=relaxed/simple;
	bh=+Iz7ohCIiVLVvbLglRbfWG2WcKAzXy4uMq8DXHU1P3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXB9IojgbypVSoWfGsROUOeVeNhTV7oZKG6eUXT/DIy/gTrk1hsJWKUFE6DgIBLnZbEPC+wq9jjE5aqE+GXSPdrkxS5qu0DsKaUE3x+R8U05/mt7FjBPd+MZst87iJr5dUEWdfkkaEa04Z+uPRt/f8BFJRRJBmBraegXQW49RNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (unknown [95.90.241.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 62F7661E5FE05;
	Wed, 22 May 2024 06:19:20 +0200 (CEST)
Message-ID: <2e2d43d5-8447-4e67-8fe6-c7e7f48e7997@molgen.mpg.de>
Date: Wed, 22 May 2024 06:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Patch for CYW4373 hci up fail issue
To: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
References: <016dd2b28cd5435ba6f13b01d4da0d44@infineon.com>
 <48e9ba9c-1bc8-4086-b7da-31a7d78b2a16@molgen.mpg.de>
 <baa852ee646a40f9ae70c6793b838ea7@infineon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <baa852ee646a40f9ae70c6793b838ea7@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Nobuaki,


Thank you for your reply.

Am 21.05.24 um 03:43 schrieb Nobuaki.Tsunashima@infineon.com:

>>> CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power
>>> command as supported in a response of Read_Local_Supported_Command
>>> command but rejects the LE_Read_Transmit_Power command with "Unknown HCI Command" status.
>>> Due to the issue, Bluetooth driver of 5.15 and later kernel fails to hci up.
>>
>> Why not 5.14?
> 
> More precisely, there was no problem with 5.10 and the issue was firstly
> reported with 5.15. So, not sure for the interim versions. If the exact version
> the issue was firstly introduced is needed, I will take some effort for it.

As you have the test setup, and bisecting is normally very quick, it’d 
be great if you could pinpoint the commit causing the regression.

[…]


Kind regards,

Paul
