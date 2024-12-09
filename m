Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5D1B4231
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758867; cv=none; b=jCSF5wf06/dv3xnT1PqfTrsPdYRFVjvVh2oR9+LyLgJNgq1nlEuS78aKEkanK6V+btZB8Daukoe5MzCZTagP/MGdbRsDrySeNatmcqI9RWsUi9kL1K7K6dxFZoXQ5/YTMIX5RJXoyqegRlmnsWpUsCpf/09Jz04JCpuq5LXZHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758867; c=relaxed/simple;
	bh=suaargCRPKYU6/C/ynIL11jJiiSx3X03zfWF0kMSvw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLfwq40q1550NMM1hBFbrL1Eo7p9SC4nyndhaPpHKt1QnRzt+ihdRk6brmG2o/Spcf43OQ0a0d3Kthoa14BHPYE0s441TUdZJ45hTliGVqHH1+OMagQHM23EQYFPl4+GuLIO/vnSqSiIR2a5oYIobTOzCiVmCT5tLiEQjiBebkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=hQL3s7Sw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="hQL3s7Sw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733758858; x=1734363658; i=fiona.klute@gmx.de;
	bh=suaargCRPKYU6/C/ynIL11jJiiSx3X03zfWF0kMSvw0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hQL3s7SwOH2VqQZ3GKiNPIOvuqBjQutOFDqvn4Q4/RbSrbLTr1ur0GFjjJhOwiLU
	 Ug1EhEYUel2mFsyhRLequffYTmE3adNTxymJu3L6x/9EjiwPiuRsBnFUicX0LE9jB
	 B4tf8vvwpLXJKNKjZbJxoTKtfkq7m1ZmM6rbTiSnVelZEgyS7rzbuIAS370FJ7kOU
	 PBNRmjKUZlEijxXxNIfy4H1cjV/ZnOnL4IK1FYh4gROos8ICzV3RPDxM1HCqBE+ME
	 zuMXoG4rninLJ4NaDrjX3Dn40V3xVh9bu5gmeLGTlQMaBxLyPrPcXKtaHFwIGR2fX
	 l61P+4fXvOTay39lQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.114.177]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1tyBVT2BVJ-00f9QR; Mon, 09
 Dec 2024 16:40:58 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH BlueZ v2] Leave config files writable for owner
Date: Mon,  9 Dec 2024 16:40:43 +0100
Message-ID: <20241209154043.105358-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:bq+LzY9ErZ6XOE3LXqBstqKfaFgzcsLnEv3+XoInVfke83pKlr4
 t7gc3X0eDX5Bp5T8lcBzLeNGXqhL+LWaqYLRmQg33+38coZq6Qoan6vOBBpu0i9P+tm8nrS
 +8krODIChiy0zUJ8UWQo426WJ4UPb0/v4QNXEvS2WRppyi1OZrvMRd2B4B1hdoaYxtK2o+X
 0NL4lTbVAhHDX89o+j4zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+szr2173rtc=;LGppUorn+MvY+HiPoJrWz8VWQ6Q
 epGFN1QvibflD2e0X0a0Fmeikhb2nZ2y2Hu0302dndpW3fNRhkHCH438A2NCKnKwapCFFDFt1
 NE4Dsc8EN0DRXWyXRWrVE9f2mYVuG7f+BzN8o4i3jhM++UdHu3QVcDTh2lp7oTMgjaGl9eSfP
 cbXrvzvxdbHqylZu+4VdP3OZTNxRk6COnOKa4/BkuIpMVMckMpHP9uUlxEtjdqp5+gGF82GD7
 PfxzveDRNYoCfbfPvpo3ADq09Lk9OHekXn5PvA4F2PMmamJ7JO6D66BLppAPXYXXTrNay9J8+
 HqR4YFh8m3tulLIrGtijypnnSkWsa306jgltFCpZhBa7b0dhLJ4NPToGpxQxgUbsmOmOWROii
 ultbi07sh6z9gRVJO8lWcP7Bzsq83MXDTxJPpbDCuC7OIMxnaZay3PBsfajEpwyYG27RYsfcB
 zfLmrybBC4wViWVQE9jc/aKYyQOAJb7yypxWjHMTscLztuZPXltux3JtKguJHn+KoJwEA8Jkg
 l6GWmRrSfYGCRVVVucAYUvMSHVIXyy/gymcRzrvZcdfeOzdsxEKOFqXZye10SeSCkzmtmJ/hf
 3TmUQTy2ul0e4T92KEZesDtsLlUiyEpGhAOi1DKbbNljyZn4MCrVUYPSrFUKVssnhTEYbBDbn
 0EpK6fI2si9TuBK5euvJvAxezOcThj37XT56/Y1s2G6cFqq2wiK+0atBthckIPmbBTb2cSWCS
 K+Gucec9Ovi0trk36H3YyUjUxdT/lI6B7fmAX/ujbHthRDIH65+nEoaE0V2H8BcG0IXoAqkKa
 3PN9G3g2xpaoDYDIL4/AfQ/p4U/A86EuJu40A4usFRfvs+aP5fvVc0gRN19l2q285tmsmCZ0t
 hRNL72Ex88WsQVCSmDqy/Bkx2CHirNwAzDt4YFVAo+F05WqZh3VElX3Lb9jHwBbkaCW2+BRMA
 9RwsiSfB1/seMImXY7A0+gj+3Ktn8q7ayLnTP1bmwI/vY9pGUNjIMLjCq0g46JNwBP+Z1NdK7
 jLYcCf4A9Icga9In9dSZOZHPJnITuMXlK0azpQZIejWUQ+Ps78xWfPltNf/7DdbOtKvl1HEA6
 mayjAbCgtBnbosBEEjsR0WCQZ438Ri

