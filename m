Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80B1BDAB3;
	Tue,  1 Oct 2024 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769185; cv=none; b=Br1w2YRimMYM/a+2fH10aE8u/6O6t+3fTha0DBzko0m3kQOGZvfYgQfIA5+9JyiCaJG4hq8T+6shCHm3sjnsjJQAcWEHBKQZtE0ee+YZ/le3aB++zMFvqZiY6OCbZ5aagheqyx/QvFqBwJhDjxRV4QvolQzxAdQduMkjhMd1hUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769185; c=relaxed/simple;
	bh=p+68XHeuh/9JTQrgbyme5lfp6RgJ5q/iJgZ75ub89js=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kHUouGWYqEE0kCv0LoD5ZDjGnYGYbPReFI55XKJiw1cNy6GrKOHmzFWT4WR4a3eBZ5Hq25gKcVg5p10pfpqKye+Et3mSGUf8aH+sAV3f6HtZBOttLGuFQnYI21NQw9Xzjl+sfUpsVOPvv/neMKZC8CgcYrnsqq8JGRV2KdxEGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cY7S9ffc; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cY7S9ffc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727769180; x=1728373980; i=markus.elfring@web.de;
	bh=nU7c+zuDOpaIklLSDmbSnBbFhCBfbRGPQPXISmUBRN8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cY7S9ffcuky1PNfQESgZljJrlybLoYxZAc3SJBHqkVwR2ryoy88XHzUE1q+aYM2O
	 DsbXbqJD2fmrU3FU/VcMwVIwtFNPrP/CzyckqwBNzZCM1Pm7LSGebRNeJZWxjC93t
	 4299mFSFryXDrQ5POBBrV//XzT/Ka5v8kSnTNTktUYJuv+3+7vUjWybSTTzIoBcKi
	 X30Qp7SuxTbiEEnd59cVCH7PgbxBeOMzKoV0Fm+flimYinqJ7L5CuIq/qlIVB+1F3
	 nBCsnCkXhLsCYtqRxJ6rRToLId3qkjazPj7vzoSVUPAZywrax12LZXPIyy7fBJGS5
	 Khl4Zd2jN4oa1Xs3JA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS13n-1sS8yl0VKN-00XdSJ; Tue, 01
 Oct 2024 09:53:00 +0200
Message-ID: <938ce374-99ec-41fa-87be-304cbe1f27a6@web.de>
Date: Tue, 1 Oct 2024 09:52:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next] Bluetooth: hci_conn: Reduce hci_conn_drop() calls in
 two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4NmNI6UpHZXQZSbZMSzJN3IgaXICePfUsiHSub+IMKLlzlLWuvO
 obndOXB4a1p7eyytdhMcD0+WL1FtnjKFvpS3Oc9XMPRakOHJgPt78R7dsLVGyhUiB8gvBbF
 4iaNQS1k9tM7eF9MeRCGOKgg1rnbhVMVlFgkimxZy33UkefSEJ5kfKZpRuRI/vwAZrrc4Do
 D60PTg3GH2fLjtiJL/SZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o3l+HP/FJKY=;kG8JdATZHrSmfpWlKfdeUHCs37S
 U42Vv0GbHNR8qocC+Qf2GLtqGN4fcg8nf0iRI1HM9RQcKoi+T1v66cXUxlqOdc5dglbg80vSW
 ccO5gl/pfLF4kTWfCGdY1idwz/x1d4xXo1CwrwmVP4/IMSXJpnCBliHwUhxzfSekc19KYLM7n
 rJgAmQvEz8SUOfgGu/6ee3LHjBBj0iews45UNJUdZ3MIvStutdftsSz+uologgNAeXY2SdJh3
 Z6/P17u5mc80VisbMTMf28EOF030sLLDYDPZUqTkqIzdf2PEt/cmchaMNcZ42IUQuXlYZodCg
 FFeFghwqhsss7NTX4NAuZ54j6HJywxCgjzJpbEySn38MZ94RF7Fq5Gd4BgpL7k53ed6S0eWeu
 wxea0GVeCmccBYOTBsXIDdFf0BgCoDIOaUJ39RYNViTFtqDuqkZP0TqyoJj/N9+/QqdfqbLrp
 /LTjllQMnqKhffy2MN57Sox9ZkAIa5LSfDnZiNUAxsZD7h83f976uXjv8sj20osKJvsez78VC
 3VvYjEvJr5k1cnb8njNd6StT4IEPvWqc301VnjSv7sn9EIzuze+yLe6bYhdeoFvKGtUvajsVj
 Ba2CCcNN3mL6grGTBFck5tcCFVCcQxlHL/Jyw+3FJld4xJUySEJ3G8Z5EuhH6uWYV4yeiBvEw
 WdXZuQxf759wRcLFzL2fRO5SyYO3K8lhRvi05wLXUfa3WsmcbLPJbnIf7e3c5edBHd7Uxc6Sn
 95aGTcM3bKSfdJAGTOQBq3Ti2QiSIrwcomGFurwyOh570bg04DSPQH6dVWUR8Fy6OZZTvHpXh
 8In2qtJ568aHlV3Zga71r2cw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 1 Oct 2024 09:21:25 +0200

An hci_conn_drop() call was immediately used after a null pointer check
for an hci_conn_link() call in two function implementations.
Thus call such a function only once instead directly before the checks.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/bluetooth/hci_conn.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d083117ee36c..0c01ece500a9 100644
=2D-- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2221,13 +2221,9 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev,=
 bdaddr_t *dst,
 					  conn->iso_qos.bcast.big);
 	if (parent && parent !=3D conn) {
 		link =3D hci_conn_link(parent, conn);
-		if (!link) {
-			hci_conn_drop(conn);
-			return ERR_PTR(-ENOLINK);
-		}
-
-		/* Link takes the refcount */
 		hci_conn_drop(conn);
+		if (!link)
+			return ERR_PTR(-ENOLINK);
 	}

 	return conn;
@@ -2317,15 +2313,12 @@ struct hci_conn *hci_connect_cis(struct hci_dev *h=
dev, bdaddr_t *dst,
 	}

 	link =3D hci_conn_link(le, cis);
+	hci_conn_drop(cis);
 	if (!link) {
 		hci_conn_drop(le);
-		hci_conn_drop(cis);
 		return ERR_PTR(-ENOLINK);
 	}

-	/* Link takes the refcount */
-	hci_conn_drop(cis);
-
 	cis->state =3D BT_CONNECT;

 	hci_le_create_cis_pending(hdev);
=2D-
2.46.1

