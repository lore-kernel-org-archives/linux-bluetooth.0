Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 5 Jul 2011 10:55:45 -0400
Subject: Re: [PATCH v2 1/1] Bluetooth: l2cap: fix NULL ACL packet handling
Message-ID: <1309877745.4125.7.camel@THOR>
References: <1309628689.22449.12.camel@THOR>
	 <1309644714.21109.7.camel@aeonflux>
In-Reply-To: <1309644714.21109.7.camel@aeonflux>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

T24gU2F0LCAyMDExLTA3LTAyIGF0IDE4OjExIC0wNDAwLCBNYXJjZWwgSG9sdG1hbm4gd3JvdGU6
DQo+IEhpIFBldGVyLA0KPiANCj4gPiAgLyogLS0tLSBIQ0kgSW9jdGwgcmVxdWVzdHMgc3RydWN0
dXJlcyAtLS0tICovDQo+ID4gIHN0cnVjdCBoY2lfZGV2X3N0YXRzIHsNCj4gPiArCV9fdTMyIG51
bGxfcng7CQkvKiAjIE5VTEwgcGt0cyByZWN2ZCAqLw0KPiA+ICAJX191MzIgZXJyX3J4Ow0KPiA+
ICAJX191MzIgZXJyX3R4Ow0KPiA+ICAJX191MzIgY21kX3R4Ow0KPiANCj4geW91IGNhbiBub3Qg
ZG8gaXQgbGlrZSB0aGlzLiBUaGlzIHdpbGwgYnJlYWsgdXNlcnNwYWNlIEFQSS9BQkkuDQoNClRo
YW5rcyBmb3IgdGhlIGRlZmluaXRpdmUgYW5zd2VyLCBNYXJjZWwuDQoNCkkgc3VzcGVjdGVkIGFz
IG11Y2ggKHdoaWNoIGlzIHdoeSBJIG5vdGVkIGluIHRoZSBhY2NvbXBhbnlpbmcgY292ZXIgdGhh
dA0KdGhpcyB3b3VsZCBiZSBpbmNvbXBhdGlibGUgd2l0aCBwcmV2aW91cyB1c2Vyc3BhY2UgdmVy
c2lvbnMgb2YgdGhpcw0KaW9jdGwpLg0KDQpJcyB0aGUgZ2VuZXJhbCBwbGFuIHRoZW4gdG8gZnJl
ZXplIHRoZSBleGlzdGluZyByYXcgSENJIGludGVyZmFjZSBhbmQNCm9ubHkgaW1wbGVtZW50IG5l
dyB1c2Vyc3BhY2UgPC0+IGtlcm5lbCBpbnRlcmZhY2VzIG9uIG1nbXRvcHM/DQoNClJlZ2FyZHMs
DQpQZXRlcg0KDQoNCg==
