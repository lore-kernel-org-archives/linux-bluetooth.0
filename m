Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA1198842;
	Fri,  9 Aug 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218708; cv=none; b=tB2EWK6WRLxbCDgWLNiQFtbuK9xpEcJTH6njj6NP3EvjUO9O02H31K/ydqLlftYhRB7C2xXKbc5Forv5eVpQUr7ebtGfYTr1JeCAGAwXkQ8jxauEkms3qAo1SipVWqUP8ZtXYrO/q95HkaDw7FzSM3Pa8fXQSHsjM4WJFNJe58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218708; c=relaxed/simple;
	bh=zmFzz0vXp+1KptTGdIHs4Fxvy4Bj0+KfLt2z7ujuPpg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C7PXqRFzhdjXo8aIcO/2iKat7rUVo9LDqGPw1ta7tBBVviZGqHsowk8THSfdBp2VHfw2sU/uUEd4SYXSJ9lawzrkTD+xV+9XUVvZOwbF0f6JEYkIX1inc9ChzmjsWCLq52ll5W9xrX69bfM+h18JZwvk9LbNiKOsUCEGSjXvw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=X9ooF5In; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="X9ooF5In"
Received: from [192.168.42.20] (p5de45112.dip0.t-ipconnect.de [93.228.81.18])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id ADFA52FC0055;
	Fri,  9 Aug 2024 17:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1723218701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCzsHdgi+apuiAwqBnVvU09Ka+YjHBCYovbNNuVML94=;
	b=X9ooF5In9NOdgLS3vuOlpUELyxCyqdYN1ql7Pk8zu3ckGMLJ9AM2mx/yChProwd82SL5c6
	6/AqlUANzqif7cumGVYej/pM/OlexDXRYE+30Orkf4Z01BSoPcL+rbwf/2a15JFeljpSZs
	9vuHzjpiiWbP/xEGXQ515VupP6Fd/Uc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <a19ee9c8-c53e-4986-a05a-9517fde744de@tuxedocomputers.com>
Date: Fri, 9 Aug 2024 17:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
To: luiz.dentz@gmail.com
Cc: cs@tuxedo.de, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcel@holtmann.org, wse@tuxedocomputers.com
References: <CABBYNZ+DNkb4bC8eSQaxcDFEuA4hWJMgk00r6+YKc+BH953x+w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+DNkb4bC8eSQaxcDFEuA4hWJMgk00r6+YKc+BH953x+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Hi Werner,
>
> On Mon, Apr 8, 2024 at 8:35=E2=80=AFAM Werner Sembach <wse@tuxedocomputers.com>  wrote:
>
> > From: Christoffer Sandberg <cs@tuxedo.de>
> >
> > For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
> > connection issues when enabled. This patch disables it through
> > the existing quirk.
>
> Perhaps the following could be a proper fix for that:
>
> https://patchwork.kernel.org/project/bluetooth/patch/20240405204037.3451091-1-luiz.dentz@gmail.com/
> 
> If you manage to test it please reply and add Tested-by to its thread.

Sorry I never answered, but the problem seems to be gone with the current kernel version, don't know which patch fixed it exactly though.