VGhpcyBpcyBuZWVkZWQgZm9yIGJ1aWxkcyBydW5uaW5nIGFzIG5vbi1yb290IHVzZXJzLCBzbyB0
aGUgYnVpbGQKcHJvY2VzcyBhbmQgYW55IGRpc3RyaWJ1dGlvbiB0b29scyBjYW4gY3JlYXRlL21v
dmUvZGVsZXRlIGZpbGVzIGluIHRoZQpjb25maWcgZGlyZWN0b3J5IHdpdGhvdXQgYWRqdXN0aW5n
IHBlcm1pc3Npb25zIHNlcGFyYXRlbHkuIExpbWl0aW5nCndyaXRlcyBmcm9tIHRoZSBydW5uaW5n
IHNlcnZpY2UgbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgc3lzdGVtZCB1bml0CihhbHJlYWR5IHRo
ZSBjYXNlKSBvciBpbml0IHNjcmlwdC4KClNlZSBhbHNvOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1ibHVldG9vdGgvNGQxMjA2ZGYtNTk4Yi00YTY4LTg2NTUtNzQ5ODFiNjJlY2NhQGdt
eC5kZS9ULwotLS0KQ2hhbmdlcyB2MSAtPiB2MjoKKiBFeHBsaWNpdGx5IG1lbnRpb24gaW4gY29t
bWl0IG1lc3NhZ2UgdGhhdCB3cml0ZSBwZXJtaXNzaW9uIGlzIG5lZWRlZAogIGZvciBidWlsZCBh
cyBub24tcm9vdCB1c2VyLgoKIE1ha2VmaWxlLmFtIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9N
YWtlZmlsZS5hbQppbmRleCAyOTdkMDc3NGMuLjI5MDE4YTkxYyAxMDA2NDQKLS0tIGEvTWFrZWZp
bGUuYW0KKysrIGIvTWFrZWZpbGUuYW0KQEAgLTMyLDcgKzMyLDcgQEAgY29uZmRpciA9ICQoc3lz
Y29uZmRpcikvYmx1ZXRvb3RoCiBzdGF0ZWRpciA9ICQobG9jYWxzdGF0ZWRpcikvbGliL2JsdWV0
b290aAogCiBibHVldG9vdGhkLWZpeC1wZXJtaXNzaW9uczoKLQlpbnN0YWxsIC1kbTU1NSAkKERF
U1RESVIpJChjb25mZGlyKQorCWluc3RhbGwgLWRtNzU1ICQoREVTVERJUikkKGNvbmZkaXIpCiAJ
aW5zdGFsbCAtZG03MDAgJChERVNURElSKSQoc3RhdGVkaXIpCiAKIGlmIERBVEFGSUxFUwotLSAK
Mi40NS4yCgo=
