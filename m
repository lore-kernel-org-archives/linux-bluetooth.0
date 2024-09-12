Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B34AEF4
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157619; cv=none; b=KQdDsWtkOcNVJ5NxRsf/qRSa2FSkuzAhixCNuGF5No0W9FZZmHMZctWlIHcP2uaa6kxhGKGSkR9dMt9y+YS2GDOadveNNQ7Bfab40TiJfMpZ1eWQLd5jrKyDNWEdq6K6cN6A296nLlHD9tjW7zu3tlmngaSQEFzG0LjJU9nIG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157619; c=relaxed/simple;
	bh=CLPSzaGY0cpcg6TWMceV1dleQN1fJei7CaphiN5rIYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UafV4ovYKVt7QK0L7GS+TXoWF203ZgECbIO/PEP6dK/oKQ31I+0kG45G87a6YJgNS40uhNuUP3YZikueqv2d7peTBmAQe8sVzoerlvGoa4qEewrkWyF6bsIaH6UJomdX61CyEgpcOYSANF3kLDdyajiouMDhFVTAiQT7UGSwmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F9612000E;
	Thu, 12 Sep 2024 16:13:35 +0000 (UTC)
Message-ID: <4aa63c7d4fc4409152189bd7bf3200cfc3b7ebed.camel@hadess.net>
Subject: Re: [BlueZ 3/3] shared/shell: Exit after printing the help
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 12 Sep 2024 18:13:30 +0200
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
b3UgbWlnaHQgd2FudCB0byBhZGQgcHJpbnRfY21kcyBjYWxsLgoKSSdsbCBuZWVkIHRvIGNvbWUg
YmFjayB0byB0aGlzLgoKYnRfc2hlbGxfaW5pdCgpIGlzIGNhbGxlZCBiZWZvcmUgdGhlIHN1Ym1l
bnVzIGFyZSBhZGRlZCwgc28gSSBjYW4ndApjYWxsIHByaW50X2NtZHMoKSBhdCB0aGF0IHBvaW50
LCBJJ2xsIG5lZWQgdG8gcG9zdHBvbmUgdGhlIGV4aXQgdW50aWwKYWZ0ZXIgdGhlIG1lbnVzIGFy
ZSByZWdpc3RlcmVkIGFuZCB0aGVpciBoZWxwIHByaW50ZWQuCgo+IAo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAncyc6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChvcHRhcmcgJiYgZGF0YS5pbml0X2ZkIDwg
MCkgewo+ID4gLS0KPiA+IDIuNDYuMAo+ID4gCj4gPiAKPiAKPiAKCg==

