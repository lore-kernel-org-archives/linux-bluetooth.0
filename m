Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.128.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882958;
	b=ealLyZfVVD5hK//treIpAzuHPBG69B6eYeE6dtLu1vsidHoGw8OrXWPuF0Hs5OhVekBe
	 Z8mHUSKI4web2FOEFq5X9Rs6jTG3ZSpalWa3zlqBMH9wfhOWQYw0P8ZXNNxhwwrhEhaPv
	 +rm0zQtJsChJz7+JAxuz7Ai3faVfaYYljBxDyjqjGC0kCOfvPmrRqp8t9/oIpwOit770k
	 Ey/a8mKr5z5IOfQYIm281ryT8eyNP504iJHyORHXuIGhR+EDz1Ya4zsPyDojq4UAy8T8J
	 RBFiC+Im7d49uXpSLiyOXE23vkRomWfLASXAOMgZ1qPjoe8rxpPVyGEuFGSRQot4j6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882958;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S/lj0TYqPx4BxSJYXs3qtdNfo9m8HzClzLPKr674ojY=;
	b=4azd46Woh8CZ8StKJO3MgKXYkk0NHnlmbq8Wn+sAUFij48n2h7sXB4S+0FWzttnjZRJi
	 NkDtDaSxAST4V3mpTZtBdRGUixNxArRtaPXcplXabQhu7isLuxSoJR6CJJQ4lSuDOuHoJ
	 Z99ArwS6sV2x8e/05mZJZdoWFXx4dF+5cBLgHSmgn7E3Fz1Xb/5TaTHcxErV20fcAac2g
	 NH5JRG7ISG7yobOTmCFMk+GGnVmqTUK6zA1Kcg2exvDiMX1OSGYvdi5D+aFW+i+TPKwrU
	 N02BQYRiphdPAFoxiQrtZ9v00dQQCZR8m76scUpdgWizng9UCyDJhN0RMI+h8HEVreA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="CgE3//Ee";
	arc=none smtp.remote-ip=74.6.128.111
