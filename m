Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71953235BEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761831; cv=none; b=GRaZ4JMQTb2PB330dxZ7LHqNxn1YABX1M1/WdV+jTAOozTlbgscxfUeNiePLFvF/Aw/S/OtyNehdMFwrtA+hL1XCs11L4LZHaY1xtnRm00ALBCL9QD/mE4/I3hvo2zWu/JaUvxw5XiMRMcFIBUI1hRLDCrW7fOXoLMXwCmXMF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761831; c=relaxed/simple;
	bh=qQztn/cVlCAze9xeOPKuEGqLWvb6SaDulSgKeJyqwg0=;
	h=From:Subject:To:Date:Message-ID:MIME-Version:Content-Type; b=U2F1Q3/z4MpxnjfDpstYK3Pu3qzNScEWNqGQiRy9pTu9bRCTh/G5mrlCIfP5jRsjPrneXYNMoaeYjmQTYEwJJneOkQoOjqSYigpFeGVTQIn9QOhlYHsu14gVdywtEfW0+rRWNdPYjMWWPOEh5xR/Kv5bGPvxuTNTcEwGFJzt/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cd6fe504d19311efa216b1d71e6e1362-20250113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:434c7099-742a-42fc-92f2-8a65bda48792,IP:0,U
	RL:0,TC:-5,Content:0,EDM:0,RT:0,SF:0,FILE:5,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1d20cf0cf299447c55214502c23d3032,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:1,Content:0|50,EDM:-3,IP:nil,URL:
	1,File:2,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cd6fe504d19311efa216b1d71e6e1362-20250113
