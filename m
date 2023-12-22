Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2927D2F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ccIz1vAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=EuWi+yY2Z8xBr9ic5ln/17FBqtrn4ZdFYnxEBIvlBZg=; b=c
	cIz1vAWXzy8vtZ9ft+nrB1RZbCoj6mi0DidpZUCl2m1ud1IxdaGhPgnZ6S3Vw9Sy
	5cycgMs6xDZ2Cl0SHck6em0gYTQyum2Xf0dfE2j4fQoFWk/O1sE6WSPifiG3c8mS
	+BxN7XsTyY4cVct7Ej6hI6IW7ZFkJ5o2nbjevlz/gQ=
Received: from wendy_vs$163.com ( [218.82.140.144] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Fri, 22 Dec 2023 17:07:17 +0800
 (CST)
Date: Fri, 22 Dec 2023 17:07:17 +0800 (CST)
From: =?UTF-8?B?5pyx5rW35Lic?= <wendy_vs@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: wendy_vs <wendy_vs@163.com>
Subject: Can't setup cis with bluez5.70
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <60d0200b.4fc3.18c90909e2a.Coremail.wendy_vs@163.com>
References: <e3e3a0f.48b3.18c90760c43.Coremail.wendy_vs@163.com>
 <60d0200b.4fc3.18c90909e2a.Coremail.wendy_vs@163.com>
X-NTES-SC: AL_Qu2bAf6YuUgo4SSdYukfm04Qj+44WcG1svQu2oJQPpt4jC3p2xo+enRIFmv57tuGDz6zjBOcYjlp4PZcX6p9QZ0Wz5co4v4cwaREwINHk4CVTQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <48d28ce2.6114.18c90c76b54.Coremail.wendy_vs@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD33zPFUYVlhFhGAA--.62192W
X-CM-SenderInfo: xzhqv5xbyvqiywtou0bp/1tbiJRNO5WVN+14xDwABsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLApJIGhhdmUgYSBBWDIxMCwgd2hpY2ggaGFzIEJUNS4yIGZlYXR1cmVzLCBzbyBJIHdhbnQg
dG8gcGxheSBtdXNpYyBieSBsZSBhdWRpbyBjaXMsIGJ1dCB3aGVuIEkgcmVnaXN0ZXIgZW5kcG9p
bnRzLCBpdCBmYWlscy4KCmxvZyBpcyBsaWtlIHRoaXM6CgoKcm9vdEB6ei1IUC1Qcm9Cb29rLTY1
MC1HMTovaG9tZS96ei9wcm9qZWN0L2JsdWV6LTUuNzAjIGhjaWNvbmZpZwpoY2kwOsKgwqDCoCBU
eXBlOiBQcmltYXJ5wqAgQnVzOiBVU0IKwqDCoCDCoEJEIEFkZHJlc3M6IEY0OjdCOjA5OkY4Ojc0
OjRCwqAgQUNMIE1UVTogMTAyMTo0wqAgU0NPIE1UVTogOTY6NgrCoMKgIMKgVVAgUlVOTklORyAK
wqDCoCDCoFJYIGJ5dGVzOjIwMDM2IGFjbDowIHNjbzowIGV2ZW50czoyOTM0IGVycm9yczowCsKg
wqAgwqBUWCBieXRlczo2OTgwMjYgYWNsOjAgc2NvOjAgY29tbWFuZHM6MjkxMiBlcnJvcnM6MAoK
cm9vdEB6ei1IUC1Qcm9Cb29rLTY1MC1HMTovaG9tZS96ei9wcm9qZWN0L2JsdWV6LTUuNzAjIGhj
aWNvbmZpZyBoY2kwIHVwCnJvb3RAenotSFAtUHJvQm9vay02NTAtRzE6L2hvbWUvenovcHJvamVj
dC9ibHVlei01LjcwIyBibHVldG9vdGhjdGwgCkFnZW50IHJlZ2lzdGVyZWQKW2JsdWV0b290aF0j
IHBvd2VyIG9uIApDaGFuZ2luZyBwb3dlciBvbiBzdWNjZWVkZWQKW2JsdWV0b290aF0jIGFkdmVy
dGlzZSBvbgpoY2kwIGFkdmVydGlzaW5nX2FkZGVkOiBpbnN0YW5jZSAxCltDSEddIENvbnRyb2xs
ZXIgRjQ6N0I6MDk6Rjg6NzQ6NEIgU3VwcG9ydGVkSW5zdGFuY2VzOiAweDA3ICg3KQpbQ0hHXSBD
b250cm9sbGVyIEY0OjdCOjA5OkY4Ojc0OjRCIEFjdGl2ZUluc3RhbmNlczogMHgwMSAoMSkKQWR2
ZXJ0aXNpbmcgb2JqZWN0IHJlZ2lzdGVyZWQKVHggUG93ZXI6IG9mZgpOYW1lOiBvZmYKQXBwZWFy
YW5jZTogb2ZmCkRpc2NvdmVyYWJsZTogb24KUlNJOiBvbgpbYmx1ZXRvb3RoXSMgZW5kcG9pbnQu
cmVnaXN0ZXIgMDAwMDJiYzktMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIDB4MDYKWy9sb2Nh
bC9lbmRwb2ludC9lcDBdIEF1dG8gQWNjZXB0ICh5ZXMvbm8pOiB5ClsvbG9jYWwvZW5kcG9pbnQv
ZXAwXSBNYXggVHJhbnNwb3J0cyAoYXV0by92YWx1ZSk6IGEKWy9sb2NhbC9lbmRwb2ludC9lcDBd
IENJRyAoYXV0by92YWx1ZSk6IGEKWy9sb2NhbC9lbmRwb2ludC9lcDBdIENJUyAoYXV0by92YWx1
ZSk6IGEKRmFpbGVkIHJlZ2lzdGVyIGVuZHBvaW50CgoKSGVyZSBpcyBteSBjb21waWxlIG1ldGhv
ZDoKCjEuIGNoYW5nZSBtYWluLmNvbmYgZm9sbG93ZWQgaHR0cHM6Ly93d3cuYmx1ZXoub3JnL2xl
LWF1ZGlvLXN1cHBvcnQvCgoyLiAuL2NvbmZpZ3VyZSAtLXByZWZpeD0vdXNyIC0tbWFuZGlyPS91
c3Ivc2hhcmUvbWFuIC0tc3lzY29uZmRpcj0vZXRjIC0tbG9jYWxzdGF0ZWRpcj0vdmFyCjMuIG1h
a2UgJiYgbWFrZSBpbnN0YWxsCgoKU28sIHdvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBtZSBzb21lIGhp
bnRzIHRvIHNvbHZlIHRoaXMgcHJvYmxlbT8gVGhhbmtzLgoKCkJlc3QgcmVnYXJkcywKCldlbmR5
CgoKCgoKCgoKCgoKCgoKCgoKCg==
