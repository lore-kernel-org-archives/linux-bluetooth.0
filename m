Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.133.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882956;
	b=vZWNXjpgjRrBO87ckz/h1zUE5Oj4ObdR9rFCTqaAznAEH2dwlD3nneUcYZDARDLXiCWA
	 WjSkO0h0kseGg05y9NdsisyXu79MgM6SsOUExqeF+P2TzCP1StG+rqdIO1BwYXB7ZzZGN
	 gWAybgctrmcmPDLJNKZgM06t+i/KgsXwu+EfHS+6tewk+Lk2jAoyeQP079oanN9ESgh+P
	 reeuGOkdT8ji3IlLuVRQrS0SHApNLk0BSQIZaOXbURvFRWYdttV8rz2bhklS/cYms3TP2
	 tZaKTDgUlFxGJHmqXYMZRNYmwSDzP0IIeLK5Bup2KXnZHCWsjKK+k/HLSdVmpgQSuuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882956;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Os3RvI7DuWiaxJJ79oY6RF74L8oVKu3AXX6k4Pj8mZk=;
	b=jUt9xNgJAqHrc7hby8gpaRIDnBMVSWeEljoNQVwctknN7PkdpwEMBck6c/Zfd6FslSMr
	 HfhW+af6aRBXwgBYL5rzR5cl2khWheHywoiO/FTTb8MrOHTFBK/0xRK9UlvUANuqGROni
	 UyUf8dDEc/6V3jRhA9HV/uA8pWLwazcFFtj/+9HePNcVQi0NipvHn8LUbeht5krA3lHi1
	 CCiMtS7ZCWDOyPaHM4sHe2/jZ4NHCJz5VBeMCvCd39EO6K2idvL7ZSuUVEHxPzjcGVoDI
	 OKMpNZ/39dh9Mnibe1BR409aMT6POMTa1kjSryf6QVV8K2pF1BH10CppWtRkcJGmH/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=cweLKKDU;
	arc=none smtp.remote-ip=74.6.133.218
