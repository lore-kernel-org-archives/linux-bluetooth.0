Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6413A3F7
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740202012; cv=none; b=Z3AZ+yZ0Z1PNs+hBahQiLI3k+tLYMrW/gkc4mZKCulc96TkNdSl6aR01UmKjld0mlpJ0qcbIoiMM/oxH4p4HKVJR5/PIIX7uC4ekOwyMF/hXf63ll9FUD9bMnmxzOWmKAWGPLeFLKnUhCAJhxUxEynOa5yxayGX4/gh/AJqPeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740202012; c=relaxed/simple;
	bh=yTWv4s7a1MVSDdfwpiTnUZD4ZAcI9kO/9ENWd784UPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBBfqPnpRMqKQnoe6tKaTNzCygsbGvLO/9JqhkDWq187gfRTztSrL1v0Bz5L5hFc1w+3iwOGBQ0t0wJbHH74xP7nhkya17kBNMtvdJdqWQm2QYHF1MmH+K7vzbEsxTWn69dlSb6+j/GRWW4voR1HR1FrUKTgCAXjy7LbRWZwJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af50a.dynamic.kabel-deutschland.de [95.90.245.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C206D61E64783;
	Sat, 22 Feb 2025 06:26:43 +0100 (CET)
Message-ID: <1e49f9fa-fb5b-4ef6-9fe5-b6d9961fd241@molgen.mpg.de>
Date: Sat, 22 Feb 2025 06:26:43 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Bluetooth: Add new quirks for fake Bluetooth
 dongles
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Pedro,


Thank you for your patch.

Am 22.02.25 um 06:04 schrieb Pedro Nishiyama:
> This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.
> 
> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> ---
>   include/net/bluetooth/hci.h | 16 ++++++++++++++++
>   net/bluetooth/hci_sync.c    |  6 ++++++
>   2 files changed, 22 insertions(+)

[…]

I’d make one commit per quirk. The diff looks good.


Kind regards,

Paul
