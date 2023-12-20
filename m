Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF920DE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="HdTFRaHB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1703069698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Laj8y3iGa1nNa0MObsZbMxFu0s7RXAGHUjE0l0PMik0=;
	b=HdTFRaHB26DYEAKcrGcmv9tnl8n7jpkj4+qlkCq7OfT/sZN54FJQPLiePuMC5zLrNID+Rw
	0woNOSPvxatkaoRPTu41WOXtCG12R4nnfTmUF8Nsc8IKCrCOC+UNw84c0iZ1Br3ldD+hZ6
	V62T2FlbRzWsgREQGngkbOMIUi9pbgE=
From: Ronan Pigott <ronan@rjp.ie>
To: vlad.pruteanu@nxp.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH 1/1] transport: Check if transport is bcast before it's cast to bap_transport
Date: Wed, 20 Dec 2023 03:49:49 -0700
Message-ID: <20231220104955.541287-5-ronan@rjp.ie>
In-Reply-To: <20231219124916.44173-2-vlad.pruteanu@nxp.com>
References: <20231219124916.44173-2-vlad.pruteanu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Vlad,

This appears to fix the use-after-free in bluez 5.71. Thanks.

Tested-by: Ronan Pigott <ronan@rjp.ie>

Cheers,

Ronan
