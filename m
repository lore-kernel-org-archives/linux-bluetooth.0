Received: from cstnet.cn (smtp86.cstnet.cn [159.226.251.86])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949729405
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209394; cv=none; b=RfCCpA5P5yCOOUI0KntZg+EItQe1tT/uY4q8DhKtCWypNzwdZiI1y/Sf+hGEJNRYMYbhw+IIOZlaoyHuOB8fe02ujOlTx2ccY6MgRBl8XOXNn22ia6huSg98cxog3wopk3tKUboaABew+zIO/ux1dTYXXMy6XzkjpYGwP4VyjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209394; c=relaxed/simple;
	bh=7prYcyHtuBmv6LxaxJnIi4WRyPULpW7rNbiGUZM6h4E=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=XVTAPo6jwsPP82ZobZGQ3JCkRfHO1fkpDJ0bTRY7ImpG4KmIap7ahhnPVKpQgYjR1qRYF3C7mFpBBZftoGVlZ8VKGTWTLYHN8VJeJLDnW/ijSsjHblenbTDQoNkvdQQu9aO38U2ibtdH5D99zCTENXRmBLI8aS2Q3PcOArgPUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from pengpeng$iscas.ac.cn ( [23.249.16.216] ) by
 ajax-webmail-APP-16 (Coremail) ; Wed, 11 Mar 2026 14:09:47 +0800
 (GMT+08:00)
Date: Wed, 11 Mar 2026 14:09:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5L6v5pyL5pyL?= <pengpeng@iscas.ac.cn>
To: linux-bluetooth@vger.kernel.org
Subject: [BUG] `ad_replace_name()` copies AD name payloads up to 254 bytes
 into `utf8_name[250]`
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1d62d5cd.57f7e.19cdb8402e8.Coremail.pengpeng@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:sQCowABXfLAsB7FpdTUWAA--.49623W
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/1tbiCRADBWmw+gUkbQABsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gQmx1ZVogbWFpbnRhaW5lcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IHdoYXQgYXBw
ZWFycyB0byBiZSBhIHJlYWwgY3VycmVudC1oZWFkIGJvdW5kZWQgc3RhY2sgb3ZlcmZsb3cgaW4g
dGhlIGFkdmVydGlzaW5nLWRhdGEgbmFtZSBwYXJzZXIuIEkgcmVjaGVja2VkIGN1cnJlbnQgdXBz
dHJlYW0gaGVhZCBvbiAyMDI2LTAzLTEwIGJlZm9yZSB3cml0aW5nIHRoaXMgcmVwb3J0LgoKVGhl
IGRlc3RpbmF0aW9uIGJ1ZmZlciBpczoKCmBgYGMKY2hhciB1dGY4X25hbWVbSENJX01BWF9OQU1F
X0xFTkdUSCArIDJdOwpgYGAKCndpdGg6CgpgYGBjCiNkZWZpbmUgSENJX01BWF9OQU1FX0xFTkdU
SCAyNDgKYGBgCgpzbyB0aGUgdG90YWwgc3RhY2sgYnVmZmVyIHNpemUgaXMgYDI1MGAgYnl0ZXMu
CgpUaGUgdnVsbmVyYWJsZSBjb3B5IGlzOgoKYGBgYwptZW1zZXQodXRmOF9uYW1lLCAwLCBzaXpl
b2YodXRmOF9uYW1lKSk7CnN0cm5jcHkodXRmOF9uYW1lLCAoY29uc3QgY2hhciAqKWlvdi0+aW92
X2Jhc2UsIGlvdi0+aW92X2xlbik7CmBgYAoKVGhlIGxlbmd0aCBwYXNzZWQgdG8gdGhpcyBoZWxw
ZXIgY29tZXMgZnJvbSBgYnRfYWRfbmV3X3dpdGhfZGF0YSgpYCwgd2hlcmUgdGhlIEFEIGVsZW1l
bnQgbGVuZ3RoIGlzIHJlYWQgYXMgYSBgdWludDhfdGAsIHRoZW4gZGVjcmVtZW50ZWQgb25jZSBm
b3IgdGhlIHR5cGUgYnl0ZToKCmBgYGMKd2hpbGUgKHV0aWxfaW92X3B1bGxfdTgoJmlvdiwgJmVs
ZW4pKSB7CiAgICAuLi4KICAgIGlmICghdXRpbF9pb3ZfcHVsbF91OCgmaW92LCAmdHlwZSkpCiAg
ICAgICAgZ290byBmYWlsZWQ7CiAgICBlbGVuLS07CiAgICAuLi4KICAgIGRhdGEgPSB1dGlsX2lv
dl9wdWxsX21lbSgmaW92LCBlbGVuKTsKYGBgCgpTbyB0aGUgcGF5bG9hZCBsZW5ndGggZGVsaXZl
cmVkIHRvIGBhZF9yZXBsYWNlX25hbWUoKWAgY2FuIGJlIGFzIGxhcmdlIGFzIGAyNTRgLCB3aGls
ZSB0aGUgZGVzdGluYXRpb24gYnVmZmVyIGlzIG9ubHkgYDI1MGAgYnl0ZXMuCgpJIGFtIGRlbGli
ZXJhdGVseSBub3Qgb3ZlcnN0YXRpbmcgdGhpczoKCi0gdGhpcyBpcyBwcm90b2NvbC1ib3VuZGVk
LCBub3QgYXJiaXRyYXJ5IGxlbmd0aAotIHRoZSBtYXhpbXVtIG92ZXJ3cml0ZSBhbXBsaXR1ZGUg
aXMgc21hbGwsIGFib3V0IDQgYnl0ZXMKCkJ1dCBpdCBzdGlsbCBsb29rcyBsaWtlIGEgcmVhbCBj
dXJyZW50LWhlYWQgYnVnOgoKLSBmaXhlZCBzdGFjayBidWZmZXIgb2YgMjUwIGJ5dGVzCi0gY29w
eSBsZW5ndGggY2FuIHJlYWNoIDI1NAotIG5vIGxvY2FsIGd1YXJkIGBpb3YtPmlvdl9sZW4gPD0g
c2l6ZW9mKHV0ZjhfbmFtZSlgCgpUaGUgZml4IHNlZW1zIHN0cmFpZ2h0Zm9yd2FyZDogY2xhbXAg
b3IgcmVqZWN0IGBpb3YtPmlvdl9sZW4gPiBzaXplb2YodXRmOF9uYW1lKSAtIDFgIGJlZm9yZSB0
aGUgY29weSwgYW5kIHByZXNlcnZlIGV4cGxpY2l0IHRlcm1pbmF0aW9uLgoKQmVzdCByZWdhcmRz
LApQZW5ncGVuZyBIb3U=
