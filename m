Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553658;
	b=f9Zna8Z7hmLe/a/XoMICiES2pp0+2XWw+yotyM5OOH+sbLQLFW7s9YuNL/sMN3Kf4B1n
	 VR4kHN8FacJ65ZpJiwZWGFdNImZmch8ekth1Ng7EIy9CPyDKBYxRigefOyDWdl68q7h8w
	 lu8sJj+2GaQ0PxoV8zdTdYntB5kzqwvYJAAGlrXs7EPZvvOkPFPYsPL+Ngvs4vzrjP78s
	 MAiW7witbGhHY9x8xSU/lwLVVCRr1iE1SiqlU/DfeMAcqBeb2i7xJXHEeTuyHdJmGatri
	 uuvEnWzHhsr/8l41Rk+cBURedH2ixDHAvEBJZdcvEHDP5mdly/LJPxldLaNf+QDmbBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553658;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=CX0nGZZYH85zNnsXZ3LAVAZW/1Whu6yPSjL8pRiWuE0=;
	b=SWVOiuQsTEUi1Fy4lRnkzxnKuQMansVQSy3y2S4ZRrWoe7mH/H04yR0UATovqo8zsH6h
	 MUF8ZgI6Imvp62zlpEiexFxGusUaMzv0WjHPv+9xmubuDoPScY8DnAvup7LM1dMdYyPPX
	 tGgHrLDbAlbZKu6Q9PjEfGLnaXIsF6PNzF2+vpr0tHidQ6ijQQbSbVQxYnZhr3glR543R
	 JF5Okqm/vqKoDoqsfmCeMH7hlOdVN2k6M4g+9lgAXMMiu3ULU3/HLVCI/8ajAkiR4rDyG
	 9D1APmGYXn3lWYM7cx4Ci+BBBuGGDlOCZPXCPH/oOtIpn3+Kh8DGiFTLt8pFh2bMl/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=xdpcIz2+;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE2606A326;
	Sun,  1 Nov 2026 17:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77EE2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=xdpcIz2+
Received: from email.seznam.cz
	by smtpc-mxb-568cf9fdf9-ttkbv
	(smtpc-mxb-568cf9fdf9-ttkbv [2a02:598:96:8a00::1200:52d])
	id 10ec28d5a6d685cc1563329d;
	Sun, 01 Nov 2026 18:20:36 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1793553636; bh=CX0nGZZYH85zNnsXZ3LAVAZW/1Whu6yPSjL8pRiWuE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=xdpcIz2+ApVf8x6UPqWgoXRhwvYukFyMzoHmoNhGqva9HLmrsxFlVgxcK2IRpp2kQ
	 MY2ZiprbsLK5wWN4+XFd6hoORKENUcfBmXwLyCoBluqrQTt/eX96eowzIPKnuekPSf
	 06ccY0QLshooVxgPyWd8wK0CBuVhnS/ivevAX6ybR/OZbVCoLGBqDZsWlsna760Fgl
	 6dJq2eH1Lywyekf28iuiPgeQCfsUkjHpoo9bnvhz+06duvbN9eTCiSLzxvUbKtrdVd
	 1V3YR7mSaW+qpSMO82bBLiZxFc5NUBgvj+Wp8w+KxP0AF04zS/shBlsgUXKXqlLcec
	 jsbLUDz/w0vZw==
Received: from [192.168.31.81] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-7df688cd44-rngcc (szn-email-smtpd/2.0.89) with ESMTPA
	id a97df324-18aa-4cdf-90f8-45d6cafca780;
	Sun, 01 Nov 2026 18:20:23 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Sun, 01 Nov 2026 18:20:22 +0100
Subject: [PATCH] Bluetooth: find an RPA peer's connection parameters by its
 identity
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrCMBBFf6XM2sGm9QH+iriYpBMbsWmYSaVQ+
 u8mujyHy7kbKEtghVuzgfAnaJhjAXNowI0Un4xhKAxd212MaQ36WXBJmoVpwjejm2PEREKToiR
 C3/X9ydvzMNAVSiUJ+7D+Hu6PP+tiX+xyzdaFJWW0QtGNVdmMkdd8nEgzC+z7F84gf6mkAAAA
X-Change-ID: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

hci_le_create_conn_sync() looks up the peer's connection parameters by
conn->dst. Those parameters are stored under the identity address, but
hci_connect_le() puts the peer's cached RPA in conn->dst, and
__hci_conn_add() no longer converts it back when the controller cannot
translate an identity address.

The lookup then misses, and the connection is created with the
controller-wide defaults in hdev instead of the peer's interval, latency
and supervision timeout.

Resolve an RPA to its identity before the lookup, as
hci_connect_le_scan_cleanup() does. The other lookups by conn->dst run
after le_conn_complete_evt() has resolved it, so they are not affected.

Measured with btmon on a BCM4345C0 against a bonded peer that rotates
RPAs, with stored parameters of interval 12, latency 0 and timeout 600,
over six forced reconnects each way on v7.3.1:

                       before          after
  requested interval   30.00-50.00 ms  15.00-15.00 ms
  requested timeout    420 ms          6000 ms
  link interval        48.75 ms        15.00 ms
  link timeout         420 ms          6000 ms

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
This is the follow-up to the on-air address patch that Luiz said could
be done on top:
https://lore.kernel.org/linux-bluetooth/CABBYNZ+5zV8xzhHZKTUQYT4tLHaZAO7iiKOEsKuT8aA+YNLjPQ@mail.gmail.com/

What this does not establish:
 - tested on v7.3.1, not on bluetooth-next; the patch applies to both
   and bluetooth-next was only build-tested
 - it shows the stored parameters now reach the controller. It does not
   show that links are more reliable: all twelve reconnects succeeded,
   with or without the patch

Per Documentation/process/generated-content.rst: the patch, this message
and the btmon test runs were done with the Claude coding assistant
(model as in the Assisted-by trailer). The prompts asked it to fix the
lookup miss named in the on-air address review, then to measure the
result on the author's van, with and without the patch. The author
directed the work and reviewed the result.
---
 net/bluetooth/hci_sync.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9d829c20c31604..810d6f5143342a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7018,6 +7018,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_create_conn cp;
 	struct hci_conn_params *params;
+	struct smp_irk *irk;
 	u8 own_addr_type;
 	int err;
 	struct hci_conn *conn = data;
@@ -7057,7 +7058,16 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	hci_dev_lock(hdev);
 
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	/* conn->dst may hold the peer's RPA, but connection parameters are
+	 * stored under its identity address.
+	 */
+	irk = hci_get_irk(hdev, &conn->dst, conn->dst_type);
+	if (irk)
+		params = hci_conn_params_lookup(hdev, &irk->bdaddr,
+						irk->addr_type);
+	else
+		params = hci_conn_params_lookup(hdev, &conn->dst,
+						conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
 		conn->le_conn_max_interval = params->conn_max_interval;

---
base-commit: 42b8c2d729268a65a2d98064e8dc59ff53646b14
change-id: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7

-- 
Radek Podgorny <radek@podgorny.cz>

