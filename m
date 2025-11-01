Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7834D3A7;
	Sat,  1 Nov 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015016; cv=none; b=PKA8gL9eQcbIQHVCJ8J4HSzgPjPYhLjoLqFZTbkLZPIt9UUwvLWVswXoSU1VgXHYwollXiUriE5abuPqUhyzRDH3VCw8sGhFlzZ3buUFuWJn5gW3lnZVNTYWvjh07uc77aj6bgqXLeyW4vnnr4mYXGMF+5fTsJCDi/rx62P4pEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015016; c=relaxed/simple;
	bh=g0ChhHcKt6YzFKTS0xvRxpNkWjx/u5cIu5EPQYFzzWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MaPi/9mUT+cjdYsiPTlS6loSmbvtYiGuYuzsW8oETYL1iNGlgKz/UhKVAchX9VRUTJPRyo1ZBXwkzupQpLkFCAXw3jztoKd1E0K+MJRCNjIo5Q0fxhQ+wQCSBf+RUOlhg0NWYGfufxPHi+odUBtZucxDW1n/5K/C6zTCFRH4V3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=YWg8618f reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="YWg8618f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=L/9D6uIGwDP+WjGZhkAhyVm31eVL9to0o7VaEgGtNjI=; b=Y
	Wg8618frS1S5ztIumDCuaWsVIRclH7qZvGOMxXNiDYk5N7qmMx3vXaBUEppmHC1H
	ORfyo8SyrztTR6YMJQ/y1aKwjfSpGbG5xmDouEV8QAMf8QGlOFFNzDBa1lffwa00
	DoHqJ0oBP9lyS03I2BSfAc6BdMY0bBfsi7H2upbXJ4=
Received: from zzzccc427$163.com ( [1.203.169.43] ) by
 ajax-webmail-wmsvr-40-101 (Coremail) ; Sun, 2 Nov 2025 00:36:34 +0800 (CST)
Date: Sun, 2 Nov 2025 00:36:34 +0800 (CST)
From: zzzccc427  <zzzccc427@163.com>
To: "Pauli Virtanen" <pav@iki.fi>
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, johan.hedberg@gmail.com,
	marcel@holtmann.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com,
	r33s3n6@gmail.com, gality369@gmail.com, zhenghaoran154@gmail.com
Subject: Re:Re: [PATCH v3] bluetooth: sco: Serialize state check in
 sco_sock_connect to fix UAF
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <9430e38fd2fb34abfac0d90bc84880667749294d.camel@iki.fi>
References: <20251101104522.174388-1-zzzccc427@163.com>
 <9430e38fd2fb34abfac0d90bc84880667749294d.camel@iki.fi>
