Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>, Lubomir Rintel <lkundrak@v3.sk>
CC: David Woodhouse <dwmw2@infradead.org>, Ben Hutchings
	<ben@decadent.org.uk>, "libertas-dev@lists.infradead.org"
	<libertas-dev@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Date: Tue, 8 Jan 2013 18:43:23 -0800
Subject: RE: [PATCH] Bluetooth: btmrvl_sdio: look for sd8688 firmware in
 alternate place
Message-ID: <477F20668A386D41ADCC57781B1F70430D13FDB783@SC-VEXCH1.marvell.com>
References: <1357689361-7969-1-git-send-email-lkundrak@v3.sk>
	 <1357689361-7969-2-git-send-email-lkundrak@v3.sk>
 <1357698538.1806.43.camel@aeonflux>
In-Reply-To: <1357698538.1806.43.camel@aeonflux>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

DQo+ID4gbGludXgtZmlybXdhcmUgc2hpcHMgdGhlIHNkODY4OCogZmlybXdhcmUgaW1hZ2VzIHRo
YXQgYXJlIHNoYXJlZCB3aXRoDQo+ID4gbGliZXJ0YXNfc2RpbyBXaUZpIGRyaXZlciB1bmRlciBs
aWJlcnRhcy8uIGxpYmVydGFzX3NkaW8gbG9va3MgaW4gYm90aCBwbGFjZXMNCj4gPiBhbmQgc28g
c2hvdWxkIHdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVib21pciBSaW50ZWwgPGxrdW5k
cmFrQHYzLnNrPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2JsdWV0b290aC9idG1ydmxfc2Rpby5j
IHwgICAyNCArKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgv
YnRtcnZsX3NkaW8uaCB8ICAgIDYgKysrKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IE5BSyBmcm9tIG1lIG9uIHRoaXMgb25l
LiBJIGRvIG5vdCB3YW50IHRoZSBkcml2ZXIgdG8gY2hlY2sgdHdvDQo+IGxvY2F0aW9ucy4gVGhh
dCBpcyB3aGF0IHVzZXJzcGFjZSBjYW4gd29yayBhcm91bmQuDQo+IA0KPiBJZiB3ZSB3YW50IHRv
IHVuaWZ5IHRoZSBsb2NhdGlvbiBiZXR3ZWVuIHRoZSBXaUZpIGRyaXZlciBhbmQgdGhlDQo+IEJs
dWV0b290aCBkcml2ZXIsIEkgYW0gZmluZSB3aXRoIHRoYXQsIGJ1dCBzZXJpb3VzbHksIGp1c3Qg
cGljayBvbmUgb3Zlcg0KPiB0aGUgb3RoZXIuIEkgZG8gbm90IGNhcmUgd2hpY2ggb25lLg0KDQpU
aGUgdW5pZmllZCBsb2NhdGlvbiBpcyBtcnZsLyBkaXJlY3RvcnkuDQoNCldlIGNhbiBwcm9iYWJs
eSBtb3ZlIFNEODY4OCBmaXJtd2FyZSAmIGhlbHBlciBiaW5hcmllcyB0byBtcnZsLyBhbmQgaGF2
ZSBib3RoIGRyaXZlcnMgZ3JhYiB0aGUgaW1hZ2VzIHRoZXJlPw0KDQpSZWdhcmRzLA0KQmluZw0K
DQo=
