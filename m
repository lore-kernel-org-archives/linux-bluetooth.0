Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436515AF
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Dec 2023 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="qOBxJVY0";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="mjA5mTu0"
Message-ID: <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1702688169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T/wKCh+bfYL4EG0Iec6CYGXhoynGsEYAIN9VGsVepxo=;
	b=qOBxJVY08lquLUQmwuFeRDqyoaxQs3BcJdkgmQnBvhpcp92cvbPqsylhJoNdNznIJilkAD
	J5LWJ1u2oWg8m7VVSRtYaIXo/BNc0gStu8Z9sEjwlKtv/QHVtWpkTDVog0nxgzoFGQuMbp
	4JHAfiCroDs6Xcm359tZck4FDQUyuVou4J7oxDBR1mU4D+hJmxZex18as9s0zhp+qtRgl6
	z/6kPH/A0kR5c+N/zxwyP44g8AQRYpRsfxUUpilXPav5XbxfY0uDIo1Sp7QXmFnKnVIXRQ
	0vwLZOobMVVqiJbT77qZiXxpeWMch4EfnWrBR/OXYXoCagFn6GvGKMwc3eHfV5ahsKYC04
	/LczPDeMDTmJgtjox1FYszOtbmEZiwZFaei5CAma0Nyg6WcEQc8PlZIeaudakf88x7Oexz
	ebyEtgXo8D4+qF51byye6CCYB3kn7DokGh5jmRwBMBqrt4msy8b+at248wOmIZkiRWKQuI
	cho71qLDfsvmIZVLyMjBFareT0SWXrcM8eZ9+BZxEqPpKBXq63nshm9IhxEX/6XdaPLgNd
	VxiBlFHvTFmsvCt9OLa1Fu5q6ssVPSpzBuYvYvICBpO0Uv649f+L89DJiT+dwIIGJFvfJ9
	i4tEjcPwWTow6xyjJzz2HIeh8olcMui8VOHQ/TJnTx/KreTCa2ZQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1702688169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T/wKCh+bfYL4EG0Iec6CYGXhoynGsEYAIN9VGsVepxo=;
	b=mjA5mTu0sJscUzEk9nkygvm2dEvx2KXutvPOgdw9GGa4bkRuB3pm2A/YZbGtOYkgC3M3Ef
	KUd1x/OS7aBs2RDA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=antiz smtp.mailfrom=antiz@archlinux.org
Date: Sat, 16 Dec 2023 01:59:51 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
Content-Language: en-US, fr
To: Xiao Yao <xiaokeqinhealth@126.com>, linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
From: Robin Candau <antiz@archlinux.org>
Autocrypt: addr=antiz@archlinux.org; keydata=
 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
In-Reply-To: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------R3lDKX0aq7esnoekmafxhyOz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------R3lDKX0aq7esnoekmafxhyOz
Content-Type: multipart/mixed; boundary="------------0Ap9vbGReHzQa1oxlLIKQgfs";
 protected-headers="v1"
From: Robin Candau <antiz@archlinux.org>
To: Xiao Yao <xiaokeqinhealth@126.com>, linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Message-ID: <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org>
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231211162729.1183207-1-xiaokeqinhealth@126.com>

--------------0Ap9vbGReHzQa1oxlLIKQgfs
Content-Type: multipart/mixed; boundary="------------yJiEFh18uPHPx66G0VhV2PYZ"

--------------yJiEFh18uPHPx66G0VhV2PYZ
Content-Type: multipart/alternative;
 boundary="------------rPYk7oy4fcL9aqfoGqOq0xg4"

