Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36E35BDA5;
	Thu, 13 Nov 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053639; cv=none; b=jg3t+peV7dQBNwJuWq/DnJzjpbn0Dg87mw7F/QJv7S6cY8L7o4ZAlfrwpFSImWNv/N5QYJ7iXPJvoQKHDPP8XiqoQmOFQCG363URtxO5oZmDRuMrWV0S+Ld/y2BQ4Wgv/cBr3Qdm+rEal1LpfxsAnimE5IdcUOuinzwQ4ekx8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053639; c=relaxed/simple;
	bh=XWvYhFRERHcm2fhhF48O3hnwjVvsWp3+VDtb6+aCLwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RXPazk80BQizs4a2GXApBAE6aoxnLddX5OSuV41lh72/r/PKUEKVt+dAfG8d7AkaSg/eBrkNajIJVzt5RRJMbXQbbi0EsAQjKpd+laqTnAJLfQKC3s6plvXYOCZmlKX47k2bXpB1ojnVE5Aza+uv0/iuW3vLn7lzjYH5OGni1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=bbQdp3hI reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="bbQdp3hI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=DTwTzXmzIAadLC6qc7pVgAGrFJF8mrA3I9cZaVBQ+BY=; b=b
	bQdp3hIPb/FlnXBMPEFnnvXHL0OasdUeKkC7MtrbfwtCYqcdjm7bv/eGg4FgNWcP
	lQs/196uusFzn1l42V7p3V47u2arYH5XxD5j/b91GH8YoItNJTYbIeA3ToAdBD07
	M4s53i4A0AKzDT5NPtWoz/1phRqZX1svwno+nYniTQ=
Received: from zzzccc427$163.com ( [1.203.169.43] ) by
 ajax-webmail-wmsvr-40-146 (Coremail) ; Fri, 14 Nov 2025 01:06:50 +0800
 (CST)
Date: Fri, 14 Nov 2025 01:06:50 +0800 (CST)
From: zzzccc427  <zzzccc427@163.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com,
	zhenghaoran154@gmail.com
Subject: Re:[PATCH v4] Bluetooth: sco: Serialize state check in
 sco_sock_connect to fix UAF
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251101170110.179111-1-zzzccc427@163.com>
References: <20251101170110.179111-1-zzzccc427@163.com>
X-NTES-SC: AL_Qu2dAfyevE4q5iGZZulS7zFN8KZpBJ/L3opdqvogTt4LtgTCwxIZRnp+L37OwOyMWniPdgueNTqFGECxeLQY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <103a4b9f.a79e.19a7e2f248f.Coremail.zzzccc427@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kigvCgD3N1QrEBZprggiAA--.6207W
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/xtbBYx4FhGkWCMi7tQAAsN
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSwKCkp1c3QgYSBnZW50bGUgcGluZyBvbiB0aGlzIHBhdGNoLgoKSXQgZml4ZXMgYSByZXBy
b2R1Y2libGUgU0NPIHNvY2tldCByYWNlIGxlYWRpbmcgdG8gYSB1c2UtYWZ0ZXItZnJlZSBhbmQK
aGFzIGdvbmUgdGhyb3VnaCBzZXZlcmFsIGl0ZXJhdGlvbnMgKHY0KS4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIGFueQpmdXJ0aGVyIGNoYW5nZXMgb3IgaW1wcm92ZW1lbnRzIGFyZSBuZWVkZWQuCgpU
aGFua3MsCkNlbgoKCgo=
