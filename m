Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 Feb 2008 23:25:11 -0800 (PST)
Message-Id: <20080217.232511.24233030.davem@davemloft.net>
To: caglar@pardus.org.tr
From: David Miller <davem@davemloft.net>
In-Reply-To: <1203003412-11594-15-git-send-email-caglar@pardus.org.tr>
References: <1203003412-11594-15-git-send-email-caglar@pardus.org.tr>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH 14/14] net/bluetooth/hci_core.c: Use
	time_* macros
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

RnJvbTogUy7Dh2HEn2xhciBPbnVyIDxjYWdsYXJAcGFyZHVzLm9yZy50cj4NCkRhdGU6IFRodSwg
MTQgRmViIDIwMDggMTc6MzY6NTIgKzAyMDANCg0KPiBUaGUgZnVuY3Rpb25zIHRpbWVfYmVmb3Jl
LCB0aW1lX2JlZm9yZV9lcSwgdGltZV9hZnRlciwgYW5kIHRpbWVfYWZ0ZXJfZXEgYXJlIG1vcmUg
cm9idXN0IGZvciBjb21wYXJpbmcgamlmZmllcyBhZ2FpbnN0IG90aGVyIHZhbHVlcy4NCj4gDQo+
IFNvIGZvbGxvd2luZyBwYXRjaCBpbXBsZW1lbnRzIHVzYWdlIG9mIHRoZSB0aW1lX2FmdGVyKCkg
bWFjcm8sIGRlZmluZWQgYXQgbGludXgvamlmZmllcy5oLCB3aGljaCBkZWFscyB3aXRoIHdyYXBw
aW5nIGNvcnJlY3RseQ0KPiANCj4gQ2M6IGJsdWV6LWRldmVsQGxpc3RzLnNmLm5ldA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTLsOHYcSfbGFyIE9udXIgPGNhZ2xhckBwYXJkdXMub3JnLnRyPg0KDQpBbHNv
IGFwcGxpZWQsIHRoYW5rcy4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMg
c3BvbnNvcmVkIGJ5OiBNaWNyb3NvZnQKRGVmeSBhbGwgY2hhbGxlbmdlcy4gTWljcm9zb2Z0KFIp
IFZpc3VhbCBTdHVkaW8gMjAwOC4KaHR0cDovL2Nsay5hdGRtdC5jb20vTVJUL2dvL3ZzZTAxMjAw
MDAwNzBtcnQvZGlyZWN0LzAxLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpCbHVlei1kZXZlbCBtYWlsaW5nIGxpc3QKQmx1ZXotZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2JsdWV6LWRldmVsCg==
