Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B63909B5
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262388; cv=none; b=h4rvksmQ1ua8s8yRew5x/7XzxjBcYZalwDDORw6GaXkq6ivpB/s5hcm08fxJXwKB3sv8MSQjqhuZ/A9dYlEMhBfAabBYFC5Y2Xt9mSl0bZvicBSUxqghLVZeq7Nxlpo0nmEEIuI5V3Z3GqAeWJ63KEASqc5+ON9nS7rXtyV3Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262388; c=relaxed/simple;
	bh=akh/56Yw94wkRry0AovN9rjpnKvaCzb8QNThsPUKTqU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=OeQtlHSu7230u1u5c2gVfauH18bESzHXlh6dq4AIFWIkOUv5f818Luj0rM7/Z2tgdQT2R/CozA0/F6bM8zNMM/HM9x+K2dycjWQjlLDS1ePKJNld2mBacGFpj2AdfT8oXEOb+bKvxKnMEtM8gRz8ISWM7irFkrpvHB+HrLaYfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=yB5cMpNx; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="yB5cMpNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=nq7zwbmlmratrdeyhgoutmblnm.protonmail2; t=1792262373;
	x=1792521573; bh=akh/56Yw94wkRry0AovN9rjpnKvaCzb8QNThsPUKTqU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=yB5cMpNxXarvlJXM5A3OsdjY3XOutAD/PDazHqLu6V6jjncy//1AzosU3MQWVTZ2r
	 7nQtT2ndgzk7fGaP64q3vJ1NLyPNk2qttNAEh0sZG8TLM7LGRydEoc7s05shGfgEwC
	 AwlncRApEZIP/Ua8HFsCSxFUcWcW42Qnk3L6OVotoywhHlRmsD+Y1ZHxhq+K5KVW45
	 QPJ1LPLFSK4AIt/+N9go6txC7Dcam8P669NAik9ILt5tOEn20FYXCWrpgUlaEdMTk5
	 ZlH/adEtz9WYMl0hsQl6MNdnSWAhyyJHCO7shCB7bU9Mod5jv/OBv77H9sQFbIQ5QL
	 6DdRKb4xsixMQ==
Date: Sat, 17 Oct 2026 18:39:28 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: wonkru-dev@proton.me
Subject: [PATCH BlueZ] build: Do not regenerate internal ELL headers with external ELL
Message-ID: <x_EJuUS4KOJ6yHSe5ZA9ec4KemaHtdtTbgUuuJapF1iyjOWRcoz0WkTMwRnZD2b3_dY5baLu3artXUCE52dZF1lo5xAn2_sU01Di8oPiuUE=@proton.me>
Feedback-ID: 220953440:user:proton
X-Pm-Message-ID: ea57827344b1ebe1b6329ba5cd31d2d11a766152
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs"

--b1=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs
Content-Type: multipart/alternative;
 boundary="b2=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs"

--b2=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

RW1wdHkgTWVzc2FnZQ==

--b2=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdj5FbXB0eSBNZXNzYWdlPC9kaXY+


--b2=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs--

--b1=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs
Content-Type: text/x-patch; name=0001-Do-not-regenerate-internal-ELL-headers-with-external.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Do-not-regenerate-internal-ELL-headers-with-external.patch

RnJvbSBiYjczYjg0NGM1ODg0ZGIyNjljMzc4MmExMzIyZGJhMDhmZWJlNWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBvbGQgPDE1Mjg1MDY5MytDZWxlc3RpZnlYQHVzZXJzLm5vcmVw
bHkuZ2l0aHViLmNvbT4KRGF0ZTogU2F0LCAxNyBPY3QgMjAyNiAxODozNTo0OCArMDIwMApTdWJq
ZWN0OiBbUEFUQ0ggQmx1ZVpdIGJ1aWxkOiBEbyBub3QgcmVnZW5lcmF0ZSBpbnRlcm5hbCBFTEwg
aGVhZGVycyB3aXRoIGV4dGVybmFsIEVMTAoKLS0tCiBNYWtlZmlsZS5hbSB8IDYgKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0g
Yi9NYWtlZmlsZS5hbQppbmRleCBmNzQyNDU4ZDEuLmYzYTZkZWVmNiAxMDA2NDQKLS0tIGEvTWFr
ZWZpbGUuYW0KKysrIGIvTWFrZWZpbGUuYW0KQEAgLTg1MCw4ICs4NTAsMTIgQEAgZW5kaWYKIGlm
IE1FU0gKIHVuaXRfdGVzdHMgKz0gdW5pdC90ZXN0LW1lc2gtY3J5cHRvCiB1bml0X3Rlc3RfbWVz
aF9jcnlwdG9fQ1BQRkxBR1MgPSAkKGVsbF9jZmxhZ3MpCitpZiBFWFRFUk5BTF9FTEwKK3VuaXRf
dGVzdF9tZXNoX2NyeXB0b19TT1VSQ0VTID0gdW5pdC90ZXN0LW1lc2gtY3J5cHRvLmMgbWVzaC9j
cnlwdG8uaAorZWxzZQogdW5pdF90ZXN0X21lc2hfY3J5cHRvX1NPVVJDRVMgPSB1bml0L3Rlc3Qt
bWVzaC1jcnlwdG8uYyBcCiAJCQkJbWVzaC9jcnlwdG8uaCBlbGwvaW50ZXJuYWwgZWxsL2VsbC5o
CitlbmRpZgogdW5pdF90ZXN0X21lc2hfY3J5cHRvX0xEQUREID0gJChlbGxfbGRhZGQpCiBlbmRp
ZgogCkBAIC05NzMsMTEgKzk3NywxMyBAQCBlbGwvaW50ZXJuYWw6IE1ha2VmaWxlCiAJCWZpIFwK
IAlkb25lID4gJEAKIAoraWYgIUVYVEVSTkFMX0VMTAogZWxsL2VsbC5oOiBNYWtlZmlsZQogCSQo
QU1fVl9hdCllY2hvIC1uID4gJEAKIAkkKEFNX1ZfR0VOKWZvciBmIGluICQoZWxsX2hlYWRlcnMp
IDsgZG8gXAogCQllY2hvICIjaW5jbHVkZSA8JCRmPiIgPj4gJEAgOyBcCiAJZG9uZQorZW5kaWYK
IAogbWFpbnRhaW5lci1jbGVhbi1sb2NhbDoKIAktcm0gLXJmIGVsbAotLSAKMi41NS4wCgo=

--b1=_oOrNuvImwQugl2ENHefK01doZfn51NqxCLP6LRWAs--