--------------rPYk7oy4fcL9aqfoGqOq0xg4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIvMTEvMjMgMTc6MjcsIFhpYW8gWWFvIHdyb3RlOg0KPiBGcm9tOiBYaWFvIFlhbzx4
aWFveWFvQHJvY2stY2hpcHMuY29tPg0KPg0KPiBBY2NvcmRpbmcgdG8gQkxVRVRPT1RIIENP
UkUgU1BFQ0lGSUNBVElPTiBWZXJzaW9uIDUuNCB8IFZvbCAzLA0KPiBQYXJ0IEgsIDIuNC4y
NC8yLjQuMjUsIFRoZSBMRSBMVEsgYW5kIEJSL0VEUiBsaW5rIGtleXMgY2FuIGJlDQo+IGNv
bnZlcnRlZCBiZXR3ZWVuIGVhY2ggb3RoZXIsIHNvIHRoZSBhZGRyIHR5cGUgY2FuIGJlIGVp
dGhlcg0KPiBCUkVEUiBvciBMRSwgc28gZml4IGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBY
aWFvIFlhbzx4aWFveWFvQHJvY2stY2hpcHMuY29tPg0KPiAtLS0NCj4gICBzcmMvYWRhcHRl
ci5jIHwgMjAgKysrKysrKysrKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3NyYy9h
ZGFwdGVyLmMgYi9zcmMvYWRhcHRlci5jDQo+IGluZGV4IDg2ZmZmNzJiYy4uZWU3MGIwMGQy
IDEwMDY0NA0KPiAtLS0gYS9zcmMvYWRhcHRlci5jDQo+ICsrKyBiL3NyYy9hZGFwdGVyLmMN
Cj4gQEAgLTE3MCw2ICsxNzAsNyBAQCBzdGF0aWMgR1NMaXN0ICpjb25uX2ZhaWxfbGlzdCA9
IE5VTEw7DQo+ICAgDQo+ICAgc3RydWN0IGxpbmtfa2V5X2luZm8gew0KPiAgIAliZGFkZHJf
dCBiZGFkZHI7DQo+ICsJdWludDhfdCBiZGFkZHJfdHlwZTsNCj4gICAJdW5zaWduZWQgY2hh
ciBrZXlbMTZdOw0KPiAgIAl1aW50OF90IHR5cGU7DQo+ICAgCXVpbnQ4X3QgcGluX2xlbjsN
Cj4gQEAgLTM5NjQsNyArMzk2NSw5IEBAIHN0YXRpYyBib29sIGlzX2Jsb2NrZWRfa2V5KHVp
bnQ4X3Qga2V5X3R5cGUsIHVpbnQ4X3QgKmtleV92YWx1ZSkNCj4gICAJcmV0dXJuIGZhbHNl
Ow0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBzdHJ1Y3QgbGlua19rZXlfaW5mbyAqZ2V0X2tl
eV9pbmZvKEdLZXlGaWxlICprZXlfZmlsZSwgY29uc3QgY2hhciAqcGVlcikNCj4gK3N0YXRp
YyBzdHJ1Y3QgbGlua19rZXlfaW5mbyAqZ2V0X2tleV9pbmZvKEdLZXlGaWxlICprZXlfZmls
ZSwgY29uc3QgY2hhciAqcGVlciwNCj4gKwkJCQkJdWludDhfdCBiZGFkZHJfdHlwZSkNCj4g
Kw0KPiAgIHsNCj4gICAJc3RydWN0IGxpbmtfa2V5X2luZm8gKmluZm8gPSBOVUxMOw0KPiAg
IAljaGFyICpzdHI7DQo+IEBAIC0zOTc2LDYgKzM5NzksNyBAQCBzdGF0aWMgc3RydWN0IGxp
bmtfa2V5X2luZm8gKmdldF9rZXlfaW5mbyhHS2V5RmlsZSAqa2V5X2ZpbGUsIGNvbnN0IGNo
YXIgKnBlZXIpDQo+ICAgCWluZm8gPSBnX25ldzAoc3RydWN0IGxpbmtfa2V5X2luZm8sIDEp
Ow0KPiAgIA0KPiAgIAlzdHIyYmEocGVlciwgJmluZm8tPmJkYWRkcik7DQo+ICsJaW5mby0+
YmRhZGRyX3R5cGUgPSBiZGFkZHJfdHlwZTsNCj4gICANCj4gICAJaWYgKCFzdHJuY21wKHN0
ciwgIjB4IiwgMikpDQo+ICAgCQlzdHIyYnVmKCZzdHJbMl0sIGluZm8tPmtleSwgc2l6ZW9m
KGluZm8tPmtleSkpOw0KPiBAQCAtNDM0Myw3ICs0MzQ3LDcgQEAgc3RhdGljIHZvaWQgbG9h
ZF9saW5rX2tleXMoc3RydWN0IGJ0ZF9hZGFwdGVyICphZGFwdGVyLCBHU0xpc3QgKmtleXMs
DQo+ICAgCQlzdHJ1Y3QgbGlua19rZXlfaW5mbyAqaW5mbyA9IGwtPmRhdGE7DQo+ICAgDQo+
ICAgCQliYWNweSgma2V5LT5hZGRyLmJkYWRkciwgJmluZm8tPmJkYWRkcik7DQo+IC0JCWtl
eS0+YWRkci50eXBlID0gQkRBRERSX0JSRURSOw0KPiArCQlrZXktPmFkZHIudHlwZSA9IGlu
Zm8tPmJkYWRkcl90eXBlOw0KPiAgIAkJa2V5LT50eXBlID0gaW5mby0+dHlwZTsNCj4gICAJ
CW1lbWNweShrZXktPnZhbCwgaW5mby0+a2V5LCAxNik7DQo+ICAgCQlrZXktPnBpbl9sZW4g
PSBpbmZvLT5waW5fbGVuOw0KPiBAQCAtNDU5OCwxNCArNDYwMiwxOCBAQCBzdGF0aWMgdm9p
ZCBsb2FkX2Nvbm5fcGFyYW1zKHN0cnVjdCBidGRfYWRhcHRlciAqYWRhcHRlciwgR1NMaXN0
ICpwYXJhbXMpDQo+ICAgCQlidGRfZXJyb3IoYWRhcHRlci0+ZGV2X2lkLCAiTG9hZCBjb25u
ZWN0aW9uIHBhcmFtZXRlcnMgZmFpbGVkIik7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIHVp
bnQ4X3QgZ2V0X2xlX2FkZHJfdHlwZShHS2V5RmlsZSAqa2V5ZmlsZSkNCj4gK3N0YXRpYyB1
aW50OF90IGdldF9hZGRyX3R5cGUoR0tleUZpbGUgKmtleWZpbGUpDQo+ICAgew0KPiAgIAl1
aW50OF90IGFkZHJfdHlwZTsNCj4gICAJY2hhciAqdHlwZTsNCj4gICANCj4gKwkvKiBUaGUg
QWRkcmVzc1R5cGUgaXMgd3JpdHRlbiB0byBmaWxlIG9ubHkgV2hlbiBkZXYtPmxlIGlzDQo+
ICsJICogc2V0IHRvIHRydWUsIGFzIHJlZmVyZW5jZWQgaW4gdGhlIHVwZGF0ZV90ZWNobm9s
b2dpZXMoKS4NCj4gKwkgKiBUaGVyZWZvcmUsIFdoZW4gdHlwZSBpcyBOVUxMLCBpdCBkZWZh
dWx0IHRvIEJEQUREUl9CUkVEUi4NCj4gKwkgKi8NCj4gICAJdHlwZSA9IGdfa2V5X2ZpbGVf
Z2V0X3N0cmluZyhrZXlmaWxlLCAiR2VuZXJhbCIsICJBZGRyZXNzVHlwZSIsIE5VTEwpOw0K
PiAgIAlpZiAoIXR5cGUpDQo+IC0JCXJldHVybiBCREFERFJfTEVfUFVCTElDOw0KPiArCQly
ZXR1cm4gQkRBRERSX0JSRURSOw0KPiAgIA0KPiAgIAlpZiAoZ19zdHJfZXF1YWwodHlwZSwg
InB1YmxpYyIpKQ0KPiAgIAkJYWRkcl90eXBlID0gQkRBRERSX0xFX1BVQkxJQzsNCj4gQEAg
LTQ5MTQsOSArNDkyMiw5IEBAIHN0YXRpYyB2b2lkIGxvYWRfZGV2aWNlcyhzdHJ1Y3QgYnRk
X2FkYXB0ZXIgKmFkYXB0ZXIpDQo+ICAgCQkJZ19jbGVhcl9lcnJvcigmZ2Vycik7DQo+ICAg
CQl9DQo+ICAgDQo+IC0JCWtleV9pbmZvID0gZ2V0X2tleV9pbmZvKGtleV9maWxlLCBlbnRy
eS0+ZF9uYW1lKTsNCj4gKwkJYmRhZGRyX3R5cGUgPSBnZXRfYWRkcl90eXBlKGtleV9maWxl
KTsNCj4gICANCj4gLQkJYmRhZGRyX3R5cGUgPSBnZXRfbGVfYWRkcl90eXBlKGtleV9maWxl
KTsNCj4gKwkJa2V5X2luZm8gPSBnZXRfa2V5X2luZm8oa2V5X2ZpbGUsIGVudHJ5LT5kX25h
bWUsIGJkYWRkcl90eXBlKTsNCj4gICANCj4gICAJCWx0a19pbmZvID0gZ2V0X2x0a19pbmZv
KGtleV9maWxlLCBlbnRyeS0+ZF9uYW1lLCBiZGFkZHJfdHlwZSk7DQo+ICAgDQoNCkhlbGxv
LA0KDQpJdCBzZWVtcyBsaWtlIHRoZSBhYm92ZSBjb21taXQgaW50cm9kdWNlZCBhIHJlZ3Jl
c3Npb24gd2hlcmUgdGhlIGluaXRpYWwgDQphdXRvLWNvbm5lY3QgZm9yIEJsdWV0b290aCBk
ZXZpY2VzIGRvZXNuJ3Qgd29yayBhbnltb3JlLg0KDQpJbmRlZWQsIGF0IHN5c3RlbSBzdGFy
dHVwLCBzdGFydGluZyBhIEJsdWV0b290aCBkZXZpY2Ugd2lsbCBjYXVzZSBpdCB0byANCmdv
IGluIGEgImNvbm5lY3RlZC9kaXNjb25uZWN0ZWQiIHN0YXRlIGxvb3AsIHJlcXVpcmluZyB0
byBpbml0aWFsaXplIGEgDQptYW51YWwgY29ubmVjdGlvbiBmaXJzdCAod2l0aCBzb21ldGlt
ZXMgbXVsdGlwbGUgYXR0ZW1wdHMgbmVlZGVkKSBiZWZvcmUgDQpnZXR0aW5nIGl0IGNvbm5l
Y3RlZCBjb3JyZWN0bHkgYW5kIHdvcmtpbmcgYXMgaW50ZW5kZWQuDQoNCmBzeXN0ZW1jdGwg
c3RhdHVzIGJsdWV0b290aGAgcmVwb3J0cyB0aGUgZm9sbG93aW5nIGVycm9yOg0KDQpbLi4u
XQ0KZMOpYy4gMTUgMTE6MDM6MTggQXJjaC1EZXNrdG9wIGJsdWV0b290aGRbNTkyXTogRmFp
bGVkIHRvIGxvYWQgbGluayBrZXlzIA0KZm9yIGhjaTA6IEludmFsaWQgUGFyYW1ldGVycyAo
MHgwZCkNClsuLi5dDQoNCioqSSBiaXNlY3RlZCB0aGUgYnVnIHdpdGggYGdpdCBiaXNlY3Rg
IGFuZCBpdCBwb2ludGVkIG91dCB0aGlzIGNvbW1pdCANClsxXSBhcyB0aGUgImZhdWx0eSIg
b25lLg0KSSBjYW4gY29uZmlybSB0aGF0IHJldmVydGluZyBpdCBzb2x2ZXMgdGhlIGlzc3Vl
Lg0KDQpJIHJlcG9ydGVkIHRoaXMgYnVnIGluY2x1ZGluZyBkZXRhaWxzIGluIHRoZSBHaXRI
dWIgcmVwbyBbMl0uDQoNCkkgcmVtYWluIGF2YWlsYWJsZSBpZiBhbnkgYWRkaXRpb25hbCBp
bmZvcm1hdGlvbiBhcmUgbmVlZGVkLg0KDQpbMV0gDQpodHRwczovL2dpdGh1Yi5jb20vYmx1
ZXovYmx1ZXovY29tbWl0L2Q1NTM2ZTBjZDQzMWUyMmJlOWExMTMyYmU2ZDRhZjI0NDU1OTA2
MzMNClsyXSBodHRwczovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovaXNzdWVzLzY4NnwNCnwN
Cg0KLS0gDQpSZWdhcmRzLA0KUm9iaW4gQ2FuZGF1IC8gQW50aXoNCg0K
--------------rPYk7oy4fcL9aqfoGqOq0xg4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 12/11/23 17:27, Xiao Yao wrote:<br>=

    </div>
    <blockquote type=3D"cite">
      <pre class=3D"moz-quote-pre" wrap=3D"">From: Xiao Yao <a class=3D"m=
