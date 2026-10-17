Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8539A060;
	Sat, 17 Oct 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222655; cv=none; b=ZxIPZFdw14jjBuDLgt1+yu8BxhCUNUbDoVBGx2BgXrFs1kgMcM1HJgvnmpZX4PZG9wXM0na9X7ZaX9DtuwXo1OPX7HCvVhpsaggSZMUKagzpddn9zeyePOOAMUwOdcY49jAnb3in0Tr8rxfESXHSbtqw6ihtM640DVU1CLjKsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222655; c=relaxed/simple;
	bh=71F1a5zKwaom90xrHbsu9nKbmWtG+xFm2DAmJvjrXm8=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aF7bJMrwx/9nLhKNXVLgS6Dfz/1nLBrKrWbP2VU+T1NcGqiRCTvzEIrcoGyfboD+GfmH4ecnNOly0p1WBszyE/6q5oIMzn4Di6JqRoqUZOiUUvK8w6IxhtlwhurzOcoT80S0qlVy0Zh4/4pExqrDzUBCXfLVRPyHQ64UymdGzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WVJe+cNJ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WVJe+cNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=71F1a5zKwaom90xrHbsu9nKbmWtG+xFm2DAmJvjrXm8=; b=W
	VJe+cNJpzOvtG+xPsjBymjfNoO/oMzTEHfFRJsLG/3kVGL8C86edhkneJHy3ppvC
	9GF/H1vMxeTC+WEHrRJLpxHYG6hM+oCbjDS4ub9AE21lRPOUiBg1Lo+t/+drMhMm
	IhgXs5EkZ1oc9SbBToq7vGibZ+0cESjwg0RvTxCsq4=
