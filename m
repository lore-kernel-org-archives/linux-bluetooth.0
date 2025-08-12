Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8B2EE607;
	Tue, 12 Aug 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012427; cv=none; b=muaIHXnSUq0jcbZ27JVe36BKXIu3oFYvBmAuZI0aE7AC/5Q4hqo/OplLc1le/hRcwxaLs+dvUHPf+MjyRyXQnuJ0Yu1cJamYl9BJp/1hA6rZA1jNElWvRUXRmJXHSNRhwJCDcR9AAITonImhHtBhIbo8+ubX5tcfKbhS7ssagbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012427; c=relaxed/simple;
	bh=Ex6W/KSOYhCD/6skWyz7Ougdqe1uwHhxO1wzKmo2tH0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=GjeHLA+FhfkdcVBRGprFtmaorhRf9QIoZjrIdNYA73sT0tSHAdaq8aml7nF4ditdA7ybUzo6NAXnVNxY2E7Ufbxi6dC2cs1uE+nngQYd8glfnuz5NYAAQqLyYE91MzDXK/o1V7vMvygo/B/QoxBwjiAkJSB881WQ/LbSi5yRxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HniZpvhe; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HniZpvhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755012376;
	bh=Ex6W/KSOYhCD/6skWyz7Ougdqe1uwHhxO1wzKmo2tH0=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=HniZpvheag81hHDRsiUh3yrIR0e8KYxrPGfBGg6hbyXKA2W0UTiQd+oM9S9Yge6jA
	 jbTt/UjqSCBTRq2ByXN1N7HYELlrnF5YZ6/3B6yM28GjWntZWiPtoOiyH2YS2ZsVSS
	 vffrdx7Ju8j5vF7zAgFQGx59jUOSmFdA1WItK+1Q=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqST8P4pfj07qGG6ZowgZlQrBrKFg+dHp6U=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: WgrX86/THEBM5K/93NY0LvhAPNGXNXJSTHcJJOZPQHk=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1755012371ta29fe660
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?UGF1bCBNZW56ZWw=?=" <pmenzel@molgen.mpg.de>
Cc: "=?utf-8?B?bHVpei5kZW50eg==?=" <luiz.dentz@gmail.com>, "=?utf-8?B?a2lyYW4uaw==?=" <kiran.k@intel.com>, "=?utf-8?B?dmlqYXkuc2F0aWph?=" <vijay.satija@intel.com>, "=?utf-8?B?bGludXgtYmx1ZXRvb3Ro?=" <linux-bluetooth@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 12 Aug 2025 15:26:11 +0000
X-Priority: 3
Message-ID: <tencent_0665526729786E503E775272@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250812124308.2504833-1-guanwentao@uniontech.com>
	<d002d395-6196-4879-905b-24168c691786@molgen.mpg.de>
In-Reply-To: <d002d395-6196-4879-905b-24168c691786@molgen.mpg.de>
X-QQ-ReplyHash: 3539178494
X-BIZMAIL-ID: 10459941266219184821
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 12 Aug 2025 23:26:12 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N+n6UtIkOPCaoPZd7fwpuyZoqBZF19Pt4PPbgR7T1cXkL1XmoxAWnZ3f
	NOBcd9lpc8cZEcqNBpi/adFqyIXDVMA119FrTLQsSo5brppSq+9KZCtLcRwRD/BPYkBeOOX
	OmGjiTMWKdnYTxnlScvFDSvh8fAksTuOUpDyNECVRTkC++SbhJUwVogwtQfhnKlo76y0gdb
	ge4PA7b+udwWDe10KqoM/datLevLGViaOpURtfejYRTi43EMi+1alcP8C2S2RoexZ9vs+hf
	3Fnnnk+gPJ8gTNTV/awXOlUqz1n0sVOP1Gzn5FY9TFsqniyhUYarcKbgVveKZBLek/R2Ezg
	ruTpOgOhCwg0C8WXsOHRDICz1arib2Z2/HUC0TkEhvKQClpQiPb4TwZ2QBtIDZj1xhuwl34
	GP6SWe9nWPRem3nW20z/JBxH+p71GDRKykqUw92V5SdM1hQRHMCjdpiEqTXGetSu8hQnaMB
	GEW1tbXhwYl/Fe+paNR6xKGc8LPB+i1Qx4QcjLbDVbA6IU50baGKmqH/Edjd6yUI/zbp3oW
	oRpRZMtvUboHJPqDTzlzxCtWj9b/yP2tBW4pINIBHzhU78m39OE1O6e5ckKLbXfhm+gyKBK
	Bjce6Jg+edezXwAO05fV57U8+sOKhbgYlXKTgvM7UEOojDrxGe6WoQWlIZWoWRsXab5JL0r
	Q2Xh0cd/bUq2+PrnOeSZVExQU+ksgIvg9Yu/wIHCjcNQ3CD11j5ny6LmbrZ4Y3SXklnYYRa
	yiv/KxqevAUCM6YX2qRPjYxszO4K75rRzxS4xxOekUhKaJdSfeEm4Go+pq/BdbBnoTe50c6
	l7KYa4yTcJZmuLmflhZ6Y9098v3HNGNoH4NHGkAAiwVL0W5Ked/gjE99o8up5EVqZC66lgX
	WJCHQbl7jC4REdhdSuMKLGE3ZH33LQEgvx6PjPt3h/ZG076BPfWgdXYn+bMn6s2koL5toii
	LLlwA/5t+6iD9VJ8N8Vh/QoG9ZtCEZ6PQaBA3PAEyYJ3+tvzTSEbr1oR5S98D/dqiEVCO/J
	kCjCKYID4Ijvl+MCRLKc3brxguHoQNbiUfmJv78SGfAW/VILpNSfWuPNNYVNLjFwEQtwjWM
	A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

RGVhciBQYXVsLA0KDQpUaGFua3MgZm9yIHlvdSByZXZpZXcsDQoNCj4gPiBQUzogSSBkb25g
dCBrbm93IHdoeSBub3Qgc2hvdyBhIGdjYyByZWRlZmluZWQgd2FybmluZyBvciBlcnJvcj8N
Cj4gDQo+IE1hY3JvcyBhcmUgcHJvY2Vzc2VkIGJ5IHRoZSBwcmVwcm9jZXNzb3IsIGFuZCBh
cmUgbm8gdmFyaWFibGVzLiBCdXQgDQo+IG1heWJlIEkgYW0gd3JvbmcuDQpSaWdodCwgIklm
IGEgbWFjcm8gaXMgcmVkZWZpbmVkIHdpdGggYSBkZWZpbml0aW9uIHRoYXQgaXMgbm90IGVm
ZmVjdGl2ZWx5IA0KdGhlIHNhbWUgYXMgdGhlIG9sZCBvbmUsIHRoZSBwcmVwcm9jZXNzb3Ig
aXNzdWVzIGEgd2FybmluZyBhbmQgDQpjaGFuZ2VzIHRoZSBtYWNybyB0byB1c2UgdGhlIG5l
dyBkZWZpbml0aW9uLiAiDQpGcm9tIEdDQyBkb2NzOg0KaHR0cHM6Ly9nY2MuZ251Lm9yZy9v
bmxpbmVkb2NzL2NwcC9VbmRlZmluaW5nLWFuZC1SZWRlZmluaW5nLU1hY3Jvcy5odG1sDQoN
CkJlc3QgUmVnYXJkcw0KV2VudGFvIEd1YW4=

