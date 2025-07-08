Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADD2E1C5C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989400; cv=none; b=BdyOJamVZxjPA8i4cRSLbV8cRoMy8sVH8/7yyaG57eL74aOPHfNSP46HQisRNWDdbkZz+OQhfnNQxU9S50JaTvHztKosZuKw2c6mznCbTsOgRWUAd0f+hDMTGy++rdn9/e1oeZKMIeE5b35LETwSmLYidXvujfJWvXS8yz0zhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989400; c=relaxed/simple;
	bh=BiqWoJqvkyhp5RlQheFeGTGd12lxs+Tox/erbqIlkXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0dLeukZIXZzkEoO6BefLKwsJsOEmR7IEtjV2/vtOF3L1aQeQzIpfPVGMD3HuWB1909JgS+cZb4F8JyUL9LdunXYzRX5eKB2lRxZXKbvAokhJm85z255/uz4/smvXFWWAk/2fb672CNm/ZUqfOybed1+NYw0WgutK3Li2vVoh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E8/ywSgY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E8/ywSgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989395;
	bh=BiqWoJqvkyhp5RlQheFeGTGd12lxs+Tox/erbqIlkXs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E8/ywSgYZQ92rYAaR0xaDWcULZrYegt9gUOm2jMbVs7QUx4N+CBC1iRb9A30tIaMH
	 V6gnM+r77aeXBQ3JUePdU9qOjIDhICh1q34rE7nJnv/QM9mASbjTC+vfMuWoBkVynP
	 0ffDoOR7OVTbmz+38gR4zcNVDW2ULINw47zV+D0JuoFU0Dm6k9DXEkP4ppcxMM1tcz
	 /XBlWICw7K9VPySfRNFu7f6DrubT9BctOctQ4bhfkIWCY56fzsNyc3kual7rKKCEW4
	 CG6x0LusdMsOBDTGobm/wIk2GoUL/noS/lxYAAHaEkClrZnt0RkYy7+GFSY5S6j7hR
	 dGGNbeVaaPJ0Q==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 46CE317E05F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:15 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/7] unit/test-eir: Add name encoding tests
Date: Tue,  8 Jul 2025 17:43:07 +0200
Message-ID: <20250708154308.238963-8-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708154308.238963-1-frederic.danis@collabora.com>
References: <20250708154308.238963-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This ensures that device name encode with UTF-16, ISO-2022-JP or with
an incorrect character in UTF-8 string are truncated correctly.
---
 unit/test-eir.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 49ce65f24..b94a2985a 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -396,6 +396,50 @@ static const struct test_data fuelband_test = {
 	.uuid = fuelband_uuid,
 };
 
+static const unsigned char invalid_utf8_name_data[] = {
+		0x22, 0x09, 0x74, 0x65, 0x73, 0x74, 0x20, 0xe0,
+		0xa4, 0xaa, 0xe0, 0xa4, 0xb0, 0xe0, 0xa5, 0x80,
+		0xe0, 0xa4, /*0x95,*/ 0xe0, 0xa5, 0x8d, 0xe0, 0xa4,
+		0xb7, 0xe0, 0xa4, 0xbe, 0x20, 0x69, 0x6e, 0x76,
+		0x61, 0x6c, 0x69, 0x64,
+};
+
+static const struct test_data invalid_utf8_name_test = {
+	.eir_data = invalid_utf8_name_data,
+	.eir_size = sizeof(invalid_utf8_name_data),
+	.name = "test परी",
+	.name_complete = true,
+	.tx_power = 127,
+};
+
+static const unsigned char utf16_name_data[] = {
+		0x17, 0x09, 0x00, 0x55, 0x00, 0x54, 0x00, 0x46,
+		0x00, 0x2d, 0x00, 0x31, 0x00, 0x36, 0x00, 0x20,
+		0x00, 0x74, 0x00, 0x65, 0x00, 0x73, 0x00, 0x74,
+};
+
+static const struct test_data utf16_name_test = {
+	.eir_data = utf16_name_data,
+	.eir_size = sizeof(utf16_name_data),
+	.name = "",
+	.name_complete = true,
+	.tx_power = 127,
+};
+
+static const unsigned char iso_2022_jp_name_data[] = {
+		0x13, 0x09, 0x74, 0x65, 0x73, 0x74, 0x20, 0x1B,
+		0x24, 0x42, 0xbb, 0xfa, 0xb8, 0xb5, 0x1b, 0x28,
+		0x42, 0x20, 0x4f, 0x4b,
+};
+
+static const struct test_data iso_2022_jp_name_test = {
+	.eir_data = iso_2022_jp_name_data,
+	.eir_size = sizeof(iso_2022_jp_name_data),
+	.name = "test \033$B",
+	.name_complete = true,
+	.tx_power = 127,
+};
+
 static const unsigned char bluesc_data[] = {
 		0x02, 0x01, 0x06, 0x03, 0x02, 0x16, 0x18, 0x12,
 		0x09, 0x57, 0x61, 0x68, 0x6f, 0x6f, 0x20, 0x42,
@@ -707,6 +751,12 @@ int main(int argc, char *argv[])
 	tester_add("/eir/sl910", &gigaset_sl910_test, NULL, test_parsing, NULL);
 	tester_add("/eir/bh907", &nokia_bh907_test, NULL, test_parsing, NULL);
 	tester_add("/eir/fuelband", &fuelband_test, NULL, test_parsing, NULL);
+	tester_add("/eir/invalid-utf8-name", &invalid_utf8_name_test, NULL,
+							test_parsing, NULL);
+	tester_add("/eir/utf16-name", &utf16_name_test, NULL, test_parsing,
+									NULL);
+	tester_add("/eir/iso-2022-jp-name", &iso_2022_jp_name_test, NULL,
+							test_parsing, NULL);
 	tester_add("/ad/bluesc", &bluesc_test, NULL, test_parsing, NULL);
 	tester_add("/ad/wahooscale", &wahoo_scale_test, NULL, test_parsing,
 									NULL);
-- 
2.43.0