Received: from sonic313-44.consmr.mail.bf2.yahoo.com (sonic313-44.consmr.mail.bf2.yahoo.com [74.6.133.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA7606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 02:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07EA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=cweLKKDU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882954; bh=Os3RvI7DuWiaxJJ79oY6RF74L8oVKu3AXX6k4Pj8mZk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type; b=cweLKKDUc3aPqSgDFWDehDNqxKdMgnHH+Qm0ovqK3pDhWQK1HVflYoGB4tPq3R4RtZMnuiEWgOD7p/VkMuGT8z3A+g3T53NxRoNCCHaE2jQqu/2MI2OcfXCOkO4T/tZyGRCVd2tAeZYPDatswh5X5bw8L8RPMZFoYr0aUJCzqBTvkfYaLW6UxL8Fxmg6ZPFgnPqAX/aEzXaqOTVLXMyK+hgT2gp9RmgnVgVwXVa1T8XVnpPTS5MjHBy9pOw2sZJ6KyK1LWPgxFlPPI8F4rVeTO4YQ/z+MY3TF7VplyZkuerAYgUdqgv0Nz+p8SiE9DJck0cTym4VchooYUwYT1zAFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882954; bh=K5ZCqgUZE2VsPpS2Yp+G4qJYQnJClCX/R9iAGEZRK96=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hpfVew6eo3EIpbbLWS70vEiIG/v5foKvY3/2CO9+XKH9kuemkermaVOq5/9k1bRkP86L/A20bja35RhDwGqg3tkJU5iGKGY8BA95o0AtHOgiwX9YN1q3jVL3r+XasuKzcLxRKAcuGXaUfbeq0c8s+0iEzSyJYMvTvH7ImenBoCb9XJwfaQe6Milf/QsVJux3pg/7qvkteHVrck72R+4pF02+k14la7UZtwiXX7qFyNkSTzr/PCmOdexkez62wM2JQWSQVebjaA+CVxMmYYAmDVLgV1+5Gp/KWJJpdBFbo4kwOzDYPPOnM33wj702XxO/1KH7wGANGNyoywvUDemJOQ==
X-YMail-OSG: 39tUaG8VM1lxBb6Y8y5yAudVwIYaLTeiJeKi2d_8oIKk6ahiDOO8.3WAYg5CRVZ
 kErQ1EdLcIuYa1Mml0XIjHGgw44vriOFrzvU9SXHVupmyfRyuRUJFQhZ.Q6kqPApuv2kCxy5HswA
 dMazDX4.vjyboYQ4XFpHF8a4lZ4tbKBz.cFmrwRblKV4T8SLJzZA.07pqtZ2tbWSYlx0W5qaWaxp
 6ROJ_EXhigj5T40Md.W0qA8aU6mq3u7dZjAqhwQg1s9QclDorCKi187IvamOpbU9JaYMFvyGth0f
 h58oWArj7l.nS8dgKDTXgJBJJ5e9LDAGmEjW3gVhxjg8m9ZlSDa3_drb6x9ZS6Wa0mCn_Cyp9BXx
 klxIJG8.3iRibugB1tQZWujhS97tiMtZq9HeEA4CP7iSWeGQOoZmw_h1FcyrR2w0OX4odwCyXmW9
 4MkfAq1Ws7JSF1I4bLa1UpeZtFyzlULPtf0ODLqIrIFaVcYSHf7BWXQzVAMQmOUWu8sjLWUZTtEO
 AKmwoms0OT76mwpiCrmhlnAkqWMQOmluQ71U3PYk4_z0uPkBzRa2stKgrpRaJCirxH3m_Z200RZl
 lvuGUO0N3AlMSWYATnjUEuNNW9jUmFYpId5G2_gHdMp.iWHPiBzcaVjEzDdJAz5hcGfcQowjU4I.
 tgqVOIB7SVut_bKIUS73KS.B8Jmclof6R8EIH0X.SX5taY7.ZhBzKxOf0DLbpCbgvHNh98yEE71P
 1vnQCFUdbpJJgHhzXLeRwjvGYDclHgx4kHRb3nn0OYYVZtAA2GKoIDNG2Q6Pnt7Gfp1sSe1bzHwA
 w1nh9iqCJC.BZspQ6c8sTPYlhwkjRUTaVAoWmMeWd1Oydc3uw7x6JANBHf5d3evF4t5yAzVLjl2.
 MEESmr7tp.CB1BbX3ohsXbZ6J2BTYQhsCRfb9p3bVS3xACeGdhKo3nwyxwC6Ua8O.KNvwjoXy3cz
 eF3KQn7BVQvbfncMnRapXuVzkdFn0hwQt7aE7qUtrZBQ4gt3X2cuyQ.1x6sL_rPems0qbr8J9NnG
 XrG9CdBvMZol_4tY5HkfCzZwV99dsiUVBMBb.Jna4gv9lpCbL1vEJR3TcNYpBVgHtfAXNITf7_eK
 ymlXwayQBogkjIEIPS6K6oJ0EG0Gcv5QBIV349byo4YUdYWaO1kNLutT.rMluSO.niI0XVgqtiXD
 H9YKKHJFNx2IgOX1Xjz012YRXyPNSGf.reN5rhWHaEucbatksRSZDS4B5F_AMKeMv.PmVps7bEpW
 0ddTRU_AY.Q_leSd2sLkckthswsS9i3THBhj2TC3pLpaI1ukXLtL8DbUDtwrdlkY7BBbHowsJQdb
 dFJfekwVtlb.rv0OUrifxQ6yNpEmmyGyf9yZek8qDuJ0OpFdFf4WHgcPnVxkWvpboddHIe8cRFbM
 d5bzBaUJrWjJTHUlK6GluG4VKzHf31IDClsjTWYlpuM8CEJNaCZ8AYfTUC9ODwhU_MNoiR5AOHq4
 d4QEAWWIJYxGH_pdmq0iBgRE5RtuuQc48GPLZhMAB53AAg5Lo3Hdog6xYS4lX9yy8tUSYyl1yQCh
 H8WyEMggReyM932soONcRvY2dLskL0G5H5zQ0UTIhGrMgLeQTVS6nEFJX3TtbqPTmZVOlBZS3eB7
 Bx0v4ZADJiforv0w82nftQASDo4qM2ygvJ02gPN5KU28S9g88RBAfuxBgGMDp85VXYNG6FHL0pUU
 vG.IlPnuEdTW5dKBVPzYgwUwnkGd8ou2vw2PT3mpOsrW6IRHBwyf3s7KsaKHtvcWit6C7VxbyVy4
 G4DmSMeZvdrm0TzwUljBVEYNkHLjLlTkmGudZ6j.Cm4ftP9YRa.gDY17Q2OhdzfvEeFXStfNAFVm
 3NpR_WZmCgEqxwnvPm0CvBZIPe0pWU6VXMl32tcAqUec72A0Kk1yqDgNQOojJIw4swtH.Nd4ajSs
 LDx..deHS5.Tb5qBBgtwHg5A585nvvFhV46sHuZCf9cFQGI3IDTT4WRsgexnyp_5hmF480FiUQ6t
 R2tqe3Y4CWkaby4zNdstQ8BB7crS4dMqpf2ka779SBlyAt3pBsvRWZU0GuMF5i1aa2TL_gYPaawi
 LeqH9EkOopYPDC6qOvZHDhSsNRKbvbajGSDuZox4y.j5Qb7CJXY99pIeqzOkY8IylhUNeGjhksv_
 oDZ23nT6eE5VB0t2NiA8S5u03PN0bRAZdkDn0jFU_xbkGMQi7my7omm0xdeXv.MCPTAwaa3b1Oq_
 xhxdahmUW7AgKkYs_VuFNbb5h14THl6kHaMlgbuuPBqMBoe9iDG2xWQFIW.TbHrkpk_qkkcct2vY
 eJbet2gaETItL1Et8afolniF22Z1pA1egiTw-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: a527fe53-1549-4fbb-bd3a-a050a5f2d7e9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Nov 2026 02:35:54 +0000
Received: by hermes--production-bf1-6d6877594b-c5dh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b4a44673d94ff3e2f092b66bff98f7f;
          Tue, 17 Nov 2026 02:33:52 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.xuanziyang@huawei.com,
	johan.hedberg@intel.com,
	hdanton@sina.com,
	Jeremy Dean Clifton <deaner92@yahoo.com>
Subject: [PATCH v2 1/3] Bluetooth: hci_conn: Free the unset handle when adding a connection fails
Date: Tue, 17 Nov 2026 02:33:42 +0000
Message-ID: <20261117023344.278269-2-deaner92@yahoo.com>
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

hci_conn_add_unset() reserves a handle from hdev->unset_handle_ida and
passes it to __hci_conn_add(). When __hci_conn_add() returns an error,
no hci_conn exists, so hci_conn_cleanup() never runs and the handle is
never returned to the IDA. It stays reserved until the device is
released.

The Sashiko AI reviewer found this while reviewing a change
that adds another error return to __hci_conn_add().

Free the handle in hci_conn_add_unset() when __hci_conn_add() fails.

Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
---
 net/bluetooth/hci_conn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c474263fbab9..d729a72f2f77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1176,6 +1176,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 				    bdaddr_t *dst, u8 dst_type, u8 role)
 {
+	struct hci_conn *conn;
 	int handle;
 
 	bt_dev_dbg(hdev, "dst %pMR", dst);
@@ -1184,7 +1185,11 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 	if (unlikely(handle < 0))
 		return ERR_PTR(-ECONNREFUSED);
 
-	return __hci_conn_add(hdev, type, dst, dst_type, role, handle);
+	conn = __hci_conn_add(hdev, type, dst, dst_type, role, handle);
+	if (IS_ERR(conn))
+		ida_free(&hdev->unset_handle_ida, handle);
+
+	return conn;
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
-- 
2.43.0

