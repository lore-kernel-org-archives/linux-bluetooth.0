Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08C38F94C
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276309; cv=none; b=j0xYIU2ngPVZz7sTdWavVCsPdMjeDtMoqLvOGUYkbL4KtUTowFD3QAm+HNqJZ4Yc/+BvFj9gtmGYiYFCQHLArx9yIjSeu09TwImHO3MV81MwtUHoedlKecVawCQSwUziM7rgIqumQ2rafzCSIF8DF5Wp0yPLqdkniKi3lCLqYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276309; c=relaxed/simple;
	bh=bi5rkM/OeMtxJO7mF06HNTYmj4v+pcKsTmBmQA2d8EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBN2HcAiQNPZsa9Til5/eQouALEQyUze8jNbl/ox0z6rfoLyRqILO5D6GR+rnIXi7lwKVBie8SNpLRiYRlfJ99FHQbGgeJAyHuHcZCQEDtRocJ+ESCMmYYHpUNFXP7pKFVS99AX5Uqt7pFvpTeZIwSqqVUxanDXjAutZS96469A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hornang.me; spf=pass smtp.mailfrom=hornang.me; dkim=pass (2048-bit key) header.d=hornang.me header.i=@hornang.me header.b=AfOt/64W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZ+Jn28T; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hornang.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hornang.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hornang.me header.i=@hornang.me header.b="AfOt/64W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZ+Jn28T"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DEA81D0013F;
	Fri, 12 Jun 2026 10:58:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 10:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hornang.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781276306; x=
	1781362706; bh=bi5rkM/OeMtxJO7mF06HNTYmj4v+pcKsTmBmQA2d8EU=; b=A
	fOt/64WiHJRDISh42FbaBPMPmOnbFYaEJyroWRql5xyyFbEkISCUScWc6r8inVvb
	Dx2clFWDg/CqCCSUWkSnLRIqFd2qvc+xDqlM47v2Z25RFY8bBlPxG+QqdytDZ4IT
	miSZQbpRsPnDtc/mEc3El3ywvB7qlsVeee+S/+Gh7MkEtE9KgnRcEWLHvH6PGgzO
	w07qBBRF5xqbjiL+zzCANXfoIWKEabRCD59rwXcE7Pi5s39CqrBlLXSsWRsc0vma
	99qsxgkNg2tdo3BNyOGmr32mg8wasWMV25mGeOd2vxtuZii7tXqsLTA+MiIz7gzD
	Ha9IeE3WBpuyhF1yDy7Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781276306; x=1781362706; bh=b
	i5rkM/OeMtxJO7mF06HNTYmj4v+pcKsTmBmQA2d8EU=; b=VZ+Jn28T03FVcU6sm
	jFxRB8OLne66w6q6Q5QB/TltTDJ9G1MB1X6EsASshMbj5IpQBqYAO9OaFVqUiFL6
	6v7NJm3UF5h1qRNffIbuTVoBv1+DRfgmJJqtFYxCIvi6+yUno0wXvtlOHh847cQq
	7MsXPNo0/KJFpBpQkFpNovG2mbkHMltpV/c4PFtUxeqZ2iKx86xz0W3I5pWbcm3j
	t2ZIoWicJ1BQyJAOM7xKAA0fSrLmFnUAh2Szs/1HdjZnoWnWnAi5FYY0Lkjl+7s2
	9kxXmVi955UqqnKCIKs1KF7G+PUx7cfXTx83ad2hXfSsyucdL3Qdgnkq6mowWvSP
	LxJtQ==
X-ME-Sender: <xms:kh4sasd8hYFZIf6-qAkZqEF69bMekfE-hHMINMJmsC7o_vivfXCDzA>
    <xme:kh4salOrkxCqJaeL6Q7kN0gQcWhJkrVchepKchfNZzAhQk_9amOFZDM_RARw09qQZ
    IxU8PbmJo9oEJqdLOiS_b71ap3Cb6tgoz1BYHrIOY0qrgCBf9bOzn0>
X-ME-Received: <xmr:kh4saiiSOhP9u74QP3VsqoHK99rJHN1oNI54U4_Xvz8FcJ_x-_feC_inCg_FNkcJFii1lx47Xc_Qgs7No7dd05IC5otDatYWIp2bw1Y>
X-ME-Proxy-Cause: dmFkZTEL/EH6XGQNYT95nLnopZ09+4OIddvrSeevVEp75brA7p1LsrDvaAP1syWHa3+93c
    JGFUgQWTPEg19Vu5GZbnyW0GG09MzydSt8RLsOoeYY9j2TRq0/HrSNfGrW4pA6NRF6QVDU
    6sj2vMgnvEcpPWwOswPosRGtEbtPx4cfc/xoehJ6MhLFFIeP+7mb2XTzlVfngFdaNSFVe+
    X/74WHOpZR+0LWALvX0VyREwxt/822eHAPv2H75bUvwcgXqt8gLa04U4cLOgCGAkt3a3Lb
    0y3GbZET3we0QTYMGrhUhERWOuvAm5rkPcV3F5PbhOXYrvHUSEdesByrM0lWOuTGF8W4qn
    Ls3P8azGDW9j0UkxFS07A9TJcyWTSWYyIymJv6F/3r3g0xW0T2Jsn9tI1/u+wwoIAHVQXx
    UJ7q9cM+7Z2EZHE9576L8P42c6ZsL6exPsbeUeH9+ygzmRkGAIS6hRUa+RsBQqJ7KBGvbV
    kUVKvsVlgnnXywzICu/rUc+3nwWYdaFBbs+YJszbKyXbOn+tp/EesEUWAm39Gt37hu/7ct
    LnAs4TfZxN9+twH4NwVq2C8ztb4TqUj8zLguA2EZl2pqMdXtxpZttaTwdwieUlHTR7IS1b
    OnN8FgmDA3n+XmBSQB9kl5PPgEwYrWc3mWUoc8q+1TaIoKvUDpaLs7i/4x/g
X-ME-Proxy: <xmx:kh4sag05QBVvlPgx0Kb8kvyGtHS1OPo2zwI74REMgksYWF7e6ijTYg>
    <xmx:kh4sakgu10ozKP8AWPr9xAgi9sk3is_OP0BEZn0oqkh_33MtnG2C0g>
    <xmx:kh4saoeyKZotyocQaOW7dyqrAwyg8ppNfAdJIhjk2jf1Fq3fNChhew>
    <xmx:kh4savlghUgLNP7UL715ZB9B96cQJ6JeD10B22uxfZkBcWwkW50WhQ>
    <xmx:kh4saiSTiILkEEJyrG74VYRxdBQwtOqNXzHksw3li3PelRkO4zV3-vbK>
Feedback-ID: i9c9648fe:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:58:25 -0400 (EDT)
From: Stig Hornang <stig@hornang.me>
To: stig@hornang.me
Cc: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: L2CAP: fix tx ident leak for commands without a response
Date: Fri, 12 Jun 2026 16:58:10 +0200
Message-ID: <20260612145809.181685-2-stig@hornang.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612143818.167643-1-stig@hornang.me>
References: <20260612143818.167643-1-stig@hornang.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found out it was already reported and suggested fix here: https://bugzilla.kernel.org/show_bug.cgi?id=221629
