Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2052853E0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429895; cv=pass; b=ErhzREzwSiGeGxmKaI89sO4prUhR8Eb1kFXfzdt4kjaEz0kdbJuZHEHNTFnit4xbLpVwhTD5MVIDPZyMVvdt/93ho6NxajRYp+5eWLNH8Fr8kgTvmr0I3SH9lf6+pAkoXh2kyZzTo3+oMWEGjUtZnB6J7ejPvnQOw9EdeILUsEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429895; c=relaxed/simple;
	bh=7ByGhAvSA43lq7ggrAYYLUgf3ZISHCJvTiITNBsbYE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWNWFSiJease5kivanFfP11K9+siex4Pd+zXokV99nYhV6crp4I9wvBftriEHUGFzSO/TtC0qiYEpcXq9QOIu09SV3ODuTqoW2EoxmSBDJboqwV6/zqLucjjVsd4ewPM/1IDFVW89p8DZN1gq31aEUlH+WqqO7ReS3mSvtniQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lD4dxCG7; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tUsmWvlE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lD4dxCG7";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tUsmWvlE"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4gVM0G0vvVz49Q1q
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 22:51:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1780429886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ByGhAvSA43lq7ggrAYYLUgf3ZISHCJvTiITNBsbYE8=;
	b=lD4dxCG79q+9jRwnSB9jV9DtT8YA6x7i5bFk1/MlJWhyCc6qDC3mo9CHVG7JaeUHdj0T7f
	qYrRtJ85jXDZ+qgPiCoJcoW3OTHDtrgctwIU49/7iMSNwujy3Ed3jvfH1B26rmiNKMnOSY
	oNgm+8roUYOP+UIzjrtxRC2ODnwibmC+8zpurXCA5BAqxSwGMDJOZp+FA04M7FN7iQbZQq
	Sz04o4pCBry6IRuMYRkYj1dweQ11op8Q0SsvxZNf6UMzLFM51KEPjjHCTceHgPo+dfzc4k
	FBzCeQAyGIAwXx57nIXZsGqnVAyaLt2H51EI0zk4CKe9fyCQQtbtthNhGdpEXg==
