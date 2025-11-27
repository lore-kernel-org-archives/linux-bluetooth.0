Received: from mail-m49232.qiye.163.com (mail-m49232.qiye.163.com [45.254.49.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FC31C58A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246085; cv=none; b=AR96ciKlVtGvOUikMRJu8V4YCkzuXriXp+B2mMlbh7m10HHG2oIXtwoEef/uqNFsEGB3AplmMbIOn6IqniYa+mSB1DD9ffNqaNK2eQaHd5UH5R1Rma/hpHxJRMqwg7s5aNyA7H2uBiuq3zMcOROzrHEB70nVjwHuPGtqPAl7nbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246085; c=relaxed/simple;
	bh=YM4qbCb+nzuHFDxXeMY6zpAkpSDuqy7O2GrYT5gDLhI=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=QXPGDLyTpTTp1my56OB3n6CRkJ8lpi1cTVNCO/5sOuwRMsZfCdCwNP63+cVXChmR2rsDDd1MPmFQxIatNave6UGBWpwvtQqD3HC9qNYjMOADPLXcW7p0w1FwUy8RbDlVClLB3+RyjvAXVGC/CeVJr+ng3Uoi6vNM7Fhfnr11RXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=BHqBan23; arc=none smtp.client-ip=45.254.49.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="BHqBan23"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJMA6ACZJsDbFlQIckIfV4oY.1.1764245763996.Hmail.2200013188@stu.pku.edu.cn>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	"luiz.dentz" <luiz.dentz@gmail.com>, 
	"johan.hedberg" <johan.hedberg@gmail.com>, 
	marcel <marcel@holtmann.org>, 
	xujiakai2025 <xujiakai2025@iscas.ac.cn>
Subject: =?UTF-8?B?W0JVR10gQmx1ZXRvb3RoOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGwyY2FwX2NvcmUuYw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_MAC_1.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2200013188@stu.pku.edu.cn( [210.73.43.101] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 27 Nov 2025 20:16:03 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5aSp5a6H?= <2200013188@stu.pku.edu.cn>
Date: Thu, 27 Nov 2025 20:16:03 +0800 (GMT+08:00)
X-HM-Tid: 0a9ac536b16309b6kunm5f6835a110f
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMYTqrvk2VXm1s3jojcL7ki9S5UDbyOJxmDzs8e
	YzTqMdKwpWKMh6NnGmqzdrLX2gtSVGYmoxDwl8xVhLAO7Z5gtjQivdReiURg4yGSB77thk2wd5xy
	HMnSA69e9o+YW9thfqk6f6AmALqWSS+60CC1c=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkkZVh0aT01DGEpJSUgYSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJSktVTEhVT0hVSktKWVdZFhoPEhUdFFlBWU9LSFVKS0hLT0NIVUpLS1
	VKQlkG
DKIM-Signature: a=rsa-sha256;
	b=BHqBan23CNN6LJe3Qy/7TkfNXRngy/aJQgP6ZRNtgjVRCHuB8SBD/Ms5R1bnkxldiBtIpKuCxUlSBEsQx0W83wQo5pHp6KZq6tnNMHJHBgEhKkQbZzs3s8Eh4KnTf2Ur3NYa+eYQF1sG9l/lIUcUJwMwERMCE51gdLPkWIvc+5Q=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=YM4qbCb+nzuHFDxXeMY6zpAkpSDuqy7O2GrYT5gDLhI=;
	h=date:mime-version:subject:message-id:from;

RGVhciBtYWludGFpbmVycywKCkkgYW0gd3JpdGluZyB0byByZXBvcnQgYSBzbGFiLXVzZS1hZnRl
ci1mcmVlIGJ1ZyB0aGF0IEkgZm91bmQgdXNpbmcgYSBmdXp6aW5nIGZyYW1ld29yayBvbiBMaW51
eCA2LjE4LXJjNywgdGhlIG1haW5saW5lIGtlcm5lbC4KClRoZSBidWcgaXMgdHJpZ2dlcmVkIHdo
ZW4gbDJjYXBfY2hhbl90aW1lb3V0KCkgaXMgY2FsbGVkLiBTcGVjaWZpY2FsbHksIGF0IGxpbmUg
NDE3LCB0aGUgYWRkcmVzcyBvZiBjb25uLSZndDtsb2NrIGlzIHBhc3NlZCBhcyBhIHBhcmFtZXRl
ciwgYW5kIGxhdGVyIGluIGtlcm5lbC9sb2NraW5nL211dGV4LmM6MTgzLCBpdCBpcyBkZXRlY3Rl
ZCBhcyBhIGZyZWVkIHBvaW50ZXIgd2hlbiBhY2Nlc3NpbmcgaXRzIHdhaXRfbGlzdCBmaWVsZC4g
VGhlIGxvY2sgZmllbGQgYXBwZWFycyB0byBiZSBmcmVlZCBpbiBsMmNhcF9jb25uX2ZyZWUsIHdo
aWNoIGlzIGxpbmtlZCB0byBhIHJlZmNvdW50IG1vZHVsZSBpbiBsMmNhcF9jb25uX3B1dC4gQmFz
ZWQgb24gdGhpcywgSSBzdXNwZWN0IHRoYXQgdGhlIGlzc3VlIG1heSBzdGVtIGZyb20gYW4gaW5j
b3JyZWN0IGNhbGN1bGF0aW9uIG9mIHRoZSByZWZlcmVuY2UgY291bnQgZm9yIHRoZSBjb25uIHN0
cnVjdCwgd2hpY2ggY291bGQgbGVhZCB0byBhbiBlYXJseSByZWxlYXNlIG9mIHJlc291cmNlcy4K
CkR1ZSB0byBteSBsaW1pdGVkIGtub3dsZWRnZSBvZiB0aGUga2VybmVsIGFuZCB0aGUgbGFjayBv
ZiBmdXJ0aGVyIGluZm9ybWF0aW9uLCBJIGFtIHVuc3VyZSBpZiBhZGRpdGlvbmFsIGFuYWx5c2lz
IGlzIG5lZWRlZC4gSG93ZXZlciwgSSBob3BlIHRoaXMgcmVwb3J0IGlzIGhlbHBmdWwgaW4gaWRl
bnRpZnlpbmcgYW5kIGFkZHJlc3NpbmcgdGhlIGlzc3VlLgoKVGhhbmsgeW91IGZvciB5b3VyIGF0
dGVudGlvbiB0byB0aGlzIG1hdHRlci4KClJlbGV2YW50IG1hdGVyaWFsczoKCUtlcm5lbCBsb2c6
IGh0dHBzOi8vZ2l0aHViLmNvbS9XeG0tMjMzL0tDb25maWdGdXp6X2NyYXNoZXMvcmF3L3JlZnMv
aGVhZHMvbWFpbi9mYmZmNDJiNDZiZTA2OTJlOGJkNzU1YjU5MTRmYzlhZDA4MDEzNTkwL3JlcG9y
dDAKCVVuZm9ydHVuYXRlbHksIEkgZG9uJ3QgaGF2ZSByZXBybyBjb2RlIGF0IHRoaXMgdGltZSA6
KAoKQmVzdCByZWdhcmRzDQoNCg==
