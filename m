Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03C42AD61;
	Sat, 17 Oct 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222618; cv=none; b=tfF1nWjttbtgwwmBhN15kzvaSroeyLzUpY9hg27PjRaUgW6BlVPGJtzyozDmjRHLzKVlLaCj3UvOXS3jUxh06MVeLaWkx5/RcdIBKHvAqoDKkd6EGnWt9lLVEyy6m7+QO7w24Ri9kidcFh4rVZZ0EBxD0v8b+96sraiUIngtQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222618; c=relaxed/simple;
	bh=dNzEpfK6ph8vAkjZMNpXwefN9ALLND8ZwvWLs1KlRPg=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MseZOPMbQBOPbHHvlaIedp2XAythi++5+r50uH4Hl5YkddPERAeY2QZoNMri6IXHLKDuHOS9pAM75eqTrTuIfYGXJSEkkAJuvW6IGfoiohZObyzovZ2zWNb8dckzAdFXe9e3fInIr823PDdvl205WNcbdqQ74K/04BdQKy1vbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=piWmJPgH; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="piWmJPgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=dNzEpfK6ph8vAkjZMNpXwefN9ALLND8ZwvWLs1KlRPg=; b=p
	iWmJPgH1lPoXPcNLoTqRjSzzaM27nPqJM9kKvZv3blJZnxj5Vev581xNZEpHcplI
	OrfB7U780usVI7pEO7Z7Fg6KTc2eWEJtwKu4CuUz4jhK/6Axa1VrJp2l+seOigxA
	2eDzfmIP79jyYJ6sR7H21WBbk274Ck4/gMhirMK7+w=
Date: Sat, 17 Oct 2026 15:36:46 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Marcel Holtmann" <marcel@holtmann.org>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 1/2] Bluetooth: MGMT: free remove monitor command on
 cancel
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261017030939.3615701-1-yaojiale02@163.com>
References: <20261017030939.3615701-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvU4r4COfZ+kdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHOGwc/1iZaOn21MqELHrH6g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3e436213.18ae.1a148cab430.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgD3n26OJdNq8vtaAA--.153W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ77NmrTJY4iDwAA3x
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNyAxMTowOTozOSwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5yZW1vdmVfYWR2X21vbml0b3IoKSBhbGxvY2F0ZXMgaXRzIHF1ZXVlZCBjb21tYW5k
IHdpdGgKPm1nbXRfcGVuZGluZ19uZXcoKSwgc28gdGhlIGNvbW1hbmQgaXMgbm90IGxpbmtlZCBp
bnRvCj5oZGV2LT5tZ210X3BlbmRpbmcuIElmIHRoZSBjb21tYW5kLXN5bmMgZW50cnkgaXMgY2Fu
Y2VsbGVkLCBpdHMKPmNvbXBsZXRpb24gY2FsbGJhY2sgcmV0dXJucyB3aXRob3V0IGZyZWVpbmcg
dGhlIGNvbW1hbmQsIGxlYWtpbmcgYm90aAo+dGhlIGFsbG9jYXRpb24gYW5kIGl0cyBzb2NrZXQg
cmVmZXJlbmNlLgo+Cj5GcmVlIHRoZSBwZW5kaW5nIGNvbW1hbmQgYmVmb3JlIHJldHVybmluZyBm
cm9tIHRoZSBjYW5jZWxsYXRpb24gcGF0aC4KPgoKRml4ZXM6IGU2ZWQ1NGU4NmFhZSAoIkJsdWV0
b290aDogTUdNVDogRml4IFVBRiBvbiBtZ210X3JlbW92ZV9hZHZfbW9uaXRvcl9jb21wbGV0ZSIp
Cgo+U2lnbmVkLW9mZi1ieTogSmlhbGUgWWFvIDx5YW9qaWFsZTAyQDE2My5jb20+Cj4tLS0KPiBu
ZXQvYmx1ZXRvb3RoL21nbXQuYyB8IDQgKysrLQo+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbWdtdC5j
IGIvbmV0L2JsdWV0b290aC9tZ210LmMKPmluZGV4IDI1MWE4OTZiYWJkNS4uZTU0YTgzOGFlYWRh
IDEwMDY0NAo+LS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMKPisrKyBiL25ldC9ibHVldG9vdGgv
bWdtdC5jCj5AQCAtNTY4Miw4ICs1NjgyLDEwIEBAIHN0YXRpYyB2b2lkIG1nbXRfcmVtb3ZlX2Fk
dl9tb25pdG9yX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAo+IAlzdHJ1Y3QgbWdtdF9w
ZW5kaW5nX2NtZCAqY21kID0gZGF0YTsKPiAJc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25p
dG9yICpjcDsKPiAKPi0JaWYgKHN0YXR1cyA9PSAtRUNBTkNFTEVEKQo+KwlpZiAoc3RhdHVzID09
IC1FQ0FOQ0VMRUQpIHsKPisJCW1nbXRfcGVuZGluZ19mcmVlKGNtZCk7Cj4gCQlyZXR1cm47Cj4r
CX0KPiAKPiAJaGNpX2Rldl9sb2NrKGhkZXYpOwo+IAo+LS0gCj4yLjM0LjEK
