Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195208;
	b=VKBl1wR5Fo/ZPg2MUpYq5YyvHwp5s7xd/NhaT5YUAXGxUYXdaAkDXmBg08joN1NnnQca
	 N7mywAM7/Tc2et1GJ6kU2gAJUrsbSU9j6lYfWG4W9PkoncaVuDHut+J5tzGFbGiQonR+B
	 NMLzqnhUbFJnIvfwpk6/vJSzp7CYZ+N+ROja4UdXRW2xd1qrYWX36IGgnvsqR7MkCKrH5
	 LlLDbu84+C34fjf9RyG2QgIk95MJSIwCuRBMvDPtvGTnS3CW+UnOD2IcQ9r2Xlq5nqmxI
	 x1jS6CQFwYAc3XeWjEisuLawUyFuKCTdDWQwvzNQ4QebXx5JTsLerFyE23m23QpQObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YnD6ivR6v+smYNM+xYN2G91XYMaHiNSbWjEy6hii1CU=;
	b=Heb6YHYYr1hPWt0tjeC/CPXniGNfU74/+F5bZCv8M7cPO07+ps2EP8F/zPXWq+RnLZsS
	 V2MbKIXMKt7Id0th7x6+Ib5Fpd2jwMQ4AUcFiSrFOIEU3WF6HbXZePHIsS4vxTowccxtx
	 a0kLxLkkgKDEPkyTfUE/MzNcdWLUhzAvlW+bLH4q+mmOn0RFepC28kRoC+KCdcwJs9D0I
	 Cq3Zxwb3WabSETDJg4o5mE5CdXqcGs/rFADtf3R3AL18eXfEsfpmhnTkoqvVV6PvQWshO
	 8TrVXxp6wyzAomN8aso/SQms0l4LdVI2pOyMiy5RAG6fbcDH0P938y3RudUuyR51a7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozGcW1Z0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B860A2623
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozGcW1Z0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0969E1F000EB;
	Fri, 20 Nov 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195208;
	bh=YnD6ivR6v+smYNM+xYN2G91XYMaHiNSbWjEy6hii1CU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ozGcW1Z0CvPwHVxeT+vh2BaqaV0vT8vq54tqlDvO5VwQy6x1QTtTwFbdi2ZYxslhx
	 5eE7Ogki/gZEj3UidRpgjmdy9fyjtnSoyw+NfdP7fmWqS3I4iujH0Yl4+kYmwNV7mV
	 vd/7WYY/zIgX/drznlRgALUO492/eKdtUg9q01bI3YI4ABL7ecIn9mvduERJOdjCaB
	 NF1KPYJRRfjch+txJkjWYEmfqyBl+mWKDJXQ4H3YT5BKljjDQg19QZ1YF3VuNZXslf
	 VLCoM4NfsnY8lemHNznlBoO3T9ZCJ4VtZ/6ZRDFyLfohmyRS2sUe0X5Tw0I5bh6FZK
	 BMxiYFImAOv1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15FC3809A88;
	Fri, 20 Nov 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in
 btintel_pcie_mac_init()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179519520652.673037.13393312532564477069.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 17:20:06 +0000
References: <20261120094249.2419421-1-kiran.k@intel.com>
In-Reply-To: <20261120094249.2419421-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Nov 2026 15:12:48 +0530 you wrote:
> btintel_pcie_mac_init() is called prior to reading device memory via
> target access. To acquire MAC access, only the MAC_INIT and
> MAC_ACCESS_REQ bits in the function control register need to be
> programmed.
> 
> Currently, btintel_pcie_mac_init() also modifies FUNC_ENA, FUNC_INIT,
> BUS_MASTER_DISCON, and SW_RESET, which are not relevant to MAC access
> (though doing so had no observed side effects). Leave those bits
> untouched and only set MAC_INIT if it is not already set.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b535edbf5178
  - [v3,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4fe38719e673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


