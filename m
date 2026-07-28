Received: from sonic303-31.consmr.mail.bf2.yahoo.com (sonic303-31.consmr.mail.bf2.yahoo.com [74.6.131.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681244756BC
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275882; cv=none; b=REUT1sVnseC4pseyvx9HIobs4Ev/TxbClOEnKvrK+w2Swp5yoM23iqfQl7rWudtKWr8UwokQIVpuXBGL+utToi09hlrovBKJErhAsVW78jJINrB/BaiDoiMSKWiQlWLfbqlWAZ2y+OOYI/Cxrhdo6c9ofSHqt5pB0Dz8Nh5bDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275882; c=relaxed/simple;
	bh=GoyXt2Ob6wheB8o0jhTCUtaDXqFm9Miw6kW2MIeW1/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=JH5T1ElEn/Biy9qc6dHpsnjEDutRPpr05ZRY1RU5+sQtr4192QnaGELxsqqbvyIhoYEBZaVrOwQfnZf297tOPZuMb8xLYBRk/831ZcBrKWUHx8XmUixQKjpmCBvxRgCLTSTRQBsYAlcrhmYVVGgo03lMBYnGxQACbl26oan9608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FpELQXHm; arc=none smtp.client-ip=74.6.131.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FpELQXHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785275879; bh=TbVeXK9PgGNFb4O0oy8CE4lQ4QxdnItquwxhSacc1WA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=FpELQXHmpySK4tYp6fuoVOIVnCXm7b3b2EAF/R9xsqZFA66YOfY2CofBnfsnxtpxKE2qEynw5MXmTir7RlrzXs/mkzSVLQPvl0t9ATbh3ogHcmZxuU2Oe2m9yKDa/3WZ8zaeV7iQaILnropVCif9FzhgvR3n6cwtWdN486EqA66I/9WPdVuA7+cpkhaLiNXgXrYowXTnoKK0NrQsiM3QH7v7ln/NRd8LsFrn/Eu5XmiHQC/pK+Fh8E5zB+ivNCyKhsWj9eNLfwxjUvB6DOVCd7RUnMWYhO+iK3T3OO6jRzEe7VDe0SwVBc6rV0CdcQlS/+cbvwdLtt4gaZMlrD2AIw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785275879; bh=8ZuV1oPJ7/NbZpou9bp1sPWEgLOmsYCzXu37q7/mPhZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ARFQvPgdRF4NJWUTyQbIDlnCNXAfUGWjwtblCv9zBA9D+Wb6XwUc6ObQJvQiWgzf09QTwVra518keYHApasvcNPjh7LF/9iOZC2uXS88XWI73yVPrZ0O6bjIq+U48/re7TRGcENAKAVfNmuOwLUXoZErPakA1ljfERHpb7t2CS3agHzJALK8/Anx7r1VGjiWdi65NWOx0BLW3eAm5vVfkmDjS6qDEx7p1WurW7GTaiYN3z8bv4sKEg76drV3wPWkxmvMv50VrBhDUVF/oS3IJdoD8CnObVIcQBy4Ib/Yj06t3I/6VrrgFPePEschxKJsXjR+18D34/026htNAC3uyw==
X-YMail-OSG: XjHpv0oVM1mujqYCE6Q3Qk4juVb4YSkWkxki49SZRJOBU6el88tJTMVv0ktXZNW
 .qKg0F6Utenpu9JdfG03Z8C0LuEaw7EFk_5PCXslcYuITqwGR1JxSYxnqxUvPHqvkDpeBSefMtel
 IygEq8FkVfTG5FVzaZUd8TVm57NoZTpU2zcHR5QUnmGlzVERVlyL22M_V.RHLWOcUSZWz1BMeP9F
 GpaYCvrH0HZTPdyFAhO3EalJXAGSKosCP3NazrPSVdyQFu5qQCjd2ZcOMV7bwyJB8STGo9oPXkld
 T6.3RLebJhsGT5CGlhpKdcKGT1eFse0cqQW1v0kdxzvwVacAJXKU0sWszBzqX_nVLohz.50cjPml
 5atReTqjwhocTOl._S7nzp4k5plcLt_aY1XIAu_QlOUdSd5Z4aPvB3NvGA1fmozJe5dbtHh36vUB
 SRQcD4kl290QbBRtGeGmO5vuRo.jCAty9alcAPI4zpo3C1SE15npaZNffr9.bhWZ9r_1Bv1Sozbn
 gvB5D6LP2bfwuGRtqs_EGAwGKESFb0iD1HxKnuN9RnfktUzNBv6fru.Xtex8PDr_09wLYVMiwYj.
 21IC_wuqffgOoIPUtIMSmcBXmxZ88jIIhzGY0qYZdiMZp.4ec2Cxcr_7dU2kzE2MLDxUUpHBChjA
 f_QAFVJE8zXyb9PYceBPgU9KAlmEusOZrtVo05GpHmaZ2z._qn4LhwH84UQ8qAzZQtUtvVWvgI3I
 E_ydaFJQshoOi6yZzYhHmITkZZp4WKogmqW6djOvjpaN7lgoCAqI5iUcpJWRPcoXM2z6FuFlhNpJ
 vcjuLhs3dtOFheWOxdPvg2BQ4U9LtEWuEmRP_aD6NWCpBarnZzyrNnxrolgxoIlie4EuvvwvktF0
 TY8rdaI.ORdILNf6Kg253xjPM05haXqJbDUle92QBYBIsAa3YYRz9fiCs5yZ92VKU4OHwZvuxhua
 5YT.JbOKDTl4Ck8ySErGqPLYrFyauVQu6syN7OSwg3NVERezBk5T4MCnh1FYg6pCptBTpnspFXOu
 _o4uO1qiZs8n27KITjLHdihhXq8bgblJ3cBCTz_AwjkcDl2TLFV.BtGFtv1VYnjyvEpwjhfG14AD
 8xpG1pfcIit9KGsAo3vlwLMqMLRxKDh8_2cu7PkhG2H_I42jxcgxWhccCGp_sJHE.3MVaToyE7tO
 Ns1dk3N8n_VF6SvMScj6jmkz6UNvVf7CwTuxqKwwiY3lII7FUHyzv.wct6C.VWNg_gKQxTqT6FEj
 Om75URc8sVZDMGGjglRtTkv7Tw9fXm5sukUJ3iPE0pxVcGWvyY9QeWEkPPEqwjKN8e2Y2JwKxAnF
 ypfZPMF9OVUIRCSDVrV5pcMNmtb6hQWfSDZ5VLBua9.3ZIVo6ZZTMA8zj04NKUb..WIZejjb0hHv
 nZnl_2O425rp4K34t1jQBzm_tGCfRpbfw7d0sbl9r55oStoe6L5nXVToKn3tNhTTXdZDV_Alj.qv
 a9yCrLCJayHCF0vd74raNUNkhzeZSiRrxqcKfVjTw0hLXkrhZAVqKpjdtPr2Uc2S.Z6P85n.47Hm
 IHp5pumBhlPPdhL1jWYNpFWI.EagGWN8HH4.eDG.NhZOXGVRAQDfqiBWfncXneNFwIRK9.8i8DP3
 QyrLiruYFtyveNY4cGWojqzyQUZfi5p4CTzr_8YrMSXTwVElJTtiWwFNChcuJ5vDoJoKbRNVKA9n
 RunvlhIDO9zuzgBy_eVQVQJcbD44cB4NdyGEGtG3G_h2NJ9MiqHcQwSt0LSqOWuY12JSXYzHicnc
 DfNM6_USGhhZCZj8u.H0MD3WQoQqLkJTgd8YL1o.3KqPMKGUIzawS0fLvRO3R8ADmZbUNkYFtBq0
 sg9tX7NVq4pHOyt97PMMry2GTU5e4P4IrK4uQVXXpOHRA3MnN0K1MYEWgukfmmEul2a4gYgyQZ0J
 d6ASX2XUOwxDFAHwRn5c1e9a7r6WFeSz5NsXOIHEJPQ2p3xphUI2wdrokOtqI.veaP3Omb5.q8nM
 4qsA8xS1aJiYZ7NlScDk_O9kzm3BlwUrc.NtLByfJzGpNjXMCFX2ZDdlMoXmDOq.1N9akreWOccH
 R1tdXBltZZPOZQxiiQfMW8oEQzu_ufv7fHujvcaeSXEtQ1Yx5MuH0klim5Ps7iAvAUhtzpWGsmC9
 uqpQWFtisTkqTubmUdUFYQR8TrZrLXIm1CBytTAw.COHL89O5zk7Y351MPkvdTNOqTp9o4cNWRlA
 o82WKfmoRuneWqcnTQXjz48SlW29rEHjtStEl1TXZXajgsEkVdykrmPDZ68pRvQF89uGCJPMYutc
 ZbpPzJegYYCY.30zd3bfa7XT9WBByNvwQ
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 04037b43-16f4-4667-ac29-7b15be3d4777
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 Jul 2026 21:57:59 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-h2bbq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 58267813fdc2b2e316ffe8b1e820e324;
          Tue, 28 Jul 2026 21:24:40 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Dean <deaner92@yahoo.com>
Subject: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for qca_dump_hdr
Date: Tue, 28 Jul 2026 21:24:31 +0000
Message-ID: <20260728212431.106411-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260728212431.106411-1-deaner92.ref@yahoo.com>

Replace the deprecated zero-length array members in struct
qca_dump_hdr with DECLARE_FLEX_ARRAY(), since C99 flexible array
members are not permitted inside unions or as the sole member of
a struct.

Verified via offsetof()/sizeof() comparison that struct layout
(data/data0 offsets and overall size) is unchanged, and confirmed
the driver still compiles cleanly with the change.

Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
Signed-off-by: Jeremy Dean <deaner92@yahoo.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac6..b78c4a0e75fd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3103,10 +3103,10 @@ struct qca_dump_hdr {
 	__le16 seqno;
 	u8 reserved;
 	union {
-		u8 data[0];
+		DECLARE_FLEX_ARRAY(u8, data);
 		struct {
 			__le32 ram_dump_size;
-			u8 data0[0];
+			DECLARE_FLEX_ARRAY(u8, data0);
 		} __packed;
 	};
 } __packed;
-- 
2.43.0