Received: from sonic312-49.consmr.mail.bf2.yahoo.com (sonic312-49.consmr.mail.bf2.yahoo.com [74.6.128.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D85606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 02:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D85606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=CgE3//Ee
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882956; bh=S/lj0TYqPx4BxSJYXs3qtdNfo9m8HzClzLPKr674ojY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type; b=CgE3//Ee3AxTUUck5zvU4jAL43qz24+8GGfBr/408yU7RAsEYGHARHQhbhWmDu2YNGzUsBHSA/znzCbH/Qy+SBN6tnuzwnZCLNXoQfTtnJZMjUgNAeqnPFErQysHaoM1KOeRXaHqQuYTWkr+h0I8bhHrYGTRRhPEDqBtr+YWE7Mc54bd+M6SfXaxWs9lQs06kBYehDOQhugC99lRXUO6OWDY6po2qRQD6VD+0pFDi8hKERUqKnDhhp9JOf1ZVNIxuytebBhRqVG01NH3vxXH5uuJYxpKVZ1R/s0WDdxVrg2yBxX4iht43QuJgqg/sgMyg4pRbgqzGv2QdH/rSEzhnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882956; bh=xGo+7NnfRNf3kif5eYE8/dSx5SfAtdAteOWL3kreren=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=m0vPitRWs6cF90KHFvOB0toPqbgb45iY2Sg28aj+uD4N4a2vc4kS6iKhlvCF0/PLVZ8ahoqkA5gjdgKrRBWjMfaXVPVVIe+w2PStLBbhlb8CA7kg5iU/67dv7HCskkql0sPZnKgcGETcWhpIaMwgIcFORqO6U38YCZfEpfQ07Li2JV95vaab2xt0kqJFW2fJZHgDYDkcVNFeAL6mUoBWKrQdinXM9lp9ar60It8B3kuTc1j0pCKrzVueiNBAR7g77bJ5Zko+gE9REdJ/ZmseOLjD1VSs0B1ON/JBCEEz7J6uOgYtNxB1T3/ypEjBdr5tPfekZf8jAxuhgD4aU4eoWg==
X-YMail-OSG: PRJId84VM1kHdqRQwbOubh.mSFMchG63FKAvywJMA40Bs3Js2UOoiIJolTkOvpN
 daKQZbAaqLnNKGppCcEL1kmlxMazPVhi5dtP5Cii1Gk2EIXuAZR2yVz4JRSWO1KNhmeYahO_LHI7
 lmlYyeIpFrZoL3Q8iJkTP4aypPX_bzQrQKk_IgxaoMObuBjiOnFnDZwXLYSSvdfODGuNpXrTvuPY
 aDGsFbGCnlXbxVOmfxOBTK01wz_OrNcrOUjmcv4UofugPARqczzlknlMVhzYU5x_L2z.0L4ikbBQ
 Y_Av0frWq15_UgESFBsRTo.G8dSK0zqnlLt9.FKyaaV3PTa2HJIrQHw4DgnZg.KqGcdwytZSJY4r
 q1r0zYtStMyZLJtoHqOH8V_bnNUnMnVBtk3RGh1bhjbIEae3gkot6ToRUFG_DxsApc0l22RqF0dx
 SJqYsPdsyCu_BuBBlivKvS7Kq2tOdUVpT292dGHyI.JwmpD1dms0KqpyfLL13RJ68Wp1N0TTTAw_
 rfZLwekujJCnAABlW4.xU2Sj7UmrMz8lhwyPHJAgaLA5fRjq.i_RYvNeCGDR451YqZ4TluVBfNN1
 y4YBc79FIlb5UPH4ee79K8SCAcDcujbctlfaHq9pkDjnb45BbwPleT3uQC7Ql8wfI5nTGinEF7sw
 q0zKwZG3yv52gR09_SdYsxJhD2zTURrFQNnX4fVX3Bm2dJqpgxy37M9jqp73a15c7jRdGhSuJehH
 8ezuHb0qpgIebhSUzOVyAnxNwZykocvQcbvvYDXoxAeRAfuNyFBJtGRK8U6tr9jLn_E8f3vTAbEL
 rckIJkSloWqjWwHPTLVHtE0ctJ56SF3zYpFM72jPJRZ.PVlKSnLM.db5fP9diDpHvp2_0jRkasje
 10gCQ84zWt0TP1dApZ1yIjgLTC4iQ6MmX8ZL7361qJvz5_C7KjjtbeG.hWO1aOwqlKr7ePNmI003
 dwOSHKCDv0B2Gv9SBP1fQF_3E3iLS2OM2qwkPheGWDuPAULKxe2..DcppGJrn3R5Y7jT_jXIYSkk
 dGaBM1qbgoBUKc6hLxHLNYmPYbl5X0sxY0uGCY.FpI28g8WfQgniMS8aWZnF9ijHDs1Yy3dHRa6B
 RruvEGhLtqL_VGpQM3Y8aOyKQGrxQ1zHswmWjKzAlcFBNAfd94RyrarFi7cprNcRWAeDDnIUHr2l
 xWtyxZMt4Ca16.6FQ4Rqn0o3WFkg3i5cSp_P6ZY3Gfa4dNGCir2QZoHUU2bjEPiac9OIQ5gyfOmd
 OeM7KUSqzeOzyxBnDbhK0gQFC_PMRhU6YWcoltqucJUzk7uGP7q4wSWyat8aveufJbjwLdZnrqeE
 5P.ObCfRoZHy7gnXWpyK4toT63RXr.MsHhtRalGiEZoHwyAEqVnny4lRWSSuITThslow_Jp7zBM4
 x1hLJVobd7PufelJP6TM0XnI0MK2fXoi9gMQoRXp8ssCOjFgh_1eWyGpSkxOLqIFoBboeprZ5bx8
 9SlJ1007tNEiforshJiipkXYVWjiQB3pb47aqnPsaa.0kZnnF3ado_DB.tjiOSOZb.pnuyee_KrA
 1iN28Y242x4hCbnJYyO_X58lsMOWty6uQK3CH2RUED3A9CdLW.emFzo.ymJhW3qLU6J5PPOHwc2k
 TBn9UkqLrwHrHG.tbNWniyTQ1eYjYCylR7sh6LO76Qyn0q5cVqmP6USTirl7lRlFuatDYCq6rcMy
 vxklaKkCOBoRZqFwMTz_a2L0srCE3EGNGLvdv9ApJTYWUdZD3Gb6us4m3GKaq0b2xRBy9TtBSPAA
 O2rPS26X019T9S7tbH9b_XewpYK3SI7FZ5ETIdSsnJPikm8EhDVV8aYx2dQTu2L1xIWH74dJrU0i
 lgZXu8DqrMwViO_7DJ18drKN0AMwd3VodrSHp3_QK7Xw3QK6CUucyhQrJHGAKzO5Nj574XSR_8s0
 WqVqIKylQT6qO1W6rRJsLXvMgBkteaBQ7GZso0.NGHK8TfRxuVBwrkdvJgIjEGC1Vaqj3Vj_fP7V
 hBrXHk5CoQJxBt5b8CidXPXPjPV2vIl411tgDt8bPHYitIYkggXAp6dU5HQMRrzPxDPiDR_lqLH0
 NETptpclqQQtnt93Bs9uPBdjDEl7.e2C4zS5kjd3UY7PkSSBYJftuW4QLSlKp.pKouXr7jieY4Eg
 .3Nuy.SCUHVehsXHvb1Pf913UVMrL71TLHbJMXi771z0iJD2Ksipv.6MuNHFXZo3WaQk.XVOcjTx
 O94G1Z2fHUwFxqlgngUloe6RUxsHolkuhFNpAHCO_Eexv.dW4QftsquJ4btBISAW9zM2slYEhKYU
 Fc8cN7oba4w1I2Cm7mlDoQsV8dUhFkklis2pYzYOupA--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: a8e65f9a-d379-43ee-aa75-80067d837425
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Nov 2026 02:35:56 +0000
Received: by hermes--production-bf1-6d6877594b-c5dh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b4a44673d94ff3e2f092b66bff98f7f;
          Tue, 17 Nov 2026 02:33:55 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.xuanziyang@huawei.com,
	johan.hedberg@intel.com,
	hdanton@sina.com,
	Jeremy Dean Clifton <deaner92@yahoo.com>
Subject: [PATCH v2 2/3] Bluetooth: hci_conn: Refuse new connections once HCI_UP is cleared
Date: Tue, 17 Nov 2026 02:33:43 +0000
Message-ID: <20261117023344.278269-3-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117023344.278269-1-deaner92@yahoo.com>
References: <20261117023344.278269-1-deaner92@yahoo.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_dev_close_sync() clears HCI_UP and later calls hci_conn_hash_flush()
to delete every connection. A connection created by __hci_conn_add()
after the flush has run is never deleted. It keeps the hci_dev_hold()
reference and the sysfs device taken in __hci_conn_add(), so the
hci_dev is never freed, and its works can still be queued after the
workqueue is drained.

Check HCI_UP in __hci_conn_add(), which serves both hci_conn_add() and
hci_conn_add_unset(). All callers hold hdev->lock: the HCI event
handlers, create_pa_complete() in hci_sync.c, and the l2cap, sco, iso
and mgmt paths that reach the hci_connect_*() and hci_bind_*() helpers.
hci_conn_hash_flush() runs under hdev->lock too, so a connection is
either added before the flush and deleted by it, or refused.

Also include lockdep_assert_held() so the locking rule is checked.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
---
 net/bluetooth/hci_conn.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d729a72f2f77..7f0250653189 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1001,6 +1001,15 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	struct hci_conn *conn;
 	struct smp_irk *irk = NULL;
 
+	lockdep_assert_held(&hdev->lock);
+
+	/* hci_dev_close_sync() clears HCI_UP before hci_conn_hash_flush().
+	 * A connection added after that would never be flushed, so refuse
+	 * it. The caller holds hdev->lock, which the flush also takes.
+	 */
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return ERR_PTR(-ENETDOWN);
+
 	switch (type) {
 	case ACL_LINK:
 		if (!hdev->acl_mtu)
-- 
2.43.0