Date: Sat, 17 Oct 2026 15:37:19 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Marcel Holtmann" <marcel@holtmann.org>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 2/2] Bluetooth: msft: free detached address filter on
 cancel
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261017031022.3616384-1-yaojiale02@163.com>
References: <20261017031022.3616384-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvU4o7ymbZukdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHPvlxq4k8Psie8lna/ticSw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <994a66d.18b6.1a148cb3747.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDXn7SwJdNq+vtaAA--.161W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRAFP2rTJbAjyAAA3g
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNyAxMToxMDoyMiwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5BbiBhZGRyZXNzIGZpbHRlciBxdWV1ZWQgZm9yIGFkZGl0aW9uIGNhbiBiZSBkZXRh
Y2hlZCBmcm9tIHRoZSBNU0ZUCj5maWx0ZXIgbGlzdCBhbmQgbWFya2VkIEFGX1NUQVRFX1JFTU9W
SU5HIGJlZm9yZSBpdHMgY29tbWFuZC1zeW5jIHdvcmsKPnJ1bnMuIElmIHRoZSBxdWV1ZWQgZW50
cnkgaXMgdGhlbiBjYW5jZWxsZWQsIGl0cyBOVUxMIGRlc3Ryb3kgY2FsbGJhY2sKPmxlYXZlcyB0
aGUgZGV0YWNoZWQgZmlsdGVyIHdpdGhvdXQgYW4gb3duZXIuCj4KPkluc3RhbGwgYSBkZXN0cm95
IGNhbGxiYWNrIHRoYXQgZnJlZXMgYSBjYW5jZWxsZWQgZmlsdGVyIG9ubHkgd2hlbiBpdAo+aGFz
IHJlYWNoZWQgQUZfU1RBVEVfUkVNT1ZJTkcuIEZpbHRlcnMgdGhhdCBhcmUgc3RpbGwgbGlua2Vk
IHJlbWFpbgo+b3duZWQgYnkgdGhlIG5vcm1hbCBjbG9zZSBjbGVhbnVwIHBhdGguCj4KCkZpeGVz
OiA5ZTE0NjA2ZDhmMzggKCJCbHVldG9vdGg6IG1zZnQ6IEV4dGVuZGVkIG1vbml0b3IgdHJhY2tp
bmcgYnkgYWRkcmVzcyBmaWx0ZXIiKQoKPlNpZ25lZC1vZmYtYnk6IEppYWxlIFlhbyA8eWFvamlh
bGUwMkAxNjMuY29tPgo+LS0tCj4gbmV0L2JsdWV0b290aC9tc2Z0LmMgfCAxMiArKysrKysrKysr
Ky0KPiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj5k
aWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9tc2Z0LmMgYi9uZXQvYmx1ZXRvb3RoL21zZnQuYwo+
aW5kZXggZDlkZDcyMmRiM2ViLi5iOWY4ZjA4OWNjNzIgMTAwNjQ0Cj4tLS0gYS9uZXQvYmx1ZXRv
b3RoL21zZnQuYwo+KysrIGIvbmV0L2JsdWV0b290aC9tc2Z0LmMKPkBAIC05MjgsNiArOTI4LDE2
IEBAIHN0YXRpYyBpbnQgbXNmdF9hZGRfYWRkcmVzc19maWx0ZXJfc3luYyhzdHJ1Y3QgaGNpX2Rl
diAqaGRldiwgdm9pZCAqZGF0YSkKPiAJcmV0dXJuIDA7Cj4gfQo+IAo+K3N0YXRpYyB2b2lkIG1z
ZnRfYWRkX2FkZHJlc3NfZmlsdGVyX2Rlc3Ryb3koc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQg
KmRhdGEsCj4rCQkJCQkgICAgaW50IGVycikKPit7Cj4rCXN0cnVjdCBtc2Z0X21vbml0b3JfYWRk
cl9maWx0ZXJfZGF0YSAqYWRkcmVzc19maWx0ZXIgPSBkYXRhOwo+Kwo+KwlpZiAoZXJyID09IC1F
Q0FOQ0VMRUQgJiYKPisJICAgIGFkZHJlc3NfZmlsdGVyLT5zdGF0ZSA9PSBBRl9TVEFURV9SRU1P
VklORykKPisJCWtmcmVlKGFkZHJlc3NfZmlsdGVyKTsKPit9Cj4rCj4gLyogVGhpcyBmdW5jdGlv
biByZXF1aXJlcyB0aGUgY2FsbGVyIGhvbGRzIG1zZnQtPmZpbHRlcl9sb2NrICovCj4gc3RhdGlj
IHN0cnVjdCBtc2Z0X21vbml0b3JfYWRkcl9maWx0ZXJfZGF0YSAqbXNmdF9hZGRfYWRkcmVzc19m
aWx0ZXIKPiAJCShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTggYWRkcl90eXBlLCBiZGFkZHJfdCAq
YmRhZGRyLAo+QEAgLTk1OSw3ICs5NjksNyBAQCBzdGF0aWMgc3RydWN0IG1zZnRfbW9uaXRvcl9h
ZGRyX2ZpbHRlcl9kYXRhICptc2Z0X2FkZF9hZGRyZXNzX2ZpbHRlcgo+IAlsaXN0X2FkZF90YWls
KCZhZGRyZXNzX2ZpbHRlci0+bGlzdCwgJm1zZnQtPmFkZHJlc3NfZmlsdGVycyk7Cj4gCj4gCWVy
ciA9IGhjaV9jbWRfc3luY19xdWV1ZShoZGV2LCBtc2Z0X2FkZF9hZGRyZXNzX2ZpbHRlcl9zeW5j
LAo+LQkJCQkgYWRkcmVzc19maWx0ZXIsIE5VTEwpOwo+KwkJCQkgYWRkcmVzc19maWx0ZXIsIG1z
ZnRfYWRkX2FkZHJlc3NfZmlsdGVyX2Rlc3Ryb3kpOwo+IAlpZiAoZXJyIDwgMCkgewo+IAkJYnRf
ZGV2X2VycihoZGV2LCAiTVNGVDogQWRkIGFkZHJlc3MgJXBNUiBmaWx0ZXIgZXJyIiwgYmRhZGRy
KTsKPiAJCWxpc3RfZGVsKCZhZGRyZXNzX2ZpbHRlci0+bGlzdCk7Cj4tLSAKPjIuMzQuMQo=
