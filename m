Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE32FB0BE;
	Tue, 18 Nov 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449471; cv=none; b=rG+Ks1MRD68Ft1ozyVanqV05CTa/vmJVGVOPTdnNma3X1wrKs2mitjCqogAdQsOrRO02j3mqvH8GtgkHrCj50DCAgIVqlQ6qnCwFaLQVPE9FTMTH8aJYLhEK4xUvm4uvCueQBWJxHTtS5JVtzfRLZnG1wV48yTjmihRmZW12Wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449471; c=relaxed/simple;
	bh=OfprQLYI4RgqtjIJfUtAr68jRU8ISndVn4w3jaO6b/4=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=miWnf3+S8ufEhwYUJv4t+9tyqUnFpAcPFCItlcgSds4cJopqpzQlu9UDjDsxVN9KqGTYJ/DeLET30nDgjUAq7yfhx5wBztFbDNqSfOxWMSROxCmIcFU/ykuyP5a4sBkoxn5gJpGDQu12ImtDMi2ik5CVl14+kuN57Tb2R2o2+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from xudongjie25$mails.ucas.ac.cn ( [114.245.33.6] ) by
 ajax-webmail-APP-12 (Coremail) ; Tue, 18 Nov 2025 14:57:05 +0800
 (GMT+08:00)
Date: Tue, 18 Nov 2025 14:57:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6K645Lic5rSB?= <xudongjie25@mails.ucas.ac.cn>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] Bluetooth: use-after-free in l2cap_info_timeout during
 connection cleanup
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5c6629f6.1d1a1.19a95c0b5bf.Coremail.xudongjie25@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tgCowACXtgfCGBxpRcoCAA--.28398W
X-CM-SenderInfo: p0xg00pjmlvj2v6ptx1ovo3u1dvotugofq/1tbiBgoKB2kcAZlRMA
	AAsN
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8sCgpBIHVzZS1hZnRlci1mcmVlIHZ1bG5lcmFiaWxpdHkgd2FzIGRpc2NvdmVyZWQgaW4g
dGhlIEJsdWV0b290aCBMMkNBUCBzdWJzeXN0ZW0gb2YgTGludXgga2VybmVsIDYuNi4wIHVzaW5n
IHRoZSBzeXprYWxsZXIgZnV6emluZyB0b29sLgoKVGhlIGlzc3VlIGludm9sdmVzIGEgcmFjZSBj
b25kaXRpb24gZHVyaW5nIGNvbm5lY3Rpb24gY2xlYW51cDogd2hlbiBsMmNhcF9jb25uX2RlbCBz
dGFydHMgY2xlYW5pbmcgdXAgY29ubmVjdGlvbiByZXNvdXJjZXMsIGlmIGwyY2FwX2luZm9fdGlt
ZW91dCB3b3JrcXVldWUgZXhlY3V0ZXMgc2ltdWx0YW5lb3VzbHkgb24gYW5vdGhlciBDUFUsIGl0
IG1heSBhY2Nlc3MgZnJlZWQgbWVtb3J5LgoKU3BlY2lmaWMgbWVjaGFuaXNtOgotIGwyY2FwX2Nv
bm5fZGVsIGZ1bmN0aW9uIGRlbGV0ZXMgSENJIGNoYW5uZWxzIGFuZCBjbGVhbnMgdXAgY29ubmVj
dGlvbiBzdGF0ZQotIEhvd2V2ZXIsIGJlZm9yZSBjYWxsaW5nIGNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYyB0byB3YWl0IGZvciBpbmZvX3RpbWVyIGNvbXBsZXRpb24sIHRoZSBjb25uZWN0aW9uIGRh
dGEgc3RydWN0dXJlcyBtYXkgaGF2ZSBiZWVuIHBhcnRpYWxseSBkZXN0cm95ZWQKLSBNZWFud2hp
bGUsIGwyY2FwX2luZm9fdGltZW91dCBjb250aW51ZXMgZXhlY3V0aW5nIGFuZCBhY2Nlc3NlcyB0
aGUgaGNpX2NoYW4gc3RydWN0dXJlIGJlaW5nIGNsZWFuZWQgdXAgdGhyb3VnaCB0aGUgY2FsbCBj
aGFpbgotIFRoaXMgZXZlbnR1YWxseSBsZWFkcyB0byBkZXJlZmVyZW5jaW5nIGFuIGludmFsaWQg
cG9pbnRlciBpbiBza2JfcXVldWVfdGFpbAoKQ3Jhc2ggc2lnbmF0dXJlOgpCVUc6IHVuYWJsZSB0
byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBza2JfcXVldWVfdGFp
bAoKQ2FsbCBzdGFjayBwYXRoOgpsMmNhcF9pbmZvX3RpbWVvdXQgLSZndDsgbDJjYXBfY29ubl9z
dGFydCAtJmd0OyAuLi4gLSZndDsgaGNpX3F1ZXVlX2FjbCAtJmd0OyBza2JfcXVldWVfdGFpbAoK
UmVsYXRlZCBtYXRlcmlhbHMgYXJlIHByb3ZpZGVkIGJlbG93OgpDb25maWcgZmlsZTogaHR0cHM6
Ly9naXRodWIuY29tL2oxYWthaS9LQ29uZmlnRnV6el9idWcvYmxvYi9tYWluL3g4Ni82Ni1jb25m
aWcKQWRkaXRpb25hbCBmdXp6aW5nIGNvbnRleHQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9QTEFTU0lD
QXh1L09TLWJ1Zy90cmVlL21haW4vZWExM2U3NzQxMWUyYTE5N2ExOTI5YWQwNzM4ZDZkOGQzZTE4
MTgyMwoKU3VnZ2VzdGVkIGFwcHJvYWNoOiBhZGQgcmVmZXJlbmNlIGNvdW50IGNoZWNraW5nIGF0
IHRoZSBiZWdpbm5pbmcgb2YgbDJjYXBfaW5mb190aW1lb3V0IHRvIGVuc3VyZSB0aGUgY29ubmVj
dGlvbiByZW1haW5zIHZhbGlkIHRocm91Z2hvdXQgZnVuY3Rpb24gZXhlY3V0aW9uLgoKQWNrbm93
bGVkZ21lbnRzClh1IERvbmdqaWUKVW5pdmVyc2l0eSBvZiBDaGluZXNlIEFjYWRlbXkgb2YgU2Np
ZW5jZXM=
