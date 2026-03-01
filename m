Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C87331220
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378983; cv=none; b=QHFfHVJ2zdNbPpm6F+UpWIIAd7L4j+4D6kLzGrMsGWQZSVKq66FQuizuRBUXD/ETxOZ149buFdWuU6+TwVIdQ2oec8CC60B3LVgokbOPJ0m3ABK5e0BbNXQL71jChWNENiFz1VGbdLCTMnnnmeqA4wd4rc628Jm2ZrPzgFJhDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378983; c=relaxed/simple;
	bh=iXinGyyqfkQUxT/xcP0IoFRIWWdRaMmh0A4k4Wd1raE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe55pGxPfvOjzp/Zv3TaKcEeZd5kycDOqRIAyUTCQ/M4f2A5pnY0YDuDv6Tyxke0/SNaKr5F/RaUbp6Dqm5eebE5Gz5tTmry1acEftZ28jQuSzek2jIlb2BZZ/Gw6rtok0FUKMSgo569G++rYiLBnq3G7iF9DoaVCgZhdM1GenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=gNrbfgAx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="gNrbfgAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772378978; x=1772983778; i=martinbts@gmx.net;
	bh=isxXnKz+zNDEMdA7aaD8SwgFV+tF2H1rZ/KDklzqxck=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gNrbfgAxHyZKZV/Rj9wgiG3g9RCtk6WAxnRLzz9ZFImFqagLslskjdM0v3MVi4Hj
	 iu3nBj6J6Gs5MiWp8iAM9v4FtXQAdt3qTIASeGeKru7cuUwgJjwYioO7+ZkCD3iUn
	 6BtUY010yJz9eJL7P1LgFsjP2BGBbQD2QbhjVbeQr210nS94t0UAZrUUaJFul3hST
	 mLgs/WUo4X2hAX7T/r4IA1S+8yOzbEeY8JB2CmhKTVBF7BlopEyQddxoqViOWL8J9
	 m7FkMRHS1eVsOljtNJZkSebfo2QiqEmrPYrP+HICClD72ptWgIgjCEd40IfHkxKti
	 X1kesUod2NkH1g/zMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1wA8qh0rhp-00J5DO; Sun, 01
 Mar 2026 16:29:38 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ 1/5] shared/att: Don't disconnect on ATT request timeout
Date: Sun,  1 Mar 2026 16:29:26 +0100
Message-ID: <20260301152930.221472-2-martinbts@gmx.net>
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
X-Provags-ID: V03:K1:uiZjwc/OvSd92BgmV5KB0xgufRs3vjO1vCIuahyrCEjNjy5J9Pq
 L3C2CcS00l2b/jC+YS3SC960+qCVedXtsh7kg09Qge5pPOZbbDdLYzhJz6rOvBS/E4FeUZa
 CD3xieM6TLwSb32quAM9h04jAMVeuCk7Gwsk5hfr8Rry2dtKBsGFXdJ9h72K/zAQ1DwkX98
 0bQ3vnmPVo0cxvrl5uGsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:szrEE8FUfV0=;bVRv69J5JO08zjXHxk5amWvQlxs
 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
 ov9eSPi7aD+oGe50eFEL1h1x6IaTT

The ATT layer currently calls io_shutdown() on every request timeout,
terminating the connection.  This is too aggressive for devices that
silently ignore optional ATT requests (e.g. secondary service
discovery, UUID 0x2801) while remaining otherwise fully functional.

Remove the io_shutdown() call from timeout_cb().  The upper layer
(gatt-client.c) already handles aborted-request error codes for
optional operations and continues discovery.  Truly dead connections
are caught by the link-layer supervision timeout.
=2D--
 src/shared/att.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 3d3c8cfa2..e93e7429a 100644
=2D-- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -504,11 +504,15 @@ static bool timeout_cb(void *user_data)
 	disc_att_send_op(op);
=20
 	/*
-	 * Directly terminate the connection as required by the ATT protocol.
-	 * This should trigger an io disconnect event which will clean up the
-	 * io and notify the upper layer.
+	 * Do NOT call io_shutdown() here. Shutting down the ATT bearer on
+	 * every request timeout is too aggressive: some devices never respond
+	 * to optional ATT requests (e.g. secondary service discovery, UUID
+	 * 0x2801) while remaining otherwise fully functional. The upper layer
+	 * (gatt-client.c) already handles the aborted-request error codes
+	 * (BT_ATT_ERROR_UNLIKELY) for optional operations and continues
+	 * discovery. Truly dead connections are handled by the LL supervision
+	 * timeout without requiring ATT-level disconnection here.
 	 */
-	io_shutdown(chan->io);
=20
 	return false;
 }
=2D-=20
2.47.3

