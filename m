Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7AC387373
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268068; cv=none; b=j1s0L/QCiyZmFwsc0PRNhzHBHnHeHXn1uEXf5ZZzJKGWc+tvy3aMGuoJipP/QTIJo32Mgl86nDQS/REZi9oqK2pPiaMA2ayDXhdzdBcW/gbhxYyU/x01GizojFRzRdZZ0JqQR27u4yQGWO0/PeMWX+PxVEipt3SO1lTCtXguHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268068; c=relaxed/simple;
	bh=8qam5LbqlPURVPIrnSunr0aifL5l8w8dbVZQ0BWSUtg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=TAIVye7ie2tIN7q+V7Sd6QEMxpFnKKVo9wKNWVtacVpqg1AeBs+qK4AbtXqnAshf9gPICH26Sd2D+JmPsSxt1xnfigq5bIgUQABCyxLVDvaexDTokfyIrxKvRd6QFRkyHLHwSSl683g946woUJ3M8ilPJmIPvxz/fn86vpkCro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=oNjPu3T4; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="oNjPu3T4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792268050; x=1792527250;
	bh=8qam5LbqlPURVPIrnSunr0aifL5l8w8dbVZQ0BWSUtg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oNjPu3T47ZT7W3ozsBmjjt3eggTcFkTd4k6dotDI+ee5Ehf4CY5k9MxR5tvSStaQX
	 NzEYdigZkcuNwD8jkiYec1GkiSCVFba3mUYYcEpc2RDqlkXko6tTcuJt7gEaYv4akI
	 bnViE1Qh7Mtqw2EjXZU3xvEzGzDwmd+gJMqD9lBPBhNTEuGsF1yn80s5xlNGqm4vEn
	 Q+O2LPi14rmcCpUwbPobgK2BE7A+PFF4fKpPN/Fv3yHRWPoZ+JEZk7RWv0W0X86r1k
	 cnsqf0287lTC35/nCB6AfH2uwmkn5/oxlv3nX7ZaoQuQ0goO7y/v7JwcME3iYBFUl3
	 pd2P5tsFJo1+g==
Date: Sat, 17 Oct 2026 20:14:06 +0000
To: linux-bluetooth@vger.kernel.org
From: wonkru-dev@proton.me
Subject: [BlueZ] build: Do not regenerate internal ELL headers with external ELL
Message-ID: <X5NYZHGSaimprKHVFhopOLVmmlI95TooO7oJcNid-yDh-wyxZ1IYeDg9TEkt28iU6_I4njm0J8b-Yq8NXxDrbWaAx1fuxArrEm5UgwOVJ1g=@proton.me>
Feedback-ID: 220953440:user:proton
X-Pm-Message-ID: b47f756386ece4d6fcb5e4dd4e33287dea2fc4b8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY"

--b1=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY
Content-Type: multipart/alternative;
 boundary="b2=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY"

--b2=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

RW1wdHkgTWVzc2FnZQ==

--b2=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdj5FbXB0eSBNZXNzYWdlPC9kaXY+


--b2=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY--

--b1=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY
Content-Type: text/x-patch; name=0001-Do-not-regenerate-internal-ELL-headers-with-external.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Do-not-regenerate-internal-ELL-headers-with-external.patch

RnJvbSBiYjczYjg0NGM1ODg0ZGIyNjljMzc4MmExMzIyZGJhMDhmZWJlNWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWeWxlbiBMaW51eCBUZWFtIDx3b25rcnUtZGV2QHByb3Rvbi5t
ZT4KRGF0ZTogU2F0LCAxNyBPY3QgMjAyNiAxODozNTo0OCArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
Qmx1ZVpdIGJ1aWxkOiBEbyBub3QgcmVnZW5lcmF0ZSBpbnRlcm5hbCBFTEwgaGVhZGVycyB3aXRo
IGV4dGVybmFsIEVMTAoKLS0tCiBNYWtlZmlsZS5hbSB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5h
bQotLS0gYS9NYWtlZmlsZS5hbQkyMDI2LTEwLTE3IDIyOjA5OjQ2LjcxMzg4NDU0NSArMDIwMAor
KysgYi9NYWtlZmlsZS5hbQkyMDI2LTEwLTE3IDIyOjA4OjQxLjYxNzAwMDAwMCArMDIwMApAQCAt
ODUwLDggKzg1MCwxMiBAQAogaWYgTUVTSAogdW5pdF90ZXN0cyArPSB1bml0L3Rlc3QtbWVzaC1j
cnlwdG8KIHVuaXRfdGVzdF9tZXNoX2NyeXB0b19DUFBGTEFHUyA9ICQoZWxsX2NmbGFncykKK2lm
IEVYVEVSTkFMX0VMTAordW5pdF90ZXN0X21lc2hfY3J5cHRvX1NPVVJDRVMgPSB1bml0L3Rlc3Qt
bWVzaC1jcnlwdG8uYyBtZXNoL2NyeXB0by5oCitlbHNlCiB1bml0X3Rlc3RfbWVzaF9jcnlwdG9f
U09VUkNFUyA9IHVuaXQvdGVzdC1tZXNoLWNyeXB0by5jIFwKIAkJCQltZXNoL2NyeXB0by5oIGVs
bC9pbnRlcm5hbCBlbGwvZWxsLmgKK2VuZGlmCiB1bml0X3Rlc3RfbWVzaF9jcnlwdG9fTERBREQg
PSAkKGVsbF9sZGFkZCkKIGVuZGlmCiAKQEAgLTk3MywxMSArOTc3LDEzIEBACiAJCWZpIFwKIAlk
b25lID4gJEAKIAoraWYgIUVYVEVSTkFMX0VMTAogZWxsL2VsbC5oOiBNYWtlZmlsZQogCSQoQU1f
Vl9hdCllY2hvIC1uID4gJEAKIAkkKEFNX1ZfR0VOKWZvciBmIGluICQoZWxsX2hlYWRlcnMpIDsg
ZG8gXAogCQllY2hvICIjaW5jbHVkZSA8JCRmPiIgPj4gJEAgOyBcCiAJZG9uZQorZW5kaWYKIAog
bWFpbnRhaW5lci1jbGVhbi1sb2NhbDoKIAktcm0gLXJmIGVsbAo=

--b1=_DhH58IQ67dRpFmfbE3gVET6cc7382JGTI61Y7tzwY--

