Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22201EEA56
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677326; cv=none; b=jSLisZrEKcc7Gr2wXCkVS604FgHGk6+mGu9SFGD77L+AbeBSWgwajJXFsKE2fjyuZwtYcYzl26chstFV8SaRHVKoqbl0AcDKAuAzWWVC1UPZpjkz1iL5iMmDoYtXl+NDvmQt86I3OHe4nNVd5oTtaZbej/Uv/R4zEOdaM/rdI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677326; c=relaxed/simple;
	bh=6jbdUQSOptl4gF7SsBT4FkUFfM4gFD43rEW774W9KzM=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gwYLtBmj07JgV9PEC5b4qFg1umfbPXGHKwtIOKPpnxkaB7Q6lspXZKmzOmU+Odvvy372pVk2rjp5KgkQiCj9Q9iCeJnyEG89UIhM+jDvNPcFswyCdC4k/LuqpnJFyMfYgUxQwjmbCCJbY1VjpeacjZvRP2lCSwnI1zFUabJYj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=VNsSeVXa reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="VNsSeVXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=GsFF2qCqkqTCqHwC98O7loMrR4yfth95XxCa40VsfUo=; b=V
	NsSeVXasOh4CwCl2OIaJCB0RqkCu96BbfK+xWRzqwfKVF2egIHqqWkJodF01f0Qq
	VrxdZBboB5C43i/2eOl44vQYHsgiBGK9+qCOdpTX3yJKWJnDPUI5PQOZN36cMsWD
	RWgXrA5N3OUSMVOkHEv8yQ5XNi0JKszCKBypHUIx4A=
Received: from kx960506$163.com ( [121.227.245.102] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Tue, 11 Mar 2025 15:15:21 +0800
 (CST)
Date: Tue, 11 Mar 2025 15:15:21 +0800 (CST)
From: "Michael Kong" <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re:RE: [BlueZ] Fix data type in bt_hci_send_data
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <67cfd6e2.050a0220.2ab63e.c64e@mx.google.com>
References: <72fe471.4f65.19583bc77c9.Coremail.kx960506@163.com>
 <67cfd6e2.050a0220.2ab63e.c64e@mx.google.com>
X-NTES-SC: AL_Qu2fA/qcuEsp5yiZbOkfmU4Vge85UMS3v/og3o5SOJ5+jArp/R4AZEJSBXnJ7OO0OiyImgmGcBZzz9l7RZlFYawx9r8gIE3b+OXXSZVQtmIx5w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23b1e024.6922.195840ede5e.Coremail.kx960506@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eSgvCgBXHcgJ489n7IR7AA--.17458W
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/1tbiWwsNumfP2bv-kQABsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkZyb20gNDQ0MTIyODdjMmEwMDc5MmQ0YzBmYzJjMzZlZTI1MTRkN2EzYTcxZiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogbWljaGFlbF9rb25nIDxtaWNoYWVsX2tvbmdAcmVhbHNpbC5j
b20uY24+CkRhdGU6IFR1ZSwgMTEgTWFyIDIwMjUgMTE6MDU6MTMgKzA4MDAKU3ViamVjdDogW1BB
VENIXSBzaGFyZS9oY2k6IEZpeCBkYXRhIHR5cGUgaW4gYnRfaGNpX3NlbmRfZGF0YQoKClRoZSBk
YXRhIHR5cGUgaW4gYnRfaGNpX3NlbmRfZGF0YSBzaGFsbCBiZSBBQ0wsIFNDTyBvciBJU08uCi0t
LQrCoHNyYy9zaGFyZWQvaGNpLmMgfCAyICstCsKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgoKZGlmZiAtLWdpdCBhL3NyYy9zaGFyZWQvaGNpLmMgYi9zcmMv
c2hhcmVkL2hjaS5jCmluZGV4IDA3ZmRmZmM4Mi4uNTc1MjU0YzA5IDEwMDY0NAotLS0gYS9zcmMv
c2hhcmVkL2hjaS5jCisrKyBiL3NyYy9zaGFyZWQvaGNpLmMKQEAgLTYyMCw3ICs2MjAsNyBAQCBi
b29sIGJ0X2hjaV9zZW5kX2RhdGEoc3RydWN0IGJ0X2hjaSAqaGNpLCB1aW50OF90IHR5cGUsIHVp
bnQxNl90IGhhbmRsZSwKwqAJc3dpdGNoICh0eXBlKSB7CsKgCWNhc2UgQlRfSDRfQUNMX1BLVDoK
wqAJY2FzZSBCVF9INF9TQ09fUEtUOgotCWNhc2UgQlRfSDRfRVZUX1BLVDoKKwljYXNlIEJUX0g0
X0lTT19QS1Q6CsKgCQlicmVhazsKwqAJZGVmYXVsdDoKwqAJCXJldHVybiBmYWxzZTsKLS3CoAoy
LjI1LjEKCg==
