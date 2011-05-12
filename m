Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 12 May 2011 13:54:46 +0200
Subject: RE: [PATCH v6] staging: Add ST-Ericsson CG2900 driver
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA3395A6DC72@EXDCVYMBSTM005.EQ1STM.local>
References: <1305040232-750-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <20110510200801.GA8125@kroah.com>
 <AFCDDB4A3EA003429EEF1E7B211FDBBA3395A1A289@EXDCVYMBSTM005.EQ1STM.local>
 <20110511134859.GB12717@kroah.com>
In-Reply-To: <20110511134859.GB12717@kroah.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtIIFttYWlsdG86Z3Jl
Z0Brcm9haC5jb21dDQo+IFNlbnQ6IGRlbiAxMSBtYWogMjAxMSAxNTo0OQ0KPg0KPiA+IEkgdXNl
ZCBuZXh0LTIwMTEwNTEwIGFuZCBpbiB0aGF0IHRhZyB0aGUgZmlsZQ0KPiBpbmNsdWRlL0xpbnV4
L21mZC9jb3JlLmgNCj4gPiBUaGUgc3RydWN0IG1mZF9jZWxsIGhhcyBhIHBhcmFtZXRlciBjYWxs
ZWQgcGxhdGZvcm1fZGF0YSwgd2hpbGUgaW4NCj4geW91cg0KPiA+IGJ1aWxkIGl0IHNlZW1zIGl0
IGRvZXNuJ3QuDQo+ID4gVGhpcyB3YXMgY2hhbmdlZCB2ZXJ5IHJlY2VudGx5IGluIHRoZSBjb3Jl
LmggZmlsZSAob24gQXByaWwgNikuDQo+ID4gU28gZm9yIGNvcmUuaCB0aGUgbGFzdCBjb21taXQg
SUQgSSBoYXZlIGluIHRoZSB0YWcgSSBidWlsdCB1cG9uIGlzDQo+ID4gNTU4YWE5YzBkNjIwYjkx
YTg5NmQ1ZTM5Y2U4YTU3MGJlZDY1NTg5Yi4NCj4gDQo+IFNvIGRvIEkgbmVlZCB0aGF0IHBhdGNo
IG9uIHRoZSBzdGFnaW5nLW5leHQgdHJlZSBhbHNvPw0KPiANCj4gT3IgaXMgaXQgYW4gaXNzdWUg
b2YgYnVpbGRpbmcgdGhpcyBvbiB4ODYtNjQuLi4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcg
ay1oDQoNCkhpIEdyZWcsDQoNCkkgZG93bmxvYWRlZCB5b3Ugc3RhZ2luZyB0cmVlIGFuZCBjb21w
YXJlZCB0aGUgbG9ncyBmb3IgdGhlIGNvcmUuaCBmaWxlLg0KQ29tcGFyZWQgdG8gbGludXgtbmV4
dCB0YWcgbmV4dC0yMDExMDUxMCBpdCBpcyBtaXNzaW5nIDIgY29tbWl0czoNCjRkYmVlNmI3NmZm
ZmQ1NzQwZTg3ZTI4NmY0ZjRjMWMxNTkwMWJjYWUNCjU1OGFhOWMwZDYyMGI5MWE4OTZkNWUzOWNl
OGE1NzBiZWQ2NTU4OWINCndoZXJlIHRoZSBmaXJzdCBvbmUgaXMgdGhlICJvbGRlc3QiIG9uZSBp
biB0aGUgbG9nIGFuZCBpcyB0aGUgbW9zdA0KaW1wb3J0YW50IG9uZSBmb3IgbXkgcGF0Y2guDQpB
bm90aGVyIG9wdGlvbiB3b3VsZCBiZSBmb3IgbWUgdG8gZml4IHRoZSBwYXRjaCBmb3IgeW91ciB0
cmVlLCBidXQNCnRoZW4gSSB3b3VsZCBwcm9iYWJseSBoYXZlIHRvIGZpeCBpdCBiYWNrIGluIGEg
ZmV3IGRheXMgd2hlbiB5b3UgdXBkYXRlDQp5b3VyIHN0YWdpbmcgdHJlZSB0byBMaW51eC1uZXh0
LiBIb3cgb2Z0ZW4gaXMgeW91ciB0cmVlIHVwZGF0ZWQ/DQoNClRoZSBlYXNpZXN0IGlzIHByb2Jh
Ymx5IHRvIHdhaXQgYSBmZXcgZGF5cyB1bnRpbCB5b3UgaGF2ZSB0aGUgbmV4dC0yMDExMDUxMA0K
dGFnIGluIHlvdXIgdHJlZSBhbmQgdGhlbiBhcHBseSB0aGUgcGF0Y2guDQoNClRoYW5rcywNClAt
Rw0KDQo=
