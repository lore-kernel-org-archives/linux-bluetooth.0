Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812F1A2630
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235375; cv=none; b=f4ox5KpwF7+KL1MA7G0+gu1IDEuiErSodz62/3fZcgkx+PcjcZzPNB3yxUeal8EXW+MDevxNbewwj20T+Xycf0OyY82DksKvM/IfYqFlFqnxWtd8VhdLx801FL7SnxU9cmE/HkI3462GuaEvl91cprMH45FhWb8//2e+7j03k78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235375; c=relaxed/simple;
	bh=P9nuSolWh/nEZvcOmxJ7qruiZITOZXk1CSUGMKBWr9I=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ntem1z5Gk76lRVZGePOJkb2+i0C9hu0bHE/0cgO/fhgNHgwNaODAwSR/VfsfsrL41OegXQAk3huPe+JtjEi22s2TKA2Pdqu2LM6m0eRZYjU+LDFPDID2XN+mQPCzjBnEHjb94SpoUX3MMp14GTCuZi+yRdDj9kBhHDXslV54FQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EmrQw9la; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EmrQw9la"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742235342;
	bh=P9nuSolWh/nEZvcOmxJ7qruiZITOZXk1CSUGMKBWr9I=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=EmrQw9laoZ0gZIbHHGoLop4G8+6ONky1rbwtsZXRgHX5WmabBGLltqs/LMiC0UeYU
	 kOBU8QaHkcmTz7wvFo9jUb+tgtTbIOXHPfGU93pGg/W062sXKBz/gDdVEhl8J8quxi
	 EpDHthTLYXW51urevaF31jRPKNaMXMmNKeH8ED1U=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 7s6yzF3zASig0FjzGfRNCaezCQkEO4+FLqH7YYvX33g=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1742235336t7602166
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?THVpeiBBdWd1c3RvIHZvbiBEZW50eg==?=" <luiz.dentz@gmail.com>
Cc: "=?utf-8?B?bHVpei52b24uZGVudHo=?=" <luiz.von.dentz@intel.com>, "=?utf-8?B?bGludXgtYmx1ZXRvb3Ro?=" <linux-bluetooth@vger.kernel.org>, "=?utf-8?B?bWFyY2Vs?=" <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 18 Mar 2025 02:15:36 +0800
X-Priority: 3
Message-ID: <tencent_27D3557D435FC05369A3ACCA@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250317154715.15023-1-guanwentao@uniontech.com>
	<CABBYNZ+MdXNdLrgNb0UOuh2aFnukcUTTAvGkD6M5js=pvQuQkw@mail.gmail.com>
In-Reply-To: <CABBYNZ+MdXNdLrgNb0UOuh2aFnukcUTTAvGkD6M5js=pvQuQkw@mail.gmail.com>
X-QQ-ReplyHash: 2399442445
X-BIZMAIL-ID: 3930025385411776433
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 18 Mar 2025 02:15:38 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NEaes6yu2o+mIs0PGN3Wk0b+mFNDIEzk7aYXBUl4ououcIYIXDJ99nrx
	nONvS1MCQsU8knGFqcWoEYt2rp1WL/j35RUHY+vUv3oUb1aMCS3thloEim6v7c9zv0bgf/g
	sshtWODQJxJ4K+EHy6s0Ptzs+sm+nVCHpGWNIIdTdsiKwwQbQdx1iKdtJywRH1n4Gs7mBG1
	3Wsk0aybaHOL0DRWjXSOODwRer4gurQZ6AAez0T/bTyM6fdcT7FMx6rMlhh/OPJL7b8hpgU
	8pjVtLRkbaK7V+M/KGlu6rBMC+zRXRDpqplNNPmOuhWh8sW11ds71DXHTsyrsTQbsgH/Z8m
	VZZwiyAsuN5cLaEai9T7GmNq90W5zSmUCVivNzaWPycDsFYzzQ2vGnCGCLynbpqPmnpWZeD
	H9jq/xVJ+zqSfK1u+KFiXZkUYx1Apo+fLZd5l9wAOO0QdkKljvgBadOasZFA6acYvco3Aje
	8/gg+4NHdIE8OG6QWwf5qSYKk3Sp9fliTrxlrJV5Z7plj5gcq1YRg+ip3utgBgqEvs632CR
	/QrM00gF9DtrWb/2Dv6Uht5yMgX3HjpIIbGYJx7mmETkM0wlBRnVHGzy6DYkq/xE825fGf8
	Z9aAY2E+MT7okWO2LkkFrmoBg1LfCWpxZjSvxVYCpOo+zHtq2WZVzX2b/6QcieAsjg1mYCW
	Rcj6ncX73jYnnURW1Bh8EVZhYG5Z0TgkcfvJ2vZuvXr7llzoCRK9DzHPObFt5hiWoH3QCRh
	iJg7p8VookJKRNF7ndRb9GkujWxqBbFOYTwr3qqh+1KQ1MaSXICWJ9bvCrETdkbqTUR+LF1
	USTjw8je6bS2cStJCStpJc4+ix9/TUJU+5BdW6Uv7R1vxGmgjMrFTi7pKXmzPd2SBwCMS+9
	v+Tto2beHHj0b+nOjbHjU/MZqSGkZKtn62gzezjr/bK3rQy8F2xa8TrxVloNJXorXHIt6xj
	aGAHONgVT6+Y2WFyZx9Z+CtBKDsAyC8/dnWmwT/TUysxwCQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

SGVsbG8sDQoNCmM4OTkyY2ZmYmU3NCBCbHVldG9vdGg6IGhjaV9ldmVudDogVXNlIG9mIGEg
ZnVuY3Rpb24gdGFibGUgdG8gaGFuZGxlIENvbW1hbmQgQ29tcGxldGUsIGlzIGl0IG9rPw0K
YTlkZTkyNDgwNjRiIFtCbHVldG9vdGhdIFN3aXRjaCBmcm9tIE9HRitPQ0YgdG8gdXNpbmcg
b25seSBvcGNvZGVzLGlzIG1hbnkgeWVhcnMgYWdvIGFuZCBpdCBzZWVtcyBub3Qgd3Jvbmcu
DQoNCkJScw0KV2VudGFvIEd1YW4=

