Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com [220.197.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18073770B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763206776; cv=none; b=r0BCMgm3PE4lf44uypLTtnL4gB7VaewvRAk9XEOjMBxVvGLPsULFzsViIMHoQMF1Hf1LsJNcHl1Vg7rbfqyGrcfrKBEinc4XSUiw9H9tAg9ySNWNVHkVV8QfGFYq+fb0RgwlQ9a6evRv4t7baaZChwEZDm5ABkcHdZanXPc5Us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763206776; c=relaxed/simple;
	bh=8WLFKICKYdHkMh3kq9Yuto4u15r/D+yomNKWtNJJSjk=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=sCfoqUnQUvtNO275o0dnlilOcX31A3Qb8e/CdcKOP+ZViZOkKqfuLlWRVX3UvvvSQD0e88jCcjR7+KbkM9tEMt4+ZRHzzvjjiuQnUp9DfoF42RvfqhjL7rKij1lBBybOIaot3QCalbuhGxp7xYRsBzVE/7rBQD9r4tvgZMwYh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=HOsOXu7M; arc=none smtp.client-ip=220.197.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="HOsOXu7M"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AKkAKwAGJh0rblXOmD98sapq.1.1763206454879.Hmail.2200013188@stu.pku.edu.cn>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	"luiz.dentz" <luiz.dentz@gmail.com>, 
	"johan.hedberg" <johan.hedberg@gmail.com>, 
	marcel <marcel@holtmann.org>
Subject: =?UTF-8?B?W0JVR10gQmx1ZXRvb3RoOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGhjaV9jb3JlLmM6aGNpX3NlbmRfYWNsKCk=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_MAC_1.55.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2200013188@stu.pku.edu.cn( [210.73.43.101] ) by ajax-webmail ( [127.0.0.1] ) ; Sat, 15 Nov 2025 19:34:14 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5aSp5a6H?= <2200013188@stu.pku.edu.cn>
Date: Sat, 15 Nov 2025 19:34:14 +0800 (GMT+08:00)
X-HM-Tid: 0a9a872b115f09b6kunm54fc44fd342b9
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMYTqrvk2VXm1s3jojcL7ki9S5UDbyOJxmDzs8e
	YzTqMdKwpWKMh6NnGmqzdrLX2gtXxvA4tYj9170HXwr/mSP2qUXmLprL2xLM1FRLzF5trXeOJ6tv
	MNnUzo6i8oKdKatszNtOWYpY9Lci5b/33vu0s=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEwdVkhKQhgeT0tKTUxLQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJSktVTEhVT0hVSktKWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk5IVUpLS1
	VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=HOsOXu7MX3jEgRkXig7VDrUuapXQaCIT4i6iKweW6wx2fkDJdSG1JbxBI3YIc9Jz16/s9qnPioFMGHsvXhEPYB34Ok0Y8laBKEIE8djoUKe6Ra/9R0cVe+mPoHEg/moSDnsbUKKa0Z+ZwJ07UidE0+1BFZ0uWYZf+496mrKZ7sk=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=8WLFKICKYdHkMh3kq9Yuto4u15r/D+yomNKWtNJJSjk=;
	h=date:mime-version:subject:message-id:from;

SGVsbG8sCgpBIHVzZS1hZnRlci1mcmVlIGJ1ZyB3YXMgdHJpZ2dlcmVkIGluIHRoZSBCbHVldG9v
dGggc3Vic3lzdGVtIHdoZW4gaGFuZGxpbmcgTDJDQVAgY29ubmVjdGlvbiBzZXR1cCBzZXF1ZW5j
ZXMuClRoZSBrZXJuZWwgcmVwb3J0cyBhIHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gaGNpX3NlbmRf
YWNsKCkgaXNzdWUgY2F1c2VkIGJ5IGwyY2FwX2luZm9fdGltZW91dCgpIGFjY2Vzc2luZyBhIGZy
ZWVkIGhjaV9jaGFuIG9iamVjdC4KClRoaXMgYnVnIHdhcyBmb3VuZCB2aWEgYSBmdXp6aW5nIGZy
YW1ld29yayBvbiBMaW51eCB2Ni42KHg4Nl82NCwgUUVNVSkuIFRlc3QgZW52aXJvbm1lbnQsIGNv
bmZpZ3VyYXRpb24sIGFuZCByZWxldmFudCBtYXRlcmlhbHMgYXJlIHByb3ZpZGVkIGJlbG93OgoK
CUtlcm5lbCBzb3VyY2U6IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92
Ni54L2xpbnV4LTYuNi50YXIuZ3oKCUNvbmZpZyBmaWxlOiBodHRwczovL2dpdGh1Yi5jb20vajFh
a2FpL0tDb25maWdGdXp6X2J1Zy9yYXcvcmVmcy9oZWFkcy9tYWluL3g4Ni82Ni1jb25maWcKCUtl
cm5lbCBsb2c6IGh0dHBzOi8vZ2l0aHViLmNvbS9qMWFrYWkvS0NvbmZpZ0Z1enpfYnVnL3Jhdy9y
ZWZzL2hlYWRzL21haW4veDg2L2NyYXNoZXMtcGFydDEvMDA5NF9hYTViNDM2Yjc4Y2U0MzJlYjlm
YTIzYmYxNDEwNTg4OWMwODI1OTkwL3g4Nl82Ml82Nl9zeXprYWxsZXJfMDkwMV82LjZfeWluL3Jl
cG9ydDAKClRoZSByZXBvcnRzIGluZGljYXRlIHRoYXQgaGNpX2NoYW4gd2FzIGFsbG9jYXRlZCBp
biBoY2lfY2hhbl9jcmVhdGUoKSBhbmQgbGF0ZXIgZnJlZWQgaW4gaGNpX2NoYW5fY2xlYW51cCgp
LCB3aGlsZSBhIHBlbmRpbmcgTDJDQVAgd29yayBxdWV1ZSBjYWxsYmFjayAobDJjYXBfaW5mb190
aW1lb3V0KSBjb250aW51ZWQgdG8gYWNjZXNzIHRoaXMgb2JqZWN0IGFuZCBpbnZva2VkIGhjaV9z
ZW5kX2FjbCgpLCByZXN1bHRpbmcgaW4gYSB1c2UtYWZ0ZXItZnJlZSByZWFkLiAKQWZ0ZXIgY2hl
Y2tpbmcgcmVsZXZhbnQgY29kZSBvbiBtYWlubGluZSwgaXQgc2VlbXMgdGhvdWdoIHRoZXJlIGFy
ZSBzb21lIGFkZGl0aW9uYWwgY2hlY2tzLCBub25lIG9mIHRoZW0gaW52b2x2ZSBjaGVja2luZyB3
aGV0aGVyIGhjaV9jaGFuIGlzIGVtcHR5LgoKSeKAmW0gY3VycmVudGx5IG9ubHkgcmVwb3J0aW5n
IHRoZSBpc3N1ZSB0byB0aGUgY29tbXVuaXR5OyB0aGUgZXhhY3QgZml4IHdpbGwgbGlrZWx5IG5l
ZWQgY29uZmlybWF0aW9uIGFuZCByZXZpZXcgZnJvbSB0aGUgQmx1ZXRvb3RoIG1haW50YWluZXJz
Lg0KDQo=
