Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7543328FB
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378982; cv=none; b=V4o7mD/tQi0VTSwkI5nYhS1XlkAd9ClKBzq1OASCTGXVF4pvSDOqamAFH+MYzehVoT1L455hLeeO5jmh8Iv+df/j5IFBrCrE9f7j/+Rrw50tRgkVNrdAtSufmyC/KcDximMEALTHwY/+05+/XXgei1MY3TqbBBfqf2LA1/BOI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378982; c=relaxed/simple;
	bh=D2lg8lyBaVO6+qurpbYjUPgfaIoQFTw9e8dQgXdm9u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XST5pBB75OOyNY7P4abM+OlGdX2hFGVsWIlvCgh/I9yUMXxh2Xl95z85ckEhckfUjbGeYPJHoJTH+zu1/kGgicTpY4D4boKLgAu4y15oJB5u/FnwSC26fy2+McrkEcc4f/kbBIvqJPOhmqrYTcTIPLvZueDzr951BfFzA1S5rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=NUgQVaEa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="NUgQVaEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772378979; x=1772983779; i=martinbts@gmx.net;
	bh=HsRmnFchROIjH31qkTH9zPNijazDkjkIAN3icZ3F5wI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NUgQVaEaXhWbQF/1Xy8/XtCso/V3ScLZJdO+V5VymqrwpayWsmd20wnRzEg5wvJQ
	 gYpmDpFmZzKQggwy0jtMSUda4C+ydvrildhfQVhZOEF3uVlhIXjZegbjiHm5yXpwI
	 3EMKTewxyPYIEux1ADa7tFRXC1ssDlSVW6AklcwidgCLKczs6QravrK9SAMSHRTjJ
	 tnlCutUYglqwEuEvSOjHA4eakV46gPgLLBfdcI8pKLj+nbHQ/PAyBKtW9Ui6bvRui
	 VCu/hTZbI3Ze2GGA1lmmECTMd1YPz0NYcwZ5RfjNkWIiDw/uhXAz1Jls+YatK2DFf
	 ShI+vfU5nnV9HQeysg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1vVbUt1VtV-00vjLi; Sun, 01
 Mar 2026 16:29:38 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ 2/5] shared/gatt-client: Handle secondary discovery timeout
Date: Sun,  1 Mar 2026 16:29:27 +0100
Message-ID: <20260301152930.221472-3-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301152930.221472-1-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cYIFLg2+dX5N7fznbuX2dBrxkNyobQlcT9+ilw6WVNJT6eN6vGl
 RdyXy2U/K6uM+uD2i/XaCT8XyetMX+jHHJ4AAD7kPN/Kcv9hy8T1jxasexTdqdXy3Y76f/h
 vP4OUCYOjsUtACo5ciWlrVqR3I+aOL7SoFlyXyrhctYFF2VRGQSBh5Ta5gd5xekjE9qL16B
 Es0923Wpg3cjipWXUUoiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QHLi18FxnOk=;8bvul90DgqM/Y5N4nyaqLfSei8U
 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

When a BLE device silently ignores the secondary service discovery
request, the ATT layer (after the previous att.c fix) invokes the
callback with success=3Dfalse and att_ecode 0x00 or BT_ATT_ERROR_UNLIKELY
(0x0e).  These fell through to the default case, aborting the entire
GATT discovery even though primary services were already found.

Add cases for att_ecode 0x00 and BT_ATT_ERROR_UNLIKELY in
discover_secondary_cb(), treating them the same as
ATTRIBUTE_NOT_FOUND so discovery continues with the primary services.
=2D--
 src/shared/gatt-client.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index df1541b88..b44f9c51a 100644
=2D-- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1243,6 +1243,19 @@ static void discover_secondary_cb(bool success, uin=
t8_t att_ecode,
=20
 	if (!success) {
 		switch (att_ecode) {
+		case 0x00:
+			/* fall through */
+		case BT_ATT_ERROR_UNLIKELY:
+			/*
+			 * att_ecode 0 or BT_ATT_ERROR_UNLIKELY (0x0e) with
+			 * success=3Dfalse means the request was aborted.
+			 * disc_att_send_op() in att.c calls the callback as
+			 * (BT_ATT_OP_ERROR_RSP, NULL, 0); process_error()
+			 * maps a NULL PDU to BT_ATT_ERROR_UNLIKELY (0x0e).
+			 * Secondary services are optional; treat this the
+			 * same as ATTRIBUTE_NOT_FOUND and continue.
+			 */
+			/* fall through */
 		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
 		case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
 			success =3D true;
=2D-=20
2.47.3

