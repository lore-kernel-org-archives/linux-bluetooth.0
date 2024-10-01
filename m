Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B219992D;
	Tue,  1 Oct 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769105; cv=none; b=UGtWdpaHyEs40ohUZu85bSF7GBu9YyX1m0ThWtlzNnsA5byT4R37u0l2sRCghd9YCOjPO3j/nwkWtY+2bD31xwPxuidrQv1N8e2mfH+cUceKn12tbIHbnnTp4lYaVDlKScvyL7Le4NTj9yDahtXm1exiyFMbst7nrwpzNiW9LWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769105; c=relaxed/simple;
	bh=AXlG2BBzfIg6kHEFKJj+boiEiSTUmsHsiChUAuOGl7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlZCot55TkLTLGNboIiaOzLe9Qn6TT8A9eLvEtRMKfRM7zrcrgFj8tg8vBL1xEcFfp+1dIhKfCMcLhpZvJe0WTFamDnLUm0XwHr/MSQf4Tg6tF6VycVZghnhdnnxP41HdqYW68becPbGnbAOUP2oVHE8hOyquyvkyxjPCJnmCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OW9Z+qKH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OW9Z+qKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727769102;
	bh=AXlG2BBzfIg6kHEFKJj+boiEiSTUmsHsiChUAuOGl7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OW9Z+qKH1khY5K7P3eSa7gsd8yqYjVokhYoG1eV9Gt80nASa8TAh7Epq7yqw1E7eu
	 0rLBtgh3zNoH7+SQ5feceU4Lflgi0BTE0MNECucNdCmiI2C/yzmSPvl35SJH2xqJBH
	 SQ/40bblj97Z0utK+Wor2vgMmo7tEzWzCqhhe3DRtZn8U4QicwVB0G7YAqaKCJ8WMl
	 Ta4bWaEWwp2cDvi+IWuA+EyQT2u+k1eUElfr3MmmZ77y1By3KmcXH4CN42mIUo8ohP
	 hiM2PNlk9bXHlT7+kQs1PKEvrYPm2Fg9Jpg3Tq3RX/jDAJpMnmwkdymRnJ9pnuT8H0
	 jBacA1ym3n9dQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2154817E0E39;
	Tue,  1 Oct 2024 09:51:42 +0200 (CEST)
Message-ID: <6356b43b-ab17-457c-9d3a-a64033777ecb@collabora.com>
Date: Tue, 1 Oct 2024 09:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] bluetooth: Fix typos in the comments
To: Yan Zhen <yanzhen@vivo.com>, marcel@holtmann.org, luiz.dentz@gmail.com,
 matthias.bgg@gmail.com, sean.wang@mediatek.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 opensource.kernel@vivo.com
References: <20240929085727.523732-1-yanzhen@vivo.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240929085727.523732-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/09/24 10:57, Yan Zhen ha scritto:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'fragement' ==> 'fragment',
> 'genration' ==> 'generation',
> 'funciton' ==> 'function',
> 'Explitly' ==> 'Explicitly',
> 'explaination' ==> 'explanation',
> 'Tranlate' ==> 'Translate',
> 'immediatelly' ==> 'immediately',
> 'isntance' ==> 'instance',
> 'transmittion' ==> 'transmission',
> 'recevie' ==> 'receive',
> 'outselves' ==> 'ourselves',
> 'conrol' ==> 'control'.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


