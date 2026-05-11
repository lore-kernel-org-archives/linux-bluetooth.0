Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777643A1C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479508; cv=none; b=qOdmwt81+1502zNYU6M/uEmqPgNMl1MmsWaNm2DPGVH60yLm7w2lvd0P1sYBYoOYrrfjM0hPMg+smjCxkki+TD9fifDx58LFFl5X7o21MjXv37MKGSmeaO3+o2UIxqsfToeV7wS31r/Sc1/hGL/kKBkn6gpW3T6ED1RPmSpgqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479508; c=relaxed/simple;
	bh=FMsv25TAfJw13OWlNCA6AhD6fpn4zQZMhpjWXQirL0g=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=uMxK2yAwBzBzTMnFHe0xvWmGBF/sAVJ7qKjBO4YdlPEbLb+U90Ud7fNuL5+96PJ6DRl45Ua+PoCjj8Z5XmRrJPbLJeI4cXZcTM84FCJgnclGhvGaKKIGAQwfkeOUoJXP3KwcXoT+879SLJpt9UYsiBrfgMut2WMSDdRRz7MeV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AX3zwjNi; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AX3zwjNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hIRh6a1e2bVj2R4hijkFlyI0FxWntlTzgKCM//E18MM=; b=A
	X3zwjNiu3UUCEaJUECYLi+FpdeOzA35nDalKipPDdIbmblz3YVOHVGCrHCn+w0W3
	R8vFLfELHI22uFPYbWF4hAWoF3JMxgdcPtIJW+kWTtym6ihbU6uHpvcYFqXipx5m
	875CagimVpc2wb8El4JqAhmcM3neGjrQvqSBl8WHpA=
Received: from fundawang$yeah.net ( [123.124.145.206] ) by
 ajax-webmail-wmsvr-207-62 (Coremail) ; Mon, 11 May 2026 13:58:38 +0800
 (CST)
Date: Mon, 11 May 2026 13:58:38 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From: "Funda Wang" <fundawang@yeah.net>
To: linux-bluetooth@vger.kernel.org
Subject: [Patch] support libical 4.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn yeah
X-NTES-SC: AL_Qu2cCvictkkq7iKfbOkfm04Xg+02WsC5u/Qk3IdUNpp+jCvn1AwDX01nO1DU9cuCOwCQgR2mdTtOz8F+QKtAcK0PxpdeH/1KxOA5SimRzGAvqw==
Content-Type: multipart/mixed; 
	boundary="----=_Part_13880_1450293014.1778479118290"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:Ps8vCgDHzysOcAFqjQQAAA--.395W
X-CM-SenderInfo: xixqvtpzdqwqh1hdxhhqhw/1tbiNA75a2oBcA4HdAAA3O
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

------=_Part_13880_1450293014.1778479118290
Content-Type: multipart/alternative; 
	boundary="----=_Part_13882_1110665142.1778479118290"

------=_Part_13882_1110665142.1778479118290
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8sCgpTaW5jZSBsaWJpY2FsIDQuMCBbMV0sIHBrZ2NvbmZpZyBmaWxlcyBvZiBsaWJpY2Fs
IGhhdmUgYmVlbiBzcGxpdHRlZCBpbnRvIHNldmVyYWwgZmlsZXMgYWNjb3JkaW5nIHRvIGxpYnJh
cmllcy4gVGhlIGxpYmljYWwgcGtnY29uZmlnIGNoZWNrIG5lZWQgdG8gYmUgdHdlYWtlZCB0byBj
aGVjayBsaWJpY2FsdmNhbC4gUGF0Y2ggYXR0YWNoZWQuCgpUaGFua3MuCgpbMV06IGh0dHBzOi8v
Z2l0aHViLmNvbS9saWJpY2FsL2xpYmljYWwvcHVsbC85ODgK
------=_Part_13882_1110665142.1778479118290
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8sPGJyPjxicj5TaW5jZSBsaWJpY2FsIDQuMCBbMV0sIHBrZ2NvbmZpZyBmaWxlcyBvZiBs
aWJpY2FsIGhhdmUgYmVlbiBzcGxpdHRlZCBpbnRvIHNldmVyYWwgZmlsZXMgYWNjb3JkaW5nIHRv
IGxpYnJhcmllcy4gVGhlIGxpYmljYWwgcGtnY29uZmlnIGNoZWNrIG5lZWQgdG8gYmUgdHdlYWtl
ZCB0byBjaGVjayBsaWJpY2FsdmNhbC4gUGF0Y2ggYXR0YWNoZWQuPGJyPjxicj5UaGFua3MuPGJy
Pjxicj5bMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9saWJpY2FsL2xpYmljYWwvcHVsbC85ODg8YnI+

------=_Part_13882_1110665142.1778479118290--

------=_Part_13880_1450293014.1778479118290
Content-Type: text/plain; name=bluez-5.86-support-ical-4.0.patch.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bluez-5.86-support-ical-4.0.patch.txt"

RnJvbSBlNTEyOGUxMTI0ZWZhODE0ZDhjNjViNDc5NzAyNWIxYTE1YzZiMjUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGdW5kYSBXYW5nIDxmdW5kYXdhbmdAeWVhaC5uZXQ+CkRhdGU6
IE1vbiwgMTEgTWF5IDIwMjYgMTI6Mzc6MzUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzdXBwb3J0
IGxpYmljYWwgNC4wCgotLS0KIGNvbmZpZ3VyZS5hYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5h
YyBiL2NvbmZpZ3VyZS5hYwppbmRleCA1MmRlN2Q2Li4xY2RkNTUxIDEwMDY0NAotLS0gYS9jb25m
aWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC0zMDYsNyArMzA2LDkgQEAgZmkKIEFDX0FS
R19FTkFCTEUob2JleCwgQVNfSEVMUF9TVFJJTkcoWy0tZGlzYWJsZS1vYmV4XSwKIAkJW2Rpc2Fi
bGUgT0JFWCBwcm9maWxlIHN1cHBvcnRdKSwgW2VuYWJsZV9vYmV4PSR7ZW5hYmxldmFsfV0pCiBp
ZiAodGVzdCAiJHtlbmFibGVfb2JleH0iICE9ICJubyIpOyB0aGVuCi0JUEtHX0NIRUNLX01PRFVM
RVMoSUNBTCwgbGliaWNhbCkKKwlQS0dfQ0hFQ0tfTU9EVUxFUyhJQ0FMLCBbbGliaWNhbHZjYWwg
Pj0gNC4wLjBdLCBbXSwKKyAgICAgICAgICAgICAgICBbUEtHX0NIRUNLX01PRFVMRVMoSUNBTCwg
W2xpYmljYWxdKV0KKyAgICAgICAgKQogZmkKIEFNX0NPTkRJVElPTkFMKE9CRVgsIHRlc3QgIiR7
ZW5hYmxlX29iZXh9IiAhPSAibm8iKQogCi0tIAoyLjQ3LjMKCg==
------=_Part_13880_1450293014.1778479118290--

