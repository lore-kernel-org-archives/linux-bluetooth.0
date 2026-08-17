Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6263BFE4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955274; cv=none; b=LdSyxI5smzKgOPl3NynCaxSrCOgVmA0jdyTjF0DpDLO/Y4xaf0JrhKVKI+mapM9pPD6EBj/LI/iBTknJDStVNyqneCfvpBSPhaF+SmrbNcZfmgDNh4KU405pKhiKyGclBHAepocnrTe/3/pD02eL3aL4YLEDjRn8/Q2j1KZYDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955274; c=relaxed/simple;
	bh=LaXxUHdhdUiSjqCpXcR2LXMGWRCGLFEfzMxx+g6mqcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7O8y8aCev5fruk/27qpCN5ewdG2jcLl4LDRGdbaYG/9s6qWNSIC6iSIs1fbkmktDYcuq7gYShwolcyZHFm45FB46bJ4mI001L2lRuhjo13WBasGw3eJtY/ZmptdEgQ0KG3/pEtypCITFBAM5ks1f9xKeAsqSEAlOnvO6q/v0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0F9494C28871A6;
	Mon, 17 Aug 2026 10:27:35 +0200 (CEST)
Message-ID: <520e859a-57c6-4ae1-b1d8-a9f6eaf51c36@molgen.mpg.de>
Date: Mon, 17 Aug 2026 10:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MT7902 Bluetooth (0489:e156) not supported - btusb/btmtk
To: Kaiser Bh <kernel@kaiser.moe>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <178695324809.6.15793290053564777912.1554499092@kaiser.moe>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <178695324809.6.15793290053564777912.1554499092@kaiser.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kaiser,


Am 17.08.26 um 09:54 schrieb Kaiser Bh:
> Reporting this rather than submitting a patch. Happy for a maintainer to
> pick these up.

[…]

Thank you for the report. It would be great if you could submit two 
patches for these.


Kind regards,

Paul