X-NTES-SC: AL_Qu2dAPyau0Ei4iSbYOkfmUYQj+02WsKwufkl3oJUPJ18jCvpyi4wRH1KAWP3/Nm0DhKsgiO9VTR++/hcc5VJUZ0ijh/DJPHJvlQLB7CVvXbfGw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <534d8927.34d1.19a4047200e.Coremail.zzzccc427@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgD3t8ISNwZpz3AYAA--.531W
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/xtbBYwr4hGkGMEcnsgADsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgUGF1bGksCnRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgdGhlIGRldGFpbGVkIGV4cGxhbmF0
aW9uLgo+VGhpcyBsb29rcyBjb3JyZWN0IGluIHByaW5jaXBsZSwgc2tfc3RhdGUgc2hhbGwgYmUg
YWNjZXNzZWQgb25seSB1bmRlcgo+bG9jay4KPgo+SG93ZXZlciwgdGhlIGxvY2sgaXMgcmVsZWFz
ZWQgYmVmb3JlIHNjb19jb25uZWN0LCBzbyBsb29rcyBsaWtlIHR3bwo+Y29ubmVjdCBjYWxscyBj
YW4gc3RpbGwgYmUgYXQgdGhpcyBwb2ludCBhdCB0aGUgc2FtZSB0aW1lLCBzbyBBRkFJQ1MKPnRo
ZSBhYm92ZSBvbmx5IHJlc3RyaWN0cyB0aGUgdGltZSB3aW5kb3cgZm9yIHRoZSByYWNlLgo+Cj5Q
cm9iYWJseSBzb21ldGhpbmcgYWxvbmcgdGhlIGZvbGxvd2luZyBpcyBtb3JlIHN1cmUuIEl0J3Mg
aW1wb3J0YW50IHRoZQo+Y2hlY2sgaXMgdW5kZXIgc2FtZSBsb2NrX3NvY2soKSBpbiBzY29fY29u
bmVjdCB3aGVyZSBza19zdGF0ZSBpcwo+bW9kaWZpZWQ7IGluIGFkZGl0aW9uIHNrX3N0YXRlIGNo
ZWNrIGNvdWxkIGJlIGFkZGVkIChvciBtYXliZSBtb3ZlZCkKPmFsc28gdGhlcmUuCj4KPmRpZmYg
LS1naXQgYS9uZXQvYmx1ZXRvb3RoL3Njby5jIGIvbmV0L2JsdWV0b290aC9zY28uYwo+aW5kZXgg
YWIwY2Y0NDJkNTdiLi4wNmMyMGQ5OTUyMWQgMTAwNjQ0Cj4tLS0gYS9uZXQvYmx1ZXRvb3RoL3Nj
by5jCj4rKysgYi9uZXQvYmx1ZXRvb3RoL3Njby5jCj5AQCAtMjk4LDcgKzI5OCw3IEBAIHN0YXRp
YyBpbnQgc2NvX2NoYW5fYWRkKHN0cnVjdCBzY29fY29ubiAqY29ubiwKPnN0cnVjdCBzb2NrICpz
aywKPiBpbnQgZXJyID0gMDsKPgo+IHNjb19jb25uX2xvY2soY29ubik7Cj4tIGlmIChjb25uLT5z
aykKPisgaWYgKGNvbm4tPnNrIHx8IHNjb19waShzayktPmNvbm4pCj4gZXJyID0gLUVCVVNZOwo+
IGVsc2UKPiBfX3Njb19jaGFuX2FkZChjb25uLCBzaywgcGFyZW50KTsKPkBAIC0zNTYsNiArMzU2
LDcgQEAgc3RhdGljIGludCBzY29fY29ubmVjdChzdHJ1Y3Qgc29jayAqc2spCj4gZXJyID0gc2Nv
X2NoYW5fYWRkKGNvbm4sIHNrLCBOVUxMKTsKPiBpZiAoZXJyKSB7Cj4gcmVsZWFzZV9zb2NrKHNr
KTsKPisgaGNpX2Nvbm5fZHJvcChoY29uKTsKPiBnb3RvIHVubG9jazsKPiB9Cj4KWW91J3JlIHJp
Z2h0IKGqIG15IHYzIG9ubHkgcmVkdWNlZCB0aGUgcmFjZSB3aW5kb3cgYmVjYXVzZSBJIHdhcyBy
ZWxlYXNpbmcKdGhlIHNvY2tldCBsb2NrIGJlZm9yZSBjYWxsaW5nIHNjb19jb25uZWN0KCksIHNv
IHR3byBjb25jdXJyZW50IGNvbm5lY3QoKQpjYWxscyBjb3VsZCBzdGlsbCByZWFjaCBzY29fY29u
bmVjdCgpIGF0IHJvdWdobHkgdGhlIHNhbWUgdGltZS4KPlRoZSB0ZXN0IGJvdCBhbHNvIHNheXM6
Cj4KPiJCbHVldG9vdGg6ICIgcHJlZml4IGlzIG5vdCBzcGVjaWZpZWQgaW4gdGhlIHN1YmplY3QK
Pgo+VGhlIHBhdGNoIHN1YmplY3Qgc2hvdWxkIHN0YXJ0ICJCbHVldG9vdGg6IFNDTzoiIG5vdCAi
Ymx1ZXRvb3RoOiBzY286Ii4KPgo+VGhlIGZvbGxvd2luZyBlcnJvcnMgaW4gdGVzdCBib3QgYWZh
aWsgYXJlIGtub3duIHByZS1leGlzdGluZyBmYWlsdXJlcywKPmFuZCBjYW4gYmUgaWdub3JlZCBo
ZXJlOgo+Cj5GYWlsZWQgVGVzdCBDYXNlcwo+UmVhZCBFeHAgRmVhdHVyZSAtIFN1Y2Nlc3MgRmFp
bGVkIDAuMTAyCj5zZWNvbmRzCj5MTCBQcml2YWN5IC0gQWRkIERldmljZSAzIChBTCBpcyBmdWxs
KSBGYWlsZWQgMC4xOTYKPnNlY29uZHMKPk1lc2ggLSBTZW5kIGNhbmNlbCAtIDEgVGltZWQgb3V0
IDIuMDIyCj5zZWNvbmRzCj5NZXNoIC0gU2VuZCBjYW5jZWwgLSAyIFRpbWVkIG91dCAxLjk5Ngo+
c2Vjb25kcwpUaGFua3MgYWdhaW4gZm9yIHRoZSBndWlkYW5jZSx0aGlzIGhlbHBzIG1lIGEgbG90
IQpJJ2xsIHNlbmQgYSB2NCB0aGF0IGRvZXMgdGhlIGZvbGxvd2luZzoKICAtIGZpeCB0aGUgc3Vi
amVjdCBwcmVmaXggdG8gIkJsdWV0b290aDogU0NPOiAuLi4iCiAgLSBpbiBzY29fY2hhbl9hZGQo
KSwgYWxzbyBjaGVjayBzY29fcGkoc2spLT5jb25uIGFuZCByZXR1cm4gLUVCVVNZIGlmIHRoZQog
ICAgc29ja2V0IGlzIGFscmVhZHkgYXR0YWNoZWQsIGFzIHlvdSBzdWdnZXN0ZWQ6CiAgICAgICAg
aWYgKGNvbm4tPnNrIHx8IHNjb19waShzayktPmNvbm4pCiAgICAgICAgICAgICAgICBlcnIgPSAt
RUJVU1k7CiAgLSBpbiBzY29fY29ubmVjdCgpLCBpZiBzY29fY2hhbl9hZGQoKSBmYWlscywgZHJv
cCB0aGUgaGNpX2Nvbm4gcmVmCiAgICAoaGNpX2Nvbm5fZHJvcChoY29uKSkgYmVmb3JlIHJldHVy
bmluZwoKQmVzdCByZWdhcmRzLApDZW4gWmhhbmc=
