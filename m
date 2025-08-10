Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE2566A
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754825968; cv=pass; b=Cm3E2GmGpr8nPaK1s475ZnrP2MHJhYkYem0Ho0mjR+5FXtNsSoO7jqeijRXwlZEZ3Rn3NLicfKdHIz6U+WbVTIdFAkEDgRRURfNaFJhK9Pnz2MfVLUTvR7C39iN/ZZf6NymXgz8IPBiEhCMlDzj0SDKwHZfTfUH89TUtx1Nq1c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754825968; c=relaxed/simple;
	bh=AoUv7qhIHOkRy+amT1utuVaGxfyZFUcErQmRZnu76so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSoZcSMRGqneA9wK4lYOtrHEnWL8ooHT23mFtJLbForfPLY8Tq3Tng002Kg/XIxANG58/8znaG/SR6Lq8WiL/fvnNkO5c8y9hyONUW4AD9YSVJAKHBZgp7LOweD1j7AU9pdxB/hn/uR9s1My7KGgD25hn2OtvTFVnyYX4tHnAZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=laZJJU8c; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="laZJJU8c"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c0G4x6CQtz49Q3D;
	Sun, 10 Aug 2025 14:39:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754825953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hq5YQDpvb85N4x6wax+V0mfsGgvOD7kkGOqoyp39Zw8=;
	b=laZJJU8cv7uoX6Vb6YGBqkTT5AITgpwbhIVzqv+/iPp8s4dk0hokdclY9y5E7oSSrSmsll
	PrsvhplxwwL/9o+0ay3NBQfp41MNx6N+A6KhMDzwxlHljMtxE5w049pL76mjY7eIqlTxe7
	OpjdcG4BWJEviYvzKK15NaXcnWT6WgM7i8r0U7imXY46J58r7wbeh344Djnslug7u9x0Vj
	O8Z2tWf6MRikvqLg0N2wXw/+eDB0HyeboEFbEDTSWbabPJkr/Nd2T7qqd5AC8PeZncdwZ3
	U9HiOtYCpFcUxjpmDDo1N29gpXEtih4oN8DU/Qoon5yfptZlebH6jItQMaUJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754825953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hq5YQDpvb85N4x6wax+V0mfsGgvOD7kkGOqoyp39Zw8=;
	b=f3OD5ft8akjZc0WBvbSTfTg18rHJft0GYph8+4Z3kFY3vua9ms6trg5nf9UmtU66rkMBQf
	da7s0Z9P6NlMzIFzpqzTrVJkwzig0AG4kCNRlBM2+BsGaEdovG9ClJenln1s3xaIT0+lIe
	FfsfXnrLy5kFtk/cRxD1+3qknWRQhP+MQ9iYrY1ejdWctP1UfiJlyp9GRPTljBGsAmw08U
	iXeACUIA6bIxwrHtonVr7h922Qng5zFyUc/Gvp3ev9CztXeVAtV73pFUaAVtqC6d+I7lP7
	qxyyaYH+KaJASADtjfQPdqKz0TjRybN/g0xeUPlBZWisKxsQGVTolbiW+YQXzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754825953; a=rsa-sha256;
	cv=none;
	b=Hoye37I1ZkSt5H5traoMGTKioFzTJRd7qtFjKtIH3ntszh2Fbv9lNdbD6P1Nm9f5aq5TlM
	31REZXfpUw5EaldSW6KqBEcZFrdg8oPOHqBqQgmDrzJ9YJj47xeu8sdXvGETA7B9ZwJf09
	BbBXHDekuzUiHdkwP29Azeyydct8w8/e6XNflY7NCGxltYIT3xI34PKpYRo5dr36ya60kQ
	DRyFbT1liFFQiT7KKFFPl0sOvuzSg5Ym8YSHyPSHQoj/OFOwZFCqNmErjiH/YLFPmB54nc
	39BwfliWwk/Ft+KSx2muy5tipXM0HqH3JE8xbaolxDuIE6EAK/KO8QNUSw7WEA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: remove bap_update_cigs callback properly whan data is freed
Date: Sun, 10 Aug 2025 14:39:10 +0300
Message-ID: <36b28eff897f6dda6872ce26a13ddc571a7e5ec2.1754821407.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_free() may re-enable the CIG update callback. If this occurs in
bap_data_free(), the callback crashes with UAF.

Fix by moving clearing the callback after all setups are freed.
---
 profiles/audio/bap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 3dc4cd92e..2c7942843 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -189,9 +189,6 @@ static void bap_data_free(struct bap_data *data)
 	if (data->io_id)
 		g_source_remove(data->io_id);
 
-	if (data->cig_update_id)
-		g_source_remove(data->cig_update_id);
-
 	if (data->service && btd_service_get_user_data(data->service) == data)
 		btd_service_set_user_data(data->service, NULL);
 
@@ -204,6 +201,10 @@ static void bap_data_free(struct bap_data *data)
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
 	bt_bap_unref(data->bap);
+
+	if (data->cig_update_id)
+		g_source_remove(data->cig_update_id);
+
 	free(data);
 }
 
-- 
2.50.1

