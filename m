Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BB55C1A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910404; cv=none; b=H9YH9ALKFuG+8UCrvWbw9GljyH6PjheWnenlKDzhuysMxMmHXzlnuJQa2b/6Zx21E8JkV5TtgJqXgpLLu8RK3RehnF9TpM/ZtILgFpuEx9KgmM7S4Ug/AzEj5cDOn/KaI6RMWxDt9E975N6oKNpiZD1IfdUMuPeOVegTI0ZJ1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910404; c=relaxed/simple;
	bh=6n5RDWmRQuoj91gup8D+puR4xQRPspEoKI7vKoC0C3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lr6oT6xk5ozKSaeJfUqWPeh32HjhWFGJk/giRC3VLTQ9cIXXZhEs0RwoeC05MGhfJG7la4PXOnhD/InROGqTXN+xvAL13kIhH1CgNQrxizVGgMwmYIO+ZKoij9hH/ZLZHjtbbBhqLzNCpzXYieqq0r/+Aech6yCPkUBoZBPd6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4BFEE000C;
	Tue,  2 Jul 2024 08:53:20 +0000 (UTC)
Message-ID: <25466726f9dab96e00823ebceeb1916497097ffe.camel@hadess.net>
Subject: Re: [BlueZ 9/9] avdtp: Fix manipulating struct as an array
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Tue, 02 Jul 2024 10:53:20 +0200
In-Reply-To: <CABBYNZJB5kYZd5=jEz6sC5TOe9EMphMDBkKgHGjpTf_AH8fXdQ@mail.gmail.com>
References: <20240530150057.444585-1-hadess@hadess.net>
	 <20240530150057.444585-10-hadess@hadess.net>
	 <8c979897beeb8316616bb7c15f60093be177577c.camel@iki.fi>
	 <727c93065d8d1e56e9fcd5b5bed724d63dfbe871.camel@hadess.net>
	 <CABBYNZJB5kYZd5=jEz6sC5TOe9EMphMDBkKgHGjpTf_AH8fXdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

T24gTW9uLCAyMDI0LTA2LTAzIGF0IDE1OjE5IC0wNDAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOgo+IEhpIEJhc3RpZW4sCj4gCj4gT24gRnJpLCBNYXkgMzEsIDIwMjQgYXQgMTE6NTHi
gK9BTSBCYXN0aWVuIE5vY2VyYSA8aGFkZXNzQGhhZGVzcy5uZXQ+Cj4gd3JvdGU6Cj4gPiAKPiA+
IE9uIFRodSwgMjAyNC0wNS0zMCBhdCAxOTo1NyArMDMwMCwgUGF1bGkgVmlydGFuZW4gd3JvdGU6
Cj4gPiA+IEhpLAo+ID4gPiAKPiA+ID4gdG8sIDIwMjQtMDUtMzAga2VsbG8gMTY6NTggKzAyMDAs
IEJhc3RpZW4gTm9jZXJhIGtpcmpvaXR0aToKPiA+ID4gPiBEb24ndCBtYW5pcHVsYXRlIHRoZSAi
cmVxIiBzdHJ1Y3RzIGFzIGlmIHRoZXkgd2VyZSBmbGF0IGFycmF5cywKPiA+ID4gPiBzdGF0aWMK
PiA+ID4gPiBhbmFseXNpcyBhbmQgaHVtYW5zIGFyZSBib3RoIGVxdWFsbHkgY29uZnVzZWQgYnkg
dGhpcyBraW5kIG9mCj4gPiA+ID4gdXNhZ2UuCj4gPiA+IAo+ID4gPiBzdHJ1Y3Qgc3RhcnRfcmVx
IHsKPiA+ID4gwqDCoMKgwqDCoCB1bmlvbiB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBzZWlkIHJlcXVpcmVkWzFdOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3Qgc2VpZCBzZWlkc1swXTsKPiA+ID4gwqDCoMKgwqDCoCB9Owo+ID4gPiB9IF9f
YXR0cmlidXRlX18gKChwYWNrZWQpKTsKPiA+ID4gCj4gPiA+IGFuZCBhY2Nlc3Mgb25seSB2aWEg
cmVxLT5zZWlkcz8KPiA+IAo+ID4gVGhhdCdzIGEgZ29vZCBpZGVhLCBJJ2xsIGdpdmUgaXQgYSB0
cnkuCj4gPiAKPiA+ID4gPHNuaXA+Cj4gPiA+ID4gKyNkZWZpbmUKPiA+ID4gPiBSRVFfR0VUX05U
SF9TRUlEKHgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gPiA+ICvCoMKgIHN0YXRpYyBz
dHJ1Y3Qgc2VpZAo+ID4gPiA+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gPiA+
ICvCoMKgIHgjI19yZXFfZ2V0X250aF9zZWlkKHN0cnVjdCB4IyNfcmVxICpyZXEsIGludCBjb3Vu
dCwgaW50Cj4gPiA+ID4gaSnCoCBcCj4gPiA+ID4gK8KgwqAgewo+ID4gPiA+IMKgwqDCoCBcCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjb3VudCA9PSAwIHx8IGkgPj0KPiA+ID4g
PiBjb3VudCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybgo+ID4gPiA+IE5VTEw7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChpID09Cj4gPiA+ID4gMSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAmcmVxLQo+ID4gPiA+ID4gZmlyc3Rfc2VpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
ICZyZXEtCj4gPiA+ID4gPiBvdGhlcl9zZWlkc1tpXTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gPiAKPiA+ID4gKGkgPT0gMCkgYW5k
IFtpIC0gMV0/Cj4gPiAKPiA+ICpmYWNlcGFsbSoKPiA+IAo+ID4gWWVzLCB0aGlzIHdpbGwgbmVl
ZCBhIHYyLCB0aGFua3MgZm9yIHNwb3R0aW5nIHRoYXQuCj4gCj4gSXZlIGFwcGxpZWQgdGhlIHNl
dCBleGNlcHQgZm9yIHRoaXMgb25lLCBwbGVhc2UgcmVzZW5kIG9uY2UgeW91IGFyZQo+IGRvbmUg
d2l0aCB0aGUgc3VnZ2VzdGVkIGNoYW5nZXMuCgpJJ3ZlIHJlZG9uZSB0aGlzIHBhdGNoLCBpdCdz
IG5vdyBpbjoKaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9s
aXN0Lz9zZXJpZXM9ODY3NDQ4Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsdWV0b290
aC8yMDI0MDcwMjA4NDkwMC43NzM2MjAtMy1oYWRlc3NAaGFkZXNzLm5ldC9ULyN1CgpUaGFua3Mg
dG8gUGF1bGkgZm9yIHRoZSBoZWxwLgoKPiAKCg==

