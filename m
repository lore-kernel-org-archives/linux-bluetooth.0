Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316B196DA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599864; cv=none; b=Mia5z4sg1S10hUSRwOCyueZ58OaHzChKE2D22RD1sU9yR5idYKaHgRwOrrTw7/vkusHz2rCttWRI4taBHKYkqePweYaDdrco0eyv1gIKyUP9XEpM4DfmgvE7Nn8zgIu9xOIzZntlp5r+txRdlV4n9mfjo6wCRaX/1BSmaILHaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599864; c=relaxed/simple;
	bh=DbfET96DUO08kmGkJPokrrFmsArFdhdqYg+kny4hass=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4pvdACJsSj5gWgx9IreG9F1vcizQtbBaAKwCeoe+kB0ZP16VGk/yNnP8Y0cwa1EcUFsmnx/YsRFcx8Ch9YKlBt/LuV5VZuKZIzafP71obktd17R/Uy1HMITfNjt2RxkGvlgsc+1GQeRunp1rYqC6g/PsbIzoP2gQA8CpYHV4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C38C40003;
	Tue, 22 Oct 2024 12:24:20 +0000 (UTC)
Message-ID: <6d920d0d89a20adee6794d3342e7342b0d7fd0ff.camel@hadess.net>
Subject: Re: [BlueZ 3/3] shared/shell: Exit after printing the help
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Oct 2024 14:24:20 +0200
In-Reply-To: <CABBYNZLNDSsJmb=JpY=ObK-1DeJ2gc3L0pAaDN3sSP8BOzCC0g@mail.gmail.com>
References: <20240912092253.119754-1-hadess@hadess.net>
	 <20240912092253.119754-4-hadess@hadess.net>
	 <CABBYNZLNDSsJmb=JpY=ObK-1DeJ2gc3L0pAaDN3sSP8BOzCC0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

T24gVGh1LCAyMDI0LTA5LTEyIGF0IDExOjExIC0wNDAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOgo+IEhpIEJhc3RpZW4sCj4gCj4gT24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgNToyOeKA
r0FNIEJhc3RpZW4gTm9jZXJhIDxoYWRlc3NAaGFkZXNzLm5ldD4KPiB3cm90ZToKPiA+IAo+ID4g
RXhpdCBhZnRlciBoYW5kbGluZyAtLWhlbHAsIHNvIGFzIHRvIGF2b2lkIHRoZSBkYWVtb24gd2Fp
dGluZyB0bwo+ID4gY29tbXVuaWNhdGUgd2l0aCBhIEQtQnVzIHNlcnZpY2UgdGhhdCBtaWdodCBu
b3QgYmUgcnVubmluZy4KPiA+IC0tLQo+ID4gwqBzcmMvc2hhcmVkL3NoZWxsLmMgfCA0ICstLS0K
PiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvc3JjL3NoYXJlZC9zaGVsbC5jIGIvc3JjL3NoYXJlZC9zaGVsbC5j
Cj4gPiBpbmRleCBjMzE0ODcxOTBkMGYuLmY3ZThiMzMwMDM3MyAxMDA2NDQKPiA+IC0tLSBhL3Ny
Yy9zaGFyZWQvc2hlbGwuYwo+ID4gKysrIGIvc3JjL3NoYXJlZC9zaGVsbC5jCj4gPiBAQCAtMTMy
NCw5ICsxMzI0LDcgQEAgdm9pZCBidF9zaGVsbF9pbml0KGludCBhcmdjLCBjaGFyICoqYXJndiwK
PiA+IGNvbnN0IHN0cnVjdCBidF9zaGVsbF9vcHQgKm9wdCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNhc2UgJ2gnOgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1c2FnZShhcmdjLCBhcmd2LCBvcHQpOwo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRhdGEuYXJnYyA9IDE7Cj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS5hcmd2ID0g
JmNtcGx0Owo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRhdGEubW9kZSA9IDE7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZXhpdChFWElUX1NVQ0NFU1MpOwo+IAo+IFRoaXMgd291bGQgdW5kbyBzaGFyZWQv
c2hlbGw6IFByaW50IGNvbW1hbmRzIHdoZW4gLS1oZWxwIG9wdGlvbiBpcwo+IGdpdmVuLCBzbyB5
b3UgbWlnaHQgd2FudCB0byBhZGQgcHJpbnRfY21kcyBjYWxsLgoKVGhhdCB3YXNuJ3QgZW5vdWdo
LCBiZWNhdXNlIHRoZSBtZW51IGluZm8gaXNuJ3QgcG9wdWxhdGVkIGF0IHRoaXMKcG9pbnQsIHNv
IHdlJ2Qgb25seSBnZXQgdGhlIHRvcC1sZXZlbCBoZWxwLiBJdCB3YXMgcXVpdGUgYSBiaXQgbW9y
ZQppbnZvbHZlZCwgYnV0IEkgaG9wZSBJIGdvdCBhbGwgdmFyaWFudHMgY292ZXJlZCBpbiB0aGUg
djIgcGF0Y2hzZXQuCgpDaGVlcnMKCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjYXNlICdzJzoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKG9wdGFyZyAmJiBkYXRhLmluaXRfZmQgPCAwKSB7Cj4gPiAtLQo+ID4g
Mi40Ni4wCj4gPiAKPiA+IAo+IAo+IAoK

