Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1203003412-11594-15-git-send-email-caglar@pardus.org.tr>
References: y  <1203003412-11594-15-git-send-email-caglar@pardus.org.tr>
Date: Thu, 14 Feb 2008 17:03:51 +0100
Message-Id: <1203005031.7664.474.camel@violet>
Mime-Version: 1.0
Cc: =?UTF-8?Q?S=2E=C3=87a=C4=9Flar?= Onur <caglar@pardus.org.tr>,
	linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH 14/14] net/bluetooth/hci_core.c:
	Use	time_* macros
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

SGksCgo+IFRoZSBmdW5jdGlvbnMgdGltZV9iZWZvcmUsIHRpbWVfYmVmb3JlX2VxLCB0aW1lX2Fm
dGVyLCBhbmQgdGltZV9hZnRlcl9lcSBhcmUgbW9yZSByb2J1c3QgZm9yIGNvbXBhcmluZyBqaWZm
aWVzIGFnYWluc3Qgb3RoZXIgdmFsdWVzLgo+IAo+IFNvIGZvbGxvd2luZyBwYXRjaCBpbXBsZW1l
bnRzIHVzYWdlIG9mIHRoZSB0aW1lX2FmdGVyKCkgbWFjcm8sIGRlZmluZWQgYXQgbGludXgvamlm
Zmllcy5oLCB3aGljaCBkZWFscyB3aXRoIHdyYXBwaW5nIGNvcnJlY3RseQo+IAo+IENjOiBibHVl
ei1kZXZlbEBsaXN0cy5zZi5uZXQKPiBTaWduZWQtb2ZmLWJ5OiBTLsOHYcSfbGFyIE9udXIgPGNh
Z2xhckBwYXJkdXMub3JnLnRyPgoKc2luY2UgdGhpcyBpcyBmdWxsIHNlcmlvdXMgb2YgcGF0Y2hl
cywgSSBhbSBub3Qgc3VyZSBpZiBpdCBzaG91bGQgZ28gdmlhCnRoZSBzdWJzeXN0ZW0gbWFpbnRh
aW5lcnMgb3IgYmV0dGVyIGFwcGxpZWQgYXMgd2hvbGUuIEluIGNhc2Ugb2YgTGludXMKb3IgQW5k
cmV3IGRlY2lkZSB0byB0YWtlIHRoZW0gYWxsIGF0IG9uY2UgYW5kIHB1c2ggdGhlbSwgdGhpcyBv
biBpcwphY2tlZCBieSBtZS4KCkFja2VkLWJ5OiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0
bWFubi5vcmc+CgpSZWdhcmRzCgpNYXJjZWwKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5l
dCBlbWFpbCBpcyBzcG9uc29yZWQgYnk6IE1pY3Jvc29mdApEZWZ5IGFsbCBjaGFsbGVuZ2VzLiBN
aWNyb3NvZnQoUikgVmlzdWFsIFN0dWRpbyAyMDA4LgpodHRwOi8vY2xrLmF0ZG10LmNvbS9NUlQv
Z28vdnNlMDEyMDAwMDA3MG1ydC9kaXJlY3QvMDEvCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkJsdWV6LWRldmVsIG1haWxpbmcgbGlzdApCbHVlei1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vYmx1ZXotZGV2ZWwK