Received: from mail.kylinos.cn [(10.44.16.189)] by mailgw.kylinos.cn
	(envelope-from <caitao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 121686151; Mon, 13 Jan 2025 17:50:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B8F0A706CA37
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 17:50:20 +0800 (CST)
Received: by mail.kylinos.cn (NSMail, from userid 0)
	id AE065706CA37; Mon, 13 Jan 2025 17:50:20 +0800 (CST)
From: =?UTF-8?B?6JSh5rab?= <caitao@kylinos.cn>
Subject: =?UTF-8?B?UEFUQ0ggQmx1ZVo=?=
To: 	=?UTF-8?B?bGludXgtYmx1ZXRvb3Ro?= <linux-bluetooth@vger.kernel.org>,
Date: Mon, 13 Jan 2025 17:50:20 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <h5uj4hazdl-h5x3045316@nsmail7.0.0--kylin--1>
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Mon, 13 Jan 2025 17:50:20 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-k5bna4wvbw-k5cx7ybx5p
X-ns-mid: webmail-6784e1dc-jy21pm7g
X-ope-from: <caitao@kylinos.cn>

This message is in MIME format.

--nsmail-k5bna4wvbw-k5cx7ybx5p
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+RnJvbSAxNDQxOTQxMTQzZGJjNDY1YmZkZTg5NTNlNTU5ODljNzE1MTVm
OGIwIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMTxicj5Gcm9tOiBjYWl0YW8g
Jmx0O2NhaXRhb0BreWxpbm9zLmNuJmd0Ozxicj5EYXRlOiBNb24sIDEzIEph
biAyMDI1IDE3OjQ2OjUzICswODAwPGJyPlN1YmplY3Q6IFtQQVRDSCBCbHVl
WiAwLzFdICoqKiBTVUJKRUNUIEhFUkUgKioqPC9wPgo8cD4qKiogQkxVUkIg
SEVSRSAqKio8L3A+CjxwPmNhaXRhbyAoMSk6PGJyPmJhdHRlcnkuYzogVGhl
IGJhdHRlcnkgaXMgbm90IGluaXRpYWxpemVkLCBhbmQgaW5pdGlhbGl6ZSB0
aGUgYmF0dGVyeTwvcD4KPHA+cHJvZmlsZXMvYmF0dGVyeS9iYXR0ZXJ5LmMg
fCAyICsrPGJyPjEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyk8L3A+
CjxwPi0tIDxicj4yLjI1LjE8L3A+CjxwPkZyb20gMTQ0MTk0MTE0M2RiYzQ2
NWJmZGU4OTUzZTU1OTg5YzcxNTE1ZjhiMCBNb24gU2VwIDE3IDAwOjAwOjAw
IDIwMDE8YnI+RnJvbTogY2FpdGFvICZsdDtjYWl0YW9Aa3lsaW5vcy5jbiZn
dDs8YnI+RGF0ZTogRnJpLCAxMyBEZWMgMjAyNCAxNzo0OTozMCArMDgwMDxi
cj5TdWJqZWN0OiBbUEFUQ0ggQmx1ZVogMS8xXSBiYXR0ZXJ5LmM6IFRoZSBi
YXR0ZXJ5IGlzIG5vdCBpbml0aWFsaXplZCwgYW5kPGJyPmluaXRpYWxpemUg
dGhlIGJhdHRlcnk8L3A+CjxwPmZpeDogPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL2JsdWV6L2JsdWV6L2lzc3Vlcy8xMDQyIj5odHRwczovL2dpdGh1
Yi5jb20vYmx1ZXovYmx1ZXovaXNzdWVzLzEwNDI8L2E+PC9wPgo8cD5TaWdu
ZWQtb2ZmLWJ5OiBjYWl0YW8gJmx0O2NhaXRhb0BreWxpbm9zLmNuJmd0Ozxi
cj4tLS08YnI+cHJvZmlsZXMvYmF0dGVyeS9iYXR0ZXJ5LmMgfCAyICsrPGJy
PjEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyk8L3A+CjxwPmRpZmYg
LS1naXQgYS9wcm9maWxlcy9iYXR0ZXJ5L2JhdHRlcnkuYyBiL3Byb2ZpbGVz
L2JhdHRlcnkvYmF0dGVyeS5jPGJyPmluZGV4IDUzMThkNDBkMS4uYTMxNGYz
YTQ0IDEwMDY0NDxicj4tLS0gYS9wcm9maWxlcy9iYXR0ZXJ5L2JhdHRlcnku
Yzxicj4rKysgYi9wcm9maWxlcy9iYXR0ZXJ5L2JhdHRlcnkuYzxicj5AQCAt
MTM5LDYgKzEzOSw4IEBAIHN0YXRpYyB2b2lkIGJhdHRfaW9fY2NjX3dyaXR0
ZW5fY2IodWludDE2X3QgYXR0X2Vjb2RlLCB2b2lkICp1c2VyX2RhdGEpPGJy
PmdfZnJlZSAoYmF0dC0mZ3Q7aW5pdGlhbF92YWx1ZSk7PGJyPmJhdHQtJmd0
O2luaXRpYWxfdmFsdWUgPSBOVUxMOzxicj48YnI+KyBidGRfYmF0dGVyeV91
cGRhdGUoYmF0dC0mZ3Q7YmF0dGVyeSwgYmF0dC0mZ3Q7cGVyY2VudGFnZSk7
PGJyPis8YnI+REJHKCJCYXR0ZXJ5IExldmVsOiBub3RpZmljYXRpb24gZW5h
YmxlZCIpOzxicj59PGJyPjxicj4tLSA8YnI+Mi4yNS4xPC9wPgo8cD48YnI+
PGJyPjxicj48YnI+PGJyPjxicj4tLS0tPC9wPgo8ZGl2IGlkPSJjczJjX21h
aWxfc2lnYXR1cmUiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+

--nsmail-k5bna4wvbw-k5cx7ybx5p
Content-Type: application/octet-stream; name="=?UTF-8?B?MDAwMC1jb3Zlci1sZXR0ZXIucGF0Y2g=?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; size=377; seclevel=0; filename="=?UTF-8?B?MDAwMC1jb3Zlci1sZXR0ZXIucGF0Y2g=?="
X-Seclevel-1: 0
X-Seclevel: 0

RnJvbSAxNDQxOTQxMTQzZGJjNDY1YmZkZTg5NTNlNTU5ODljNzE1MTVmOGIw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjYWl0YW8gPGNhaXRh
b0BreWxpbm9zLmNuPgpEYXRlOiBNb24sIDEzIEphbiAyMDI1IDE2OjI3OjU0
ICswODAwClN1YmplY3Q6IFtQQVRDSCBCbHVlWiAwLzFdICoqKiBTVUJKRUNU
IEhFUkUgKioqCgoqKiogQkxVUkIgSEVSRSAqKioKCmNhaXRhbyAoMSk6CiAg
YmF0dGVyeS5jOiBUaGUgYmF0dGVyeSBpcyBub3QgaW5pdGlhbGl6ZWQsIGFu
ZCBpbml0aWFsaXplIHRoZSBiYXR0ZXJ5CgogcHJvZmlsZXMvYmF0dGVyeS9i
YXR0ZXJ5LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCgotLSAKMi4yNS4xCgo=

--nsmail-k5bna4wvbw-k5cx7ybx5p
Content-Type: application/octet-stream; name="=?UTF-8?B?MDAwMS1iYXR0ZXJ5LmMtVGhlLWJhdHRlcnktaXMtbm90LWluaXRpYWxpemVkLWFuZC1pbml0aWFsLnBhdGNo?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; size=851; seclevel=0; filename="=?UTF-8?B?MDAwMS1iYXR0ZXJ5LmMtVGhlLWJhdHRlcnktaXMtbm90LWluaXRpYWxpemVkLWFuZC1pbml0aWFsLnBhdGNo?="
X-Seclevel-1: 0
X-Seclevel: 0

RnJvbSAxNDQxOTQxMTQzZGJjNDY1YmZkZTg5NTNlNTU5ODljNzE1MTVmOGIw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjYWl0YW8gPGNhaXRh
b0BreWxpbm9zLmNuPgpEYXRlOiBGcmksIDEzIERlYyAyMDI0IDE3OjQ5OjMw
ICswODAwClN1YmplY3Q6IFtQQVRDSCBCbHVlWiAxLzFdIGJhdHRlcnkuYzog
VGhlIGJhdHRlcnkgaXMgbm90IGluaXRpYWxpemVkLCBhbmQKIGluaXRpYWxp
emUgdGhlIGJhdHRlcnkKCmZpeDogaHR0cHM6Ly9naXRodWIuY29tL2JsdWV6
L2JsdWV6L2lzc3Vlcy8xMDQyCgoKU2lnbmVkLW9mZi1ieTogY2FpdGFvIDxj
YWl0YW9Aa3lsaW5vcy5jbj4KLS0tCiBwcm9maWxlcy9iYXR0ZXJ5L2JhdHRl
cnkuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9wcm9maWxlcy9iYXR0ZXJ5L2JhdHRlcnkuYyBiL3By
b2ZpbGVzL2JhdHRlcnkvYmF0dGVyeS5jCmluZGV4IDUzMThkNDBkMS4uYTMx
NGYzYTQ0IDEwMDY0NAotLS0gYS9wcm9maWxlcy9iYXR0ZXJ5L2JhdHRlcnku
YworKysgYi9wcm9maWxlcy9iYXR0ZXJ5L2JhdHRlcnkuYwpAQCAtMTM5LDYg
KzEzOSw4IEBAIHN0YXRpYyB2b2lkIGJhdHRfaW9fY2NjX3dyaXR0ZW5fY2Io
dWludDE2X3QgYXR0X2Vjb2RlLCB2b2lkICp1c2VyX2RhdGEpCiAJZ19mcmVl
IChiYXR0LT5pbml0aWFsX3ZhbHVlKTsKIAliYXR0LT5pbml0aWFsX3ZhbHVl
ID0gTlVMTDsKIAorCWJ0ZF9iYXR0ZXJ5X3VwZGF0ZShiYXR0LT5iYXR0ZXJ5
LCBiYXR0LT5wZXJjZW50YWdlKTsKKwogCURCRygiQmF0dGVyeSBMZXZlbDog
bm90aWZpY2F0aW9uIGVuYWJsZWQiKTsKIH0KIAotLSAKMi4yNS4xCgo=

--nsmail-k5bna4wvbw-k5cx7ybx5p--
