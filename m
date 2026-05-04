Received: from a9-38.smtp-out.amazonses.com (a9-38.smtp-out.amazonses.com [54.240.9.38])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D073346ACC
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907765; cv=none; b=i56nlRBgt3x2DaBzyJXcSF/vyBiq22eWBv+1SUkd8kze1bNGS3jIQGnDxg2D0OkYUwqU5rkUGlPLMkPBNf0Otj3DehQL6vjxwWUcuh5uhBem9Vu+1V+mJm2FraLYMxZFuLC+o/JF1x7f/kIQn/muLxRYVtqLfFR56ZvwxClT0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907765; c=relaxed/simple;
	bh=T/tCn+h5hcof+VQ3kTr7tWldtGBL+XXcu+ATHdNjfFM=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Ve5J/X6Kj8DHPzYIcYSWvDAw/pLjCfHoVqA/jF8kpvKh79c6TEQxPwlp6abHqJlLHuhUHfw30JBoZXBc/axYlAfBqnc+0dzZiV4/oWakJIGxAHex9M5EhzbQqt+88XcSiwEsYfJav+iOUxFby8OOkVC513MQmK5q2+/ugl/odg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=send.fluentlogic.org; dkim=pass (1024-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=eNa7KxCI; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=t4qSWrl8; arc=none smtp.client-ip=54.240.9.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="eNa7KxCI";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="t4qSWrl8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fluentlogic.org; t=1777907763;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=T/tCn+h5hcof+VQ3kTr7tWldtGBL+XXcu+ATHdNjfFM=;
	b=eNa7KxCIjsz1wHt61upPMk0blOEOm8fV9D+yvTh3tpxbbcrEvsHK6yLF4EQ5ILLz
	/AOtJALD4Rw7PR7DeW/fWi5mI0nEThyoLhu2av2eE62UtUHEEJxK+sAxaggdKc6UxTY
	L9Nxy2F5rZ4R2infUjDtrcVOoAd7F9vfHme8vGR0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1777907763;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=T/tCn+h5hcof+VQ3kTr7tWldtGBL+XXcu+ATHdNjfFM=;
	b=t4qSWrl88Lbpe0Nl/GaklF4qNjlnmzhzQJAOdp6spXjFRcc/oQLnBtNypapIutJo
	z3WOyZIB7oSUbUVGe5cZ3ecrqp1ClgFh8aWlJCO5U3zDJgNz76oFA/iN45xEHDZh49M
	fTu0uXD4Luu1/tUv60PGsmvSxX0PQs54+i771Nn8=
From: Martin Brodeur <admin@fluentlogic.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <0100019df38f8843-ca2935fc-b645-44cf-8018-c7e55f953065-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 May 2026 15:16:03 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.bLnMoq1HeqxbwAh5zo6jCW/bkj6FbLsIawL4CvUjVgzBHDvB5kuVp1R4HNfEenwCNoieTMLJEeLWeUzW6hLTXt+CBNkRw9vjTyUxV7aOPrUA1ynr46NTtbaQPeA1cgPX1Q9vC3qWHGcjSQc641NmzlDaIGVe8f50qDN0FaaJJDo=:1.us-east-1.bUdgMqWxfG2SVsrQjgiKGviqCgupN9bd/NLnQooLs3w=:AmazonSES
X-SES-Outgoing: 2026.05.04-54.240.9.38

From 5c7f4c201c85248499a1cc873dc6144b555d2e83 Mon Sep 17 00:00:00 2001
From: Martin Brodeur <admin@fluentlogic.org>
Date: Mon, 4 May 2026 09:48:37=
 -0400
Subject: [PATCH BlueZ] sdp: fix overflow in sdp_extract_seqtype()

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a =
uint32_t first and return an error if
the value exceeds INT_MAX. This =
closes the residual paths not
covered by commit 31e4fb1.

Reported-by: Martin Brodeur <admin@fluentlogic.org>
---
 lib/bluetooth/sdp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 =
deletion(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 7210ce0..3295fc0 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -1249,7 +1249,15 @@ int =
sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int =
*siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size =3D bt_get_be32(buf);
+		{
+			uint32_t val32 =3D =
bt_get_be32(buf);
+
+			if (val32 > INT_MAX) {
+				SDPERR("Sequence length=
 overflow");
+				return 0;
+			}
+			*size =3D (int) val32;
+		}
 		scanned +=3D sizeof(uint32_t);
 		break;
 	default:
--=20
2.39.5 (Apple Git-154)

