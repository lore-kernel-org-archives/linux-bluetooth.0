Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1B307AF5;
	Wed, 19 Nov 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551240; cv=none; b=tED4vzvRbdgVqB6uGVUwOjxiNbbwW5cj/6JRk1HgeEUp+62AKfuKHSySlL1t5E1cKDiqJurQ0sxrtgP2rHmOYV7XTuX+XW6rvJv4JMCFJIyTlJrLJ74jioIl370ZwIaI4jPg96kmAVpxQQnTLYiMIbbqnjU6NFvgBRLKREEitS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551240; c=relaxed/simple;
	bh=tIHk7zRMpPPshPSUz9wOaTq/kDNYgwcz2JlQ/AU7qjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDCIFSRlYKPD2TG8QMNlOhAnoNBFJ8PR5VeGeb7nIDzpzpSNTHt7rEWFnupL8BAR7VU+tgid+g3APKP3sss3iyKiCYVEMX7x0lLg8oCA+xtVB3m9+YB6/BvBvq7xGTucfjz7ZPtyXZVypI3MY6wdzZ1l7NArrfc2WV1eqDFbWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.216] (p5b13a022.dip0.t-ipconnect.de [91.19.160.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1777C61B48461;
	Wed, 19 Nov 2025 12:18:50 +0100 (CET)
Message-ID: <161ebb37-b4a7-459a-b639-d1d544f378e2@molgen.mpg.de>
Date: Wed, 19 Nov 2025 12:18:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mediatek MT7922: update bluetooth firmware to
 20251118163447
To: Chris Lu <chris.lu@mediatek.com>
Cc: Josh Boyer <jwboyer@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Ben Hutchings <ben@decadent.org.uk>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Hao Qin <hao.qin@mediatek.com>,
 Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-firmware@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20251119104907.4057459-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251119104907.4057459-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for your patch.

Am 19.11.25 um 11:49 schrieb Chris Lu:
> Update binary firmware for MT7922 BT devices.
> 
> File: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
> Version: 20251118163447

Could you please document, what changes were made in the firmware?

[…]


Kind regards,

Paul