oz-txt-link-rfc2396E" href=3D"mailto:xiaoyao@rock-chips.com">&lt;xiaoyao@=
rock-chips.com&gt;</a>

According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
converted between each other, so the addr type can be either
BREDR or LE, so fix it.

Signed-off-by: Xiao Yao <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:xiaoyao@rock-chips.com">&lt;xiaoyao@rock-chips.com&gt;</a>
---
 src/adapter.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 86fff72bc..ee70b00d2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -170,6 +170,7 @@ static GSList *conn_fail_list =3D NULL;
=20
 struct link_key_info {
 	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 	unsigned char key[16];
 	uint8_t type;
 	uint8_t pin_len;
@@ -3964,7 +3965,9 @@ static bool is_blocked_key(uint8_t key_type, uint8_=
t *key_value)
 	return false;
 }
=20
-static struct link_key_info *get_key_info(GKeyFile *key_file, const char=
 *peer)
+static struct link_key_info *get_key_info(GKeyFile *key_file, const char=
 *peer,
+					uint8_t bdaddr_type)
+
 {
 	struct link_key_info *info =3D NULL;
 	char *str;
@@ -3976,6 +3979,7 @@ static struct link_key_info *get_key_info(GKeyFile =
*key_file, const char *peer)
 	info =3D g_new0(struct link_key_info, 1);
=20
 	str2ba(peer, &amp;info-&gt;bdaddr);
+	info-&gt;bdaddr_type =3D bdaddr_type;
=20
 	if (!strncmp(str, "0x", 2))
 		str2buf(&amp;str[2], info-&gt;key, sizeof(info-&gt;key));
@@ -4343,7 +4347,7 @@ static void load_link_keys(struct btd_adapter *adap=
ter, GSList *keys,
 		struct link_key_info *info =3D l-&gt;data;
=20
 		bacpy(&amp;key-&gt;addr.bdaddr, &amp;info-&gt;bdaddr);
-		key-&gt;addr.type =3D BDADDR_BREDR;
+		key-&gt;addr.type =3D info-&gt;bdaddr_type;
 		key-&gt;type =3D info-&gt;type;
 		memcpy(key-&gt;val, info-&gt;key, 16);
 		key-&gt;pin_len =3D info-&gt;pin_len;
@@ -4598,14 +4602,18 @@ static void load_conn_params(struct btd_adapter *=
adapter, GSList *params)
 		btd_error(adapter-&gt;dev_id, "Load connection parameters failed");
 }
=20
-static uint8_t get_le_addr_type(GKeyFile *keyfile)
+static uint8_t get_addr_type(GKeyFile *keyfile)
 {
 	uint8_t addr_type;
 	char *type;
=20
+	/* The AddressType is written to file only When dev-&gt;le is
+	 * set to true, as referenced in the update_technologies().
+	 * Therefore, When type is NULL, it default to BDADDR_BREDR.
+	 */
 	type =3D g_key_file_get_string(keyfile, "General", "AddressType", NULL)=
;
 	if (!type)
-		return BDADDR_LE_PUBLIC;
+		return BDADDR_BREDR;
=20
 	if (g_str_equal(type, "public"))
 		addr_type =3D BDADDR_LE_PUBLIC;
@@ -4914,9 +4922,9 @@ static void load_devices(struct btd_adapter *adapte=
r)
 			g_clear_error(&amp;gerr);
 		}
=20
-		key_info =3D get_key_info(key_file, entry-&gt;d_name);
+		bdaddr_type =3D get_addr_type(key_file);
=20
-		bdaddr_type =3D get_le_addr_type(key_file);
+		key_info =3D get_key_info(key_file, entry-&gt;d_name, bdaddr_type);
=20
 		ltk_info =3D get_ltk_info(key_file, entry-&gt;d_name, bdaddr_type);
=20
</pre>
    </blockquote>
    <p>Hello,</p>
    <p>It seems like the above commit introduced a regression where the
      initial auto-connect for Bluetooth devices doesn't work anymore.</p=
>
    <p>Indeed, at system startup, starting a Bluetooth device will cause
      it to go in a "connected/disconnected" state loop, requiring to
      initialize a manual connection first (with sometimes multiple
      attempts needed) before getting it connected correctly and working
      as intended.</p>
    <p>`systemctl status bluetooth` reports the following error:</p>
    <p>[...]<br>
      d=C3=A9c. 15 11:03:18 Arch-Desktop bluetoothd[592]: Failed to load =
link
      keys for hci0: Invalid Parameters (0x0d)<br>
      [...]</p>
    <p><strong></strong>I bisected the bug with `git bisect` and it
      pointed out this commit [1] as the "faulty" one.<br>
      I can confirm that reverting it solves the issue.</p>
    <p>I reported this bug including details in the GitHub repo [2].</p>
    <p>I remain available if any additional information are needed.<br>
    </p>
    <p>[1]
<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/bluez/bluez=
/commit/d5536e0cd431e22be9a1132be6d4af2445590633">https://github.com/blue=
z/bluez/commit/d5536e0cd431e22be9a1132be6d4af2445590633</a><br>
      [2] <a class=3D"moz-txt-link-freetext" href=3D"https://github.com/b=
luez/bluez/issues/686">https://github.com/bluez/bluez/issues/686</a><code=
><br>
      </code></p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Regards,
Robin Candau / Antiz</pre>
  </body>
</html>

--------------rPYk7oy4fcL9aqfoGqOq0xg4--
--------------yJiEFh18uPHPx66G0VhV2PYZ
Content-Type: application/pgp-keys; name="OpenPGP_0xFDC3040B92ACA748.asc"
Content-Disposition: attachment; filename="OpenPGP_0xFDC3040B92ACA748.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
s4ZSrdhY1YEifw=3D=3D
=3Di8fF
-----END PGP PUBLIC KEY BLOCK-----

--------------yJiEFh18uPHPx66G0VhV2PYZ--

--------------0Ap9vbGReHzQa1oxlLIKQgfs--

--------------R3lDKX0aq7esnoekmafxhyOz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEJipY7GxR9+o5Wy4t/cMEC5Ksp0gFAmV89ocFAwAAAAAACgkQ/cMEC5Ksp0iV
VhAAp7aTzzWjgli+RznsCpgw1GEvOT1eFi8kBe0MzGYOjBvwGXOYFqFTHHBGEW7hmbKkg0Pyo7em
+/AJwmuvnd3f9fD7O+pFRBGioXjXoJzoO1svRTYCNUzd4c5T94Bnlc6WwxQuvuzJlDnuvUAemZUp
hlkyjXG8y4jfeShIE7SZoPxQxhnKsdkNVvm1xa+ssBUJbmTPY8bd41FZcQ3WSWY6baSzGACwAQS/
MGGeSvv8LfFNBgg5XTLBrKmWLU5/eynuTvRJTb1yzkmQaUXUBwZKdc9T4CEhyQl/EUsyh1IMTBkn
rFKtsJYrGGM5yLnJSPeHBBiJC/YEE0cKT17nw5CIdjdbcYwHtpTOGjiMOYKPMV+Yrmtyz5f5ynyA
KFw7vIwBm3QqCjbQ0Sn1jJZSlww8Qd+0iXarGzlKqRHP3OJ3+eR/LhZ/Qe3AU8b1la+M/CSTOEAp
QlZIen2TAXIQkJLUbCLzPSF7SMadSOauc76UGwk4YVJ17ljQuJgcPAJGzMsoRuvWQ+fTNa2n1hle
e7D6k+heay3RfcQOBkNMvFCpTEIBOr7woqcOcZrxGZfPlJx7qBM1gfIM3Tct4UaExaEg7g54xZJb
5hX2u23YjTpciHI+K42X3bByyWiJ58ctQyeavQGzkohtViAyr2N4WrgJ56z8XH7Gea2BXCGZ6nt+
6g8=
=evCP
-----END PGP SIGNATURE-----

--------------R3lDKX0aq7esnoekmafxhyOz--