Received: from [10.70.165.216] (unknown [193.138.7.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gVM026DkyzyP7;
	Tue, 02 Jun 2026 22:51:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1780429877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ByGhAvSA43lq7ggrAYYLUgf3ZISHCJvTiITNBsbYE8=;
	b=tUsmWvlEM0v0LgsIZaP72/SqNC78oS23eqTtDcQzP7yb/RqA6EeTMBedPVfBlvGwASuufi
	XASDp+lfjYPBVMl8+NGVVm/Vp1mLmDUYEpJzEJLel/XRR5Nbk0CMjHkbNF+ynbnP+b6Ixd
	j/vlCX/97cyGqKWmgwFFbIlM4tFDRSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1780429877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ByGhAvSA43lq7ggrAYYLUgf3ZISHCJvTiITNBsbYE8=;
	b=dlzjFJrigCSu7YxrlvokSnYZjgNlhjQwfA6a9xzvXeS61hl2rfH4n2TDd2nl3UPWMyIECV
	X0m8IkayiyW0HLYpouaVzM6isgsxLFeVa7LMb+TKS/VDydLpLC7hXw64cUhm8LaHJnc2Jf
	iiHyAPIFV7EKOt2AK2QPCbMut1+OGHY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1780429877;
	b=tC8A/2Zux3kt1ieOXULzHiUasKyXUnB3v+CyV2Tqj7Vz2UJ7MuTc4+YqIToWtuxK/w+noJ
	Ktavl/gSG16g3OC/CI6+EB9gEbdWVPSoE3wowOCeG+IH4qZkw5pShI7whNZynfv3v7cxIH
	M2l2YQvYrHrbNl4prodHmVCEG0H8hnQ=
Message-ID: <132073b9a61db8dcd9c85f0b5787200a63a50604.camel@iki.fi>
Subject: Re: [PATCH BlueZ v5 08/16] test-runner: use virtio-serial for
 implementing -u device forwarding
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 02 Jun 2026 19:51:08 +0000
In-Reply-To: <CABBYNZL42S2FKP9EF33i=P5p5ggD4fg2qFkg-NaKAF4h8wD_iw@mail.gmail.com>
References: <cover.1778688966.git.pav@iki.fi>
	 <5d818c768189b6d0a8e5a4b90eb41cc7b9932624.1778688966.git.pav@iki.fi>
	 <CABBYNZL42S2FKP9EF33i=P5p5ggD4fg2qFkg-NaKAF4h8wD_iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTHVpeiwKCnRpLCAyMDI2LTA2LTAyIGtlbGxvIDE1OjM1IC0wNDAwLCBMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6IGtpcmpvaXR0aToKPiBIaSBQYXVsaSwKPiAKPiBPbiBXZWQsIE1heSAxMywgMjAy
NiBhdCAxMjo0OOKAr1BNIFBhdWxpIFZpcnRhbmVuIDxwYXZAaWtpLmZpPiB3cm90ZToKPiA+IAo+
ID4gVXNpbmcgcGNpLXNlcmlhbCB0byBmb3J3YXJkIGVnLiBidHZpcnQgc29ja2V0cyBpcyB1bnJl
bGlhYmxlLCBhcwo+ID4gcWVtdSBvcgo+ID4ga2VybmVsIHNlZW1zIHRvIGJlIHNvbWV0aW1lcyBk
cm9wcGluZyBwYXJ0IG9mIHRoZSBzZW50IGRhdGEgb3IKPiA+IGluc2VydAo+ID4gc3B1cmlvdXMg
XDAgYnl0ZXMsIGxlYWRpbmcgdG8gc3BvcmFkaWMgZXJyb3JzIGxpa2U6Cj4gPiAKPiA+IMKgwqDC
oCBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogY29tbWFuZCAweDBjNTIgdHggdGltZW91dAo+ID4g
wqDCoMKgIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBPcGNvZGUgMHgwYzUyIGZhaWxlZDogLTEx
MAo+ID4gwqDCoMKgIGJ0dmlydDogcGFja2V0IGVycm9yLCB1bmtub3duIHR5cGU6IDAKPiA+IAo+
ID4gVGhpcyBhcHBlYXJzIHRvIG9jY3VyIG1vc3Qgb2Z0ZW4gd2hlbiBob3N0IHN5c3RlbSBpcyB1
bmRlciBsb2FkLAo+ID4gZS5nLgo+ID4gZHVlIHRvIG11bHRpcGxlIHRlc3QtcnVubmVycyBydW5u
aW5nIGF0IHRoZSBzYW1lIHRpbWUuwqAgVGhlIHByb2JsZW0KPiA+IGlzCj4gPiBub3Qgc3BlY2lm
aWMgdG8gYnR2aXJ0LCBidXQgc2VlbXMgdG8gYmUgaW4gdGhlIHFlbXUgc2VyaWFsIGRldmljZQo+
ID4gbGF5ZXIKPiA+IHZzLiBrZXJuZWwgaW50ZXJhY3Rpb24uCj4gPiAKPiA+IENoYW5nZSB0ZXN0
LXJ1bm5lciB0byB1c2UgdmlydHNlcmlhbHBvcnQgdG8gZm9yd2FyZCB0aGUgYnR2aXJ0Cj4gPiBj
b25uZWN0aW9uIGluc2lkZSB0aGUgVk0sIGFzIHZpcnRpby1zZXJpYWwgZG9lc24ndCBhcHBlYXIg
dG8gaGF2ZQo+ID4gdGhlc2UKPiA+IHByb2JsZW1zLgo+ID4gLS0tCj4gPiDCoHRvb2xzL3Rlc3Qt
cnVubmVyLmMgfCAxMyArKysrKysrKystLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0
LXJ1bm5lci5jIGIvdG9vbHMvdGVzdC1ydW5uZXIuYwo+ID4gaW5kZXggYjNlMGIwY2ZlLi4wZTNi
ZmI4YjcgMTAwNjQ0Cj4gPiAtLS0gYS90b29scy90ZXN0LXJ1bm5lci5jCj4gPiArKysgYi90b29s
cy90ZXN0LXJ1bm5lci5jCj4gPiBAQCAtMzA2LDcgKzMwNiw3IEBAIHN0YXRpYyB2b2lkIHN0YXJ0
X3FlbXUodm9pZCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlc3RhcmdzKTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAg
YXJndiA9IGFsbG9jYShzaXplb2YocWVtdV9hcmd2KSArCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNpemVvZihjaGFyICopICogKDYgKyAobnVtX2Rl
dnMgKiA0KSkpICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoc2l6ZW9mKGNoYXIgKikgKiAoOCArIChudW1fZGV2cyAqIDQpKSkgKwo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc2l6ZW9mKGNoYXIgKikg
KiAodXNiX2RldiA/IDQgOiAwKSkgKwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoc2l6ZW9mKGNoYXIgKikgKiBudW1fZXh0cmFfb3B0cykpOwo+ID4g
wqDCoMKgwqDCoMKgwqAgbWVtY3B5KGFyZ3YsIHFlbXVfYXJndiwgc2l6ZW9mKHFlbXVfYXJndikp
Owo+ID4gQEAgLTMzMCwxNCArMzMwLDE5IEBAIHN0YXRpYyB2b2lkIHN0YXJ0X3FlbXUodm9pZCkK
PiA+IMKgwqDCoMKgwqDCoMKgIGFyZ3ZbcG9zKytdID0gIi1hcHBlbmQiOwo+ID4gwqDCoMKgwqDC
oMKgwqAgYXJndltwb3MrK10gPSAoY2hhciAqKSBjbWRsaW5lOwo+ID4gCj4gPiArwqDCoMKgwqDC
oMKgIGlmIChudW1fZGV2cykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJn
dltwb3MrK10gPSAiLWRldmljZSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
cmd2W3BvcysrXSA9ICJ2aXJ0aW8tc2VyaWFsIjsKPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gKwo+
ID4gwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IG51bV9kZXZzOyBpKyspIHsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFyICpjaHJkZXYsICpzZXJkZXY7Cj4gPiAK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaHJkZXYgPSBhbGxvY2EoNDggKyBz
dHJsZW4oZGV2aWNlX3BhdGgpKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
cHJpbnRmKGNocmRldiwgInNvY2tldCxwYXRoPSVzLGlkPWJ0JWQiLAo+ID4gZGV2aWNlX3BhdGgs
IGkpOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXJkZXYgPSBhbGxv
Y2EoNDgpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3ByaW50ZihzZXJkZXYs
ICJwY2ktc2VyaWFsLGNoYXJkZXY9YnQlZCIsIGkpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2VyZGV2ID0gYWxsb2NhKDY0KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNwcmludGYoc2VyZGV2LAo+ID4gInZpcnRjb25zb2xlLGNoYXJkZXY9YnQlZCxuYW1l
PWJ0LiVkIiwgaSwgaSk7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
cmd2W3BvcysrXSA9ICItY2hhcmRldiI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYXJndltwb3MrK10gPSBjaHJkZXY7Cj4gPiBAQCAtOTEwLDcgKzkxNSw3IEBAIHN0YXRpYyB2
b2lkIHJ1bl9jb21tYW5kKGNoYXIgKmNtZG5hbWUsIGNoYXIKPiA+ICpob21lKQo+ID4gwqDCoMKg
wqDCoMKgwqAgfQo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAobnVtX2RldnMpIHsKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm5vZGUgPSAiL2Rldi90dHlT
MSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpub2RlID0g
Ii9kZXYvaHZjMCI7Cj4gCj4gSW0gZ2V0dGluZyBhbmQgZXJyb3Igd2l0aCB0aGVzZSBjaGFuZ2Vz
Ogo+IAo+IEF0dGFjaGluZyBCUi9FRFIgY29udHJvbGxlciB0byAvZGV2L2h2YzAKPiBGYWlsZWQg
dG8gb3BlbiBzZXJpYWwgcG9ydDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+IAo+IEkgdHJp
ZWQgYWRkaW5nIHRoZSBrZXJuZWwgY29uZmlnIG9wdGlvbnMgYnV0IGl0IGRpZG4ndCBtYWtlIGFu
eQo+IGRpZmZlcmVuY2UuCgpXZSBoYXZlIHRlc3QtcnVubmVyIHdpdGggdGhpcyBwYXRjaCBpbiBQ
aXBld2lyZSBDSSwgYW5kIGl0IGlzIHdvcmtpbmcKCmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9waXBld2lyZS9waXBld2lyZS8tL2pvYnMvMTAxMjU2NDQ4CgpvbiBGZWRvcmEgNDQgKyBR
ZW11IDEwLjIuMi4gS2VybmVsIGNvbmZpZ3VyYXRpb24gaXMgaGVyZToKCmh0dHBzOi8vZ2l0aHVi
LmNvbS9wdi9ibHVlei10ZXN0LWZ1bmN0aW9uYWwta2VybmVsL2Jsb2IvbWFpbi90ZXN0ZXIuY29u
ZmlnCgpJJ3ZlIGFsc28gdXNlZCB3aXRoIHRoaXMgZm9yIFVTQiByZWRpcmVjdGlvbi4KCk5vdCBz
dXJlIHdoYXQgaXMgZGlmZmVyZW50IGZvciB5b3UsIGRvIHlvdSBnZXQgYW55IHZpcnRpbyBzZXJp
YWwKZGV2aWNlcyBmcm9tIHRoZSB2aXJ0Y29uc29sZT8KCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGJhc2ljX2ZsYWdzLCBleHRyYV9mbGFnczsKPiA+
IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW50ZigiQXR0YWNoaW5nIEJS
L0VEUiBjb250cm9sbGVyIHRvICVzXG4iLAo+ID4gbm9kZSk7Cj4gPiAtLQo+ID4gMi41NC4wCj4g
PiAKPiA+IAo+IAoKLS0gClBhdWxpIFZpcnRhbmVuCgo=

