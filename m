Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A571AA782
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245022; cv=none; b=YjLTqcv6oRu4tehjY1OqOiCc0wtPceNoY7djLghkdtoSBaFqEsCR6g5USHB2AdxOqjNRujOXjZ5IkrxS/AAHR4JD+971LHpHuNyOamHa+rfH9JIhnWKF3ydlOfk9htiAAu2PR5Vu+MIuDSTwbZrSAGek7yW36lLe81Q7N5UPEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245022; c=relaxed/simple;
	bh=KrCXi+34/fIwfTXvYnsVmnyYb3LKfB4ssPuWiXBs5V4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t8voB5VJnVz9rC5XbjYfZZ4pbjnX+HE1W5riLuruZYBVim1PA1QAkpYcjNqG2T7D+IVki4ftSolG74Jl58hWhUoN74txOWYClu6at4k2Cw5id46y8l3JnzMHTortV8u31myeek6CkwFgOyXagrqgKcBhT7V355qO+lPi0COHnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ta7sljXh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ta7sljXh"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5267AGtD42856178, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realsil.com.cn;
	s=dkim; t=1741245017;
	bh=KrCXi+34/fIwfTXvYnsVmnyYb3LKfB4ssPuWiXBs5V4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=ta7sljXhLzQFkRe3RduNLhyfiwqYLgbPuEKyEO1QAVaswd/hwa57U94UUU1XkFvxX
	 ZOc591uXicxjy7hQAHUdN2jVQTbfEMI7i2sVgEZyAxwzjx+SNu32811NaIv3uCkfgf
	 hXoIhKljbQ4J97ZuvaYeoYwvLsnFoepSM1qLML2XK6LHAuM6Q1cGoZ4psPd+dQBCg1
	 IGsSazpv43TcR4xSGpPwpMjnZ+53kfa4jcG5sMcfHgxOATwS7r+aqyVWA1SPx+H4eD
	 FouF9xO0a6hO8++6NZ9F6KoVPbnikLZ/6eXIEm14hOmdoN8rxi6mr+0+QbLEIyfRqm
	 riDEWnIfTyu9Q==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5267AGtD42856178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-bluetooth@vger.kernel.org>; Thu, 6 Mar 2025 15:10:17 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 6 Mar 2025 15:10:17 +0800
Received: from RSEXMBS03.realsil.com.cn (172.29.17.197) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Mar 2025 15:10:17 +0800
Received: from RSEXMBS03.realsil.com.cn ([fe80::7580:ef9d:3d2:8f0a]) by
 RSEXMBS03.realsil.com.cn ([fe80::7580:ef9d:3d2:8f0a%7]) with mapi id
 15.01.2507.035; Thu, 6 Mar 2025 15:10:17 +0800
From: =?gb2312?B?TWljaGFlbCBLb25nKL/X9s4p?= <michael_kong@realsil.com.cn>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ]
Thread-Topic: [PATCH BlueZ]
Thread-Index: AduOZsWA9v521LejT9yZzdIZcOWnWg==
Date: Thu, 6 Mar 2025 07:10:16 +0000
Message-ID: <921b0f3c68294677948ce5be56924607@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
Content-Type: multipart/mixed;
	boundary="_002_921b0f3c68294677948ce5be56924607realsilcomcn_"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_921b0f3c68294677948ce5be56924607realsilcomcn_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

DQo=

--_002_921b0f3c68294677948ce5be56924607realsilcomcn_
Content-Type: application/octet-stream;
	name="0001-share-hci-Fix-data-type-in-bt_hci_send_data.patch"
Content-Description: 0001-share-hci-Fix-data-type-in-bt_hci_send_data.patch
Content-Disposition: attachment;
	filename="0001-share-hci-Fix-data-type-in-bt_hci_send_data.patch"; size=739;
	creation-date="Thu, 06 Mar 2025 06:53:06 GMT";
	modification-date="Thu, 06 Mar 2025 06:45:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMjUxYzlkMDNjNTY1OTRmZmFjY2ZhZTQ0NjM0NGZlYTBiNDZmMjU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBtaWNoYWVsX2tvbmcgPG1pY2hhZWxfa29uZ0ByZWFsc2lsLmNv
bS5jbj4KRGF0ZTogVGh1LCA2IE1hciAyMDI1IDE0OjQ0OjE3ICswODAwClN1YmplY3Q6IFtQQVRD
SCAxLzFdIHNoYXJlL2hjaTogRml4IGRhdGEgdHlwZSBpbiBidF9oY2lfc2VuZF9kYXRhCgpUaGUg
ZGF0YSB0eXBlIGluIGJ0X2hjaV9zZW5kX2RhdGEgc2hhbGwgYmUgQUNMLCBTQ08gb3IgSVNPLgot
LS0KIHNyYy9zaGFyZWQvaGNpLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvc2hhcmVkL2hjaS5jIGIvc3JjL3No
YXJlZC9oY2kuYwppbmRleCAwN2ZkZmZjODIuLjU3NTI1NGMwOSAxMDA2NDQKLS0tIGEvc3JjL3No
YXJlZC9oY2kuYworKysgYi9zcmMvc2hhcmVkL2hjaS5jCkBAIC02MjAsNyArNjIwLDcgQEAgYm9v
bCBidF9oY2lfc2VuZF9kYXRhKHN0cnVjdCBidF9oY2kgKmhjaSwgdWludDhfdCB0eXBlLCB1aW50
MTZfdCBoYW5kbGUsCiAJc3dpdGNoICh0eXBlKSB7CiAJY2FzZSBCVF9INF9BQ0xfUEtUOgogCWNh
c2UgQlRfSDRfU0NPX1BLVDoKLQljYXNlIEJUX0g0X0VWVF9QS1Q6CisJY2FzZSBCVF9INF9JU09f
UEtUOgogCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXR1cm4gZmFsc2U7Ci0tIAoyLjI1LjEKCg==

--_002_921b0f3c68294677948ce5be56924607realsilcomcn_--
