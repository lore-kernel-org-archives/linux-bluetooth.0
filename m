Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2B82317552
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317044; cv=none; b=lKKcy55QlW10aapwy2/Ja2hryMyOl6S7MTwiPU8D3DTl2JN3Olob4UD00ionQEFojWXpGsf2b3hkHpPY4Hb+dlXmeplZiiZEcHnX9RJGJPXoUTrvYD738w4HZo92CCXBCBn5A2xmYwIU+bxA/SmIF2DmYL+vkD1TWNAn46gcGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317044; c=relaxed/simple;
	bh=EvxaHton5wj/P0A03SRti1jaUkfukgSIvXvs2eT+dTk=;
	h=Date:From:To:Cc:Subject:Mime-Version:Message-ID:Content-Type; b=CXlChPnX4N1s2KT6xWb7xnnthsd/C6I3nnT2MrInJt8fr0SXOdDQpHZq4eeMLbf5qaOHTyy23uQP61TGBbY2ypvWoEHB5TpqzJxBAGgpF6NYlMOf2a9+sXaY4Kzl3l2W4CI87M+z3CW6NJYemfhgAxYdBjBuCA7qS5AUmp+Mtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from cpu-os-wuhan (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A887D603368E3;
	Wed, 13 Mar 2024 16:03:58 +0800 (CST)
Date: Wed, 13 Mar 2024 16:03:58 +0800
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: "youwan@nfschina.com" <youwan@nfschina.com>
To: youwan <youwan@nfschina.com>, 
	marcel <marcel@holtmann.org>
Cc: johan.hedberg <johan.hedberg@gmail.com>, 
	luiz.dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [v3] Bluetooth: btusb: Set error code in btusb_mtk_hci_wmt_sync()
X-Priority: 3
X-GUID: A1107EF8-0FAC-4F41-8868-1A96DBE51F17
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202403131603580644882@nfschina.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T2theSwgdGhhbmsgeW91LiBUaGUgbmV3IHBhdGNoIGhhcyBiZWVuIHNlbnQKCgoKCmVtYWls77ya
eW91d2FuQG5mc2NoaW5hLmNvbQoKCgrCoApGcm9tOsKgWW91d2FuIFdhbmcKCgoKRGF0ZTrCoDIw
MjQtMDMtMTPCoDE1OjQzCgoKClRvOsKgbWFyY2VsCgoKCkNDOsKgam9oYW4uaGVkYmVyZzsgbHVp
ei5kZW50ejsgbGludXgtYmx1ZXRvb3RoOyBZb3V3YW4gV2FuZwoKCgpTdWJqZWN0OsKgW3YzXSBC
bHVldG9vdGg6IGJ0dXNiOiBTZXQgZXJyb3IgY29kZSBpbiBidHVzYl9tdGtfaGNpX3dtdF9zeW5j
KCkKCgoKQ29udmVuaWVudCB0byBjaGVjayBpZiB0aGUgZnVuY3Rpb24gd2FzIGV4ZWN1dGVkIHN1
Y2Nlc3NmdWxseQoKCgphbmQga25vdyB0aGUgc3BlY2lmaWMgZXJyb3IgbG9jYXRpb24gaW4gdGhl
IGNvZGUuCgoKCsKgCgoKClNpZ25lZC1vZmYtYnk6IFlvdXdhbiBXYW5nIDx5b3V3YW5AbmZzY2hp
bmEuY29tPgoKCgotLS0KCgoKZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDQgKysrLQoKCgox
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgoKCsKgCgoKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVldG9vdGgv
YnR1c2IuYwoKCgppbmRleCBkNzkzZGNkMDY2ODcuLmE3MjQ0YThhNWI3YyAxMDA2NDQKCgoKLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYwoKCgorKysgYi9kcml2ZXJzL2JsdWV0b290aC9i
dHVzYi5jCgoKCkBAIC0yODI0LDggKzI4MjQsMTAgQEAgc3RhdGljIGludCBidHVzYl9tdGtfaGNp
X3dtdF9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAoKCgpnb3RvIGVycl9mcmVlX3djOwoKCgp9
CgoKCi0gaWYgKGRhdGEtPmV2dF9za2IgPT0gTlVMTCkKCgoKKyBpZiAoZGF0YS0+ZXZ0X3NrYiA9
PSBOVUxMKSB7CgoKCisgZXJyID0gLUVOT0JVRlM7CgoKCmdvdG8gZXJyX2ZyZWVfd2M7CgoKCisg
fQoKCgovKiBQYXJzZSBhbmQgaGFuZGxlIHRoZSByZXR1cm4gV01UIGV2ZW50ICovCgoKCndtdF9l
dnQgPSAoc3RydWN0IGJ0bXRrX2hjaV93bXRfZXZ0ICopZGF0YS0+ZXZ0X3NrYi0+ZGF0YTsKCgoK
LS0KCgoKMi4yNS4xCgoKCsKgCgoK

