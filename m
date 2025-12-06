Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828121CFF6
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018907; cv=pass; b=th4h6VX29O199M4IhnqpiqvY8QCVOvHBnOoRzebuj0iLEATbpR4UYNWQMYXpOiq8vOVwVRc5z/JVeQTgcAgEvS7XOmTawgYgvlzuTbCh17JStMCxF8RM0szO1sXQc8K2oQ6exCEXPZQUEIL43bZda7bftTOVOIXE24iHelwtERI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018907; c=relaxed/simple;
	bh=158BYJaRp30mXow9jSVcmhqgZ8exkCXN2umYo59yuR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPa6nhbOG89HP1wSpYqrceM/QZkjeL4GTtc9T9TbFF4BtSONFgCs3+p6osw0uajNzta2pVcOtWrCm6M/cnKa+E2lYC3DfcaJBNLL3y+8ruizjr/uH9fM/VquZD382OjnWjrkUU4u2AfPZ+csEbQNc4GHK2kZm1Ne0bsVnBUKO+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=C53gDNxm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="C53gDNxm"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg73BVMz106Q;
	Sat,  6 Dec 2025 13:01:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJSmRtTtVb/X7dFNZM6fJ5GWY7hzrThjkizECjyERQs=;
	b=C53gDNxmMDySHqWoygA7DW3kIZ5FSbv9AN5TKmWaAdxvW+IymkEsWkKRkc9ADlUcoDUiLl
	ioP4/+oxA8zs8gpwj2pq+yFsinkhr7SMpX/6T27nklM+7FhI9HMQBIDJHpEDcmvaVgEsG/
	mgUxC9+mMbBH1bj9+7Tztm1ZXR19moQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018900;
	b=xAwC94OAFn8yDw+BfHu90l+MtEVM7ymFxzOIWyD1nxikRywp+IkGmHSl0X7riHdfPhXKm5
	YFW8h05XgTE0OUfN3gXIc40JLPbo53CFBdUZ5uvEj2HV58t6/+2tF+OKtLRXleQpLdiTz+
	NLCZ757Xi5povo61cPculzqgwB3VyLI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJSmRtTtVb/X7dFNZM6fJ5GWY7hzrThjkizECjyERQs=;
	b=Qc34ff+1pFdZkD9oQnzjt5sjN4vlkaTDU9826u+cY3T2wjRE+5c3H0qbwHTxIo5XYKYxBD
	jj1cOLftV1BiZhxm2/Ka1V+Toh7Q0376eu45PYRGJV8jB+KJbYDw1gbT4mMRCtzbFJ2hNw
	7cw/xM5ku57DH2B71HzOde4qSBfxb38=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 07/11] test-tmap: test removing and adding role
Date: Sat,  6 Dec 2025 13:01:23 +0200
Message-ID: <a75f5438bc41af7388cfa458922fcd2814cdd53e.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-tmap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-tmap.c b/unit/test-tmap.c
index 481453112..937dac6ee 100644
--- a/unit/test-tmap.c
+++ b/unit/test-tmap.c
@@ -32,6 +32,7 @@
 
 struct test_config {
 	uint16_t role;
+	uint16_t old_role;
 };
 
 struct test_data {
@@ -221,6 +222,11 @@ static void test_setup_server(const void *user_data)
 	data->tmap = bt_tmap_add_db(db);
 	bt_tmap_set_debug(data->tmap, print_debug, "tmap:", NULL);
 
+	if (data->cfg->old_role) {
+		bt_tmap_set_role(data->tmap, data->cfg->old_role);
+		bt_tmap_set_role(data->tmap, 0);
+	}
+
 	bt_tmap_set_role(data->tmap, data->cfg->role);
 
 	att = bt_att_new(io_get_fd(io), false);
@@ -344,6 +350,11 @@ const struct test_config cfg_read_role = {
 	.role = BT_TMAP_ROLE_UMS | BT_TMAP_ROLE_BMR,
 };
 
+const struct test_config cfg_read_role_re_add = {
+	.role = BT_TMAP_ROLE_UMS | BT_TMAP_ROLE_BMR,
+	.old_role = BT_TMAP_ROLE_CT,
+};
+
 static void test_tmap_cl(void)
 {
 	/* Sec. 4.5.1 TMA Client */
@@ -366,6 +377,10 @@ static void test_tmap_sr(void)
 								"TMAP Role]",
 		test_setup_server, test_server, &cfg_read_role,
 		SGGIT_CHA);
+
+	define_test("TMAP/SR/SGGIT/CHA/BLUEZ-01-C [Re-add Role]",
+		test_setup_server, test_server, &cfg_read_role_re_add,
+		SGGIT_CHA);
 }
 
 int main(int argc, char *argv[])
-- 
2.51.1

