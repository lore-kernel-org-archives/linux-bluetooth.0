Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Hedberg, Johan" <johan.hedberg@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/1] mesh: Fixed warning-to-error from GCC 8.1.1
Date: Thu, 23 Aug 2018 20:09:46 +0000
Message-ID: <1535054985.10681.1.camel@intel.com>
References: <20180823191324.12712-1-brian.gix@intel.com>
         <9C902AA8-FEF4-4819-AC35-42B3EC5835EF@holtmann.org>
In-Reply-To: <9C902AA8-FEF4-4819-AC35-42B3EC5835EF@holtmann.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

QWRkcmVzc2VkIGFuZCBwYXRjaCByZWdlbmVyYXRlZA0KDQpPbiBUaHUsIDIwMTgtMDgtMjMgYXQg
MjE6NTcgKzAyMDAsIE1hcmNlbCBIb2x0bWFubiB3cm90ZToNCj4gSGkgQnJpYW4sDQo+IA0KPiA+
IEZpeGVkIGNvbXBpbGVyIGZsYWdnZWQgdW5zYWZlIHVzYWdlIG9mIHN0cm5jcHkNCj4gPiAtLS0N
Cj4gPiBtZXNoL3N0b3JhZ2UuYyB8IDE0ICsrKysrKysrLS0tLS0tDQo+ID4gMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvbWVzaC9zdG9yYWdlLmMgYi9tZXNoL3N0b3JhZ2UuYw0KPiA+IGluZGV4IDg1ZmE4MWRkYS4u
MWJlNDAzMjk3IDEwMDY0NA0KPiA+IC0tLSBhL21lc2gvc3RvcmFnZS5jDQo+ID4gKysrIGIvbWVz
aC9zdG9yYWdlLmMNCj4gPiBAQCAtMjk4LDEzICsyOTgsMTQgQEAgYm9vbCBzdG9yYWdlX3BhcnNl
X2NvbmZpZyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgY29uc3QgY2hhciAqY29uZmlnX25hbWUpDQo+
ID4gCXJlc3VsdCA9IHBhcnNlX2NvbmZpZyhuZXQsIGNvbmZpZ19uYW1lLCBmYWxzZSk7DQo+ID4g
DQo+ID4gCWlmICghcmVzdWx0KSB7DQo+ID4gLQkJY2hhciAqYmFrID0gKGNoYXIgKikgbF9tYWxs
b2Moc3RybGVuKGNvbmZpZ19uYW1lKSArIDUpOw0KPiA+ICsJCXNpemVfdCBsZW4gPSBzdHJsZW4o
Y29uZmlnX25hbWUpICsgNTsNCj4gPiArCQljaGFyICpiYWsgPSAoY2hhciAqKSBsX21hbGxvYyhs
ZW4pOw0KPiANCj4gVGhlIChjaGFyICopIGNhc3QgaXMgdXR0ZXJseSBwb2ludGxlc3Mgc2luY2Ug
bF9tYWxsb2MgcmV0dXJuIHZvaWQgKi4NCj4gDQo+ID4gDQo+ID4gCQlpZiAoIWJhaykNCj4gPiAJ
CQlnb3RvIGRvbmU7DQo+IA0KPiBTbyB3aHkgYXJlIHdlIHN0aWxsIGRvaW5nPyBsX21hbGxvYyB3
aWxsIGFib3J0IGlmIG5vIG1lbW9yeSBjYW4gYmUgYWxsb2NhdGVkLiBXZSBuZWVkIHRvIHN0b3Ag
ZGVhbGluZyB3aXRoDQo+IG1lbW9yeSBhbGxvY2F0aW9uIGVycm9yIGhhbmRsaW5nLiBJZiB5b3Ug
bmVlZCB0aGF0IGxhcmdlIG1lbW9yeSB0aGVuIG1hbGxvYyBzaG91bGQgYmUgdXNlZC4gSWYgeW91
IHVzZQ0KPiBsX21hbGxvYyB0aGVuIGV4cGVjdCB0aGUgZGFlbW9uIG1pZ2h0IGJlIGtpbGxlZC4g
V2hpY2ggaXMgZmluZSBzeXN0ZW1kIGNhbiByZXN0YXJ0IGl0Lg0KPiANCj4gUmVnYXJkcw0KPiAN
Cj4gTWFyY2VsDQo+IA==
