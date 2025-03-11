Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180691DE894
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680696; cv=none; b=QVCPMwsm4/kNDE2ei4vFDSk/HVT36h6makM9prs91eiLRZyG2iFmagLggmWLGjcShNgw0XXu2qHd9mVwBYaR8/HM94aLjw7ePz4jiCihGTL9vxM6OKTmO5efSFhqT4qIJQUln2LcHrnQH0UHeWj4ciwChIT7F6ZihWyCsgtIju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680696; c=relaxed/simple;
	bh=L2fyD7QgpRMqMZFLzn3aZUtSkFbaRQLA44wMQIHU7hA=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=Ek2Lxs1pjvWOwlKyBTk7ohjdNOokbSspIOqMHjM3w579G0aXqqP0ykxcXT3hpp189345k0cFNSOaX6aZwiH9t47hz8TSTBpU6Ov8OHNojwg3zX/dndWDc/XVBm6qO4XyGEAAAf4Byji3LZs3Dd9bIAtH7wkgxyxkDVl0Qgql3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Dnu78Jh9 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Dnu78Jh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=a/yF7/ayx7WN0PD5mKgJ91+kbPXSoYNamMSm9sotLqQ=; b=D
	nu78Jh90JWS8FYZGVbV+ssROF3urjf0YCmcH1w0kVMgNfgg4z+4eyi2j9dmUCZVs
	prxIrG617KYER8iF9k9m/bikWjiIWBbGOTYqBbFSzWkYS7/tPulMVAJbJc5pR5bH
	AbLYhuqZsZStBfu1tjlw/cJuZAUTNkK9wUr/ZMGGJU=
Received: from kx960506$163.com ( [121.227.245.102] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Tue, 11 Mar 2025 15:56:23 +0800
 (CST)
Date: Tue, 11 Mar 2025 15:56:23 +0800 (CST)
From: "Michael Kong" <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] share/hci: Fix data type in bt_hci_send_data
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2fA/qctk8j5SadZOkfmU4Vge85UMS3v/og3o5SOJ5+jArp/R4AZEJSBXnJ7OO0OiyImgmGcBZzz9l7RZlFYawxwydqRNwlDJeIU1hjys3XGg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <251a4eaf.77e9.19584346ee6.Coremail.kx960506@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eSgvCgDnjsWn7M9n+Zp7AA--.19689W
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/1tbiWwsNumfP2bv-kQADsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RnJvbSA0NDQxMjI4N2MyYTAwNzkyZDRjMGZjMmMzNmVlMjUxNGQ3YTNhNzFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBtaWNoYWVsX2tvbmcgPG1pY2hhZWxfa29uZ0ByZWFsc2lsLmNv
bS5jbj4KRGF0ZTogVHVlLCAxMSBNYXIgMjAyNSAxMTowNToxMyArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIHNoYXJlL2hjaTogRml4IGRhdGEgdHlwZSBpbiBidF9oY2lfc2VuZF9kYXRhCgpUaGUgZGF0
YSB0eXBlIGluIGJ0X2hjaV9zZW5kX2RhdGEgc2hhbGwgYmUgQUNMLCBTQ08gb3IgSVNPLgotLS0K
IHNyYy9zaGFyZWQvaGNpLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvc2hhcmVkL2hjaS5jIGIvc3JjL3NoYXJl
ZC9oY2kuYwppbmRleCAwN2ZkZmZjODIuLjU3NTI1NGMwOSAxMDA2NDQKLS0tIGEvc3JjL3NoYXJl
ZC9oY2kuYworKysgYi9zcmMvc2hhcmVkL2hjaS5jCkBAIC02MjAsNyArNjIwLDcgQEAgYm9vbCBi
dF9oY2lfc2VuZF9kYXRhKHN0cnVjdCBidF9oY2kgKmhjaSwgdWludDhfdCB0eXBlLCB1aW50MTZf
dCBoYW5kbGUsCiAJc3dpdGNoICh0eXBlKSB7CiAJY2FzZSBCVF9INF9BQ0xfUEtUOgogCWNhc2Ug
QlRfSDRfU0NPX1BLVDoKLQljYXNlIEJUX0g0X0VWVF9QS1Q6CisJY2FzZSBCVF9INF9JU09fUEtU
OgogCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXR1cm4gZmFsc2U7Ci0tIAoyLjI1LjE=
